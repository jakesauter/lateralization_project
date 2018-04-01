import gspread
from oauth2client.service_account import ServiceAccountCredentials

#connecting to the sheet
scope = ['https://spreadsheets.google.com/feeds']
creds = ServiceAccountCredentials.from_json_keyfile_name("client.json", scope)
client = gspread.authorize(creds)

#opening the sheet
sheet = client.open("Test").sheet1

#accessing records from the sheet
test = sheet.get_all_records()
print(test)

row_1 = sheet.row_values(1)
col_1 = sheet.col_values(1)
cell_0_0 = sheet.cell(1,1).value

#updating a cell on the sheet
sheet.update_cell(1,1,2)

#updating a row on the sheet
row = ["Hey", "Look", "A", "New", "Row"]
sheet.insert_row(row, 3)

#deleting a row of a sheet
sheet.delete_row(3)

#get row count of sheet
count = sheet.row_count
print("# of rows: ", count)
