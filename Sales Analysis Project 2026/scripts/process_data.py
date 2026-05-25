"""
================================================================================
SALES DATA PROCESSING PIPELINE
================================================================================
Author: Jabulane Prince Poulo
================================================================================
"""

import pandas as pd
import logging
import sys
from datetime import datetime
from pathlib import Path
import traceback



def setup_logging():
    """
    Configure the logging system for the entire application.
    Console shows ONLY new log entries (not entire CSV file).
    """
    
    # Determine the output directory path
    output_dir = Path(__file__).parent.parent / 'output'
    
    # Create the output directory if it doesn't already exist
    output_dir.mkdir(exist_ok=True)
    
    # Create logs directory inside the output folder
    log_dir = output_dir / 'logs'
    log_dir.mkdir(exist_ok=True)
    
    # Use a SINGLE fixed filename
    log_file = log_dir / 'logs.csv'
    
    # Create a custom CSV logging handler
    class CSVLogHandler(logging.Handler):
        """
        Custom logging handler that writes log entries in CSV format.
        """
        
        def __init__(self, filename):
            super().__init__()
            self.filename = filename
            
            # Write CSV header ONLY if file doesn't exist
            if not self.filename.exists():
                try:
                    with open(self.filename, 'w', encoding='utf-8') as f:
                        f.write('timestamp,level,message,script_run_id,error_details\n')
                except Exception as e:
                    print(f"CRITICAL: Cannot create log file: {e}")
        
        def emit(self, record):
            """
            Write a log record to the CSV file.
            """
            try:
                # Convert timestamp
                timestamp = datetime.fromtimestamp(record.created).strftime('%Y-%m-%d %H:%M:%S')
                
                # Get log level
                level = record.levelname
                
                # Get message and clean it
                message = record.getMessage().replace(',', ';').replace('"', "'").replace('\n', ' ')
                
                # Get script run ID
                script_run_id = getattr(record, 'script_run_id', 'unknown')
                
                # Get error details if this is an error record
                error_details = ''
                if record.exc_info:
                    # Format the exception traceback
                    error_details = traceback.format_exc().replace(',', ';').replace('"', "'").replace('\n', ' ')
                    error_details = error_details[:500]
                
                # Append to CSV file
                with open(self.filename, 'a', encoding='utf-8') as f:
                    f.write(f'"{timestamp}","{level}","{message}","{script_run_id}","{error_details}"\n')
                    
            except Exception as e:
                print(f"FAILED TO WRITE LOG: {record.getMessage()}")
                print(f"Logging error: {e}")
    
    # Create a filter to add script run ID
    class ScriptRunFilter(logging.Filter):
        def __init__(self, run_id):
            super().__init__()
            self.run_id = run_id
        
        def filter(self, record):
            record.script_run_id = self.run_id
            return True
    
    # Generate a run ID
    run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Clear any existing handlers
    for handler in logging.root.handlers[:]:
        logging.root.removeHandler(handler)
    
    # Configure the root logger
    logging.root.setLevel(logging.DEBUG)
    
    # Create and add CSV Handler
    csv_handler = CSVLogHandler(log_file)
    csv_handler.setLevel(logging.DEBUG)
    csv_handler.addFilter(ScriptRunFilter(run_id))
    logging.root.addHandler(csv_handler)
    
    # Create and add Console Handler
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.INFO)
    console_formatter = logging.Formatter('%(levelname)s: %(message)s')
    console_handler.setFormatter(console_formatter)
    logging.root.addHandler(console_handler)
    
    logger = logging.getLogger(__name__)
    logger.info(f"Script Run ID: {run_id}")
    logger.info(f"Log file: {log_file}")
    
    return logger


logger = setup_logging()


class SalesDataProcessor:
    """
    Main class that manages the entire data processing pipeline.
    """
    
    def __init__(self, input_path, output_dir):
        """
        Initialise the SalesDataProcessor with file paths.
        """
        self.input_path = Path(input_path)
        self.output_dir = Path(output_dir)
        self.raw_data = None
        self.cleaned_data = None
        
        if not self.input_path.exists():
            error_msg = f"File not found: {self.input_path}"
            logger.error(error_msg)
            raise FileNotFoundError(error_msg)
        
        self.output_dir.mkdir(parents=True, exist_ok=True)
        logger.info(f"Processor initialised with input: {self.input_path.name}")
    
    def load_data(self):
        """Load raw CSV data from the input file into a pandas DataFrame."""
        logger.info("Loading data...")
        
        try:
            self.raw_data = pd.read_csv(self.input_path)
            
            if self.raw_data.empty:
                raise ValueError("CSV file is empty")
            
            logger.info(f"Loaded {len(self.raw_data)} rows from {self.input_path.name}")
            logger.info(f"Columns found: {', '.join(self.raw_data.columns)}")
            return True
            
        except FileNotFoundError as e:
            logger.error(f"File not found: {e}")
            return False
        except pd.errors.EmptyDataError as e:
            logger.error(f"CSV file is empty: {e}")
            return False
        except Exception as e:
            logger.error(f"Load failed: {e}")
            return False
    
    def clean_data(self):
        """Clean the raw data by fixing data quality issues."""
        logger.info("Cleaning data...")
        
        try:
            if self.raw_data is None:
                raise ValueError("No data loaded")
            
            df = self.raw_data.copy()
            initial_rows = len(df)
            logger.info(f"Starting with {initial_rows} rows")
            
            # Remove duplicates
            duplicates_before = len(df)
            df = df.drop_duplicates()
            duplicates_removed = duplicates_before - len(df)
            if duplicates_removed > 0:
                logger.info(f"Removed {duplicates_removed} duplicate rows")
            
            # REMOVE rows with missing quantity values
            if 'quantity' in df.columns:
                missing_qty = df['quantity'].isna().sum()
                if missing_qty > 0:
                    logger.warning(f"Found {missing_qty} rows with missing quantity values")
                    df = df.dropna(subset=['quantity'])
                    logger.info(f"Removed {missing_qty} rows with missing quantities")
                    logger.info(f"Rows remaining after quantity removal: {len(df)}")
            
            # Handle missing price values
            if 'price' in df.columns:
                missing_price = df['price'].isna().sum()
                if missing_price > 0:
                    logger.warning(f"Found {missing_price} rows with missing price values")
                    mean_price = df['price'].mean()
                    df['price'] = df['price'].fillna(mean_price)
                    logger.info(f"Filled missing prices with average: R{mean_price:.2f}")
            
            # Handle missing salesperson names
            if 'salesperson' in df.columns:
                missing_sales = df['salesperson'].isna().sum()
                if missing_sales > 0:
                    logger.warning(f"Found {missing_sales} rows with missing salesperson names")
                    df['salesperson'] = df['salesperson'].fillna('Unknown')
                    logger.info(f"Labeled missing salespeople as 'Unknown'")
            
            # Handle date formatting and remove invalid dates
            if 'date' in df.columns:
                rows_before = len(df)
                df['date'] = pd.to_datetime(df['date'], errors='coerce')
                df = df.dropna(subset=['date'])
                rows_removed = rows_before - len(df)
                if rows_removed > 0:
                    logger.warning(f"Removed {rows_removed} rows with invalid date formats")
            
            # Remove any rows where quantity is zero or negative
            if 'quantity' in df.columns:
                invalid_quantity = len(df[df['quantity'] <= 0])
                if invalid_quantity > 0:
                    logger.warning(f"Found {invalid_quantity} rows with zero or negative quantity")
                    df = df[df['quantity'] > 0]
                    logger.info(f"Removed {invalid_quantity} rows with invalid quantities")
            
            # Remove any rows where price is zero or negative
            if 'price' in df.columns:
                invalid_price = len(df[df['price'] <= 0])
                if invalid_price > 0:
                    logger.warning(f"Found {invalid_price} rows with zero or negative price")
                    df = df[df['price'] > 0]
                    logger.info(f"Removed {invalid_price} rows with invalid prices")
            
            # Ensure quantity and price are numeric types
            if 'quantity' in df.columns:
                df['quantity'] = pd.to_numeric(df['quantity'], errors='coerce')
                df = df.dropna(subset=['quantity'])
                df['quantity'] = df['quantity'].astype(int)
                logger.info("Converted quantity to integer type")
            
            if 'price' in df.columns:
                df['price'] = pd.to_numeric(df['price'], errors='coerce')
                df = df.dropna(subset=['price'])
                logger.info("Converted price to numeric type")
            
            final_rows = len(df)
            rows_removed_total = initial_rows - final_rows
            logger.info(f"Cleaning complete: {final_rows} rows remaining ({rows_removed_total} rows removed)")
            
            self.cleaned_data = df
            return True
            
        except Exception as e:
            logger.error(f"Clean failed: {e}")
            logger.error(traceback.format_exc())
            return False
    
    def transform_data(self):
        """Transform the cleaned data by creating new calculated fields."""
        logger.info("Transforming data...")
        
        try:
            if self.cleaned_data is None:
                raise ValueError("No cleaned data")
            
            df = self.cleaned_data
            
            # Calculate revenue as integer (zero decimal places)
            df['revenue'] = (df['quantity'] * df['price']).round(0).astype(int)
            total_revenue = df['revenue'].sum()
            logger.info(f"Calculated revenue column - Total: R{total_revenue:,}")
            logger.info(f"Revenue range: R{df['revenue'].min():,} to R{df['revenue'].max():,}")
            logger.info("Revenue rounded to zero decimal places (whole numbers)")
            
            # Extract month as number only
            if 'date' in df.columns:
                df['month'] = df['date'].dt.month
                logger.info(f"Extracted month numbers from dates (1-12)")
                logger.info(f"Date range in data: {df['date'].min().strftime('%Y-%m-%d')} to {df['date'].max().strftime('%Y-%m-%d')}")
                logger.info(f"Months present: {sorted(df['month'].unique())}")
            
            self.cleaned_data = df
            logger.info("Transformation complete")
            return True
            
        except Exception as e:
            logger.error(f"Transform failed: {e}")
            logger.error(traceback.format_exc())
            return False
    
    def aggregate_data(self):
        """Aggregate the transformed data to answer key business questions."""
        logger.info("Aggregating data...")
        
        try:
            if self.cleaned_data is None:
                raise ValueError("No transformed data")
            
            df = self.cleaned_data
            
            # Sales by region (revenue as integer)
            sales_by_region = df.groupby('region', as_index=False)['revenue'].sum().sort_values('revenue', ascending=False)
            sales_by_region.columns = ['region', 'revenue']
            sales_by_region['revenue'] = sales_by_region['revenue'].astype(int)
            logger.info(f"Found {len(sales_by_region)} regions with total revenue: R{sales_by_region['revenue'].sum():,}")
            
            # Sales by product (revenue as integer)
            sales_by_product = df.groupby('product', as_index=False)['revenue'].sum().sort_values('revenue', ascending=False)
            sales_by_product.columns = ['product', 'revenue']
            sales_by_product['revenue'] = sales_by_product['revenue'].astype(int)
            logger.info(f"Found {len(sales_by_product)} products")
            
            # Sales by category (revenue as integer)
            if 'category' in df.columns:
                sales_by_category = df.groupby('category', as_index=False)['revenue'].sum().sort_values('revenue', ascending=False)
                sales_by_category.columns = ['category', 'revenue']
                sales_by_category['revenue'] = sales_by_category['revenue'].astype(int)
                logger.info(f"Found {len(sales_by_category)} categories")
            else:
                sales_by_category = pd.DataFrame(columns=['category', 'revenue'])
                logger.warning("No 'category' column found in data")
            
            # Monthly revenue - using month number (revenue as integer)
            if 'month' in df.columns:
                monthly_revenue = df.groupby('month', as_index=False)['revenue'].sum().sort_values('month')
                monthly_revenue.columns = ['month', 'revenue']
                monthly_revenue['revenue'] = monthly_revenue['revenue'].astype(int)
                logger.info("Monthly revenue aggregated")
                for _, row in monthly_revenue.iterrows():
                    logger.info(f"  Month {int(row['month'])}: R{row['revenue']:,}")
            else:
                monthly_revenue = pd.DataFrame(columns=['month', 'revenue'])
                logger.warning("No 'month' column found for monthly aggregation")
            
            # Salesperson performance (revenue as integer)
            if 'salesperson' in df.columns:
                salesperson_perf = df.groupby('salesperson', as_index=False)['revenue'].sum().sort_values('revenue', ascending=False)
                salesperson_perf.columns = ['salesperson', 'revenue']
                salesperson_perf['revenue'] = salesperson_perf['revenue'].astype(int)
                salesperson_perf['rank'] = salesperson_perf['revenue'].rank(ascending=False, method='dense').astype(int)
                logger.info(f"Found {len(salesperson_perf)} salespeople")
                logger.info(f"Top performer: {salesperson_perf.iloc[0]['salesperson']} with R{salesperson_perf.iloc[0]['revenue']:,}")
                
                # Top 5 (revenue as integer)
                top_salespeople = salesperson_perf.head(5).copy()
            else:
                salesperson_perf = pd.DataFrame(columns=['salesperson', 'revenue', 'rank'])
                top_salespeople = pd.DataFrame(columns=['salesperson', 'revenue', 'rank'])
                logger.warning("No 'salesperson' column found")
            
            aggregations = {
                'sales_by_region': sales_by_region,
                'sales_by_product': sales_by_product,
                'sales_by_category': sales_by_category,
                'monthly_revenue': monthly_revenue,
                'salesperson_performance': salesperson_perf,
                'top_salespeople': top_salespeople
            }
            
            return aggregations
            
        except Exception as e:
            logger.error(f"Aggregation failed: {e}")
            logger.error(traceback.format_exc())
            return {}
    
    def export_data(self, aggregations):
        """Export all processed data to CSV files."""
        logger.info("Exporting data...")
        
        try:
            if self.cleaned_data is None:
                raise ValueError("No data to export")
            
            # Export clean data (ensure revenue is integer)
            self.cleaned_data['revenue'] = self.cleaned_data['revenue'].astype(int)
            clean_file = self.output_dir / 'clean_sales.csv'
            self.cleaned_data.to_csv(clean_file, index=False)
            logger.info(f"Exported clean data to {clean_file.name} ({len(self.cleaned_data)} rows)")
            
            # Export aggregations
            for name, df in aggregations.items():
                if not df.empty:
                    output_file = self.output_dir / f"{name}.csv"
                    df.to_csv(output_file, index=False)
                    logger.info(f"Exported {name} to {output_file.name} ({len(df)} rows)")
                else:
                    logger.warning(f"Skipped {name} - no data to export")
            
            logger.info("Export complete")
            return True
            
        except Exception as e:
            logger.error(f"Export failed: {e}")
            logger.error(traceback.format_exc())
            return False
    
    def run_pipeline(self):
        """Execute the pipeline from top to bottom."""
        
        logger.info("=" * 60)
        logger.info("STARTING SALES DATA PROCESSING PIPELINE")
        logger.info("=" * 60)
        
        try:
            if not self.load_data():
                logger.error("Pipeline FAILED at load_data stage")
                return False
            
            if not self.clean_data():
                logger.error("Pipeline FAILED at clean_data stage")
                return False
            
            if not self.transform_data():
                logger.error("Pipeline FAILED at transform_data stage")
                return False
            
            aggregations = self.aggregate_data()
            if not aggregations:
                logger.error("Pipeline FAILED at aggregate_data stage")
                return False
            
            if not self.export_data(aggregations):
                logger.error("Pipeline FAILED at export_data stage")
                return False
            
            logger.info("=" * 60)
            logger.info("PIPELINE COMPLETED SUCCESSFULLY")
            logger.info("=" * 60)
            
            # Summary statistics
            logger.info("Final Summary:")
            logger.info(f"  - Total rows processed: {len(self.cleaned_data)}")
            logger.info(f"  - Total revenue: R{self.cleaned_data['revenue'].sum():,}")
            logger.info(f"  - Average revenue per transaction: R{self.cleaned_data['revenue'].mean():.0f}")
            logger.info(f"  - Output files: 7 CSV files in {self.output_dir}")
            logger.info(f"  - Log file: {self.output_dir / 'logs' / 'logs.csv'}")
            logger.info(f"  - All revenue values are integers (zero decimal places)")
            
            return True
            
        except Exception as e:
            logger.critical(f"PIPELINE ERROR: {e}")
            logger.critical(traceback.format_exc())
            return False


def main():
    """
    Main function that serves as the entry point for the script.
    """
    try:
        project_root = Path(__file__).parent.parent
        input_file = project_root / 'data' / 'Sales_data.csv'
        output_dir = project_root / 'output'
        
        # Try alternative filename if primary not found
        if not input_file.exists():
            alt_file = project_root / 'data' / 'Messy_Sales_Data.csv'
            if alt_file.exists():
                input_file = alt_file
                logger.warning(f"Primary file not found. Using alternative file: {alt_file.name}")
            else:
                # List available files in data directory
                data_dir = project_root / 'data'
                if data_dir.exists():
                    available_files = list(data_dir.glob('*.csv'))
                    if available_files:
                        input_file = available_files[0]
                        logger.warning(f"No default file found. Using: {input_file.name}")
                    else:
                        error_msg = "No CSV files found in data/ directory"
                        logger.error(error_msg)
                        raise FileNotFoundError(error_msg)
                else:
                    error_msg = "data/ directory does not exist"
                    logger.error(error_msg)
                    raise FileNotFoundError(error_msg)
        
        logger.info(f"Input file: {input_file}")
        logger.info(f"Output directory: {output_dir}")
        
        processor = SalesDataProcessor(input_file, output_dir)
        success = processor.run_pipeline()
        
        if not success:
            raise RuntimeError("Pipeline execution failed - check logs for details")
        
    except Exception as e:
        logger.critical(f"MAIN ERROR: {e}")
        logger.critical(traceback.format_exc())
        sys.exit(1)


if __name__ == "__main__":
    try:
        main()
        sys.exit(0)
    except KeyboardInterrupt:
        print("\n\nInterrupted by user")
        sys.exit(130)
    except Exception as e:
        print(f"\n\nFATAL ERROR: {e}")
        sys.exit(1)

