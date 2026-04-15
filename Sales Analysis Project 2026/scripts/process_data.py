
"""
================================================================================
SALES DATA PROCESSING PIPELINE
================================================================================


DESCRIPTION:
============
This script implements an ETL (Extract, Transform, Load) pipeline for processing
raw sales transaction data. It transforms messy, inconsistent data into clean,
analysis-ready datasets that answer key business questions.

BUSINESS QUESTIONS ANSWERED:
============================
1. Which regions generate the highest revenue?
2. What are the top-performing products?
3. Which product categories drive the most sales?
4. How do sales trend over time (monthly analysis)?
5. Who are the best-performing salespeople?

INPUT:
======
Raw CSV file containing sales transactions with columns:
- transaction_id: Unique identifier for each sale
- date: Transaction date (YYYY-MM-DD format)
- product: Product name
- category: Product category (Electronics, Furniture)
- quantity: Number of units sold (may have missing values)
- price: Price per unit (may have missing values)
- region: Sales region (North, South, East, West)
- salesperson: Name of salesperson (may have missing values)

OUTPUTS:
========
1. clean_sales.csv - Complete cleaned transaction data with calculated fields
2. sales_by_region.csv - Total revenue aggregated by region
3. sales_by_product.csv - Total revenue aggregated by product
4. sales_by_category.csv - Total revenue aggregated by category
5. monthly_revenue.csv - Total revenue aggregated by month
6. salesperson_performance.csv - All salespeople ranked by revenue
7. top_salespeople.csv - Top 5 performing salespeople

DATA QUALITY FIXES APPLIED:
===========================
- Duplicate records: Removed entirely
- Missing quantities: Default to 1 unit
- Missing prices: Filled with average price of all products
- Missing salesperson: Labeled as 'Unknown'
- Invalid dates: Rows with unparseable dates are removed

DEPENDENCIES:
=============
- pandas: Data manipulation and analysis
- logging: Execution logging and audit trail
- pathlib: Cross-platform file path handling

USAGE:
======
Run from command line:
    python scripts/process_data.py

Or as part of the automation pipeline:
    ./scripts/run_pipeline.sh

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


# =============================================================================
# LOGGING CONFIGURATION
# =============================================================================

def setup_logging():
    """
    Configure the logging system for the entire application.
    
    This function creates a 'logs' directory in the project root (if it doesn't
    exist) and sets up both file and console logging. Each execution gets a
    unique log file named with a timestamp to prevent overwriting.
    
    Log Format:
        %(asctime)s - Timestamp when log entry was created
        %(levelname)s - Severity level (INFO, ERROR, WARNING)
        %(message)s - The actual log message
    
    Returns:
        logging.Logger: Configured logger instance for use throughout the script
    
    Example log line:
        2026-04-14 10:17:21,668 - INFO - Loading data...
    """
    
    # Determine the log directory path
    # __file__ is the current script's path (scripts/process_data.py)
    # .parent goes up one level to the project root
    # / 'logs' appends the 'logs' directory name
    log_dir = Path(__file__).parent.parent / 'logs'
    
    # Create the logs directory if it doesn't already exist
    # exist_ok=True prevents an error if the directory already exists
    log_dir.mkdir(exist_ok=True)
    
    # Generate a unique log filename using current timestamp
    # strftime formats the datetime: YYYYMMDD_HHMMSS
    # Example: sales_processing_20260414_101720.log
    log_file = log_dir / f'sales_processing_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log'
    
    # Configure the root logger
    logging.basicConfig(
        level=logging.INFO,  # Only show INFO level and above (not DEBUG)
        format='%(asctime)s - %(levelname)s - %(message)s',  # Log format
        handlers=[
            # File handler: Writes logs to timestamped file
            logging.FileHandler(log_file, encoding='utf-8'),
            # Stream handler: Also prints logs to console (stdout) for real-time viewing
            logging.StreamHandler(sys.stdout)
        ]
    )
    
    # Return a logger instance named after the current module
    # This allows multiple modules to have their own loggers if needed
    return logging.getLogger(__name__)


# Initialize the logger for use throughout this script
# This logger instance is now available globally
logger = setup_logging()


# =============================================================================
# MAIN PROCESSOR CLASS
# =============================================================================

class SalesDataProcessor:
    """
    Main class that orchestrates the entire data processing pipeline.
    
    This class follows the ETL (Extract, Transform, Load) pattern with
    a pipeline architecture where each step feeds into the next.
    
    Pipeline Flow:
        load_data() -> clean_data() -> transform_data() -> aggregate_data() -> export_data()
        
    Each method returns a boolean indicating success/failure. If any step fails,
    the pipeline stops immediately (fail-fast principle) to prevent processing
    invalid data.
    
    Attributes:
        input_path (Path): Path to the raw input CSV file
        output_dir (Path): Directory where processed files will be saved
        raw_data (DataFrame): Original unmodified data after loading
        cleaned_data (DataFrame): Data after cleaning and transformation
    
    Usage Example:
        processor = SalesDataProcessor('data/sales.csv', 'output/')
        processor.run_pipeline()
    """
    
    # -------------------------------------------------------------------------
    # CONSTRUCTOR
    # -------------------------------------------------------------------------
    
    def __init__(self, input_path, output_dir):
        """
        Initialize the SalesDataProcessor with file paths.
        
        This constructor validates that the input file exists and creates the
        output directory if needed. It also initializes empty containers for
        the data that will be loaded and processed.
        
        Args:
            input_path (str or Path): Path to the raw CSV file to process
            output_dir (str or Path): Directory where output CSV files will be saved
        
        Raises:
            FileNotFoundError: If the input file does not exist at the specified path
        
        Example:
            processor = SalesDataProcessor('data/Sales_data.csv', 'output/')
        """
        
        # Convert string paths to Path objects for cross-platform compatibility
        # Path objects provide methods like .exists(), .mkdir(), and support / operator
        self.input_path = Path(input_path)
        self.output_dir = Path(output_dir)
        
        # Initialize data containers as None (will be populated later)
        self.raw_data = None      # Stores original loaded data
        self.cleaned_data = None  # Stores processed data after cleaning/transformation
        
        # Validate that the input file exists before proceeding
        # This fails fast rather than failing later during processing
        if not self.input_path.exists():
            raise FileNotFoundError(f"File not found: {self.input_path}")
        
        # Create the output directory (and any missing parent directories)
        # parents=True creates intermediate directories if they don't exist
        # exist_ok=True prevents error if directory already exists
        self.output_dir.mkdir(parents=True, exist_ok=True)
    
    # -------------------------------------------------------------------------
    # STEP 1: DATA EXTRACTION (LOADING)
    # -------------------------------------------------------------------------
    
    def load_data(self):
        """
        Load raw CSV data from the input file into a pandas DataFrame.
        
        This method reads the CSV file specified during initialisation and
        stores it in self.raw_data. It handles common loading errors and
        logs the number of rows loaded.
        
        Error Handling:
            - File reading errors 
            - Empty file 
        
        Returns:
            bool: True if loading was successful, False otherwise
        
        Example Log Output:
            INFO - Loading data...
            INFO - Loaded 52 rows
        """
        
        logger.info("Loading the data...")
        
        try:
            # Read the CSV file into a pandas DataFrame
            # pandas automatically detects headers from the first row
            # Handles various data types and missing value indicators
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
    
    # -------------------------------------------------------------------------
    # STEP 2: DATA CLEANING
    # -------------------------------------------------------------------------
    
    def clean_data(self):
        """
        Clean the raw data by fixing common data quality issues.
        
        This method addresses several data quality problems
        sales data:
            1. Duplicate records - Identical transactions recorded twice
            2. Missing quantities - Unknown number of units sold
            3. Missing prices - Unknown product prices
            4. Missing salesperson names - unknown salesperson
            5. Invalid dates - Dates that cannot be parsed
        
        Cleaning Strategy:
            - Duplicates: Complete row removal (keeping first occurrence)
            - Missing quantity: Default to 1 (assume at least one item sold)
            - Missing price: Impute with column mean (preserves overall average)
            - Missing salesperson: Label as 'Unknown' for tracking
            - Invalid dates: Remove the entire row (cannot perform time analysis)
        
        Returns:
            bool: True if cleaning was successful, False otherwise
        
        Example Log Output:
            INFO - Cleaning data...
            INFO - Cleaned rows: 50
        """
        
        logger.info("Cleaning data...")
        
        try:
            # Create a copy of the raw data to avoid modifying the original
            # This preserves the raw data for reference if needed
            df = self.raw_data.copy()
            
            # -----------------------------------------------------------------
            # FIX 1: Remove Duplicate Records
            # -----------------------------------------------------------------
            # drop_duplicates() removes rows that are identical in all columns
            # By default, keeps the first occurrence and removes subsequent ones
            # This addresses cases where the same transaction was recorded twice
            df = df.drop_duplicates()
            # -----------------------------------------------------------------
            # FIX 2: Handle Missing Quantity Values
            # -----------------------------------------------------------------
            # Check if the 'quantity' column exists
            if 'quantity' in df.columns:
                # fillna(1) replaces all null/NaN values with 1
                # astype(int) ensures the column is integer type
                
                df['quantity'] =df['quantity'].fillna(1).astype(int)
            
            # -----------------------------------------------------------------
            # FIX 3: Handle Missing Price Values
            # -----------------------------------------------------------------
            if 'price' in df.columns:
                # Calculate the average price across alll product
                # This is a simple imputation method that does not mess up the data
                mean_price = df['price'].mean()
                # Replace missing prices with the calculated avaerage
                df['price'] = df['price'].fillna(mean_price)
            # -----------------------------------------------------------------
            # FIX 4: Handle Missing Salesperson Names
            # -----------------------------------------------------------------
            if 'salesperson' in df.columns:
                # Replace empty salesperson fields with 'Unknown'
                # This allows tracking of which transactions have incomplete data
                df['salesperson'] = df['salesperson'].fillna('Unknown')
            
            # -----------------------------------------------------------------
            # FIX 5: Handle Invalid Dates
            # -----------------------------------------------------------------
            if 'date' in df.columns:
                # Convert date strings to pandas datetime objects
                # errors='coerce' converts unparseable dates to NaT (Not a Time)
                # Example: '2024-01-05' becomes datetime(2024, 1, 5)
                # Example: '22024-02-24' (typo) becomes NaT
                df['date'] = pd.to_datetime(df['date'], errors='coerce')
                
                # Remove any rows where date conversion failed (became NaT)
                # Without valid dates, time-based analysis would be impossible
                df = df.dropna(subset=['date'])
            
            # Store the cleaned DataFrame for use in subsequent steps
            self.cleaned_data = df
            
            # Log the final row count after all cleaning operations
            logger.info(f"Cleaned rows: {len(df)}")
            return True
            
        except Exception as e:
            # Log any error that occurred during cleaning
            logger.error(f"Clean error: {e}")
            return False
    
    # -------------------------------------------------------------------------
    # STEP 3: DATA TRANSFORMATION
    # -------------------------------------------------------------------------
    
    def transform_data(self):
        """
        Transform the cleaned data by creating new calculated fields.
        
        This method adds derived columns that enable deeper business analysis:
            1. revenue: Total monetary value of each transaction (quantity × price)
            2. year: Calendar year extracted from transaction date
            3. month: Calendar month (1-12) extracted from transaction date
        
        These calculated fields are essential for:
            - Revenue analysis (primary business metric)
            - Time-based trend analysis
            - Seasonal pattern detection
            - Year-over-year comparisons
        
        Returns:
            bool: True if transformation was successful, False otherwise
        
        Example Log Output:
            INFO - Transforming data...
            INFO - Transformation complete
        """
        
        logger.info("Transforming data...")
        
        try:
            # Get the cleaned data from the instance variable
            df = self.cleaned_data
            
            # -----------------------------------------------------------------
            # TRANSFORMATION 1: Calculate Revenue
            # -----------------------------------------------------------------
            # Revenue is the primary Key Performance Indicator (KPI) for sales
            # Formula: Revenue = Quantity Sold × Price Per Unit
            # This creates a new column that didn't exist in the raw data
            df['revenue'] = df['quantity'] * df['price']
            
            # -----------------------------------------------------------------
            # TRANSFORMATION 2: Extract Date Components
            # -----------------------------------------------------------------
            # Check if date column exists (should exist after cleaning)
            if 'date' in df.columns:
                # Extract the year (e.g., 2024) using pandas datetime accessor
                # .dt accessor provides datetime-specific properties
                df['year'] = df['date'].dt.year
                
                # Extract the month number (1 = January, 12 = December)
                df['month'] = df['date'].dt.month
            
            # Store the transformed data back to the instance variable
            self.cleaned_data = df
            
            logger.info("Transformation complete")
            return True
            
        except Exception as e:
            logger.error(f"Transform error: {e}")
            return False
    
    # -------------------------------------------------------------------------
    # STEP 4: DATA AGGREGATION
    # -------------------------------------------------------------------------
    
    def aggregate_data(self):
        """
        Aggregate the transformed data to answer key business questions.
        
        This method creates summary datasets by grouping and summing revenue
        across different dimensions. Each aggregation answers a specific
        business question.
        
        Aggregations Performed:
            1. sales_by_region: Total revenue per geographic region
               Question: "Which regions perform best?"
               
            2. sales_by_product: Total revenue per product
               Question: "Which products generate the most revenue?"
               
            3. sales_by_category: Total revenue per product category
               Question: "Do electronics or furniture drive more sales?"
               
            4. monthly_revenue: Total revenue per calendar month
               Question: "How do sales trends change over time?"
               
            5. salesperson_performance: Total revenue per salesperson with ranking
               Question: "Who are the top performers?"
               
            6. top_salespeople: Top 5 salespeople (subset of above)
               Question: "Who deserves recognition?"
        
        Returns:
            dict: Dictionary mapping aggregation names to pandas DataFrames.
                  Returns empty dictionary if aggregation fails.
        
        Example Output Structure:
            {
                'sales_by_region': DataFrame with columns ['region', 'revenue'],
                'sales_by_product': DataFrame with columns ['product', 'revenue'],
                ...
            }
        """
        
        logger.info("Aggregating data...")
        
        try:
            # Get the transformed data
            df = self.cleaned_data
            
            # -----------------------------------------------------------------
            # AGGREGATION 1: Sales by Region
            # -----------------------------------------------------------------
            # This answers: "Which regions are performing best?"
            # groupby('region'): Groups all rows with the same region together
            # as_index=False: Keeps 'region' as a column instead of row index
            # ['revenue']: Select only the revenue column for aggregation
            #.sum(): Adds up revenue for each group
            # .sort_values(): Orders from highest to lowest revenue
            sales_by_region = (
                df.groupby('region', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            # Rename columns for clarity (groupby default uses 'revenue' as column name)
            sales_by_region.columns = ['region', 'revenue']
            
            # -----------------------------------------------------------------
            # AGGREGATION 2: Sales by Product
            # -----------------------------------------------------------------
            # This answers: "Which products generate the highest revenue?"
            # Same pattern as region, but grouped by product instead
            sales_by_product = (
                df.groupby('product', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            sales_by_product.columns = ['product', 'revenue']
            
            # -----------------------------------------------------------------
            # AGGREGATION 3: Sales by Category
            # -----------------------------------------------------------------
            # This answers: "Which product categories drive more sales?"
            # Helps with high-level strategic decisions (electronics vs furniture)
            sales_by_category = (
                df.groupby('category', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            sales_by_category.columns = ['category', 'revenue']
            
            # -----------------------------------------------------------------
            # AGGREGATION 4: Monthly Revenue Trends
            # -----------------------------------------------------------------
            # This answers: "How do sales change month to month?"
            # Group by month number (1-12) to see seasonal patterns
            # sort_values('month') ensures chronological order (Jan, Feb, Mar...)
            monthly_revenue = (
                df.groupby('month', as_index=False)['revenue']
                .sum()
                .sort_values('month')
            )
            monthly_revenue.columns = ['month', 'revenue']
            
            # -----------------------------------------------------------------
            # AGGREGATION 5: Salesperson Performance with Rankings
            # -----------------------------------------------------------------
            # This answers: "Who are the best and worst performing salespeople?"
            # First, group and sum revenue by salesperson
            salesperson_perf = (
                df.groupby('salesperson', as_index=False)['revenue']
                .sum()
                .sort_values('revenue', ascending=False)
            )
            salesperson_perf.columns = ['salesperson', 'revenue']
            
            # Add a rank column to easily identify top performers
            # rank() assigns numbers based on revenue order
            # ascending=False: Higher revenue = lower rank number (1 is best)
            # method='dense': Ties get same rank with no gaps (1,2,2,3 not 1,2,2,4)
            # astype(int): Convert rank from float to integer for cleaner display
            salesperson_perf['rank'] = salesperson_perf['revenue'].rank(
                ascending=False, method='dense'
            ).astype(int)
            
            # -----------------------------------------------------------------
            # AGGREGATION 6: Top 5 Salespeople
            # -----------------------------------------------------------------
            # Extract only the top 5 performers for quick reference
            # .head(5) gets first 5 rows (already sorted descending by revenue)
            # .copy() creates an independent copy to avoid warning messages
            top_salespeople = salesperson_perf.head(5).copy()
            
            # -----------------------------------------------------------------
            # Package All Aggregations in a Dictionary
            # -----------------------------------------------------------------
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
    
    # -------------------------------------------------------------------------
    # STEP 5: DATA EXPORT
    # -------------------------------------------------------------------------
    
    def export_data(self, aggregations):
        """
        Export all processed data to CSV files.
        
        This method saves both the complete cleaned dataset and all aggregated
        summaries to separate CSV files in the output directory.
        
        Files Created:
            - clean_sales.csv: Full transaction-level cleaned data
            - sales_by_region.csv: Revenue by region summary
            - sales_by_product.csv: Revenue by product summary
            - sales_by_category.csv: Revenue by category summary
            - monthly_revenue.csv: Monthly revenue summary
            - salesperson_performance.csv: All salespeople with ranks
            - top_salespeople.csv: Top 5 performers only
        
        Args:
            aggregations (dict): Dictionary of DataFrames from aggregate_data()
        
        Returns:
            bool: True if export was successful, False otherwise
        
        Example Log Output:
            INFO - Exporting data...
            INFO - Export complete
        """
        
        logger.info("Exporting data...")
        
        try:
            # -----------------------------------------------------------------
            # Export 1: Complete Cleaned Dataset
            # -----------------------------------------------------------------
            # This file contains every transaction after cleaning and transformation
            # Useful for ad-hoc analysis and as source for Excel Pivot Tables
            # index=False prevents pandas from adding an extra row number column
            self.cleaned_data.to_csv(self.output_dir / 'clean_sales.csv', index=False)
            
            # -----------------------------------------------------------------
            # Export 2: All Aggregated Summaries
            # -----------------------------------------------------------------
            # Iterate through the dictionary of aggregated DataFrames
            # For each item, save to CSV with the key as filename
            # Example: 'sales_by_region' becomes 'sales_by_region.csv'
            for name, df in aggregations.items():
                df.to_csv(self.output_dir / f"{name}.csv", index=False)
            
            logger.info("Export complete")
            return True
            
        except Exception as e:
            logger.error(f"Export error: {e}")
            return False
    
    # -------------------------------------------------------------------------
    # PIPELINE ORCHESTRATOR
    # -------------------------------------------------------------------------
    
    def run_pipeline(self):
        """
        Execute the complete ETL pipeline from start to finish.
        
        This method orchestrates all five steps of the pipeline in sequence.
        It follows the "fail-fast" principle: if any step fails, execution
        stops immediately and the method returns False.
        
        Pipeline Steps:
            1. load_data()   - Read raw CSV file
            2. clean_data()  - Fix data quality issues
            3. transform_data() - Create calculated fields
            4. aggregate_data() - Generate summary statistics
            5. export_data() - Save results to CSV files
        
        Returns:
            bool: True if the entire pipeline executed successfully, False otherwise
        
        Example Log Output:
            INFO - Starting pipeline...
            INFO - Loading data...
            INFO - Loaded 52 rows
            INFO - Cleaning data...
            INFO - Cleaned rows: 50
            INFO - Transforming data...
            INFO - Transformation complete
            INFO - Aggregating data...
            INFO - Exporting data...
            INFO - Export complete
            INFO - Pipeline finished successfully
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


# =============================================================================
# MAIN ENTRY POINT
# =============================================================================

def main():
    """
    Main function that serves as the entry point for the script.
    
    This function:
        1. Determines the project root directory
        2. Locates the input data file (with fallback to alternative filename)
        3. Creates a SalesDataProcessor instance
        4. Executes the pipeline
        5. Handles any uncaught exceptions
    
    File Location Logic:
        - First tries: data/Sales_data.csv (standard name)
        - Then tries: data/Messy_Sales_Data.csv (sample data name)
        - If neither exists: Raises FileNotFoundError
    
    Returns:
        None (exits with status code 0 on success, 1 on failure)
    """
    
    # Determine the project root directory
    # __file__ is the path to this script (scripts/process_data.py)
    # .parent goes up one level to the 'scripts' directory
    # .parent again goes up to the project root directory
    project_root = Path(__file__).parent.parent
    
    # Define standard input and output paths
    input_file = project_root / 'data' / 'Sales_data.csv'
    output_dir = project_root / 'output'
    
    # -------------------------------------------------------------------------
    # Fallback Logic: Try Alternative Filename
    # -------------------------------------------------------------------------
    # The sample data provided is named 'Messy_Sales_Data.csv'
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


# =============================================================================
# SCRIPT EXECUTION GUARD
# =============================================================================

if __name__ == "__main__":
    """
    This block only executes when the script is run directly (not imported).
    
    When this script is imported as a module by another script, this block
    does NOT run. This allows other scripts to use the SalesDataProcessor
    class without automatically executing the pipeline.
    
    Exit Codes:
        0 - Success (normal termination)
        1 - Error (something went wrong)
    
    These exit codes can be checked by shell scripts that call this Python script.
    """
    
    try:
        # Attempt to run the main function
        main()
        # Exit with code 0 indicating success
        sys.exit(0)
        
    except Exception as e:
        # Print the error to console (logging may not be available)
        print(f"ERROR: {e}")
        # Exit with code 1 indicating failure
        sys.exit(1)

