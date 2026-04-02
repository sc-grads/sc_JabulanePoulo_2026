
"""print("Welcome to your simple adder")
print(30* "-")

a: str = input("Enter a value for a :")
b: str = input("Enter another value for b :")

print(30* "-")

print("The result is : ", int(a) + int(b))
"""

"""my_list = ["Alice", 30, True, [1, 2, 3]]

my_fist = my_list[0]
print(my_fist)
my_second = my_list[1]
print(my_second)
"""
"""
users = {"bob": 1, "luigi": 2}
user_id = users["bob"]
users["mario"] = 3  # Adds a new key-value pair
users["luigi"] = 4  # Modifies the existing key-value pair
del users["bob"]    # Removes the key "bob" and its associated value

weather_data = {
    "time": "12:00",
    "weather": {
        "morning": "rain",
        "evening": "more rain"
    }
}
"""

name: str = input('Enter a name: ')
noun_a: str = input('Enter a noun: ')
verb_a: str = input('Enter a verb: ')
number_a: str = input('Enter a number: ')
number_b: str = input('Enter another number: ')


story: str = f"""
----------------------------------------------------------------------
This is a story about {name}, a strong (and beautiful) {noun_a} 
loved to {verb_a}.
"""
print(story)