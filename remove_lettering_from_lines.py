import re
import sys
import os

input_file_name = sys.argv[1]
output_file_name = input_file_name[0:-3] + "mat"

input_file = open(input_file_name, 'r')
output_file = open(output_file_name, 'w')

for line in input_file:
    output_file.write(re.sub("[a-z, :, (, )]", " ", line).strip() + "\n")

input_file.close()
output_file.close()

os.remove(input_file_name)
