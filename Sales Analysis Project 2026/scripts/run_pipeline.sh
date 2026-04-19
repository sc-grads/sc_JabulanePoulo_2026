#!/bin/bash
# =============================================================================
# SALES DATA PIPELINE Mastermind Script
# =============================================================================
# AUTHOR: Jabulane Prince Poulo

echo "=========================================="
echo "Sales Data Pipeline"
echo "Started at: $(date)"
echo "Author: Jabulane Prince Poulo"
echo "=========================================="

PROJECT_DIR="/mnt/c/sc_JabulanePoulo_2026/Sales Analysis Project 2026"

cd "$PROJECT_DIR" || {
    echo "ERROR: Cannot enter project directory: $PROJECT_DIR"
    exit 1
}

echo "Project directory: $PROJECT_DIR"

if [ -f "data/Sales_data.csv" ]; then
    echo "Data file found: Sales_data.csv"
else
    echo "ERROR: No data file found in data/ directory"
    ls -la data/
    exit 1
fi

mkdir -p output

echo ""
echo "Running Python script..."
echo ""

python scripts/process_data.py

if [ $? -ne 0 ]; then
    echo ""
    echo "=========================================="
    echo "PIPELINE FAILED"
    echo "=========================================="
    exit 1
fi

echo ""
echo "=========================================="
echo "PIPELINE COMPLETED SUCCESSFULLY"
echo "=========================================="

echo ""
echo "Generated files in output/ directory:"
echo ""

ls -la output/

if [ -d "output/logs" ]; then
    echo ""
    echo "Log files in output/logs/:"
    ls -la output/logs/
fi

echo ""
echo "File Summary:"
echo "  - clean_sales.csv: Complete cleaned sales data"
echo "  - sales_by_region.csv: Revenue by region"
echo "  - sales_by_product.csv: Revenue by product"
echo "  - sales_by_category.csv: Revenue by category"
echo "  - monthly_revenue.csv: Revenue by month"
echo "  - salesperson_performance.csv: All salespeople with revenue and rank"
echo "  - top_salespeople.csv: Top 5 performing salespeople"
echo "  - logs/logs.csv: Single CSV file with all execution audit trails"

echo ""
echo "=========================================="
echo "Pipeline execution complete"
echo "=========================================="