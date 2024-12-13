import re

# Define the input file and output file
input_file = 'GCST90132226_SAS_SAS_pst_eff_a1_b0.5_phi1e-02.txt'
output_file = 'edited_GCST90132226_SAS_SAS_pst_eff_a1_b0.5_phi1e-02.txt'

# Open the input file and output file
with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
    for line in infile:
        # Use regex to capture the necessary parts (rsID, allele, and the value)
        match = re.match(r'\d+\s+(\S+)\s+\d+\s+(\S)\s+\S\s+([-\d\.e]+)', line)
        if match:
            # Extract the parts
            rsid = match.group(1)
            allele = match.group(2)
            value = match.group(3)
            # Write the new format to the output file
            outfile.write(f"{rsid}\t{allele}\t{value}\n")

