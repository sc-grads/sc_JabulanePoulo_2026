
# =============================================================================
# SALES DATA PIPELINE ORCHESTRATOR
# =============================================================================
# Project: TCO Graduate Project 2026
# Author: Graduate Candidate
# Date: April 2026
#
# DESCRIPTION:
# ============
# This shell script automates the entire sales data processing workflow.
# It serves as the orchestration layer that:
#     1. Sets up the correct working directory
#     2. Validates and prepares input data files
#     3. Creates required output and logging directories
#     4. Executes the Python ETL script
#     5. Reports success/failure and displays generated files
#
# WHY A SHELL SCRIPT?
# ===================
# - Enables automation via cron jobs or task schedulers
# - Provides a single command to run the entire pipeline
# - Handles environment setup that Python alone cannot (e.g., directory creation)
# - Captures and reports exit codes for monitoring
# - Can be extended to send email alerts, trigger downstream processes, etc.
#
# USAGE:
# ======
# From the project root directory:
#     ./scripts/run_pipeline.sh
#
# Or from anywhere (using absolute path):
#     /path/to/project/scripts/run_pipeline.sh
#
# EXPECTED DIRECTORY STRUCTURE:
# =============================
# Project Root/
# ├── data/
# │   └── Sales_data.csv (or Messy_Sales_Data.csv)
# ├── scripts/
# │   ├── process_data.py
# │   └── run_pipeline.sh
# ├── output/ (created automatically)
# └── logs/   (created automatically)
#
# EXIT CODES:
# ===========
# 0 - Pipeline completed successfully
# 1 - Pipeline failed (directory error, missing file, or Python script error)
# =============================================================================

# -----------------------------------------------------------------------------
# HEADER: Display Pipeline Start Information
# -----------------------------------------------------------------------------
# The echo command prints text to the console
# The = signs create a visual separator for readability
echo "=========================================="
echo "Sales Data Processing Pipeline"
echo "Started at: $(date)"  # $(date) executes the date command and inserts output
echo "=========================================="

# -----------------------------------------------------------------------------
# CONFIGURATION: Set Project Directory
# -----------------------------------------------------------------------------
# IMPORTANT: Update this path to match your actual project location!
# This is the root directory containing the data/, scripts/, output/ folders
# 
# Current path format for Git Bash on Windows:
# /c/ = C: drive, then full path using forward slashes
PROJECT_DIR="/mnt/c/sc_JabulanePoulo_2026/Sales Analysis Project 2026"

# -----------------------------------------------------------------------------
# STEP 1: Navigate to Project Directory
# -----------------------------------------------------------------------------
# cd: Change directory command
# The || { ... } construct means: if cd fails (returns non-zero exit code),
# execute the commands inside the braces and exit the script
#
# Why check this? If we can't find the project directory, nothing else will work
cd "$PROJECT_DIR" || {
    echo "ERROR: Cannot enter project directory: $PROJECT_DIR"
    exit 1  # Exit with error code 1
}

echo "Project directory: $PROJECT_DIR"

# -----------------------------------------------------------------------------
# STEP 2: Validate and Prepare Input Data File
# -----------------------------------------------------------------------------
# The script checks for two possible filenames:
#   1. Sales_data.csv (standard name expected by Python script)
#   2. Messy_Sales_Data.csv (sample data filename from project)
#
# Logic:
#   - If standard name exists → use it as-is
#   - If alternative name exists → rename it to standard name
#   - If neither exists → show error and exit
#
# The -f flag tests if a file exists and is a regular file
if [ -f "data/Sales_data.csv" ]; then
    echo "Data file found: Sales_data.csv"
    
elif [ -f "data/Messy_Sales_Data.csv" ]; then
    echo "Renaming Messy_Sales_Data.csv to Sales_data.csv..."
    # mv: move/rename command
    mv "data/Messy_Sales_Data.csv" "data/Sales_data.csv"
    
else
    echo "ERROR: No data file found in data/ directory!"
    # List directory contents to help user debug
    ls -la data/
    exit 1
fi

# -----------------------------------------------------------------------------
# STEP 3: Create Required Directories
# -----------------------------------------------------------------------------
# mkdir: make directory command
# -p flag: create parent directories if they don't exist
#          also prevents error if directory already exists
#
# These directories are expected by the Python script for output and logs
mkdir -p output   # Stores processed CSV files
mkdir -p logs     # Stores execution log files

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
# $? is a special shell variable that contains the exit code of the last command
# Exit code 0 means success, any non-zero value means failure
#
# This check allows the shell script to report whether the pipeline succeeded
if [ $? -ne 0 ]; then  # -ne means "not equal"
    echo ""
    echo "=========================================="
    echo "PIPELINE FAILED"
    echo "=========================================="
    exit 1
fi

# -----------------------------------------------------------------------------
# STEP 6: Success Report - Display Generated Files
# -----------------------------------------------------------------------------
echo ""
echo "=========================================="
echo "PIPELINE COMPLETED SUCCESSFULLY"
echo "=========================================="

echo ""
echo "Generated files in output/ directory:"
echo ""

# List all files in the output directory with detailed information
# -l: long format (permissions, size, date)
# -a: all files (including hidden, though none expected here)
ls -la output/

# Display a summary of what each file contains
echo ""
echo "File Summary:"
echo "  - clean_sales.csv: Complete cleaned transaction data"
echo "  - sales_by_region.csv: Revenue by region "
echo "  - sales_by_product.csv: Revenue by product"
echo "  - sales_by_category.csv: Revenue by category"
echo "  - monthly_revenue.csv: Revenue by month"
echo "  - salesperson_performance.csv: All salespeople with revenue and rank"
echo "  - top_salespeople.csv: Top 5 performing salespeople"

echo ""
echo "=========================================="
echo "Pipeline execution complete!"
echo "=========================================="