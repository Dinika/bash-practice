#!/bin/bash
set -oeu pipefail
# set -o xtrace

INVOICE_DIR="$HOME/Documents/Work/Automattic/Invoices"
TEMPLATE_DIR="$INVOICE_DIR/automation"

TEMPLATE="$TEMPLATE_DIR/invoice-template.html"
CSS="$TEMPLATE_DIR/invoice.css"

month=$(date +%B)
year=$(date +%Y)
today=$(date +%Y-%m-%d)

current_invoice_name="Invoice $month $year Dinika Saxena"
current_invoice_path="$INVOICE_DIR/$current_invoice_name.html"

# Step 1: Make a copy of invoice_template by name "Invoice <month> <year> Dinika Saxena"
cp -v "$TEMPLATE" "$current_invoice_path"
# Step 2: Extract the invoice-number from COPY_INVOICE_TEMPLATE"
invoice_line=$(grep 'id="invoice-meta"' "$current_invoice_path")

# |...| → alternate delimiter
# Invoice number</strong>: ... → anchors to that exact string
# [A-Z]\+ → 1+ capital letters (VT)
# [0-9]\{4\} → 4-digit year
# /[0-9]\{3\} → 3-digit invoice number
invoice_number=$(echo "$invoice_line" | sed -n 's|.*Invoice number</strong>: \([A-Z]\+[0-9]\{4\}/[0-9]\{3\}\).*|\1|p') # Eg VT2025/001
number=${invoice_number#*/}                                                                                            # Eg 001
number=$(printf "%03d" $((10#$number + 1)))                                                                            # Increment the number and format it to 3 digits

# Step 3: Replace the old invoice number with new one in both - INVOICE_TEMPLATE and COPY_INVOICE_TEMPLATE
new_invoice_number="VT${year}/${number}" # Eg VT2025/001
sed -i "s|Invoice number</strong>: [A-Z]\+[0-9]\{4\}/[0-9]\{3\}|Invoice number</strong>: $new_invoice_number|" "$current_invoice_path"
sed -i "s|Invoice number</strong>: [A-Z]\+[0-9]\{4\}/[0-9]\{3\}|Invoice number</strong>: $new_invoice_number|" "$TEMPLATE"

# Step 4: Replace the {{DATE}} in COPY_INVOICE_TEMPLATE to current date YYYY-MM-DD
sed -i "s|{{DATE}}|${today}|g" "$current_invoice_path"

new_invoice_path="$INVOICE_DIR/${current_invoice_name}.pdf"
# Step 6: Convert COPY_INVOICE_TEMPLATE to pdf
pandoc "$current_invoice_path" -o "${new_invoice_path}" --css="$CSS" --pdf-engine=wkhtmltopdf

# Step 7: Delete the `COPY_INVOICE_TEMPLATE` html file
rm -v "$current_invoice_path"

# Step 8: Echo location of pdf
echo "Invoice PDF created at: $INVOICE_DIR/${current_invoice_name}.pdf"
