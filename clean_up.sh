#!/bin/bash

# Check if input file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Get the input file from the argument
input_file="$1"

# Check if the input file has the "ext_" prefix
if [[ "$input_file" != ext_* ]]; then
    echo "Error: Input file must have an 'ext_' prefix."
    exit 1
fi

# Generate the output file name by replacing "ext_" with "cl_"
output_file="${input_file/ext_/cl_}"

# Remove non-printable characters
tr -cd '\11\12\15\40-\176' < "$input_file" > "temp_${output_file}"

# Remove extra spaces and tabs
sed -i 's/[[:space:]]\+/\t/g' "temp_${output_file}"

# Use awk to clean the data
awk -F'\t' 'NR == 1 || ($1 ~ /^rs/ && $2 != "" && $3 != "" && $4 != "" && $5 != "" && 
                        $4 != "NaN" && $4 != "NA" && $4 != "None" && $4 != "null" && $4 != "NULL" && $4 != "." && $4 != "Missing" && $4 != "missing" && $4 != "?" &&
                        $5 != "NaN" && $5 != "NA" && $5 != "None" && $5 != "null" && $5 != "NULL" && $5 != "." && $5 != "Missing" && $5 != "missing" && $5 != "?" &&
                        $4 != "inf" && $4 != "-inf" && $5 != "inf" && $5 != "-inf") {
    print $0
}' "temp_${output_file}" > "$output_file"

# Remove temporary file
rm "temp_${output_file}"

chmod -R 777 .

echo "Cleaned lines saved to $output_file"
