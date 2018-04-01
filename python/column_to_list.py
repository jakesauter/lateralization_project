import csv

file_name = "atypical_nodules.csv"
column = 2

f = open(file_name, 'r')
csv_in = csv.reader(f)
csv_in.next() #skip the header row

l = []

for row in csv_in:
    l.append(float(row[column]))

f.close()

f = open(file_name, 'w')
csv_out = csv.writer(f)

for i in range(0, len(l)):
    if count(l[i] > 1):
        del l[i]

#filter all duplicates
for row in l:
    csv_out.writerow([row])

f.close()
