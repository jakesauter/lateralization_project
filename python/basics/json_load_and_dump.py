import json

dict = {}

dict['tom'] = {
    'name': 'tom',
    'address': '2 whoknows st',
    'phone': '9111-911-911'
}

dict['bob'] = {
    'name': 'bob',
    'address': '1 whoknows st',
    'phone': '9341-923-914'
}


json_string = json.dumps(dict)
print(json_string)

# write this json string to a file

with open("json_test.json", 'w') as f:
    f.write(json_string)

# Now to read a json from file

json_file = open("json_test.json", "r")
json_string = json_file.read()

# use the json module to parse the json string
json_dict = json.loads(json_string)

# Access element of json formed dictionary
print(json_dict['bob'])
