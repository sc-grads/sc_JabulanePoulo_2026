#!/usr/bin/env python3
"""
===============================================================================
                    PYTHON FUNDAMENTALS DOCUMENTATION
===============================================================================

This file contains comprehensive documentation of Python fundamentals.
Use this as a reference guide and for version control on GitHub.

Author: Python Learner
Date: 2024
===============================================================================
"""

# =============================================================================
# TABLE OF CONTENTS
# =============================================================================
# 1. Syntax
# 2. Comments
# 3. Variables
# 4. Constants
# 5. Data Types
# 6. Sequence Types (Lists, Tuples, Strings, Range)
# 7. Type Hints (Type Annotations)
# 8. Integers
# 9. Floats
# 10. Comparison Operators
# 11. Logical Operators
# 12. Boolean Data Type
# 13. Strings (Detailed)
# 14. Type Conversion
# 15. Lists (Detailed)
# 16. Tuples (Detailed)
# 17. Sets (Detailed)
# 18. Frozensets (Detailed)
# 19. Dictionaries (Detailed)
# 20. None
# 21. Mad Libs Project
# 22. If, Elif, Else Statements
# 23. Ternary Operator
# 24. For Loops
# 25. Break and Continue
# 26. Else with Loops
# =============================================================================


# =============================================================================
# 1. SYNTAX
# =============================================================================
"""
Syntax is the set of rules that govern the structure of sentences in a language.

In Python, strings are always surrounded by quotes:
"""
print("Hello, World!")  # Valid syntax
# print(Hello, World!)   # Invalid syntax - missing quotes


# =============================================================================
# 2. COMMENTS
# =============================================================================
"""
Comments are lines of code that Python ignores. They start with #.

WHY USE COMMENTS:
- Clarify intent (explain WHY, not WHAT)
- Improve readability
- Explain complex logic
- Debugging (temporarily disable code)

BEST PRACTICES:
DO: Explain why, use for complex logic, keep comments up to date
DON'T: State the obvious, comment every line, leave outdated comments
"""

# This is a single-line comment
print("This code runs")  # This is an inline comment

# Multi-line comment (using multiple # symbols)
# This is a block of comments
# that spans multiple lines


# =============================================================================
# 3. VARIABLES
# =============================================================================
"""
A variable is a named storage location in memory that holds a value.

VARIABLE NAMING RULES:
- Start with letter or underscore (not a number)
- Can contain letters, numbers, underscores
- Case-sensitive
- No reserved keywords (if, else, for, etc.)

NAMING CONVENTIONS:
- snake_case: first_name (recommended for variables)
- PascalCase: PersonName (for classes)
- UPPER_CASE: MAX_SIZE (for constants)
"""

# Variable assignment
name = "Alice"
age = 25
height = 5.7
is_student = True

# Multiple assignment
x, y, z = 10, 20, 30
print(f"x={x}, y={y}, z={z}")

# Same value to multiple variables
a = b = c = 100
print(f"a={a}, b={b}, c={c}")

# =============================================================================
# 4. CONSTANTS
# =============================================================================
"""
A constant is a value that never changes.
Python doesn't enforce constants, but by convention use UPPER_CASE names.

WHY USE CONSTANTS:
- Improve readability (PI is clearer than 3.14159)
- Simplify maintenance (change in one place)
- Prevent errors (shows which values should remain fixed)
"""

PI = 3.14159
GRAVITY = 9.81
MAX_USERS = 100
DEFAULT_COLOR = "blue"

# =============================================================================
# 5. DATA TYPES
# =============================================================================
"""
A data type specifies which type of value a variable can hold.

BUILT-IN DATA TYPES:
Category     | Data Types
-------------|----------------------------------------
Text         | str
Numeric      | int, float, complex
Boolean      | bool
Sequence     | list, tuple, range
Mapping      | dict
Set          | set, frozenset
None         | NoneType

MUTABLE vs IMMUTABLE:
Mutable (can change):   list, dict, set, bytearray
Immutable (cannot change): int, float, str, tuple, bool, frozenset
"""

# Checking data types
x = 10
print(f"Type of x: {type(x)}")  # <class 'int'>
print(f"Is x an int? {isinstance(x, int)}")  # True

# =============================================================================
# 6. SEQUENCE TYPES
# =============================================================================
"""
Sequence types represent ordered collections of items.

COMMON SEQUENCE OPERATIONS:
- Indexing: seq[0], seq[-1]
- Slicing: seq[start:stop:step]
- Length: len(seq)
- Concatenation: seq1 + seq2
- Repetition: seq * n
- Membership: item in seq
"""

# List (mutable)
my_list = [10, 20, 30, 40, 50]
print(f"First element: {my_list[0]}")
print(f"Last element: {my_list[-1]}")
print(f"Slicing [1:4]: {my_list[1:4]}")
print(f"Reversed: {my_list[::-1]}")

# Tuple (immutable)
my_tuple = (10, 20, 30, 40, 50)
print(f"Tuple: {my_tuple}")

# String (immutable sequence of characters)
my_string = "Hello, World!"
print(f"String: {my_string}")
print(f"First char: {my_string[0]}")

# =============================================================================
# 7. TYPE HINTS (TYPE ANNOTATIONS)
# =============================================================================
"""
Type hints indicate expected data types. They are ignored at runtime but help
with code clarity and static type checking.

SYNTAX:
- Variable: name: type = value
- Function parameter: def func(param: type)
- Return value: def func() -> return_type
"""

# Variable type hints
name_hint: str = "Alice"
age_hint: int = 25
prices_hint: list[float] = [19.99, 29.99, 39.99]


# Function type hints
def greet(name: str) -> str:
    return f"Hello, {name}"


def add_numbers(a: int, b: int) -> int:
    return a + b


print(greet("Bob"))
print(f"5 + 3 = {add_numbers(5, 3)}")

# =============================================================================
# 8. INTEGERS
# =============================================================================
"""
Integers are whole numbers (positive, negative, or zero). Type: int

INTEGER OPERATIONS:
Operation    | Symbol | Example | Result
-------------|--------|---------|--------
Addition     | +      | 5 + 3   | 8
Subtraction  | -      | 10 - 4  | 6
Multiplication| *     | 7 * 6   | 42
Division     | /      | 15 / 2  | 7.5
Floor Division| //    | 15 // 2 | 7
Modulus      | %      | 15 % 2  | 1
Exponentiation| **    | 2 ** 4  | 16
"""

positive = 30
negative = -50
zero = 0
large = 10 ** 100  # Unlimited precision

print(f"Addition: 5 + 3 = {5 + 3}")
print(f"Floor Division: 15 // 2 = {15 // 2}")
print(f"Modulus: 15 % 2 = {15 % 2}")
print(f"Exponent: 2 ** 4 = {2 ** 4}")

# =============================================================================
# 9. FLOATS
# =============================================================================
"""
Floats are numbers with decimal points. Type: float

PRECISION LIMITATION:
Due to binary representation, some floats are not exact:
0.1 + 0.2 = 0.30000000000000004 (not exactly 0.3)

Use round() or Decimal for precise calculations.
"""

pi = 3.14159
temperature = -2.5
zero_float = 0.0
scientific = 2.5e-3  # 0.0025

print(f"0.1 + 0.2 = {0.1 + 0.2}")  # 0.30000000000000004
print(f"Rounded: {round(0.1 + 0.2, 1)}")  # 0.3

# For exact decimal calculations
from decimal import Decimal

exact_result = Decimal('0.1') + Decimal('0.2')
print(f"Decimal exact: {exact_result}")  # 0.3

# =============================================================================
# 10. COMPARISON OPERATORS
# =============================================================================
"""
Comparison operators return boolean values (True or False).

OPERATORS:
Operator | Name                     | Example
---------|--------------------------|---------
==       | Equal                    | 5 == 5 -> True
!=       | Not Equal                | 5 != 3 -> True
>        | Greater Than             | 5 > 3 -> True
<        | Less Than                | 5 < 3 -> False
>=       | Greater Than or Equal    | 5 >= 5 -> True
<=       | Less Than or Equal       | 5 <= 3 -> False
"""

a = 5
b = 5
c = 10

print(f"a == b: {a == b}")  # True
print(f"a != c: {a != c}")  # True
print(f"a > c: {a > c}")  # False
print(f"a < c: {a < c}")  # True
print(f"a >= b: {a >= b}")  # True
print(f"a <= b: {a <= b}")  # True

# =============================================================================
# 11. LOGICAL OPERATORS
# =============================================================================
"""
Logical operators combine multiple conditions.

OPERATORS:
Operator | Description                  | Example
---------|------------------------------|-----------------
and      | True if both are True        | True and False -> False
or       | True if at least one is True | True or False -> True
not      | Reverses boolean value       | not True -> False
"""

x = 10
y = 20
z = 30

print(f"(x < y) and (y < z): {(x < y) and (y < z)}")  # True
print(f"(x > y) or (y < z): {(x > y) or (y < z)}")  # True
print(f"not (x > y): {not (x > y)}")  # True

# =============================================================================
# 12. BOOLEAN DATA TYPE
# =============================================================================
"""
Booleans represent two states: True and False.

TRUTHY VALUES (convert to True):
- Non-zero numbers
- Non-empty strings
- Non-empty collections

FALSY VALUES (convert to False):
- 0, 0.0
- "" (empty string)
- [] (empty list)
- {} (empty dict)
- None
"""

is_connected = True
has_money = False

print(f"int(True): {int(True)}")  # 1
print(f"int(False): {int(False)}")  # 0

# Truthy/falsy examples
print(f"bool(1): {bool(1)}")  # True
print(f"bool(0): {bool(0)}")  # False
print(f"bool('Hello'): {bool('Hello')}")  # True
print(f"bool(''): {bool('')}")  # False
print(f"bool([]): {bool([])}")  # False

# =============================================================================
# 13. STRINGS (DETAILED)
# =============================================================================
"""
Strings are sequences of characters used to represent text.

STRING OPERATIONS:
- Concatenation: "Hello" + " World" = "Hello World"
- Repetition: "Hi" * 3 = "HiHiHi"
- Indexing: "Hello"[0] = "H"
- Slicing: "Hello"[1:4] = "ell"
- Length: len("Hello") = 5

COMMON STRING METHODS:
method      | description              | example
------------|--------------------------|-----------------
lower()     | convert to lowercase     | "HELLO".lower() = "hello"
upper()     | convert to uppercase     | "hello".upper() = "HELLO"
strip()     | remove whitespace        | "  hi  ".strip() = "hi"
replace()   | replace substring        | "hello".replace("e","a") = "hallo"
split()     | split into list          | "a,b,c".split(",") = ["a","b","c"]
join()      | join list with string    | "-".join(["a","b"]) = "a-b"
"""

# Creating strings
single = 'Hello'
double = "World"
multi = """This is a
multi-line string"""

# String methods
text = "  Python Programming  "
print(f"Original: '{text}'")
print(f"strip(): '{text.strip()}'")
print(f"upper(): '{text.upper()}'")
print(f"lower(): '{text.lower()}'")
print(f"replace(): '{text.replace('Python', 'Java')}'")

# String formatting (f-strings)
name = "Alice"
age = 25
greeting = f"Hello, {name}! You are {age} years old."
print(greeting)

# String formatting (format method)
greeting2 = "Hello, {}! You are {} years old.".format(name, age)
print(greeting2)

# =============================================================================
# 14. TYPE CONVERSION
# =============================================================================
"""
Type conversion is converting one data type to another.

IMPLICIT CONVERSION (automatic):
- Python automatically converts types when needed
- Example: int + float = float

EXPLICIT CONVERSION (type casting):
- int() - converts to integer
- float() - converts to float
- str() - converts to string
- bool() - converts to boolean
- list() - converts to list
- tuple() - converts to tuple
- set() - converts to set
"""

# Implicit conversion
result = 5 + 2.5  # int becomes float
print(f"5 + 2.5 = {result} (type: {type(result)})")

# Explicit conversion
num_str = "123"
num_int = int(num_str)
num_float = float(num_str)
print(f"int('123'): {num_int}")
print(f"float('123'): {num_float}")

# User input conversion (input always returns string)
# age = int(input("Enter your age: "))


# =============================================================================
# 15. LISTS (DETAILED)
# =============================================================================
"""
Lists are ordered, mutable collections that can hold multiple items.

LIST METHODS:
Method      | Description
------------|-------------------------------------------
append(x)   | Adds x to the end
insert(i,x) | Inserts x at index i
remove(x)   | Removes first occurrence of x
pop(i)      | Removes and returns element at index i
sort()      | Sorts the list in place
reverse()   | Reverses the list in place
index(x)    | Returns index of first x
count(x)    | Counts occurrences of x
clear()     | Removes all elements
copy()      | Returns a shallow copy

LIST COMPREHENSION:
[x**2 for x in range(10)] - creates list of squares
"""

# Creating lists
fruits = ["apple", "banana", "cherry"]
numbers = [1, 2, 3, 4, 5]
mixed = ["Alice", 30, True, 3.14]

# Accessing elements
print(f"First fruit: {fruits[0]}")
print(f"Last fruit: {fruits[-1]}")
print(f"Slicing: {fruits[1:3]}")

# Modifying lists
fruits.append("orange")
print(f"After append: {fruits}")
fruits.insert(1, "blueberry")
print(f"After insert: {fruits}")
fruits.remove("banana")
print(f"After remove: {fruits}")

# List comprehension
squares = [x ** 2 for x in range(10)]
print(f"Squares: {squares}")

# Iterating over lists
for fruit in fruits:
    print(f"Fruit: {fruit}")

# =============================================================================
# 16. TUPLES (DETAILED)
# =============================================================================
"""
Tuples are ordered, immutable collections.

WHY USE TUPLES:
- Data integrity (cannot be accidentally modified)
- Memory efficiency (use less memory than lists)
- Can be used as dictionary keys (unlike lists)
- Return multiple values from functions
"""

# Creating tuples
point = (10, 20)
person = ("Alice", 25, "Engineer")
single_element = (5,)  # Note: comma required

# Accessing elements
print(f"Point: {point[0]}, {point[1]}")
print(f"Person: {person[0]}, {person[1]}, {person[2]}")

# Tuple unpacking
x, y = point
print(f"Unpacked: x={x}, y={y}")

name, age, job = person
print(f"Name: {name}, Age: {age}, Job: {job}")

# Tuples are immutable
# point[0] = 15  # TypeError: 'tuple' object does not support item assignment

# Tuple as dictionary key
locations = {
    (40.7128, -74.0060): "New York",
    (34.0522, -118.2437): "Los Angeles"
}
print(f"Location: {locations[(40.7128, -74.0060)]}")

# =============================================================================
# 17. SETS (DETAILED)
# =============================================================================
"""
Sets are unordered collections of unique items.

SET OPERATIONS:
Operation | Symbol | Description
----------|--------|----------------------------
Union     | |      | All elements from both sets
Intersection| &    | Elements in both sets
Difference| -      | Elements in first but not second
Symmetric Diff| ^  | Elements in either but not both
"""

# Creating sets
unique_numbers = {1, 2, 3, 3, 4, 4, 5}  # Duplicates removed
print(f"Set with duplicates removed: {unique_numbers}")

# Set operations
set_a = {1, 2, 3, 4}
set_b = {3, 4, 5, 6}

print(f"Union: {set_a | set_b}")  # {1,2,3,4,5,6}
print(f"Intersection: {set_a & set_b}")  # {3,4}
print(f"Difference (A-B): {set_a - set_b}")  # {1,2}
print(f"Symmetric Diff: {set_a ^ set_b}")  # {1,2,5,6}

# Adding and removing
set_a.add(7)
print(f"After add: {set_a}")
set_a.discard(2)  # No error if not found
print(f"After discard: {set_a}")

# Remove duplicates from list
duplicates = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
unique = list(set(duplicates))
print(f"Unique list: {unique}")

# =============================================================================
# 18. FROZENSETS (DETAILED)
# =============================================================================
"""
Frozensets are immutable sets.

WHY USE FROZENSETS:
- Can be used as dictionary keys (regular sets cannot)
- Can be elements of other sets
- Immutable (cannot be modified after creation)
"""

# Creating frozensets
frozen = frozenset([1, 2, 3, 4, 5])
print(f"Frozenset: {frozen}")

# Frozensets are hashable (can be dictionary keys)
config = {
    frozenset(["read"]): "Reader",
    frozenset(["read", "write"]): "Editor"
}
print(f"Config: {config}")

# Frozensets in sets
set_of_frozensets = {
    frozenset([1, 2]),
    frozenset([3, 4]),
    frozenset([5, 6])
}
print(f"Set of frozensets: {set_of_frozensets}")

# Frozenset operations (return new frozensets)
a = frozenset([1, 2, 3])
b = frozenset([3, 4, 5])
print(f"Union: {a | b}")

# =============================================================================
# 19. DICTIONARIES (DETAILED)
# =============================================================================
"""
Dictionaries store data in key-value pairs.

DICTIONARY METHODS:
Method      | Description
------------|-------------------------------------------
keys()      | Returns view of all keys
values()    | Returns view of all values
items()     | Returns view of key-value pairs
get(key)    | Returns value or None if key not found
pop(key)    | Removes and returns value
update()    | Updates with another dictionary
clear()     | Removes all items
"""

# Creating dictionaries
person = {
    "name": "Alice",
    "age": 30,
    "city": "New York"
}
print(f"Person: {person}")

# Accessing values
print(f"Name: {person['name']}")
print(f"Age: {person.get('age')}")
print(f"Country (default): {person.get('country', 'USA')}")

# Modifying dictionaries
person["age"] = 31
person["country"] = "USA"
print(f"After modifications: {person}")

# Iterating over dictionaries
for key, value in person.items():
    print(f"{key}: {value}")

# Dictionary comprehension
squares = {x: x ** 2 for x in range(5)}
print(f"Squares dict: {squares}")

# Nested dictionary
weather_data = {
    "time": "12:00",
    "weather": {
        "morning": "sunny",
        "evening": "cloudy"
    }
}
print(f"Morning weather: {weather_data['weather']['morning']}")

# =============================================================================
# 20. NONE
# =============================================================================
"""
None represents the absence of a value.

WHY USE NONE:
- Placeholder for optional/missing values
- Default return value for functions with no return
- Sentinel value for "nothing"

CHECKING FOR NONE:
Use 'is None' or 'is not None' (not ==)
"""

no_value = None


def find_user(user_id):
    users = {1: "Alice", 2: "Bob"}
    return users.get(user_id)  # Returns None if not found


result = find_user(3)
if result is None:
    print("User not found")
else:
    print(f"User: {result}")

# None is falsy
if no_value:
    print("This won't print")
else:
    print("None is falsy")

# =============================================================================
# 21. MAD LIBS PROJECT
# =============================================================================
"""
Mad Libs is a game where users input words to create a silly story.
This is great practice for string manipulation and user input.
"""


def mad_libs():
    print("\n=== MAD LIBS GAME ===")
    print("Enter the following words to create a story:\n")

    # Get user inputs
    name = input("Enter a name: ")
    noun = input("Enter a noun: ")
    verb = input("Enter a verb: ")
    adjective = input("Enter an adjective: ")
    place = input("Enter a place: ")

    # Create the story
    story = f"""
    Once upon a time, there was a {adjective} person named {name}.
    {name} lived in a beautiful {noun} near the city of {place}.
    Every morning, {name} would {verb} to the market.
    One day, something magical happened that changed {name}'s life forever!
    """

    print("\n" + "=" * 50)
    print("YOUR MAD LIBS STORY")
    print("=" * 50)
    print(story)


# Uncomment to run:
# mad_libs()


# =============================================================================
# 22. IF, ELIF, ELSE STATEMENTS
# =============================================================================
"""
Conditional statements control program flow based on conditions.

WHEN TO USE:
- if: one condition, one action
- if-else: two possible outcomes
- if-elif: multiple exclusive conditions
- if-elif-else: multiple conditions with default
"""


def check_age(age):
    if age >= 21:
        return "Full access: You may enter any area."
    elif age >= 18:
        return "Limited access: You may enter with supervision."
    elif age >= 13:
        return "Restricted access: Must be accompanied by an adult."
    else:
        return "Access denied: You are too young."


print(f"Age 25: {check_age(25)}")
print(f"Age 19: {check_age(19)}")
print(f"Age 15: {check_age(15)}")
print(f"Age 10: {check_age(10)}")

# =============================================================================
# 23. TERNARY OPERATOR
# =============================================================================
"""
Ternary operator is shorthand for simple if-else statements.

SYNTAX: value_if_true if condition else value_if_false

WHEN TO USE: Simple binary assignments
WHEN NOT TO USE: Complex conditions or multiple elif cases
"""

# Standard if-else
age = 18
if age >= 18:
    status = "Adult"
else:
    status = "Minor"

# Ternary operator (same result)
status = "Adult" if age >= 18 else "Minor"
print(f"Status: {status}")

# More examples
x = 10
y = 20
max_value = x if x > y else y
print(f"Max of {x} and {y}: {max_value}")

# In list comprehensions
numbers = [1, 2, 3, 4, 5]
labels = ["Even" if n % 2 == 0 else "Odd" for n in numbers]
print(f"Labels: {labels}")

# =============================================================================
# 24. FOR LOOPS
# =============================================================================
"""
For loops iterate over sequences (lists, strings, ranges, etc.).

WHEN TO USE FOR LOOPS:
- Known number of iterations
- Processing all items in a collection
- Iterating over a range of numbers
- Working with strings character by character

COMMON PATTERNS:
- for item in iterable: basic iteration
- for i in range(n): repeat n times
- for i, item in enumerate(iterable): with index
- for a, b in zip(iter1, iter2): parallel iteration
"""

# Basic for loop
fruits = ["apple", "banana", "cherry"]
print("Fruits:")
for fruit in fruits:
    print(f"  {fruit}")

# Range loop
print("Numbers 0-4:")
for i in range(5):
    print(f"  {i}")

# With enumerate (index and value)
print("Indexed fruits:")
for i, fruit in enumerate(fruits):
    print(f"  {i}: {fruit}")

# With zip (parallel iteration)
names = ["Alice", "Bob", "Charlie"]
scores = [85, 92, 78]
print("Student scores:")
for name, score in zip(names, scores):
    print(f"  {name}: {score}")

# List comprehension (concise loop)
squares = [x ** 2 for x in range(10)]
print(f"Squares: {squares}")

# =============================================================================
# 25. BREAK AND CONTINUE
# =============================================================================
"""
break - Exits the loop completely
continue - Skips current iteration and continues to next

WHEN TO USE:
- break: Found what you're looking for, error condition, user wants to quit
- continue: Skip invalid data, skip certain values, ignore specific cases
"""

# Break example (exit loop when found)
numbers = [1, 3, 5, 8, 10, 12]
print("Searching for first even number:")
for num in numbers:
    if num % 2 == 0:
        print(f"  Found: {num}")
        break
    print(f"  {num} is odd, continuing...")

# Continue example (skip specific values)
print("\nNumbers except multiples of 3:")
for i in range(10):
    if i % 3 == 0:
        continue
    print(f"  {i}")


# Practical example: input validation
def get_valid_number():
    while True:
        user_input = input("Enter a number (or 'quit' to exit): ")
        if user_input.lower() == "quit":
            print("Goodbye!")
            return None
        if not user_input.isdigit():
            print("Invalid input. Please enter a number.")
            continue
        return int(user_input)


# Uncomment to test:
# number = get_valid_number()
# if number:
#     print(f"You entered: {number}")


# =============================================================================
# 26. ELSE WITH LOOPS
# =============================================================================
"""
The else block executes after a loop ONLY if the loop completed without a break.

WHEN TO USE:
- Search operations (found vs not found)
- Validation (all pass vs some fail)
- Prime number checking
"""


# Search example
def find_item(items, target):
    for item in items:
        if item == target:
            print(f"Found {target}!")
            break
    else:
        print(f"{target} not found.")


fruits = ["apple", "banana", "cherry"]
find_item(fruits, "banana")  # Found banana!
find_item(fruits, "grape")  # grape not found.


# Prime number checker
def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            print(f"{n} is divisible by {i}")
            break
    else:
        print(f"{n} is prime!")
        return True
    return False


is_prime(17)  # 17 is prime!
is_prime(20)  # 20 is divisible by 2

# !/usr/bin/env python3
"""
===============================================================================
                    PYTHON LEARNING FILE
===============================================================================

This file contains all the Python code examples including:
- Simple Adder
- Lists and Dictionaries
- Mad Libs
- While Loops
- For Loops with else
- Rock, Paper, Scissors Game

Author: Python Learner
===============================================================================
"""

import time
import random


# =============================================================================
# SIMPLE ADDER
# =============================================================================

def simple_adder():
    """A simple program that adds two numbers."""
    print("\n" + "=" * 50)
    print("SIMPLE ADDER")
    print("=" * 50)

    print("Welcome to your simple adder")
    print(30 * "-")

    a: str = input("Enter a value for a : ")
    b: str = input("Enter another value for b : ")

    print(30 * "-")

    print("The result is : ", int(a) + int(b))
    print("=" * 50)


# =============================================================================
# LISTS EXAMPLE
# =============================================================================

def list_example():
    """Demonstrates list operations."""
    print("\n" + "=" * 50)
    print("LISTS EXAMPLE")
    print("=" * 50)

    my_list = ["Alice", 30, True, [1, 2, 3]]

    my_first = my_list[0]
    print(f"First element: {my_first}")

    my_second = my_list[1]
    print(f"Second element: {my_second}")

    print("=" * 50)


# =============================================================================
# DICTIONARY EXAMPLE
# =============================================================================

def dictionary_example():
    """Demonstrates dictionary operations."""
    print("\n" + "=" * 50)
    print("DICTIONARY EXAMPLE")
    print("=" * 50)

    users = {"bob": 1, "luigi": 2}
    user_id = users["bob"]
    print(f"Bob's ID: {user_id}")

    # Adds a new key-value pair
    users["mario"] = 3
    print(f"After adding Mario: {users}")

    # Modifies the existing key-value pair
    users["luigi"] = 4
    print(f"After modifying Luigi: {users}")

    # Removes the key "bob" and its associated value
    del users["bob"]
    print(f"After deleting Bob: {users}")

    # Nested dictionary
    weather_data = {
        "time": "12:00",
        "weather": {
            "morning": "rain",
            "evening": "more rain"
        }
    }
    print(f"Weather data: {weather_data}")
    print(f"Morning weather: {weather_data['weather']['morning']}")
    print("=" * 50)


# =============================================================================
# MAD LIBS EXAMPLE
# =============================================================================

def mad_libs():
    """A fun Mad Libs game where users create a silly story."""
    print("\n" + "=" * 50)
    print("MAD LIBS GAME")
    print("=" * 50)

    name: str = input('Enter a name: ')
    noun_a: str = input('Enter a noun: ')
    verb_a: str = input('Enter a verb: ')
    number_a: str = input('Enter a number: ')
    number_b: str = input('Enter another number: ')

    story: str = f"""
    ----------------------------------------------------------------------
    This is a story about {name}, a strong and beautiful {noun_a} 
    who loved to {verb_a}.

    One day, {name} found {number_a} magical {noun_a}s and
    {verb_a}ed all the way to the castle.
    After {number_b} hours, {name} became a legend!
    ----------------------------------------------------------------------
    """

    print(story)
    print("=" * 50)


# =============================================================================
# WHILE LOOP EXAMPLE (INTERNET CONNECTION)
# =============================================================================

def internet_connection_demo():
    """Demonstrates a while loop with a connection simulation."""
    print("\n" + "=" * 50)
    print("WHILE LOOP DEMO - INTERNET CONNECTION")
    print("=" * 50)

    connected: bool = True

    while connected:
        print("Using internet...")
        time.sleep(1)  # Using 1 second instead of 10 for demo
        connected = False

    print("Connection ended")
    print("=" * 50)


# =============================================================================
# WHILE LOOP WITH USER INPUT
# =============================================================================

def chat_bot_demo():
    """Demonstrates a simple chat bot using a while loop."""
    print("\n" + "=" * 50)
    print("CHAT BOT DEMO (Type 'quit' to exit)")
    print("=" * 50)

    while True:
        user_input: str = input("You: ")

        if user_input.lower() == "quit":
            print("Bot: Goodbye!")
            break

        if user_input == "Hello":
            print('Bot: Hello World!')
        else:
            print("Bot: yes, that is interesting.")

    print("=" * 50)


# =============================================================================
# FOR LOOP WITH ELSE EXAMPLES
# =============================================================================

def for_loop_with_else_demo():
    """Demonstrates for loops with else clauses."""
    print("\n" + "=" * 50)
    print("FOR LOOP WITH ELSE DEMO")
    print("=" * 50)

    print("\n--- Without break - else executes ---")
    for i in range(5):
        print(i, end=" ")
    else:
        print("\nLoop completed normally")

    print("\n--- With break - else does NOT execute ---")
    for i in range(5):
        if i == 3:
            break
        print(i, end=" ")
    else:
        print("\nThis will not print")

    print("\n" + "=" * 50)


# =============================================================================
# ROCK, PAPER, SCISSORS GAME
# =============================================================================

def rock_paper_scissors():
    """A complete Rock, Paper, Scissors game against the AI."""
    print("\n" + "=" * 50)
    print("ROCK, PAPER, SCISSORS GAME")
    print("=" * 50)

    # Define the game moves with emojis
    moves = {
        "rock": "🪨",
        "paper": "📄",
        "scissors": "✂️"
    }

    valid_moves = list(moves.keys())

    print("Welcome to Rock, Paper, Scissors!")
    print("Type 'exit' to quit the game.")
    print("Let's start!")
    print("-" * 30)

    # Score tracking
    player_wins = 0
    ai_wins = 0
    ties = 0

    while True:
        user_input = input("\nEnter rock, paper, or scissors: ").lower()

        # Check if the user wants to exit
        if user_input == "exit":
            print("\n" + "-" * 30)
            print("FINAL SCORE:")
            print(f"  You: {player_wins}")
            print(f"  AI: {ai_wins}")
            print(f"  Ties: {ties}")
            print("Thanks for playing! Goodbye.")
            break

        # Validate user input
        if user_input not in valid_moves:
            print("Invalid input, please try again.")
            continue

        # Generate AI move
        ai_move = random.choice(valid_moves)

        # Show moves
        print(f"\nYou chose: {user_input} {moves[user_input]}")
        print(f"AI chose:  {ai_move} {moves[ai_move]}")

        # Determine the outcome
        if user_input == ai_move:
            print("It's a tie!")
            ties += 1
        elif (user_input == "rock" and ai_move == "scissors") or \
                (user_input == "scissors" and ai_move == "paper") or \
                (user_input == "paper" and ai_move == "rock"):
            print("You win!")
            player_wins += 1
        else:
            print("You lose!")
            ai_wins += 1

        # Show current score
        print(f"\nScore - You: {player_wins} | AI: {ai_wins} | Ties: {ties}")
        print("-" * 30)


# =============================================================================
# MAIN FUNCTION - RUN ALL EXAMPLES
# =============================================================================

def main():
    """Main function to run all examples."""
    print("\n" + "=" * 60)
    print("PYTHON LEARNING EXAMPLES")
    print("=" * 60)

    # Run all examples
    simple_adder()
    list_example()
    dictionary_example()
    mad_libs()
    internet_connection_demo()
    for_loop_with_else_demo()

    # Chat bot demo (commented by default - uncomment to run)
    # chat_bot_demo()

    # Run the Rock, Paper, Scissors game
    rock_paper_scissors()

    print("\n" + "=" * 60)
    print("THANK YOU FOR LEARNING PYTHON!")
    print("=" * 60)


# =============================================================================
# RUN THE PROGRAM
# =============================================================================

if __name__ == "__main__":
    main()

