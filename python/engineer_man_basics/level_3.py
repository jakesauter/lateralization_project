# Control Structures

#if/else/elif
age = 17

if age >= 18:
    print 'is an adult'
elif age>=12:
    print 'is a young adult'
elif age >=3:
    print 'is a child'
else:
    print 'is a baby'

# ternary

if age>=21:
    old_enough = True
else:
    old_enough = False

old_enough = True if age >= 21 else False

# while loop

while age < 50:
    print 'not old enough, current age is:', age
    age += 1
