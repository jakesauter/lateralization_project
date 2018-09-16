# All about dictionaries

# initializing
my_dict = {}

# add item
my_dict['name'] = 'Jim'
my_dict['state'] = 'Georgia'
my_dict['age'] = 37

# access an item
print my_dict['name']

# change item
my_dict['name'] = 'not engineer man'

# remove item by index
del my_dict['state']

# iterate
for key, value in my_dict.iteritems():
    print key, "-->", value
