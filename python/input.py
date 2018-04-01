with open("data.txt") as f:
    nums = [word for line in f for word in line.split()]
x = nums[0]
y = nums[1]
print (int(x)**2 + int(y)**2)
