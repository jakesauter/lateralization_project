import csv 
#import pandas as pd

f = open("test.csv")
csv_f = csv.reader(f)

csv_f.next()

for row in csv_f: 
    print row[1]
