f = open("data.txt", 'r')
lines = [ line for line in f ]
out_file = open("even_lines.txt", 'w')
for i in range(0,len(lines)):
    if i%2==1:
        out_file.write(lines[i])
