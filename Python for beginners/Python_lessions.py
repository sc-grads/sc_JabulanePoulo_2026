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
# 28. EXCEPTION HANDLING (TRY, EXCEPT, ELSE, FINALLY)
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
print(f"a > c: {a > c}")    # False
print(f"a < c: {a < c}")    # True
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
print(f"(x > y) or (y < z): {(x > y) or (y < z)}")    # True
print(f"not (x > y): {not (x > y)}")                  # True


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

print(f"int(True): {int(True)}")   # 1
print(f"int(False): {int(False)}")  # 0

# Truthy/falsy examples
print(f"bool(1): {bool(1)}")       # True
print(f"bool(0): {bool(0)}")       # False
print(f"bool('Hello'): {bool('Hello')}")  # True
print(f"bool(''): {bool('')}")      # False
print(f"bool([]): {bool([])}")      # False


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
squares = [x**2 for x in range(10)]
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

print(f"Union: {set_a | set_b}")           # {1,2,3,4,5,6}
print(f"Intersection: {set_a & set_b}")     # {3,4}
print(f"Difference (A-B): {set_a - set_b}") # {1,2}
print(f"Symmetric Diff: {set_a ^ set_b}")   # {1,2,5,6}

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
squares = {x: x**2 for x in range(5)}
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
squares = [x**2 for x in range(10)]
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
find_item(fruits, "grape")   # grape not found.

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


# =============================================================================
# SUMMARY TABLE
# =============================================================================
"""
DATA TYPE QUICK REFERENCE:
Type     | Description              | Example
---------|--------------------------|-----------------
int      | Whole numbers            | age = 25
float    | Decimal numbers          | price = 19.99
str      | Text                     | name = "Alice"
bool     | True/False               | is_valid = True
list     | Ordered, mutable         | colors = ["red", "green"]
tuple    | Ordered, immutable       | point = (10, 20)
dict     | Key-value pairs          | {"name": "Alice"}
set      | Unordered, unique        | {1, 2, 3}
NoneType | Absence of value         | result = None

OPERATOR QUICK REFERENCE:
Category     | Operators
-------------|------------------------------------------
Arithmetic   | +, -, *, /, //, %, **
Comparison   | ==, !=, >, <, >=, <=
Logical      | and, or, not
Assignment   | =, +=, -=, *=, /=
"""


# =============================================================================
# MAIN EXECUTION (Examples)
# =============================================================================

def main():
    """Run demonstration examples."""
    print("\n" + "=" * 60)
    print("PYTHON FUNDAMENTALS DEMONSTRATION")
    print("=" * 60)
    
    # Variables demonstration
    print("\n--- VARIABLES ---")
    my_name = "Python Learner"
    my_age = 25
    print(f"Name: {my_name}, Age: {my_age}")
    
    # List demonstration
    print("\n--- LISTS ---")
    colors = ["red", "green", "blue"]
    colors.append("yellow")
    print(f"Colors: {colors}")
    
    # Dictionary demonstration
    print("\n--- DICTIONARIES ---")
    person = {"name": "Alice", "age": 30}
    print(f"Person: {person}")
    
    # Conditional demonstration
    print("\n--- CONDITIONALS ---")
    score = 85
    if score >= 90:
        grade = "A"
    elif score >= 80:
        grade = "B"
    elif score >= 70:
        grade = "C"
    else:
        grade = "F"
    print(f"Score: {score}, Grade: {grade}")
    
    # Loop demonstration
    print("\n--- LOOPS ---")
    print("Counting to 5:")
    for i in range(1, 6):
        print(f"  {i}")
    
    print("\n" + "=" * 60)
    print("Documentation complete! Use this file for reference.")
    print("=" * 60)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
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
# 27. FUNCTIONS
# =============================================================================
"""
A function is a block of organized, reusable code that performs a specific task.

WHY USE FUNCTIONS:
--------------------------------------------------------------------------------
Reason          | Explanation
----------------|----------------------------------------------------------
Reusability     | Write code once and use it multiple times
Maintainability | Update code in one place instead of multiple locations
Organization    | Break code into logical sections for better understanding
Debugging       | Isolate and test individual pieces of code
Abstraction     | Hide complex logic behind a simple function call

FUNCTION SYNTAX:
--------------------------------------------------------------------------------
def function_name(parameters):
    '''Optional docstring describing the function.'''
    # Function body
    return value  # Optional
"""


# Basic function examples
def say_hello():
    """Function with no parameters and no return value."""
    print("Hello, World!")


def greet(name):
    """Function with a parameter but no return value."""
    print(f"Hello, {name}!")


def add(a, b):
    """Function with parameters and a return value."""
    return a + b


# Calling functions
say_hello()  # Output: Hello, World!
greet("Alice")  # Output: Hello, Alice!
result = add(5, 3)  # result = 8
print(f"5 + 3 = {result}")


# Docstrings (function documentation)
def calculate_area(length, width):
    """
    Calculate the area of a rectangle.

    Parameters:
    length (float): The length of the rectangle.
    width (float): The width of the rectangle.

    Returns:
    float: The area of the rectangle.
    """
    return length * width


# Access the docstring
print(calculate_area.__doc__)


# =============================================================================
# 28. PARAMETERS VS. ARGUMENTS
# =============================================================================
"""
Parameters are variables in a function definition.
Arguments are actual values passed to the function when called.

DEFINITIONS:
--------------------------------------------------------------------------------
Term        | Definition                          | Location
------------|-------------------------------------|--------------------
Parameter   | Variable in function definition    | Function definition
Argument    | Actual value passed to function     | Function call

TYPES OF ARGUMENTS:
--------------------------------------------------------------------------------
Type                | Description                          | Example
--------------------|--------------------------------------|-----------------
Positional          | Assigned by order/position           | func(1, 2, 3)
Keyword             | Assigned by parameter name           | func(a=1, b=2)
Default parameters  | Have default values if not provided  | def func(a=10)
"""


def introduce(name, age, city):
    """Function with multiple parameters."""
    print(f"{name} is {age} years old and lives in {city}")


# Positional arguments (order matters)
introduce("Alice", 25, "New York")
# Output: Alice is 25 years old and lives in New York

# Keyword arguments (order doesn't matter)
introduce(city="London", name="Bob", age=30)
# Output: Bob is 30 years old and lives in London

# Default parameters
def greet_person(name="Guest"):
    print(f"Hello, {name}!")


greet_person()  # Output: Hello, Guest!
greet_person("Alice")  # Output: Hello, Alice!


# =============================================================================
# 29. RETURN STATEMENTS
# =============================================================================
"""
The return statement exits a function and sends a value back to the caller.

KEY POINTS:
--------------------------------------------------------------------------------
- Functions without return return None
- return immediately exits the function
- Can return multiple values as a tuple
- Can have multiple return statements (conditional returns)
"""


def add_numbers(a, b):
    """Returns the sum of two numbers."""
    return a + b


result = add_numbers(5, 3)
print(f"add_numbers(5, 3) = {result}")  # Output: 8


# Function without return (returns None)
def say_hello(name):
    print(f"Hello, {name}!")


result = say_hello("Alice")
print(f"Return value: {result}")  # Output: None


# Multiple return statements
def compare(a, b):
    if a > b:
        return "a is greater"
    elif b > a:
        return "b is greater"
    else:
        return "Both are equal"


print(compare(10, 5))   # Output: a is greater
print(compare(3, 7))    # Output: b is greater
print(compare(4, 4))    # Output: Both are equal


# Returning multiple values
def get_min_max(numbers):
    return min(numbers), max(numbers)


lowest, highest = get_min_max([10, 20, 5, 30, 15])
print(f"Lowest: {lowest}, Highest: {highest}")  # Output: Lowest: 5, Highest: 30


# Return vs Print
def add_return(a, b):
    return a + b  # Value can be stored


def add_print(a, b):
    print(a + b)  # Only displays, cannot store


result_return = add_return(5, 3)  # result_return = 8
result_print = add_print(5, 3)  # Output: 8, result_print = None


# =============================================================================
# 30. LAMBDA FUNCTIONS
# =============================================================================
"""
Lambda functions are small, anonymous functions defined in one line.

SYNTAX: lambda parameters: expression

WHEN TO USE:
- Simple one-line operations
- As arguments to map(), filter(), sorted()
- When a small function is needed temporarily
"""

# Regular function vs Lambda
def square(x):
    return x ** 2


square_lambda = lambda x: x ** 2

print(square(5))          # Output: 25
print(square_lambda(5))   # Output: 25

# Lambda with multiple parameters
add_lambda = lambda a, b: a + b
print(add_lambda(3, 5))   # Output: 8

# Using lambda with map()
numbers = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x ** 2, numbers))
print(f"Squared: {squared}")  # Output: [1, 4, 9, 16, 25]

# Using lambda with filter()
evens = list(filter(lambda x: x % 2 == 0, numbers))
print(f"Evens: {evens}")  # Output: [2, 4]

# Using lambda with sorted()
pairs = [(1, 2), (3, 1), (5, 0)]
sorted_pairs = sorted(pairs, key=lambda x: x[1])
print(f"Sorted by second element: {sorted_pairs}")  # Output: [(5, 0), (3, 1), (1, 2)]


# =============================================================================
# 31. RECURSION
# =============================================================================
"""
Recursion is a technique where a function calls itself to solve a problem.

KEY COMPONENTS:
--------------------------------------------------------------------------------
Component       | Description
----------------|----------------------------------------------------------
Base Case       | Stops recursion (prevents infinite loops)
Recursive Case  | Function calls itself with modified arguments
Call Stack      | Each function call is placed on the stack

WHEN TO USE RECURSION:
- Tree and graph traversal
- Divide and conquer algorithms
- Problems with recursive definition (factorial, Fibonacci)
- Backtracking problems
"""


def factorial(n):
    """Calculate factorial using recursion."""
    # Base case
    if n == 0:
        return 1
    # Recursive case
    return n * factorial(n - 1)


print(f"factorial(5) = {factorial(5)}")  # Output: 120


def fibonacci(n):
    """Return the nth Fibonacci number."""
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n - 1) + fibonacci(n - 2)


print(f"fibonacci(7) = {fibonacci(7)}")  # Output: 13


def sum_numbers(n):
    """Return sum of numbers from 1 to n."""
    if n <= 0:
        return 0
    return n + sum_numbers(n - 1)


print(f"sum_numbers(5) = {sum_numbers(5)}")  # Output: 15


def power(base, exp):
    """Calculate base raised to exponent."""
    if exp == 0:
        return 1
    return base * power(base, exp - 1)


print(f"power(2, 4) = {power(2, 4)}")  # Output: 16


def is_palindrome(text):
    """Check if a string is a palindrome."""
    # Remove spaces and convert to lowercase
    text = text.lower().replace(" ", "")
    if len(text) <= 1:
        return True
    if text[0] != text[-1]:
        return False
    return is_palindrome(text[1:-1])


print(f"is_palindrome('racecar'): {is_palindrome('racecar')}")  # Output: True
print(f"is_palindrome('hello'): {is_palindrome('hello')}")  # Output: False

# Recursion limit
import sys

print(f"Default recursion limit: {sys.getrecursionlimit()}")  # Usually 1000


# =============================================================================
# 32. *ARGS AND **KWARGS
# =============================================================================
"""
*args and **kwargs allow functions to accept a variable number of arguments.

DEFINITIONS:
--------------------------------------------------------------------------------
Syntax      | Name          | What it receives           | Type
------------|---------------|----------------------------|----------
*args       | Star args     | Variable positional args   | Tuple
**kwargs    | Double star   | Variable keyword args      | Dict
"""


def sum_all(*args):
    """Sum any number of positional arguments."""
    total = 0
    for num in args:
        total += num
    return total


print(f"sum_all(1, 2, 3, 4) = {sum_all(1, 2, 3, 4)}")  # Output: 10
print(f"sum_all(5, 10, 15) = {sum_all(5, 10, 15)}")  # Output: 30
print(f"sum_all() = {sum_all()}")  # Output: 0


def print_info(**kwargs):
    """Print any number of keyword arguments."""
    for key, value in kwargs.items():
        print(f"  {key}: {value}")


print("print_info(name='Alice', age=25, city='New York'):")
print_info(name="Alice", age=25, city="New York")


def mixed_arguments(param1, *args, **kwargs):
    """Function combining regular params, *args, and **kwargs."""
    print(f"param1: {param1}")
    print(f"*args: {args}")
    print(f"**kwargs: {kwargs}")


print("\nmixed_arguments(1, 2, 3, name='Bob', age=30):")
mixed_arguments(1, 2, 3, name="Bob", age=30)

# Unpacking arguments
def add_three(a, b, c):
    return a + b + c


numbers = [1, 2, 3]
print(f"\nUnpacking list: add_three(*[1,2,3]) = {add_three(*numbers)}")  # Output: 6

person = {"name": "Alice", "age": 25, "city": "Boston"}
print("\nUnpacking dictionary:")
print_info(**person)


# =============================================================================
# 33. SLASH (/) AND ASTERISK (*) IN FUNCTION SIGNATURES
# =============================================================================
"""
The / and * symbols control how arguments can be passed to functions.

SLASH (/) - Positional-Only Parameters:
--------------------------------------------------------------------------------
Parameters before / must be passed as positional arguments (not keyword).

ASTERISK (*) - Keyword-Only Parameters:
--------------------------------------------------------------------------------
Parameters after * must be passed as keyword arguments (not positional).
"""


# Positional-only parameters (before /)
def positional_only_func(a, b, /):
    return a + b


print(f"\npositional_only_func(1, 2) = {positional_only_func(1, 2)}")
# positional_only_func(a=1, b=2)  # TypeError!


# Keyword-only parameters (after *)
def keyword_only_func(a, *, b):
    return a + b


print(f"keyword_only_func(1, b=2) = {keyword_only_func(1, b=2)}")
# keyword_only_func(1, 2)  # TypeError!


# Combining both
def combined_func(pos1, pos2, /, standard, *, kw1, kw2):
    print(f"Positional-only: {pos1}, {pos2}")
    print(f"Standard (positional or keyword): {standard}")
    print(f"Keyword-only: {kw1}, {kw2}")


print("\ncombined_func(1, 2, 3, kw1=4, kw2=5):")
combined_func(1, 2, 3, kw1=4, kw2=5)

# Practical example
def divide(dividend, divisor, /, *, round_result=False):
    """
    Divide dividend by divisor.
    dividend and divisor must be positional.
    round_result must be keyword-only.
    """
    result = dividend / divisor
    if round_result:
        return round(result)
    return result


print(f"\ndivide(10, 3) = {divide(10, 3)}")
print(f"divide(10, 3, round_result=True) = {divide(10, 3, round_result=True)}")


# =============================================================================
# 34. PASS KEYWORD
# =============================================================================
"""
The pass keyword is a placeholder where Python expects an indented block of code
but you don't want to execute any action.

WHEN TO USE PASS:
- Empty functions (to be implemented later)
- Empty classes
- Placeholder in conditional statements
- Placeholder in loops
- Exception handling (when you want to ignore an exception)

WHY USE PASS:
- Allows you to structure your program without full implementation
- Prevents syntax errors from empty blocks
- Serves as a clear placeholder/marker for future code
"""


# Empty function placeholder
def future_function():
    pass  # TODO: Implement this function later


# Empty class placeholder
class FutureClass:
    pass  # TODO: Add methods and attributes


# Conditional placeholder
condition = True
if condition:
    pass  # TODO: Add logic here
else:
    print("Condition is false")


# Loop placeholder
for i in range(5):
    pass  # TODO: Add loop body


# Exception handling (ignore specific error)
try:
    file = open("config.txt", "r")
except FileNotFoundError:
    pass  # File doesn't exist, use defaults

# pass vs continue vs break
print("\npass example (does nothing):")
for i in range(5):
    if i == 2:
        pass  # Nothing happens, continues with i=3
    print(i, end=" ")

print("\n\ncontinue example (skips iteration):")
for i in range(5):
    if i == 2:
        continue  # Skips printing 2
    print(i, end=" ")

print("\n\nbreak example (exits loop):")
for i in range(5):
    if i == 2:
        break  # Stops loop when i=2
    print(i, end=" ")
print()


# =============================================================================
# 35. CHAT BOT (PRACTICAL PROJECT)
# =============================================================================
"""
A simple rule-based chat bot that responds to user input.

FEATURES:
- Responds to keywords with predefined answers
- Handles unknown inputs with default responses
- Exit command to quit the conversation
"""

import datetime
import random


def get_response(user_input):
    """
    Get a response from the bot based on user input.

    Parameters:
    user_input (str): The message from the user

    Returns:
    str: The bot's response
    """
    # Define the bot's responses (lists for variety)
    responses = {
        "hello": ["Hey there!", "Hi!", "Hello!", "Greetings!"],
        "how are you": ["I'm good, thanks!", "Doing great!", "All good here!"],
        "what time is it": [str(datetime.datetime.now().time())],
        "goodbye": ["It was nice talking to you, bye!", "See you later!", "Take care!"],
        "your name": ["I'm Bot, your virtual assistant!", "They call me Bot!"],
        "joke": [
            "Why do programmers prefer dark mode? Because light attracts bugs!",
            "What do you call a snake that codes? A python!",
            "Why did the programmer quit his job? Because he didn't get arrays!"
        ],
        "thanks": ["You're welcome!", "Happy to help!", "Anytime!"]
    }

    # Normalize input to lower case
    message = user_input.lower()

    # Check for specific keywords
    for key in responses:
        if key in message:
            return random.choice(responses[key])

    # Default responses for unknown inputs
    default_responses = [
        "I do not understand.",
        "Could you please rephrase that?",
        "Interesting... tell me more!",
        "I'm not sure what you mean."
    ]
    return random.choice(default_responses)


def chat():
    """Main chat function that runs the bot conversation loop."""
    print("=" * 50)
    print("WELCOME TO THE CHAT BOT")
    print("=" * 50)

    # Get user's name
    name = input("What's your name? ").strip()
    if not name:
        name = "Friend"
    print(f"\nNice to meet you, {name}!")
    print("You can start talking to me. Type 'help' for commands.")
    print("-" * 50)

    while True:
        user_input = input(f"{name}: ")

        # Check for exit commands
        if user_input.lower() in ["exit", "quit", "bye", "goodbye"]:
            print(f"\nBot: It was a pleasure talking to you, {name}! Goodbye!")
            break

        # Help command
        if user_input.lower() == "help":
            print("\nBot: Here are some things you can ask me:")
            print("  - hello, hi")
            print("  - how are you")
            print("  - what time is it")
            print("  - your name")
            print("  - tell me a joke")
            print("  - thank you, thanks")
            print("  - type 'exit' to quit")
            print("-" * 50)
            continue

        # Get bot response
        bot_response = get_response(user_input)
        print(f"Bot: {bot_response}")


# Uncomment to run the chat bot:
# if __name__ == "__main__":
#     chat()


# =============================================================================
# QUICK REFERENCE ADDITIONS
# =============================================================================
"""
FUNCTION RELATED QUICK REFERENCE:
--------------------------------------------------------------------------------
Concept                 | Syntax
------------------------|------------------------------------------
Basic function          | def func(): pass
Function with params    | def func(a, b): return a + b
Default parameter       | def func(a=10): pass
Return value            | return value
Lambda function         | lambda x: x * 2
*args                   | def func(*args): pass
**kwargs                | def func(**kwargs): pass
Positional-only (/)     | def func(a, b, /): pass
Keyword-only (*)        | def func(*, a, b): pass
pass placeholder        | def func(): pass

COMMON BUILT-IN FUNCTIONS:
--------------------------------------------------------------------------------
Function    | Description                    | Example
------------|--------------------------------|-----------------
print()     | Output to console              | print("Hello")
input()     | Get user input                 | name = input()
len()       | Get length of object           | len([1,2,3]) -> 3
type()      | Get type of object             | type(10) -> int
int()       | Convert to integer             | int("123") -> 123
float()     | Convert to float               | float("3.14") -> 3.14
str()       | Convert to string              | str(123) -> "123"
list()      | Convert to list                | list("abc") -> ['a','b','c']
sum()       | Sum an iterable                | sum([1,2,3]) -> 6
max()       | Get maximum value              | max([1,5,3]) -> 5
min()       | Get minimum value              | min([1,5,3]) -> 1
round()     | Round a number                 | round(3.14159, 2) -> 3.14
"""
# =============================================================================
# 36. EXCEPTION HANDLING (TRY, EXCEPT, ELSE, FINALLY)
# =============================================================================
"""
Exception handling allows your program to respond gracefully to errors that may
arise during execution.

WHY USE EXCEPTION HANDLING:
--------------------------------------------------------------------------------
Reason              | Explanation
--------------------|------------------------------------------------------
Error Management    | Prevents program crashes on unexpected input
User Feedback       | Provides clear error messages to users
Program Stability   | Allows program to continue running after errors
Resource Cleanup    | Ensures files/connections are closed properly

BASIC TRY/EXCEPT STRUCTURE:
--------------------------------------------------------------------------------
    try:
        # Code that might raise an exception
        risky_operation()
    except ExceptionType:
        # Code that runs if exception occurs
        handle_error()

CATCHING SPECIFIC EXCEPTIONS:
--------------------------------------------------------------------------------
"""

try:
    number = int(input("Enter a number: "))
    result = 100 / number
except ValueError:
    print("Error: Please enter a valid number!")
except ZeroDivisionError:
    print("Error: Cannot divide by zero!")

"""
CATCHING MULTIPLE EXCEPTIONS:
--------------------------------------------------------------------------------
"""

try:
    number = int(input("Enter a number: "))
    result = 100 / number
except (ValueError, ZeroDivisionError) as e:
    print(f"Error: {e}")

"""
TRY-EXCEPT-ELSE:
--------------------------------------------------------------------------------
The else block runs only if no exception occurred.
"""

try:
    number = int(input("Enter a number: "))
except ValueError:
    print("Invalid input!")
else:
    # This runs only if conversion succeeded
    print(f"You entered: {number}")

"""
TRY-EXCEPT-ELSE-FINALLY:
--------------------------------------------------------------------------------
The finally block ALWAYS runs, regardless of exceptions.
"""

try:
    file = open("data.txt", "r")
    content = file.read()
except FileNotFoundError:
    print("File not found!")
else:
    print(f"File has {len(content)} characters")
finally:
    # This ALWAYS runs - cleanup
    print("Closing file...")
    if 'file' in locals():
        file.close()

"""
COMMON EXCEPTION TYPES:
--------------------------------------------------------------------------------
Exception           | When It Occurs
--------------------|------------------------------------------------------
ValueError          | Invalid value conversion (int("abc"))
TypeError           | Operation on wrong type (5 + "hello")
ZeroDivisionError   | Division by zero
FileNotFoundError   | File does not exist
KeyError            | Dictionary key not found
IndexError          | List index out of range
AttributeError      | Object has no such attribute
ImportError         | Module or function not found
"""


# =============================================================================
# 37. THE RAISE KEYWORD
# =============================================================================
"""
The raise keyword is used to intentionally trigger an exception.

WHY USE RAISE:
--------------------------------------------------------------------------------
Reason              | Explanation
--------------------|------------------------------------------------------
Input Validation    | Signal when input doesn't meet requirements
Precondition Check  | Ensure conditions are met before execution
Error Propagation   | Pass errors up the call stack
API Design          | Create clear error behavior for functions

BASIC SYNTAX:
--------------------------------------------------------------------------------
    raise ExceptionType("Error message")

EXAMPLES:
--------------------------------------------------------------------------------
"""

def set_age(age):
    if age < 0:
        raise ValueError("Age cannot be negative")
    if age > 150:
        raise ValueError("Age cannot exceed 150")
    return age

try:
    set_age(-5)
except ValueError as e:
    print(f"Error: {e}")

"""
CUSTOM EXCEPTIONS:
--------------------------------------------------------------------------------
"""

class InsufficientFundsError(Exception):
    """Raised when withdrawal exceeds balance."""
    pass

class NegativeDepositError(Exception):
    """Raised when deposit amount is negative."""
    pass

def withdraw(balance, amount):
    if amount < 0:
        raise NegativeDepositError("Cannot withdraw negative amount")
    if amount > balance:
        raise InsufficientFundsError(f"Insufficient funds: {balance}")
    return balance - amount

"""
RE-RAISING EXCEPTIONS:
--------------------------------------------------------------------------------
"""

def process_file(filename):
    try:
        file = open(filename, 'r')
        return file.read()
    except FileNotFoundError as e:
        print(f"Log: File {filename} not found")
        raise  # Re-raise the same exception


# =============================================================================
# 38. TRUTHY AND FALSY VALUES
# =============================================================================
"""
Every value in Python has an inherent truth value when evaluated in a boolean
context.

DEFINITIONS:
--------------------------------------------------------------------------------
Term        | Definition
------------|----------------------------------------------------------
Truthy      | Value that evaluates to True in a boolean context
Falsy       | Value that evaluates to False in a boolean context

TRUTHY VALUES (Evaluate to True):
--------------------------------------------------------------------------------
Category            | Examples
--------------------|------------------------------------------------------
Non-empty strings   | "hello", " ", "0"
Non-zero numbers    | 1, -1, 3.14, -5.5
Non-empty lists     | [1, 2], [0], ["a"]
Non-empty tuples    | (1,), ("a", "b")
Non-empty dicts     | {"key": "value"}, {1: "one"}
Non-empty sets      | {1, 2, 3}, {"a"}
Boolean True        | True

FALSY VALUES (Evaluate to False):
--------------------------------------------------------------------------------
Category            | Examples
--------------------|------------------------------------------------------
None                | None
Boolean False       | False
Zero numbers        | 0, 0.0, 0j
Empty strings       | ""
Empty lists         | []
Empty tuples        | ()
Empty dicts         | {}
Empty sets          | set()

WHY USE TRUTHINESS:
--------------------------------------------------------------------------------
Benefit             | Explanation
--------------------|------------------------------------------------------
Cleaner Code        | if data: vs if len(data) > 0:
More Readable       | Natural language feel
Type Flexible       | Works with strings, lists, dicts, None, numbers
Pythonic            | Follows community best practices

EXAMPLES:
--------------------------------------------------------------------------------
"""

# Check if list has items
shopping_cart = []
if shopping_cart:
    print("Cart has items")
else:
    print("Cart is empty")

# Provide default value
name = input("Enter name: ") or "Guest"

# Filter falsy values
data = [1, 0, "hello", "", None, 42]
clean = [x for x in data if x]
print(clean)  # [1, "hello", 42]


# =============================================================================
# 39. MODULES
# =============================================================================
"""
A module is a single file containing Python code that can be imported and used
in other scripts.

WHY USE MODULES:
--------------------------------------------------------------------------------
Benefit             | Explanation
--------------------|------------------------------------------------------
Organization        | Groups related code into logical files
Reusability         | Write once, use across multiple scripts
Maintainability     | Update code in one place
Namespace Management| Prevents naming conflicts
Scalability         | Makes large projects manageable

CREATING A MODULE:
--------------------------------------------------------------------------------
    # Save as greetings.py
    def say_hello(name):
        return f"Hello, {name}!"

    def say_goodbye(name):
        return f"Goodbye, {name}!"

    DEFAULT_GREETING = "Hello"

IMPORTING MODULES:
--------------------------------------------------------------------------------
Method                      | Syntax
----------------------------|-----------------------------------------------
Import entire module        | import greetings
Import specific function    | from greetings import say_hello
Import with alias           | import greetings as gr
Import all (not recommended)| from greetings import *
Import multiple items       | from greetings import say_hello, say_goodbye

EXAMPLE:
--------------------------------------------------------------------------------
    # main.py
    import greetings

    name = input("Enter your name: ")
    print(greetings.say_hello(name))

THE if __name__ == "__main__" GUARD:
--------------------------------------------------------------------------------
    # This code only runs when the file is executed directly
    # Not when imported as a module
    if __name__ == "__main__":
        print("This runs only when script is executed directly")
        main()

BENEFITS OF THE GUARD:
--------------------------------------------------------------------------------
Benefit                     | Explanation
----------------------------|------------------------------------------------------
Prevents Unintended Execution | Code doesn't run on import
Enables Testing             | Test code can be included in module
Dual Purpose                | Same file can be library AND script
Clean Imports               | No side effects when importing
"""


# =============================================================================
# 40. PACKAGES
# =============================================================================
"""
A package is a directory containing multiple modules and an __init__.py file.

PACKAGE STRUCTURE:
--------------------------------------------------------------------------------
    my_package/
        __init__.py
        module1.py
        module2.py
        subpackage/
            __init__.py
            submodule.py

THE __init__.py FILE:
--------------------------------------------------------------------------------
    # Can be empty or contain initialization code
    # Marks directory as a Python package

    # __init__.py example
    __version__ = "1.0.0"
    __author__ = "Python Developer"

    from .module1 import important_function
    from .module2 import another_function

    __all__ = ['important_function', 'another_function']

IMPORTING FROM PACKAGES:
--------------------------------------------------------------------------------
    # Import entire module from package
    from my_package import module1

    # Import specific function
    from my_package.module1 import important_function

    # Import subpackage
    from my_package.subpackage import submodule

    # Import using package alias
    import my_package as mp
"""


# =============================================================================
# 41. LIBRARIES VS. PACKAGES VS. MODULES
# =============================================================================
"""
Understanding the hierarchy of code organization in Python.

DEFINITIONS:
--------------------------------------------------------------------------------
Term        | Definition                          | Example
------------|-------------------------------------|-------------------
Module      | Single .py file                    | math.py
Package     | Directory with __init__.py          | urllib/
Library     | Collection of packages/modules      | requests, pandas

RELATIONSHIP HIERARCHY:
--------------------------------------------------------------------------------
    LIBRARY (Collection)
        │
        ├── PACKAGE 1 (Directory)
        │       ├── __init__.py
        │       └── module1.py
        │
        ├── PACKAGE 2 (Directory)
        │       ├── __init__.py
        │       └── module2.py
        │
        └── STANDALONE MODULE (single file)

KEY TAKEAWAYS:
--------------------------------------------------------------------------------
Takeaway                            | Explanation
------------------------------------|----------------------------------------
Libraries are broader than packages | A library can contain multiple packages
A package organizes modules         | Packages contain __init__.py
Modules are single files            | Smallest unit of code organization
Terminology is often loose          | "Library" used generically in conversation

EXAMPLES:
--------------------------------------------------------------------------------
    # Module (single file)
    import math          # math is a module

    # Package (directory with __init__.py)
    import urllib        # urllib is a package

    # Library (collection - term used loosely)
    import requests      # requests is called a library
    import numpy as np   # numpy is called a library
"""


# =============================================================================
# QUICK REFERENCE ADDITIONS
# =============================================================================
"""
EXCEPTION HANDLING QUICK REFERENCE:
--------------------------------------------------------------------------------
Concept                 | Syntax
------------------------|------------------------------------------
Basic try/except        | try: risky() except: handle()
Specific exception      | except ValueError as e:
Multiple exceptions     | except (TypeError, ValueError):
Try-except-else         | try: ... except: ... else: ...
Try-except-finally      | try: ... except: ... finally: ...
Raise exception         | raise ValueError("message")
Custom exception        | class MyError(Exception): pass

TRUTHINESS QUICK REFERENCE:
--------------------------------------------------------------------------------
Truthy values:          | if "text":, if 1:, if [1,2]:, if {"a":1}:
Falsy values:           | if not None:, if not 0:, if not "":, if not []:
Check truthiness        | bool(value)
Default value pattern   | value = user_input or "default"
Filter falsy values     | clean = [x for x in data if x]

MODULE/PACKAGE QUICK REFERENCE:
--------------------------------------------------------------------------------
Concept                 | Syntax
------------------------|------------------------------------------
Import module           | import module_name
Import function         | from module import function
Import with alias       | import module as alias
Module guard            | if __name__ == "__main__":
Create package          | directory + __init__.py
Import from package     | from package import module
"""

# =============================================================================
# END OF DOCUMENTATION
# =============================================================================

