"""
================================================================================
SALES DATA PROCESSING PIPELINE
================================================================================
Author: Jabulane Prince Poulo
================================================================================
"""

# =============================================================================
# IMPORTS
# =============================================================================

import pandas as pd
# pandas provides DataFrame structure for tabular data manipulation
# Methods used: read_csv(), drop_duplicates(), fillna(), groupby(), to_csv()

import logging
# logging module records execution progress, warnings, and errors
# Provides both console output and persistent log files for audit trails

import sys
# sys module provides access to system-specific parameters
# Used here for exiting the script with appropriate status codes

from datetime import datetime
# datetime class provides current timestamp for unique log filenames

from pathlib import Path
# Path class offers object-oriented file system path handling
# Cross-platform compatible (Windows, Linux, Mac)


"""This module defines the SalesDataProcessor class which implements a complete
ETL (Extract, Transform, Load) pipeline for processing sales data."""

def setup_logging():
    """
    Configure the logging system for the entire application.
    
    This function creates a 'logs' directory inside the 'output' folder 
    (if it doesn't exist) and sets up both CSV file and console logging. 
    Each execution gets a unique CSV log file named with a timestamp to 
    prevent overwriting.
    
   
    """
    
    # Determine the output directory path
    # __file__ is the current script's path (scripts/process_data.py)
    # .parent goes up one level to the project root
    # / 'output' appends the 'output' directory name
    output_dir = Path(__file__).parent.parent / 'output'
    
    # Create the output directory if it doesn't already exist
    # exist_ok=True prevents an error if the directory already exists
    output_dir.mkdir(exist_ok=True)
    
    # Create logs directory inside the output folder
    # This keeps log files organized separately from CSV data files
    log_dir = output_dir / 'logs'
    log_dir.mkdir(exist_ok=True)
    
    # Generate a unique CSV log filename using current timestamp
    # strftime formats the datetime: YYYYMMDD_HHMMSS
  
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_file = log_dir / f'logs_{timestamp}.csv'
    
    # Create a custom CSV logging handler
    class CSVLogHandler(logging.Handler):
        """
        Custom logging handler that writes log entries in CSV format.
        
        This handler creates a CSV file with headers and appends each log
        entry as a new row with timestamp, level, and message columns.
        """
        
        def __init__(self, filename):
            """
            Initialise the CSV log handler.
            
            Args:
                filename (Path): Path to the CSV log file
            """
            super().__init__()
            self.filename = filename
            
            # Write CSV header if file is new or empty
            # Headers make the CSV file readable in Excel and other tools
            if not self.filename.exists() or self.filename.stat().st_size == 0:
                with open(self.filename, 'w', encoding='utf-8') as f:
                    f.write('timestamp,level,message\n')
        
        def emit(self, record):
            """
            Write a log record to the CSV file.
            This method is called automatically by the logging system
            whenever a log message is created.
            
            """
            try:
                # Convert timestamp from record.created (Unix timestamp)
                # to a human-readable datetime string
                timestamp = datetime.fromtimestamp(record.created).strftime('%Y-%m-%d %H:%M:%S')
                
                # Get the log level name (INFO, ERROR, WARNING)
                level = record.levelname
                
                # Get the log message and clean it for CSV format
                # Replace commas with semicolons to prevent CSV breaking
                # Replace double quotes with single quotes
                message = record.getMessage().replace(',', ';').replace('"', "'")
                
                # Append the log entry as a new row in the CSV file
                # Using 'a' mode to append, 'w' would overwrite
                with open(self.filename, 'a', encoding='utf-8') as f:
                    f.write(f'"{timestamp}","{level}","{message}"\n')
                    
            except Exception:
                # Don't let logging errors crash the application
                # Use print as fallback since logging might be failing
                print(f"Failed to write to CSV log: {record.getMessage()}")
    
    # Configure the root logger
    logging.basicConfig(
        level=logging.INFO,  # Only show INFO level and above ignores DEBUG
        handlers=[
            # CSV Handler: Writes logs to timestamped CSV file in logs folder
            CSVLogHandler(log_file),
            # Stream handler: Also prints logs to console (stdout) for real-time viewing
            logging.StreamHandler(sys.stdout)
        ]
    )
    
    # Log the location of the CSV log file for reference
    logger = logging.getLogger(__name__)
    logger.info(f"CSV log file created: {log_file}")
    
    # Return a logger instance named after the current module
    # This allows multiple modules to have their own loggers if needed
    return logger


# Initialise the logger for use throughout this script
# This logger instance is available globally
logger = setup_logging()


# =============================================================================
# MAIN PROCESSOR CLASS
# =============================================================================

class SalesDataProcessor:
    """
    Main class that manages the entire data processing pipeline.
    
    
    """
    
    """this is the constructor of the class it is used to initialise the class with the input and output paths and also to
      check if the input file exists and to create the output directory if it does not exist
    """
    def __init__(self, input_path, output_dir):
        """
        Initialise the SalesDataProcessor with file paths.
        This constructor validates that the input file exists and creates the
        output directory . It also initialises empty containers for
        the data that will be loaded and processed.
        
        """
        
        # Convert string paths to Path objects for cross-platform compatibility
        # Path objects provide methods like .exists(), .mkdir(), and support / operator
        self.input_path = Path(input_path)
        self.output_dir = Path(output_dir)
        
        # Initialise data containers as None (will be populated later)
        self.raw_data = None      # Stores original loaded data
        self.cleaned_data = None  # Stores processed data after cleaning/transformation
        
        # Validate that the input file exists before proceeding
        if not self.input_path.exists():
            raise FileNotFoundError(f"File not found: {self.input_path}")
        
        # Create the output directory (and any missing parent directories)
        self.output_dir.mkdir(parents=True, exist_ok=True)
    
    #this function is to load the data from the csv file and store it in a dataframe
    
    def load_data(self):
        """
        Load raw CSV data from the input file into a pandas DataFrame.
        This method reads the CSV file specified during initialisation and
        stores it in self.raw_data. It handles common loading errors and
        logs the number of rows loaded.
        
        """
        
        logger.info("Loading the data...")
        
        try:
            # Read the CSV file into a pandas DataFrame
            self.raw_data = pd.read_csv(self.input_path)
            
            # Check if the DataFrame is empty (no data rows)
            # This catches valid CSV files that have headers but no data
            if self.raw_data.empty:
                raise ValueError("CSV is empty")
            
            # Log success with the number of rows loaded
            # len() returns the number of rows in the DataFrame
            logger.info(f"Loaded {len(self.raw_data)} rows")
            return True
            
        except Exception as e:
            # Catch any exception that occurred during loading
            # Log the error with details for debugging
            logger.error(f"Load error: {e}")
            return False
    
    #this function is to clean the data
    
    def clean_data(self):
        """
        Clean the raw data by fixing  data quality issues.
        """
        
        logger.info("Cleaning data...")
        
        try:
            # Create a copy of the raw data to avoid modifying the original
            df = self.raw_data.copy()
            
            #this is to remove duplicates
            # drop_duplicates() removes rows that are identical in all columns
            df = df.drop_duplicates()
            logger.info(f"Removed duplicates, remaining rows: {len(df)}")
            
            #handle missing quantity values
            # Check if the 'quantity' column exists
            if 'quantity' in df.columns:
                # Count missing quantities before filling
                missing_qty = df['quantity'].isna().sum()
                if missing_qty > 0:
                    logger.info(f"Filling {missing_qty} missing quantity values with 1")
                
                # fillna(1) replaces all null/NaN values with 1
                # astype(int) ensures the column is integer type
                df['quantity'] = df['quantity'].fillna(1).astype(int)
            
           #handle missing price values
            if 'price' in df.columns:
                # Count missing prices before filling
                missing_price = df['price'].isna().sum()
                if missing_price > 0:
                    # Calculate the average price across all products
                    mean_price = df['price'].mean()
                    logger.info(f"Filling {missing_price} missing price values with average price: {mean_price:.2f}")
                    # Replace missing prices with the calculated average
                    df['price'] = df['price'].fillna(mean_price)
            
            #handle missing salesperson names
            if 'salesperson' in df.columns:
                # Count missing salesperson names before filling
                missing_sales = df['salesperson'].isna().sum()
                if missing_sales > 0:
                    logger.info(f"Labeling {missing_sales} missing salesperson names as 'Unknown'")
                # Replace empty salesperson fields with 'Unknown'
                df['salesperson'] = df['salesperson'].fillna('Unknown')
            
            #handle date formatting
            if 'date' in df.columns:
                # Count rows before date cleaning
                rows_before = len(df)
                # Convert date strings to pandas datetime objects
                # errors='coerce' converts unparseable dates to NaT not a Time
                df['date'] = pd.to_datetime(df['date'], errors='coerce')
                
                # Remove any rows where date conversion failed became NaT
                df = df.dropna(subset=['date'])
                rows_removed = rows_before - len(df)
                if rows_removed > 0:
                    logger.info(f"Removed {rows_removed} rows with invalid dates")
            
            # Store the cleaned DataFrame for use in subsequent steps
            self.cleaned_data = df
            
            # Log the final row count after all cleaning operations
            logger.info(f"Cleaned rows: {len(df)}")
            return True
            
        except Exception as e:
            # Log any error that occurred during cleaning
            logger.error(f"Clean error: {e}")
            return False
    
    
    
    def transform_data(self):
        """
        Transform the cleaned data by creating new calculated fields.
        
        """
        
        logger.info("Transforming data...")
        
        try:
            # Get the cleaned data from the instance variable
            df = self.cleaned_data
            
            # -----------------------------------------------------------------
            # TRANSFORMATION 1: Calculate Revenue
            # -----------------------------------------------------------------
            # Formula: Revenue = Quantity Sold × Price Per Unit
            df['revenue'] = df['quantity'] * df['price']
            logger.info(f"Calculated revenue for {len(df)} transactions")
            
            # -----------------------------------------------------------------
            # TRANSFORMATION 2: Extract Date Components
            # -----------------------------------------------------------------
            # Check if date column exists
            if 'date' in df.columns:
                # Extract the year using pandas datetime accessor
                # .dt accessor provides datetime-specific properties
                df['year'] = df['date'].dt.year
                
                # Extract the month number (1 = January, 12 = December)
                df['month'] = df['date'].dt.month
                logger.info("Extracted year and month from dates")
            
            # Store the transformed data back to the instance variable
            self.cleaned_data = df
            
            logger.info("Transformation complete")
            return True
            
        except Exception as e:
            logger.error(f"Transform error: {e}")
            return False
    
    
    def aggregate_data(self):
        """
        Aggregate the transformed data to answer key business questions.
        
        This method creates summary datasets by grouping and summing revenue
        across different dimensions. Each aggregation answers a specific
        business question.
        
        
        """
        
        logger.info("Aggregating data...")
        
        try:
            # Get the transformed data
            df = self.cleaned_data
            
            #this is sales by region
            sales_by_region = (
                df.groupby('region', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            # Rename columns for clarity (groupby default uses 'revenue' as column name)
            sales_by_region.columns = ['region', 'revenue']
            logger.info(f"Aggregated revenue by region: {len(sales_by_region)} regions")
            
            #this is sales by product
            sales_by_product = (
                df.groupby('product', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            sales_by_product.columns = ['product', 'revenue']
            logger.info(f"Aggregated revenue by product: {len(sales_by_product)} products")
            #this is sales by category
            sales_by_category = (
                df.groupby('category', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            sales_by_category.columns = ['category', 'revenue']
            logger.info(f"Aggregated revenue by category: {len(sales_by_category)} categories")
            
           #this is sales by month
            monthly_revenue = (
                df.groupby('month', as_index=False)['revenue']
                .sum()
                .sort_values('month')
            )
            monthly_revenue.columns = ['month', 'revenue']
            logger.info("Aggregated revenue by month")
             #this is sales by salesperson
            salesperson_perf = (
                df.groupby('salesperson', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            salesperson_perf.columns = ['salesperson', 'revenue']
            
            # astype(int): Convert rank from float to integer for cleaner display
            salesperson_perf['rank'] = salesperson_perf['revenue'].rank(
                ascending=False, method='dense'
            ).astype(int)
            logger.info(f"Aggregated revenue by salesperson: {len(salesperson_perf)} salespeople")
            
            # Extract only the top 5 performers for quick reference
            # .head(5) gets first 5 rows (already sorted descending by revenue)
            # .copy() creates an independent copy to avoid warning messages
            top_salespeople = salesperson_perf.head(5).copy()
            logger.info(f"Selected top {len(top_salespeople)} salespeople")
            
            # Using a dictionary allows easy iteration for exporting
            # Keys become filenames, values become the data to export
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
            logger.error(f"Aggregation error: {e}")
            return {}  # Return empty dictionary on failure
    
    
    def export_data(self, aggregations):
        """
        Export all processed data to CSV files.
        
        This method saves both the complete cleaned dataset and all aggregated
        summaries to separate CSV files in the output directory.
        
        
        """
        
        logger.info("Exporting data...")
        
        try:
            
            # This file contains every transaction after cleaning and transformation
            # Useful for ad-hoc analysis and as source for Excel Pivot Tables
            # index=False prevents pandas from adding an extra row number column
            clean_file = self.output_dir / 'clean_sales.csv'
            self.cleaned_data.to_csv(clean_file, index=False)
            logger.info(f"Exported clean data: {clean_file}")
            
            
            # Iterate through the dictionary of aggregated DataFrames
            # For each item, save to CSV with the key as filename
            for name, df in aggregations.items():
                output_file = self.output_dir / f"{name}.csv"
                df.to_csv(output_file, index=False)
                logger.info(f"Exported {name}: {output_file}")
            
            logger.info("Export complete")
            return True
            
        except Exception as e:
            logger.error(f"Export error: {e}")
            return False
    
    
    def run_pipeline(self):
        """
        Execute the complete ETL pipeline from start to finish.
        
        This method orchestrates all five steps of the pipeline in sequence.
        It follows the "fail-fast" principle: if any step fails, execution
        stops immediately and the method returns False.
        
        """
        
        logger.info("Starting pipeline...")
        
        # STEP 1: Load raw data
        if not self.load_data():
            logger.error("Pipeline failed at load_data")
            return False
        
        # STEP 2: Clean the data
        if not self.clean_data():
            logger.error("Pipeline failed at clean_data")
            return False
        
        # STEP 3: Transform data (add calculated fields)
        if not self.transform_data():
            logger.error("Pipeline failed at transform_data")
            return False
        
        # STEP 4: Aggregate data into summaries
        aggregations = self.aggregate_data()
        if not aggregations:  # Empty dictionary indicates failure
            logger.error("Pipeline failed at aggregate_data")
            return False
        
        # STEP 5: Export all data to CSV files
        if not self.export_data(aggregations):
            logger.error("Pipeline failed at export_data")
            return False
        
        # All steps completed successfully
        logger.info("Pipeline finished successfully")
        return True


def main():
    """
    Main function that serves as the entry point for the script.
    
    """
    # Determine the project root directory
    project_root = Path(__file__).parent.parent
    
    # Define standard input and output paths
    input_file = project_root / 'data' / 'Sales_data.csv'
    output_dir = project_root / 'output'
    

    # This fallback ensures the script works without manual renaming
    if not input_file.exists():
        alt_file = project_root / 'data' / 'Messy_Sales_Data.csv'
        if alt_file.exists():
            input_file = alt_file
            logger.info(f"Using alternative file: {input_file}")
        else:
            # Neither filename exists - cannot proceed
            raise FileNotFoundError("No data file found in data/ directory")
    
    # Create the processor instance with the determined file paths
    processor = SalesDataProcessor(input_file, output_dir)
    
    # Execute the pipeline
    success = processor.run_pipeline()
    
    # If pipeline failed, raise an exception
    if not success:
        raise RuntimeError("Pipeline failed")


if __name__ == "__main__":
    """
    This block only executes when the script is run directly.
    
    When this script is imported as a module by another script, this block
    does NOT run. This allows other scripts to use the SalesDataProcessor
    class without automatically executing the pipeline.
    
    """
    
    try:
        # Attempt to run the main function
        main()
        # Exit with code 0 indicating success
        sys.exit(0)
        
    except Exception as e:
        # Print the error to console
        print(f"ERROR: {e}")
        # Exit with code 1 indicating failure
        sys.exit(1)

