#!/bin/bash

# Check if the input file and column list are provided as arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_file.tsv> <col_list>"
    echo "Example: $0 your_input_file.tsv [2,6,7,12,13]"
    exit 1
fi

input_file="$1"
col_list="$2"

# Remove square brackets and spaces from the column list
col_list=$(echo $col_list | tr -d '[] ')

# Split the column list into individual columns
IFS=',' read -r -a cols <<< "$col_list"

# Check if exactly 5 columns are provided
if [ ${#cols[@]} -ne 5 ]; then
    echo "Error: Exactly 5 columns must be specified in the column list."
    exit 1
fi

output_file="ext_${input_file}"

# Extract and rename the columns to the desired format
awk -F'\t' -v col1="${cols[0]}" -v col2="${cols[1]}" -v col3="${cols[2]}" -v col4="${cols[3]}" -v col5="${cols[4]}" 'BEGIN {OFS="\t"}
NR==1 {
    # Print header
    print "SNP", "A1", "A2", "BETA", "SE"
}
NR>1 {
    # Print selected columns using the specified column numbers
    print $col1, $col2, $col3, $col4, $col5
}' "$input_file" > "$output_file"

# Change permissions of the current directory and its contents
chmod -R 777 .

echo "Extracted columns saved to $output_file and permissions changed."
