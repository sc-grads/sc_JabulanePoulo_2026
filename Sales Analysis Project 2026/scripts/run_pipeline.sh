# =============================================================================
# SALES DATA PIPELINE Mastermind Script
# =============================================================================
# AUTHOR: Jabulane Prince Poulo
echo "=========================================="
echo "Sales Data Processing Pipeline"
echo "Started at: $(date)"  # $(date) executes the date command and inserts output
echo "Author: Jabulane Prince Poulo"
echo "=========================================="

# -----------------------------------------------------------------------------
# CONFIGURATION: Set Project Directory
# -----------------------------------------------------------------------------
# This is the root directory containing the data/, scripts/, output/ folders
PROJECT_DIR="/mnt/c/sc_JabulanePoulo_2026/Sales Analysis Project 2026"

# -----------------------------------------------------------------------------
# STEP 1: Navigate to Project Directory
# -----------------------------------------------------------------------------
# cd: Change directory command
# The || { ... } construct means: if cd fails,
# execute the commands inside the braces and exit the script
cd "$PROJECT_DIR" || {
    echo "ERROR: Cannot enter project directory: $PROJECT_DIR"
    exit 1  # Exit with error code 1
}

echo "Project directory: $PROJECT_DIR"

# -----------------------------------------------------------------------------
# STEP 2: Validate and Prepare Input Data File
# -----------------------------------------------------------------------------
# The script checks for two possible filenames:
#   1. Sales_data.csv
#   2. Messy_Sales_Data.csv
# The -f flag tests if a file exists and is a regular file
if [ -f "data/Sales_data.csv" ]; then
    echo "Data file found: Sales_data.csv"
    
elif [ -f "data/Messy_Sales_Data.csv" ]; then
    echo "Renaming Messy_Sales_Data.csv to Sales_data.csv..."
    # mv: move/rename command
    mv "data/Messy_Sales_Data.csv" "data/Sales_data.csv"
    
else
    echo "ERROR: No data file found in data/ directory"
    # List directory contents to help user debug
    ls -la data/
    exit 1
fi

# -----------------------------------------------------------------------------
# STEP 3: Create Required Directories
# -----------------------------------------------------------------------------

mkdir -p output   # Stores processed CSV files (logs will go in output/logs/)

# -----------------------------------------------------------------------------
# STEP 4: Execute the Python Processing Script
# -----------------------------------------------------------------------------
echo ""
echo "Running Python script..."
echo ""

# Execute the Python script
# The script path is relative to the project root (we're already there)
python scripts/process_data.py

# -----------------------------------------------------------------------------
# STEP 5: Check Execution Result
# -----------------------------------------------------------------------------
# This check allows the shell script to report whether the pipeline succeeded
if [ $? -ne 0 ]; then  # -ne means "not equal"
    echo ""
    echo "=========================================="
    echo "PIPELINE FAILED "
    echo "=========================================="
    exit 1
fi

# -----------------------------------------------------------------------------
# STEP 6: Display Generated Files
# -----------------------------------------------------------------------------
echo ""
echo "=========================================="
echo "PIPELINE COMPLETED SUCCESSFULLY (kwenzekile)"
echo "=========================================="

echo ""
echo "Generated files in output/ directory:"
echo ""

# List all files in the output directory with detailed information
ls -la output/

# Also show the logs subdirectory if it exists
if [ -d "output/logs" ]; then
    echo ""
    echo "Log files in output/logs/:"
    ls -la output/logs/
fi

# Display a summary of what each file contains
echo ""
echo "File Summary:"
echo "  - clean_sales.csv: Complete cleaned sales data"
echo "  - sales_by_region.csv: Revenue by region "
echo "  - sales_by_product.csv: Revenue by product"
echo "  - sales_by_category.csv: Revenue by category"
echo "  - monthly_revenue.csv: Revenue by month"
echo "  - salesperson_performance.csv: All salespeople with revenue and rank"
echo "  - top_salespeople.csv: Top 5 performing salespeople"
echo "  - logs/*.csv: CSV format log files with execution audit trail"

echo ""
echo "=========================================="
echo "Pipeline execution complete! (kwenzekile)"
echo "=========================================="