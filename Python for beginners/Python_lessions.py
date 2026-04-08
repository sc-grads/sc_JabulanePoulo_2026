#!/usr/bin/env python3
"""
===============================================================================
                    PYTHON FUNDAMENTALS DOCUMENTATION
===============================================================================

This comprehensive document covers all essential Python concepts from basics
to advanced topics including syntax, data types, control flow, functions,
object-oriented programming, error handling, modules, and more.

===============================================================================
"""

# =============================================================================
# TABLE OF CONTENTS
# =============================================================================
"""
SECTION 1: PYTHON BASICS
   1.1 Syntax
   1.2 Comments
   1.3 Variables
   1.4 Constants
   1.5 Data Types
   1.6 Type Hints
   1.7 Integers
   1.8 Floats
   1.9 Comparison Operators
   1.10 Logical Operators
   1.11 Boolean Data Type
   1.12 Strings
   1.13 Type Conversion

SECTION 2: COLLECTIONS
   2.1 Lists
   2.2 Tuples
   2.3 Sets
   2.4 Frozensets
   2.5 Dictionaries
   2.6 None Type

SECTION 3: CONTROL FLOW
   3.1 If/Elif/Else Statements
   3.2 Ternary Operator
   3.3 For Loops
   3.4 While Loops
   3.5 Break & Continue
   3.6 Else with Loops

SECTION 4: FUNCTIONS
   4.1 Functions
   4.2 Parameters vs Arguments
   4.3 Return Statements
   4.4 Lambda Functions
   4.5 Recursion
   4.6 *Args and **Kwargs
   4.7 Slash (/) and Asterisk (*)
   4.8 Pass Keyword

SECTION 5: ERROR HANDLING
   5.1 Try/Except/Else/Finally
   5.2 Raise Keyword
   5.3 Truthy & Falsy Values

SECTION 6: MODULES & ORGANIZATION
   6.1 Modules
   6.2 Packages
   6.3 Libraries vs Packages vs Modules
   6.4 Import Methods

SECTION 7: BUILT-IN FUNCTIONS
   7.1 print()
   7.2 enumerate()
   7.3 round()
   7.4 range()
   7.5 slice()
   7.6 globals()
   7.7 locals()
   7.8 all()
   7.9 any()
   7.10 isinstance()
   7.11 callable()
   7.12 filter()
   7.13 map()
   7.14 sorted()
   7.15 eval()
   7.16 exec()
   7.17 zip()

SECTION 8: ADVANCED CONCEPTS
   8.1 Doc Strings
   8.2 F-Strings
   8.3 Assertions
   8.4 Unpacking
   8.5 == vs is
   8.6 List Comprehensions
   8.7 Slicing
   8.8 Don't Loop & Modify

SECTION 9: OBJECT-ORIENTED PROGRAMMING
   9.1 Classes & Objects
   9.2 __init__() Method
   9.3 self Parameter
   9.4 Class & Instance Attributes
   9.5 Dunder Methods
   9.6 __str__() & __repr__()
   9.7 __eq__()
   9.8 Methods vs Functions
   9.9 Inheritance
   9.10 super()
   9.11 @staticmethod
   9.12 @classmethod
   9.13 @abstractmethod
   9.14 Name Mangling

SECTION 10: DATA CLASSES
   10.1 @dataclass
   10.2 Fields
   10.3 __post_init__
   10.4 InitVar
   10.5 @property

SECTION 11: ASYNCIO
   11.1 AsyncIO Basics
   11.2 Tasks
   11.3 asyncio.gather()

SECTION 12: FILE HANDLING
   12.1 Opening Files
   12.2 Reading Files
   12.3 Writing Files
   12.4 Appending to Files
   12.5 Working with JSON

SECTION 13: PROJECTS
   13.1 Simple Adder
   13.2 Mad Libs Game
   13.3 Rock, Paper, Scissors
   13.4 Grocery List
   13.5 Chat Bot
   13.6 Website Status Checker
   13.7 Note Taking App
"""

import time
import random
import sys
import datetime
import json
import math
from decimal import Decimal
from functools import wraps, lru_cache, cached_property
from dataclasses import dataclass, field, InitVar
from enum import Enum
from abc import ABC, abstractmethod
import asyncio


# =============================================================================
# SECTION 1: PYTHON BASICS
# =============================================================================

# -----------------------------------------------------------------------------
# 1.1 SYNTAX
# -----------------------------------------------------------------------------
"""
Syntax is the set of rules that govern the structure of sentences in a language.

In Python, strings are always surrounded by quotes. Syntax allows us to:
- Avoid errors (missing quotes, parentheses, or colons cause failures)
- Ensure consistency across all Python programmers
- Enable translation to machine code
"""

print("Hello, World!")  # Valid syntax
# print(Hello, World!)   # Invalid syntax - missing quotes


# -----------------------------------------------------------------------------
# 1.2 COMMENTS
# -----------------------------------------------------------------------------
"""
Comments are lines of code that Python ignores. They start with #.

WHY USE COMMENTS:
- Clarify intent (explain WHY, not WHAT)
- Improve readability for team members and your future self
- Explain complex logic or mathematical formulas
- Debug by temporarily disabling code
- Document assumptions or limitations

BEST PRACTICES:
DO: Explain why, use for complex logic, keep comments up to date
DON'T: State the obvious, comment every line, leave outdated comments
"""

# This is a single-line comment
print("This code runs")  # This is an inline comment

# This comment explains a non-obvious calculation
diagonal = math.sqrt(length**2 + width**2)  # length of the diagonal


# -----------------------------------------------------------------------------
# 1.3 VARIABLES
# -----------------------------------------------------------------------------
"""
A variable is a named storage location in memory that holds a value.

VARIABLE NAMING RULES:
- Must start with a letter (a-z, A-Z) or underscore (_)
- Cannot start with a number
- Can contain letters, numbers, and underscores
- Case-sensitive (Age and age are different)
- Cannot be a Python keyword (if, else, for, while, def, etc.)

NAMING CONVENTIONS:
- snake_case: first_name (recommended for variables)
- camelCase: firstName (not recommended in Python)
- PascalCase: PersonName (for classes)
- UPPER_CASE: MAX_SIZE (for constants)

VARIABLE SCOPE:
- Local: Created inside a function, accessible only within that function
- Global: Created outside any function, accessible throughout the program
- Enclosing: In nested functions, variables from the outer function
- Built-in: Predefined in Python (like print, len)
"""

# Variable assignment
name = "Alice"
age = 25
height = 5.7
is_student = True

# Multiple assignment in one line
x, y, z = 10, 20, 30
print(f"x={x}, y={y}, z={z}")

# Same value to multiple variables
a = b = c = 100
print(f"a={a}, b={b}, c={c}")

# Variable reuse (dynamic typing)
count = 10      # count is an int
count = "ten"   # count is now a str - Python allows this!


# -----------------------------------------------------------------------------
# 1.4 CONSTANTS
# -----------------------------------------------------------------------------
"""
A constant is a variable whose value is not intended to change during execution.

CONSTANTS vs VARIABLES:
Feature     | Variable        | Constant
------------|-----------------|------------------
Purpose     | Stores changing data | Stores fixed data
Value       | Can be reassigned | Should NOT be reassigned
Naming      | snake_case      | UPPER_CASE_WITH_UNDERSCORES
Enforcement | No restrictions | Convention only

WHY USE CONSTANTS:
- Make code more readable (PI is clearer than 3.14159)
- Easier maintenance (change in one place)
- Prevent accidental changes (naming convention warns programmers)
- Centralize configuration values
"""

# Configuration constants
DATABASE_HOST = "localhost"
DATABASE_PORT = 5432
API_KEY = "abc123xyz"
TIMEOUT_SECONDS = 30

# Mathematical constants
PI = 3.14159
GRAVITY = 9.81
MAX_USERS = 100
DEFAULT_COLOR = "blue"

# Status codes
HTTP_OK = 200
HTTP_NOT_FOUND = 404


# -----------------------------------------------------------------------------
# 1.5 DATA TYPES
# -----------------------------------------------------------------------------
"""
A data type specifies which type of value a variable can hold and what operations
can be performed on it.

WHY USE DATA TYPES:
- Memory Management: Different types require different memory amounts
- Determine Allowed Operations: Some operations only work on specific types
- Prevent Errors: Invalid operations raise errors
- Optimize Performance: Python can execute operations more efficiently

BUILT-IN DATA TYPES:
Category     | Data Types
-------------|------------------------------------------
Text         | str
Numeric      | int, float, complex
Boolean      | bool
Sequence     | list, tuple, range
Mapping      | dict
Set          | set, frozenset
Binary       | bytes, bytearray, memoryview
None         | NoneType

MUTABLE vs IMMUTABLE:
Mutable (can change):     list, dict, set, bytearray
Immutable (cannot change): int, float, str, tuple, bool, frozenset, bytes
"""

# Examples of each data type
integer_num = 42                    # int
float_num = 3.14159                 # float
complex_num = 2 + 3j                # complex
text_string = "Hello, World!"       # str
boolean_value = True                # bool
empty_value = None                  # NoneType

# Checking data types
print(f"Type of integer_num: {type(integer_num)}")      # <class 'int'>
print(f"Is integer_num an int? {isinstance(integer_num, int)}")  # True


# -----------------------------------------------------------------------------
# 1.6 TYPE HINTS (TYPE ANNOTATIONS)
# -----------------------------------------------------------------------------
"""
Type hints indicate expected data types. They are ignored at runtime but help
with code clarity and static type checking (using tools like mypy).

PURPOSE:
- Help other developers understand expected types
- Prevent errors by catching type inconsistencies early
- Improve IDE support (autocomplete, warnings)

SYNTAX:
- Variable: name: type = value
- Function parameter: def func(param: type)
- Return value: def func() -> return_type
- Collections: list[str], dict[str, int], tuple[float, ...]
"""

# Variable type hints
name_hint: str = "Alice"
age_hint: int = 25
prices_hint: list[float] = [19.99, 29.99, 39.99]
person_hint: dict[str, str] = {"name": "Alice", "city": "New York"}

# Function type hints
def greet(name: str) -> str:
    """Return a greeting message."""
    return f"Hello, {name}"

def add_numbers(a: int, b: int) -> int:
    """Return the sum of two integers."""
    return a + b

def process_items(items: list[str]) -> int:
    """Process a list of strings and return the count."""
    return len(items)

print(greet("Bob"))
print(f"5 + 3 = {add_numbers(5, 3)}")


# -----------------------------------------------------------------------------
# 1.7 INTEGERS
# -----------------------------------------------------------------------------
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

USE CASES:
- Counting: count = count + 1
- Indexing: list[index]
- Loop control: for i in range(10):
- Mathematical calculations: area = length * width
- Conditional logic: if age >= 18:
"""

# Integer examples
positive = 30
negative = -50
zero = 0
large = 10 ** 100  # Python integers have unlimited precision!

# Integer operations
print(f"Addition: 5 + 3 = {5 + 3}")
print(f"Subtraction: 10 - 4 = {10 - 4}")
print(f"Multiplication: 7 * 6 = {7 * 6}")
print(f"Division: 15 / 2 = {15 / 2}")        # Returns float
print(f"Floor Division: 15 // 2 = {15 // 2}") # Returns int
print(f"Modulus: 15 % 2 = {15 % 2}")         # Remainder
print(f"Exponent: 2 ** 4 = {2 ** 4}")

# Type conversion to int
decimal_string = "123"
converted_int = int(decimal_string)  # 123
float_number = 45.67
converted_from_float = int(float_number)  # 45 (truncates)


# -----------------------------------------------------------------------------
# 1.8 FLOATS
# -----------------------------------------------------------------------------
"""
Floats are numbers with decimal points. Type: float

PRECISION LIMITATION:
Due to binary representation, some floats are not exact:
0.1 + 0.2 = 0.30000000000000004 (not exactly 0.3)

SPECIAL FLOAT VALUES:
- float('inf'): Positive infinity
- float('-inf'): Negative infinity
- float('nan'): Not a Number

WHEN TO USE FLOATS:
- Measurements: length = 12.5
- Percentages: tax_rate = 0.0825
- Scientific calculations: gravity = 9.81
- Statistical data: average = 87.6

NOTE: For financial calculations requiring exact precision, use decimal.Decimal
"""

# Float examples
pi = 3.14159
temperature = -2.5
zero_float = 0.0
scientific = 2.5e-3  # 0.0025

# Float operations
print(f"Addition: 3.5 + 2.1 = {3.5 + 2.1}")
print(f"Multiplication: 4.5 * 2.0 = {4.5 * 2.0}")
print(f"Division: 10.0 / 3.0 = {10.0 / 3.0}")

# Precision issue demonstration
print(f"0.1 + 0.2 = {0.1 + 0.2}")  # 0.30000000000000004
print(f"Rounded: {round(0.1 + 0.2, 1)}")  # 0.3

# Comparing floats with tolerance
def floats_are_equal(a: float, b: float, tolerance: float = 1e-9) -> bool:
    """Compare two floats within a tolerance."""
    return abs(a - b) < tolerance

print(f"0.1 + 0.2 == 0.3: {floats_are_equal(0.1 + 0.2, 0.3)}")  # True

# For exact decimal calculations
from decimal import Decimal
exact_result = Decimal('0.1') + Decimal('0.2')
print(f"Decimal exact: {exact_result}")  # 0.3

# Special float values
positive_inf = float('inf')
negative_inf = float('-inf')
not_a_number = float('nan')

print(f"Is inf infinite? {math.isinf(positive_inf)}")  # True
print(f"Is nan not a number? {math.isnan(not_a_number)}")  # True


# -----------------------------------------------------------------------------
# 1.9 COMPARISON OPERATORS
# -----------------------------------------------------------------------------
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


# -----------------------------------------------------------------------------
# 1.10 LOGICAL OPERATORS
# -----------------------------------------------------------------------------
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


# -----------------------------------------------------------------------------
# 1.11 BOOLEAN DATA TYPE
# -----------------------------------------------------------------------------
"""
Booleans represent two states: True and False.

TRUTHY VALUES (convert to True):
- Any non-zero number: 1, -5, 3.14
- Any non-empty string: "Hello", " "
- Any non-empty collection: [1, 2], {"key": "value"}, (1,), {1, 2}
- True itself

FALSY VALUES (convert to False):
- 0, 0.0, 0j (zero numbers)
- "" (empty string)
- [] (empty list)
- () (empty tuple)
- {} (empty dict)
- set() (empty set)
- None
- False itself

NUMERIC REPRESENTATION:
- True is equivalent to 1
- False is equivalent to 0
"""

is_connected = True
has_money = False

print(f"int(True): {int(True)}")   # 1
print(f"int(False): {int(False)}")  # 0

# Boolean from comparison
score = 50
passing_score = 40
is_passed = (score >= passing_score)  # True

# Truthy/falsy examples
print(f"bool(1): {bool(1)}")              # True
print(f"bool(0): {bool(0)}")              # False
print(f"bool('Hello'): {bool('Hello')}")  # True
print(f"bool(''): {bool('')}")            # False
print(f"bool([]): {bool([])}")            # False
print(f"bool([1, 2]): {bool([1, 2])}")    # True
print(f"bool(None): {bool(None)}")        # False


# -----------------------------------------------------------------------------
# 1.12 STRINGS
# -----------------------------------------------------------------------------
"""
Strings are sequences of characters used to represent text.

STRING OPERATIONS:
- Concatenation: "Hello" + " World" = "Hello World"
- Repetition: "Hi" * 3 = "HiHiHi"
- Indexing: "Hello"[0] = "H"
- Slicing: "Hello"[1:4] = "ell"
- Length: len("Hello") = 5

COMMON STRING METHODS:
Method      | Description              | Example
------------|--------------------------|-----------------
lower()     | Convert to lowercase     | "HELLO".lower() = "hello"
upper()     | Convert to uppercase     | "hello".upper() = "HELLO"
strip()     | Remove whitespace        | "  hi  ".strip() = "hi"
lstrip()    | Remove left whitespace   | "  hi".lstrip() = "hi"
rstrip()    | Remove right whitespace  | "hi  ".rstrip() = "hi"
replace()   | Replace substring        | "hello".replace("e","a") = "hallo"
split()     | Split into list          | "a,b,c".split(",") = ["a","b","c"]
join()      | Join list with string    | "-".join(["a","b"]) = "a-b"
find()      | Find index of substring  | "hello".find("e") = 1
count()     | Count occurrences        | "banana".count("a") = 3
startswith()| Check prefix            | "hello".startswith("he") = True
endswith()  | Check suffix            | "hello".endswith("lo") = True
isdigit()   | Check if all digits      | "123".isdigit() = True
isalpha()   | Check if all letters     | "abc".isalpha() = True
isalnum()   | Check if alphanumeric    | "abc123".isalnum() = True

ESCAPE CHARACTERS:
\n = newline
\t = tab
\' = single quote
\" = double quote
\\ = backslash

STRING IMMUTABILITY:
Strings cannot be changed after creation. Operations that modify strings
actually create new strings.
"""

# Creating strings
single = 'Hello'
double = "World"
multi = """This is a
multi-line string"""
raw_string = r"C:\Users\Name"  # Raw string ignores escape characters

# String concatenation and repetition
print(f"Concatenation: 'Hello' + ' World' = {'Hello' + ' World'}")
print(f"Repetition: 'Hi' * 3 = {'Hi' * 3}")

# Indexing and slicing
text = "Hello, World!"
print(f"First character: {text[0]}")      # 'H'
print(f"Last character: {text[-1]}")      # '!'
print(f"Slicing [0:5]: {text[0:5]}")      # 'Hello'
print(f"Slicing [7:]: {text[7:]}")        # 'World!'
print(f"Reverse: {text[::-1]}")           # '!dlroW ,olleH'

# String methods
sample = "  Python Programming  "
print(f"Original: '{sample}'")
print(f"strip(): '{sample.strip()}'")
print(f"upper(): '{sample.upper()}'")
print(f"lower(): '{sample.lower()}'")
print(f"replace(): '{sample.replace('Python', 'Java')}'")
print(f"split(): {sample.split()}")

# String formatting - f-strings (Python 3.6+)
name = "Alice"
age = 25
price = 19.99
quantity = 3

greeting = f"Hello, {name}! You are {age} years old."
total = f"Total: ${price * quantity:.2f}"
print(greeting)
print(total)

# String formatting - format() method
greeting2 = "Hello, {}! You are {} years old.".format(name, age)
print(greeting2)

# String formatting - percent formatting (legacy)
greeting3 = "Hello, %s! You are %d years old." % (name, age)
print(greeting3)

# Checking string content
text = "Python programming"
print(f"'Python' in text: {'Python' in text}")     # True
print(f"'Java' not in text: {'Java' not in text}") # True
print(f"isdigit('12345'): {'12345'.isdigit()}")    # True
print(f"isalpha('abc'): {'abc'.isalpha()}")        # True
print(f"isalnum('abc123'): {'abc123'.isalnum()}")  # True

# String length
print(f"Length of 'Hello': {len('Hello')}")  # 5

# Common string patterns
text = "hello world"
print(f"Capitalize: {text.capitalize()}")    # "Hello world"
print(f"Title case: {text.title()}")         # "Hello World"
print(f"Swap case: {text.swapcase()}")       # "HELLO WORLD"


# -----------------------------------------------------------------------------
# 1.13 TYPE CONVERSION
# -----------------------------------------------------------------------------
"""
Type conversion is converting one data type to another.

IMPLICIT CONVERSION (automatic):
- Python automatically converts types when needed
- Example: int + float = float (int becomes float)

EXPLICIT CONVERSION (type casting):
- int() - converts to integer
- float() - converts to float
- str() - converts to string
- bool() - converts to boolean
- list() - converts to list
- tuple() - converts to tuple
- set() - converts to set
- dict() - converts to dictionary

NOTE: If conversion is not possible, Python raises ValueError
"""

# Implicit conversion
result = 5 + 2.5  # int becomes float
print(f"5 + 2.5 = {result} (type: {type(result)})")  # float

# Explicit conversion
num_str = "123"
num_int = int(num_str)      # 123
num_float = float(num_str)  # 123.0
num_str_back = str(num_int)  # "123"

print(f"int('123'): {num_int}")
print(f"float('123'): {num_float}")

# String to number conversion (safe way)
def safe_convert_to_int(value: str) -> int | None:
    """Safely convert a string to an integer."""
    try:
        return int(value)
    except ValueError:
        print(f"Error: '{value}' cannot be converted to an integer")
        return None

# List to string and back
words = ["Hello", "World"]
sentence = " ".join(words)      # "Hello World"
words_back = sentence.split()    # ["Hello", "World"]


# =============================================================================
# SECTION 2: COLLECTIONS
# =============================================================================

# -----------------------------------------------------------------------------
# 2.1 LISTS
# -----------------------------------------------------------------------------
"""
Lists are ordered, mutable collections that can hold multiple items.

WHY USE LISTS:
- Store multiple items in a single variable
- Easy to access and modify items
- Maintain order of items
- Iterate and process collections easily
- Hold mixed data types
- Support nested structures

LIST METHODS:
Method      | Description
------------|-------------------------------------------
append(x)   | Adds x to the end
extend(iter)| Adds all elements from iterable
insert(i,x) | Inserts x at index i
remove(x)   | Removes first occurrence of x
pop(i)      | Removes and returns element at index i
clear()     | Removes all elements
index(x)    | Returns index of first x
count(x)    | Counts occurrences of x
sort()      | Sorts the list in place
reverse()   | Reverses the list in place
copy()      | Returns a shallow copy

LIST COMPREHENSION:
[x**2 for x in range(10)] - creates list of squares
"""

# Creating lists
fruits = ["apple", "banana", "cherry"]
numbers = [1, 2, 3, 4, 5]
mixed = ["Alice", 30, True, 3.14]
nested = [[1, 2], [3, 4], [5, 6]]

# Accessing elements
print(f"First fruit: {fruits[0]}")        # "apple"
print(f"Last fruit: {fruits[-1]}")        # "cherry"
print(f"Slicing: {fruits[1:3]}")          # ["banana", "cherry"]

# Modifying lists
fruits.append("orange")
print(f"After append: {fruits}")

fruits.insert(1, "blueberry")
print(f"After insert: {fruits}")

fruits.remove("banana")
print(f"After remove: {fruits}")

popped = fruits.pop()  # Removes and returns last item
print(f"Popped: {popped}, List: {fruits}")

# Sorting and reversing
numbers_list = [3, 1, 4, 1, 5, 9, 2]
numbers_list.sort()
print(f"Sorted: {numbers_list}")

numbers_list.reverse()
print(f"Reversed: {numbers_list}")

# List comprehension
squares = [x**2 for x in range(10)]
print(f"Squares: {squares}")

# List comprehension with condition
even_squares = [x**2 for x in range(10) if x % 2 == 0]
print(f"Even squares: {even_squares}")

# Iterating over lists
print("Fruits:")
for fruit in fruits:
    print(f"  {fruit}")

# Iterating with index using enumerate
for i, fruit in enumerate(fruits):
    print(f"  {i}: {fruit}")

# Type hints for lists
string_list: list[str] = ["apple", "banana", "cherry"]
int_list: list[int] = [1, 2, 3, 4, 5]
mixed_list: list[str | int] = ["Alice", 30, "Bob", 25]


# -----------------------------------------------------------------------------
# 2.2 TUPLES
# -----------------------------------------------------------------------------
"""
Tuples are ordered, immutable collections.

WHY USE TUPLES:
- Data integrity (cannot be accidentally modified)
- Memory efficiency (use less memory than lists)
- Can be used as dictionary keys (unlike lists)
- Return multiple values from functions
- Faster than lists for iteration

CREATING TUPLES:
- Use parentheses: (1, 2, 3)
- Single element needs trailing comma: (5,)
- Tuple packing: t = 1, 2, 3
"""

# Creating tuples
point = (10, 20)
person = ("Alice", 25, "Engineer")
single_element = (5,)  # Note: comma required!
empty_tuple = ()
coordinates = 1, 2, 3  # Tuple packing

# Accessing elements (same as lists)
print(f"Point: {point[0]}, {point[1]}")
print(f"Person: {person[0]}, {person[1]}, {person[2]}")

# Slicing tuples
print(f"Person[0:2]: {person[0:2]}")

# Tuple unpacking
x, y = point
print(f"Unpacked: x={x}, y={y}")

name, age, job = person
print(f"Name: {name}, Age: {age}, Job: {job}")

# Tuples are immutable - this would raise an error:
# point[0] = 15  # TypeError: 'tuple' object does not support item assignment

# Tuple as dictionary key (lists cannot be used as keys)
locations = {
    (40.7128, -74.0060): "New York",
    (34.0522, -118.2437): "Los Angeles"
}
print(f"Location at (40.7128, -74.0060): {locations[(40.7128, -74.0060)]}")

# Tuple methods (only count and index)
numbers_tuple = (1, 2, 2, 3, 2, 4)
print(f"Count of 2: {numbers_tuple.count(2)}")  # 3
print(f"Index of 3: {numbers_tuple.index(3)}")  # 3


# -----------------------------------------------------------------------------
# 2.3 SETS
# -----------------------------------------------------------------------------
"""
Sets are unordered collections of unique items.

WHY USE SETS:
- Automatically remove duplicates
- Fast membership testing (O(1) average)
- Mathematical set operations (union, intersection, etc.)

SET OPERATIONS:
Operation | Symbol | Method           | Description
----------|--------|------------------|----------------------------
Union     | \|     | union()          | All elements from both sets
Intersection | &   | intersection()   | Elements in both sets
Difference | -     | difference()     | Elements in first but not second
Symmetric Diff | ^ | symmetric_difference() | Elements in either but not both

COMMON SET METHODS:
Method      | Description
------------|-------------------------------------------
add(x)      | Adds element x
remove(x)   | Removes x (raises error if missing)
discard(x)  | Removes x (no error if missing)
pop()       | Removes and returns arbitrary element
clear()     | Removes all elements
copy()      | Returns a shallow copy
"""

# Creating sets
unique_numbers = {1, 2, 3, 3, 4, 4, 5}  # Duplicates removed
print(f"Set with duplicates removed: {unique_numbers}")  # {1, 2, 3, 4, 5}

# Creating set from list (removes duplicates)
duplicates = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
unique = set(duplicates)
print(f"Unique from list: {unique}")

# Adding and removing elements
unique_numbers.add(6)
print(f"After add: {unique_numbers}")

unique_numbers.discard(2)  # No error if not found
print(f"After discard: {unique_numbers}")

# Set operations
set_a = {1, 2, 3, 4}
set_b = {3, 4, 5, 6}

print(f"Union (A | B): {set_a | set_b}")                 # {1,2,3,4,5,6}
print(f"Intersection (A & B): {set_a & set_b}")          # {3,4}
print(f"Difference (A - B): {set_a - set_b}")            # {1,2}
print(f"Symmetric Difference (A ^ B): {set_a ^ set_b}")  # {1,2,5,6}

# Subset and superset checks
print(f"A is subset of B: {set_a.issubset(set_b)}")      # False
print(f"A is superset of {1,2}: {set_a.issuperset({1,2})}")  # True
print(f"Sets are disjoint: {set_a.isdisjoint({5,6})}")   # False

# Iterating over sets (order not guaranteed)
print("Set elements:")
for item in unique_numbers:
    print(f"  {item}")

# Removing duplicates from list while preserving order
def unique_preserve_order(items):
    seen = set()
    return [x for x in items if not (x in seen or seen.add(x))]

original = [3, 1, 2, 3, 2, 4, 1, 5]
unique_ordered = unique_preserve_order(original)
print(f"Original: {original}")
print(f"Unique preserving order: {unique_ordered}")


# -----------------------------------------------------------------------------
# 2.4 FROZENSETS
# -----------------------------------------------------------------------------
"""
Frozensets are immutable sets.

WHY USE FROZENSETS:
- Can be used as dictionary keys (regular sets cannot)
- Can be elements of other sets
- Immutable (cannot be modified after creation)
- Hashable (unlike regular sets)

FROZENSET vs REGULAR SET:
Feature         | Set        | Frozenset
----------------|------------|-------------
Mutability      | Mutable    | Immutable
Hashable        | No         | Yes
Dictionary key  | No         | Yes
Element of set  | No         | Yes
add/remove      | Yes        | No
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
print(f"Intersection: {a & b}")
print(f"Difference: {a - b}")


# -----------------------------------------------------------------------------
# 2.5 DICTIONARIES
# -----------------------------------------------------------------------------
"""
Dictionaries store data in key-value pairs.

WHY USE DICTIONARIES:
- Fast lookups by key (O(1) average)
- Associate related data (like a real dictionary)
- Flexible: keys can be any immutable type
- Easy to modify, add, or remove entries

DICTIONARY METHODS:
Method      | Description
------------|-------------------------------------------
keys()      | Returns view of all keys
values()    | Returns view of all values
items()     | Returns view of key-value pairs
get(key)    | Returns value or None if key not found
pop(key)    | Removes and returns value
popitem()   | Removes and returns last inserted item
update()    | Updates with another dictionary
clear()     | Removes all items
copy()      | Returns a shallow copy

KEYS MUST BE UNIQUE AND IMMUTABLE:
- Valid keys: strings, numbers, tuples
- Invalid keys: lists, dictionaries, sets
"""

# Creating dictionaries
person = {
    "name": "Alice",
    "age": 30,
    "city": "New York"
}
print(f"Person: {person}")

# Creating with dict() constructor
person2 = dict(name="Bob", age=25, city="Boston")
print(f"Person2: {person2}")

# Accessing values
print(f"Name: {person['name']}")
print(f"Age: {person.get('age')}")
print(f"Country (default): {person.get('country', 'USA')}")

# Modifying dictionaries
person["age"] = 31
person["country"] = "USA"
print(f"After modifications: {person}")

# Adding new key-value pairs
person["occupation"] = "Engineer"
print(f"After adding occupation: {person}")

# Removing items
del person["occupation"]
print(f"After del: {person}")

popped_value = person.pop("city")
print(f"Popped city: {popped_value}, Person: {person}")

# Dictionary views
print(f"Keys: {list(person.keys())}")
print(f"Values: {list(person.values())}")
print(f"Items: {list(person.items())}")

# Iterating over dictionaries
print("Iterating over items:")
for key, value in person.items():
    print(f"  {key}: {value}")

# Dictionary comprehension
squares = {x: x**2 for x in range(5)}
print(f"Squares dict: {squares}")

# Nested dictionaries
weather_data = {
    "time": "12:00",
    "temperature": 72,
    "weather": {
        "morning": "sunny",
        "afternoon": "cloudy",
        "evening": "rainy"
    }
}
print(f"Morning weather: {weather_data['weather']['morning']}")

# Safe dictionary access
user_input = input("Enter a key to lookup: ")
value = person.get(user_input, "Key not found")
print(f"Value: {value}")


# -----------------------------------------------------------------------------
# 2.6 NONE TYPE
# -----------------------------------------------------------------------------
"""
None represents the absence of a value.

WHY USE NONE:
- Placeholder for optional/missing values
- Default return value for functions with no return
- Sentinel value for "nothing"
- Initialize variables that will have a value later

CHECKING FOR NONE:
Use 'is None' or 'is not None' (not ==)
"""

no_value = None

def find_user(user_id: int) -> str | None:
    """Find a user by ID. Returns None if not found."""
    users = {1: "Alice", 2: "Bob"}
    return users.get(user_id)  # Returns None if not found

# Proper way to check for None
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

# Default value pattern
def get_value(data, key, default=None):
    """Get value from dict or return default (None by default)."""
    return data.get(key, default)

config = {"theme": "dark"}
theme = get_value(config, "theme")
font = get_value(config, "font")  # Returns None


# =============================================================================
# SECTION 3: CONTROL FLOW
# =============================================================================

# -----------------------------------------------------------------------------
# 3.1 IF, ELIF, ELSE STATEMENTS
# -----------------------------------------------------------------------------
"""
Conditional statements control program flow based on conditions.

WHY USE CONDITIONAL STATEMENTS:
- Decision Making: Programs make choices based on conditions
- Dynamic Behavior: React differently to different inputs
- Error Handling: Prevent invalid operations by checking first
- User Interaction: Respond appropriately to user input
- Code Efficiency: Skip unnecessary code when conditions aren't met

WHEN TO USE:
- if: Single condition, no alternative needed
- if-else: Two possible outcomes
- if-elif: Multiple exclusive conditions, no default needed
- if-elif-else: Multiple conditions with a catch-all default
"""

def check_age(age: int) -> str:
    """Return access level based on age."""
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

# Multiple conditions with logical operators
temperature = 75
is_weekend = True

if temperature > 80 and is_weekend:
    print("Perfect day for the beach!")
elif temperature > 70 or is_weekend:
    print("Good day for outdoor activities.")
else:
    print("Maybe stay indoors.")

# Nested conditionals
def validate_login(username, password):
    if not username:
        print("Username is required")
    elif not password:
        print("Password is required")
    else:
        if username == "admin" and password == "secret":
            print("Login successful!")
        else:
            print("Invalid credentials")


# -----------------------------------------------------------------------------
# 3.2 TERNARY OPERATOR (SHORTHAND IF-ELSE)
# -----------------------------------------------------------------------------
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

# Nested ternary (use sparingly - can hurt readability)
score = 85
grade = "A" if score >= 90 else "B" if score >= 80 else "C" if score >= 70 else "F"
print(f"Grade: {grade}")


# -----------------------------------------------------------------------------
# 3.3 FOR LOOPS
# -----------------------------------------------------------------------------
"""
For loops iterate over sequences (lists, strings, ranges, etc.).

WHY USE FOR LOOPS:
- Automation: Perform same action multiple times without repetitive code
- Efficiency: Process hundreds of items with few lines
- Readability: Clear syntax showing iteration intent
- Predictability: Fixed number of iterations
- Data Processing: Essential for working with collections

COMMON PATTERNS:
- for item in iterable: basic iteration
- for i in range(n): repeat n times
- for i, item in enumerate(iterable): with index
- for a, b in zip(iter1, iter2): parallel iteration
"""

# Basic for loop over list
fruits = ["apple", "banana", "cherry"]
print("Fruits:")
for fruit in fruits:
    print(f"  {fruit}")

# For loop with range
print("Numbers 0-4:")
for i in range(5):
    print(f"  {i}")

# Range with start, stop, step
print("Even numbers 0-10:")
for i in range(0, 11, 2):
    print(f"  {i}")

# Range counting down
print("Countdown:")
for i in range(5, 0, -1):
    print(f"  {i}")

# For loop with enumerate (index and value)
print("Indexed fruits:")
for i, fruit in enumerate(fruits):
    print(f"  {i}: {fruit}")

# For loop with zip (parallel iteration)
names = ["Alice", "Bob", "Charlie"]
scores = [85, 92, 78]
print("Student scores:")
for name, score in zip(names, scores):
    print(f"  {name}: {score}")

# For loop over string
word = "Python"
print("Characters in 'Python':")
for char in word:
    print(f"  {char}")

# For loop over dictionary
person_dict = {"name": "Alice", "age": 30, "city": "New York"}
print("Dictionary items:")
for key, value in person_dict.items():
    print(f"  {key}: {value}")


# -----------------------------------------------------------------------------
# 3.4 WHILE LOOPS
# -----------------------------------------------------------------------------
"""
While loops repeat execution as long as a condition is True.

WHY USE WHILE LOOPS:
- Unknown number of iterations
- Waiting for a condition to change
- Reading input until valid
- Game loops
- Continuous monitoring

BE CAREFUL: Always ensure the condition eventually becomes False to avoid
infinite loops. Use break as an escape hatch.
"""

# Basic while loop - countdown
count = 5
while count > 0:
    print(f"Count: {count}")
    count -= 1
print("Finished countdown!")

# While loop for user input validation
def get_positive_number():
    """Keep asking until user enters a positive number."""
    while True:
        try:
            num = float(input("Enter a positive number: "))
            if num > 0:
                return num
            else:
                print("Number must be positive. Try again.")
        except ValueError:
            print("Invalid input. Please enter a number.")

# While loop with break
def find_first_even(numbers):
    """Find and return the first even number in a list."""
    i = 0
    while i < len(numbers):
        if numbers[i] % 2 == 0:
            print(f"Found even number: {numbers[i]}")
            return numbers[i]
        i += 1
    print("No even numbers found")
    return None

# Game loop example
def simple_game():
    """A simple game loop."""
    playing = True
    score = 0
    while playing:
        print(f"Score: {score}")
        # Simulate game logic
        score += 1
        if score >= 10:
            playing = False
    print("Game over!")


# -----------------------------------------------------------------------------
# 3.5 BREAK AND CONTINUE
# -----------------------------------------------------------------------------
"""
break - Exits the loop completely
continue - Skips current iteration and continues to next

WHEN TO USE:
- break: Found what you're looking for, error condition, user wants to quit
- continue: Skip invalid data, skip certain values, ignore specific cases

BREAK vs CONTINUE:
Keyword | Effect | When to Use | Loop Continues?
--------|--------|-------------|----------------
break   | Exits loop completely | Found target, error condition | No
continue| Skips current iteration | Invalid data, skip values | Yes
"""

# Break example - exit loop when found
numbers = [1, 3, 5, 8, 10, 12]
print("Searching for first even number:")
for num in numbers:
    if num % 2 == 0:
        print(f"  Found: {num}")
        break
    print(f"  {num} is odd, continuing...")

# Continue example - skip specific values
print("\nNumbers except multiples of 3:")
for i in range(10):
    if i % 3 == 0:
        continue
    print(f"  {i}")

# Break in while loop
def get_valid_input():
    """Get valid input from user with break."""
    while True:
        user_input = input("Enter 'quit' to exit: ")
        if user_input.lower() == 'quit':
            print("Goodbye!")
            break
        print(f"You entered: {user_input}")

# Continue for error handling
def process_numbers(numbers):
    """Process numbers, skipping invalid ones."""
    results = []
    for num in numbers:
        if not isinstance(num, (int, float)):
            print(f"Skipping invalid value: {num}")
            continue
        if num < 0:
            print(f"Skipping negative number: {num}")
            continue
        results.append(num * 2)
    return results


# -----------------------------------------------------------------------------
# 3.6 ELSE WITH LOOPS
# -----------------------------------------------------------------------------
"""
The else block executes after a loop ONLY if the loop completed without a break.

WHEN TO USE:
- Search operations (found vs not found)
- Validation (all pass vs some fail)
- Prime number checking

NOTE: This feature is less common and can be less readable for some developers.
Use it wisely based on your needs!
"""

# Search example - found vs not found
def find_item(items, target):
    """Search for an item and report if found."""
    for item in items:
        if item == target:
            print(f"Found {target}!")
            break
    else:
        print(f"{target} not found in list.")

fruits = ["apple", "banana", "cherry"]
find_item(fruits, "banana")  # Found banana!
find_item(fruits, "grape")   # grape not found.

# Prime number checker using for-else
def is_prime(n: int) -> bool:
    """Check if a number is prime."""
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

# While-else example
def find_value_with_limit(values, target, max_attempts=10):
    """Search for value with a limit on attempts."""
    attempts = 0
    while attempts < max_attempts and attempts < len(values):
        if values[attempts] == target:
            print(f"Found {target} at index {attempts}")
            break
        attempts += 1
    else:
        print(f"Could not find {target} within {max_attempts} attempts")


# =============================================================================
# SECTION 4: FUNCTIONS
# =============================================================================

# -----------------------------------------------------------------------------
# 4.1 FUNCTIONS
# -----------------------------------------------------------------------------
"""
A function is a block of organized, reusable code that performs a specific task.

WHY USE FUNCTIONS:
- Reusability: Write once, use multiple times
- Maintainability: Update in one place
- Organization: Break code into logical sections
- Debugging: Isolate and test individual pieces
- Abstraction: Hide complex logic behind simple calls

BEST PRACTICES FOR FUNCTIONS:
DO: Use descriptive names, keep functions small, use docstrings, return values
DON'T: Use single letters, create giant functions, print when you should return
"""

# Basic function examples
def say_hello() -> None:
    """Function with no parameters and no return value."""
    print("Hello, World!")

def greet(name: str) -> None:
    """Function with a parameter but no return value."""
    print(f"Hello, {name}!")

def add(a: int, b: int) -> int:
    """Function with parameters and a return value."""
    return a + b

# Calling functions
say_hello()
greet("Alice")
result = add(5, 3)
print(f"5 + 3 = {result}")

# Function with multiple return statements
def compare(a: int, b: int) -> str:
    """Compare two numbers and return a string result."""
    if a > b:
        return "a is greater"
    elif b > a:
        return "b is greater"
    else:
        return "Both are equal"

print(compare(10, 5))   # "a is greater"
print(compare(3, 7))    # "b is greater"
print(compare(4, 4))    # "Both are equal"

# Function returning multiple values (as tuple)
def get_min_max(numbers: list) -> tuple:
    """Return the minimum and maximum values from a list."""
    return min(numbers), max(numbers)

lowest, highest = get_min_max([10, 20, 5, 30, 15])
print(f"Lowest: {lowest}, Highest: {highest}")


# -----------------------------------------------------------------------------
# 4.2 PARAMETERS VS ARGUMENTS
# -----------------------------------------------------------------------------
"""
Parameters are variables in a function definition.
Arguments are actual values passed to the function when called.

TYPES OF ARGUMENTS:
- Positional: Assigned by order/position
- Keyword: Assigned by parameter name
- Default parameters: Have default values if not provided
- Variable-length: *args and **kwargs (see section 4.6)
"""

def introduce(name: str, age: int, city: str) -> None:
    """Function with multiple parameters."""
    print(f"{name} is {age} years old and lives in {city}")

# Positional arguments (order matters)
introduce("Alice", 25, "New York")
# Output: Alice is 25 years old and lives in New York

# Keyword arguments (order doesn't matter)
introduce(city="London", name="Bob", age=30)
# Output: Bob is 30 years old and lives in London

# Mixing positional and keyword (positional first)
introduce("Charlie", city="Paris", age=35)

# Default parameters
def greet_person(name: str = "Guest") -> None:
    """Greet a person, using Guest as default."""
    print(f"Hello, {name}!")

greet_person()        # Hello, Guest!
greet_person("Alice") # Hello, Alice!

# Default parameters with mutable types (be careful!)
def add_item(item, items=None):
    """Add item to list, creating new list if none provided."""
    if items is None:
        items = []
    items.append(item)
    return items

# Parameter ordering rules:
# 1. Positional parameters
# 2. Default parameters
# 3. *args (variable positional)
# 4. Keyword-only parameters
# 5. **kwargs (variable keyword)


# -----------------------------------------------------------------------------
# 4.3 RETURN STATEMENTS
# -----------------------------------------------------------------------------
"""
The return statement exits a function and sends a value back to the caller.

KEY POINTS:
- Functions without return return None
- return immediately exits the function
- Can return multiple values as a tuple
- Can have multiple return statements (conditional returns)

BENEFITS OF RETURN FUNCTIONS:
- Code Reusability: Write once, use multiple times
- Modularity: Break complex problems into smaller functions
- Data Transformation: Process input and produce output
- Testability: Predictable outputs for testing
- Composability: Combine functions by passing return values
"""

def add_numbers(a: int, b: int) -> int:
    """Return the sum of two numbers."""
    return a + b

result = add_numbers(5, 3)
print(f"add_numbers(5, 3) = {result}")

# Function without return (returns None)
def say_hello(name: str) -> None:
    print(f"Hello, {name}!")

result = say_hello("Alice")
print(f"Return value: {result}")  # None

# Early return (exit function early)
def process_age(age: int) -> str:
    """Process age with early returns."""
    if age < 0:
        return "Invalid age (negative)"
    if age > 150:
        return "Invalid age (too high)"
    if age < 18:
        return "Minor"
    return "Adult"

print(process_age(-5))   # "Invalid age (negative)"
print(process_age(200))  # "Invalid age (too high)"
print(process_age(15))   # "Minor"
print(process_age(25))   # "Adult"

# Returning multiple values
def get_stats(numbers: list) -> tuple:
    """Return multiple statistics as a tuple."""
    return min(numbers), max(numbers), sum(numbers) / len(numbers)

minimum, maximum, average = get_stats([1, 2, 3, 4, 5])
print(f"Min: {minimum}, Max: {maximum}, Avg: {average}")


# -----------------------------------------------------------------------------
# 4.4 LAMBDA FUNCTIONS
# -----------------------------------------------------------------------------
"""
Lambda functions are small, anonymous functions defined in one line.

SYNTAX: lambda parameters: expression

WHEN TO USE:
- Simple one-line operations
- As arguments to map(), filter(), sorted()
- When a small function is needed temporarily

WHEN NOT TO USE:
- Complex logic (use regular function)
- Need to reuse the function multiple times
- Need docstrings or debugging
"""

# Simple lambda function
square = lambda x: x ** 2
print(f"Lambda square: {square(5)}")  # 25

# Lambda with multiple parameters
add_lambda = lambda a, b: a + b
print(f"Lambda add: {add_lambda(3, 5)}")  # 8

# Using lambda with map()
numbers = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x ** 2, numbers))
print(f"Mapped squares: {squared}")

# Using lambda with filter()
evens = list(filter(lambda x: x % 2 == 0, numbers))
print(f"Filtered evens: {evens}")

# Using lambda with sorted()
pairs = [(1, 2), (3, 1), (5, 0)]
sorted_pairs = sorted(pairs, key=lambda x: x[1])
print(f"Sorted by second element: {sorted_pairs}")

# Lambda with sorted on strings (by length)
names = ['Alice', 'Bob', 'Charlie', 'David']
sorted_by_length = sorted(names, key=lambda x: len(x))
print(f"Sorted by length: {sorted_by_length}")


# -----------------------------------------------------------------------------
# 4.5 RECURSION
# -----------------------------------------------------------------------------
"""
Recursion is a technique where a function calls itself to solve a problem.

KEY COMPONENTS:
- Base Case: Stops recursion (prevents infinite loops)
- Recursive Case: Function calls itself with modified arguments
- Call Stack: Each function call is placed on the stack

WHEN TO USE RECURSION:
- Tree and graph traversal
- Divide and conquer algorithms
- Problems with recursive definition (factorial, Fibonacci)
- Backtracking problems

WARNING: Python has a recursion limit (usually 1000). Deep recursion may cause
RecursionError.
"""

def factorial(n: int) -> int:
    """Calculate factorial using recursion."""
    # Base case
    if n == 0:
        return 1
    # Recursive case
    return n * factorial(n - 1)

print(f"factorial(5) = {factorial(5)}")  # 120

# Recursion visualization:
# factorial(5) → 5 * factorial(4)
#            → 5 * (4 * factorial(3))
#            → 5 * (4 * (3 * factorial(2)))
#            → 5 * (4 * (3 * (2 * factorial(1))))
#            → 5 * (4 * (3 * (2 * (1 * factorial(0)))))
#            → 5 * (4 * (3 * (2 * (1 * 1)))) = 120

def fibonacci(n: int) -> int:
    """Return the nth Fibonacci number using recursion."""
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n - 1) + fibonacci(n - 2)

print(f"fibonacci(7) = {fibonacci(7)}")  # 13

def sum_numbers(n: int) -> int:
    """Return sum of numbers from 1 to n."""
    if n <= 0:
        return 0
    return n + sum_numbers(n - 1)

print(f"sum_numbers(5) = {sum_numbers(5)}")  # 15

def is_palindrome(text: str) -> bool:
    """Check if a string is a palindrome using recursion."""
    # Remove spaces and convert to lowercase
    text = text.lower().replace(" ", "")
    if len(text) <= 1:
        return True
    if text[0] != text[-1]:
        return False
    return is_palindrome(text[1:-1])

print(f"is_palindrome('racecar'): {is_palindrome('racecar')}")  # True
print(f"is_palindrome('hello'): {is_palindrome('hello')}")      # False

# Recursion limit
import sys
print(f"Default recursion limit: {sys.getrecursionlimit()}")

# Increase recursion limit if needed (use with caution)
# sys.setrecursionlimit(10000)


# -----------------------------------------------------------------------------
# 4.6 *ARGS AND **KWARGS
# -----------------------------------------------------------------------------
"""
*args and **kwargs allow functions to accept a variable number of arguments.

DEFINITIONS:
- *args: Variable number of positional arguments (received as tuple)
- **kwargs: Variable number of keyword arguments (received as dict)

ORDER: Regular params → *args → **kwargs

UNPACKING:
- *list unpacks list into positional arguments
- **dict unpacks dict into keyword arguments
"""

def sum_all(*args) -> int:
    """Sum any number of positional arguments."""
    total = 0
    for num in args:
        total += num
    return total

print(f"sum_all(1, 2, 3, 4) = {sum_all(1, 2, 3, 4)}")  # 10
print(f"sum_all(5, 10, 15) = {sum_all(5, 10, 15)}")    # 30
print(f"sum_all() = {sum_all()}")                      # 0

def print_info(**kwargs) -> None:
    """Print any number of keyword arguments."""
    for key, value in kwargs.items():
        print(f"  {key}: {value}")

print("print_info(name='Alice', age=25, city='New York'):")
print_info(name="Alice", age=25, city="New York")

def mixed_arguments(param1: str, *args, **kwargs) -> None:
    """Function combining regular params, *args, and **kwargs."""
    print(f"param1: {param1}")
    print(f"*args: {args}")
    print(f"**kwargs: {kwargs}")

print("\nmixed_arguments('hello', 1, 2, 3, name='Bob', age=30):")
mixed_arguments("hello", 1, 2, 3, name="Bob", age=30)

# Unpacking arguments
def add_three(a: int, b: int, c: int) -> int:
    """Add three numbers."""
    return a + b + c

numbers = [1, 2, 3]
print(f"\nUnpacking list: add_three(*[1,2,3]) = {add_three(*numbers)}")  # 6

# Unpacking dictionary
person_info = {"name": "Alice", "age": 25, "city": "Boston"}
print("\nUnpacking dictionary:")
print_info(**person_info)


# -----------------------------------------------------------------------------
# 4.7 SLASH (/) AND ASTERISK (*) IN FUNCTION SIGNATURES
# -----------------------------------------------------------------------------
"""
The / and * symbols control how arguments can be passed to functions.

SLASH (/) - Positional-Only Parameters:
Parameters before / must be passed as positional arguments (not keyword).

ASTERISK (*) - Keyword-Only Parameters:
Parameters after * must be passed as keyword arguments (not positional).

COMBINING BOTH:
Positional-only (before /) → Standard (between / and *) → Keyword-only (after *)
"""

# Positional-only parameters (before /)
def positional_only_func(a, b, /) -> int:
    """Parameters a and b must be positional."""
    return a + b

print(f"positional_only_func(1, 2) = {positional_only_func(1, 2)}")
# This would raise TypeError:
# positional_only_func(a=1, b=2)  # Error!

# Keyword-only parameters (after *)
def keyword_only_func(a, *, b) -> int:
    """Parameter b must be keyword-only."""
    return a + b

print(f"keyword_only_func(1, b=2) = {keyword_only_func(1, b=2)}")
# This would raise TypeError:
# keyword_only_func(1, 2)  # Error!

# Combining both
def combined_func(pos1, pos2, /, standard, *, kw1, kw2) -> None:
    """Demonstrate all three parameter types."""
    print(f"Positional-only: {pos1}, {pos2}")
    print(f"Standard (positional or keyword): {standard}")
    print(f"Keyword-only: {kw1}, {kw2}")

print("\ncombined_func(1, 2, 3, kw1=4, kw2=5):")
combined_func(1, 2, 3, kw1=4, kw2=5)

# Practical example
def divide(dividend: float, divisor: float, /, *, round_result: bool = False) -> float:
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


# -----------------------------------------------------------------------------
# 4.8 PASS KEYWORD
# -----------------------------------------------------------------------------
"""
The pass keyword is a placeholder where Python expects an indented block of code
but you don't want to execute any action.

WHEN TO USE PASS:
- Empty functions (to be implemented later)
- Empty classes
- Placeholder in conditional statements
- Placeholder in loops
- Exception handling (ignore specific errors)

BENEFITS:
- Structure program without full implementation
- Prevents syntax errors from empty blocks
- Clear placeholder/marker for future code
- Enables incremental development
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
# SECTION 5: ERROR HANDLING
# =============================================================================

# -----------------------------------------------------------------------------
# 5.1 TRY, EXCEPT, ELSE, FINALLY
# -----------------------------------------------------------------------------
"""
Exception handling allows your program to respond gracefully to errors.

WHY USE TRY/EXCEPT:
- Error Management: Prevents program crashes on unexpected input
- User Feedback: Provides clear error messages
- Program Stability: Allows program to continue after errors

STRUCTURE:
    try:
        # Code that might raise an exception
    except ExceptionType:
        # Code that runs if exception occurs
    else:
        # Code that runs if NO exception occurred
    finally:
        # Code that ALWAYS runs (cleanup)

COMMON EXCEPTION TYPES:
- ValueError: Invalid value conversion (int("abc"))
- TypeError: Operation on wrong type (5 + "hello")
- ZeroDivisionError: Division by zero
- FileNotFoundError: File does not exist
- KeyError: Dictionary key not found
- IndexError: List index out of range
"""

def safe_divide(a, b):
    """Divide two numbers with comprehensive error handling."""
    try:
        result = a / b
    except ZeroDivisionError:
        print("Error: Cannot divide by zero!")
        return None
    except TypeError:
        print("Error: Please provide numbers!")
        return None
    else:
        # This runs only if no exception occurred
        print(f"Result: {result}")
        return result
    finally:
        # This ALWAYS runs
        print("Division attempt completed.")

safe_divide(10, 2)
safe_divide(10, 0)

# Example with file handling
def read_file_safely(filename: str) -> str | None:
    """Read a file with proper error handling."""
    try:
        with open(filename, 'r') as file:
            content = file.read()
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found!")
        return None
    except PermissionError:
        print(f"Error: Permission denied for '{filename}'")
        return None
    except UnicodeDecodeError:
        print(f"Error: Cannot decode '{filename}'")
        return None
    else:
        print(f"Successfully read {len(content)} characters")
        return content
    finally:
        print(f"File operation completed for '{filename}'")

# Catching multiple exceptions
def validate_number(value: str) -> int | None:
    """Validate and convert a string to integer."""
    try:
        num = int(value)
        if num < 0:
            raise ValueError("Number must be non-negative")
        return num
    except (ValueError, TypeError) as e:
        print(f"Invalid input: {e}")
        return None

# Best practices
def best_practices_example():
    """Demonstrate exception handling best practices."""
    # DO: Catch specific exceptions
    try:
        risky_operation()
    except ValueError:
        handle_value_error()
    
    # DO: Use else for success code
    try:
        result = compute()
    except CalculationError:
        handle_error()
    else:
        process_result(result)
    
    # DO: Use finally for cleanup
    file = open("data.txt")
    try:
        process_file(file)
    finally:
        file.close()  # Always closes even if error occurs
    
    # DON'T: Use bare except (catches everything including SystemExit)
    # try:
    #     risky_operation()
    # except:  # Bad practice!
    #     pass


# -----------------------------------------------------------------------------
# 5.2 RAISE KEYWORD
# -----------------------------------------------------------------------------
"""
The raise keyword is used to intentionally trigger an exception.

WHY USE RAISE:
- Input Validation: Signal when input doesn't meet requirements
- Precondition Checking: Ensure conditions are met before execution
- Error Propagation: Pass errors up the call stack
- API Design: Create clear error behavior for function users
- Defensive Programming: Fail fast and explicitly when something is wrong

WHEN TO USE RAISE:
- Invalid Arguments (negative age, empty string for required field)
- Wrong Data Types (string passed where number expected)
- Precondition Failed (insufficient balance for withdrawal)
- Resource Unavailable (file doesn't exist, database disconnected)
- State Invalid (calling withdraw() on closed account)
- Operation Impossible (division by zero, sqrt of negative)
"""

def set_age(age: int) -> int:
    """Set age with validation."""
    if age < 0:
        raise ValueError("Age cannot be negative")
    if age > 150:
        raise ValueError("Age cannot exceed 150")
    return age

try:
    set_age(-5)
except ValueError as e:
    print(f"Error: {e}")

# Custom exceptions
class InsufficientFundsError(Exception):
    """Raised when withdrawal exceeds balance."""
    pass

class NegativeDepositError(Exception):
    """Raised when deposit amount is negative."""
    pass

class AccountClosedError(Exception):
    """Raised when operation is performed on closed account."""
    pass

class BankAccount:
    def __init__(self, account_number: str, initial_balance: float = 0):
        self.account_number = account_number
        self.balance = initial_balance
        self.is_open = True
    
    def withdraw(self, amount: float) -> float:
        """Withdraw money from account."""
        if not self.is_open:
            raise AccountClosedError(f"Account {self.account_number} is closed")
        if amount < 0:
            raise NegativeDepositError("Cannot withdraw negative amount")
        if amount > self.balance:
            raise InsufficientFundsError(f"Insufficient funds: {self.balance}")
        self.balance -= amount
        return self.balance
    
    def deposit(self, amount: float) -> float:
        """Deposit money into account."""
        if not self.is_open:
            raise AccountClosedError(f"Account {self.account_number} is closed")
        if amount < 0:
            raise NegativeDepositError("Cannot deposit negative amount")
        self.balance += amount
        return self.balance

# Using custom exceptions
account = BankAccount("12345", 100)
try:
    account.withdraw(200)
except InsufficientFundsError as e:
    print(f"Withdrawal failed: {e}")

# Re-raising exceptions
def process_file_safely(filename: str) -> str:
    """Process a file and re-raise any exceptions with context."""
    try:
        with open(filename, 'r') as file:
            return file.read()
    except FileNotFoundError as e:
        print(f"Log: File {filename} not found")
        raise  # Re-raise the same exception
    except PermissionError as e:
        print(f"Log: Permission denied for {filename}")
        raise RuntimeError(f"Cannot access {filename}") from e


# -----------------------------------------------------------------------------
# 5.3 TRUTHY AND FALSY VALUES
# -----------------------------------------------------------------------------
"""
Every value in Python has an inherent truth value when evaluated in a boolean
context.

TRUTHY VALUES (evaluate to True):
- Non-empty strings: "hello", " ", "0"
- Non-zero numbers: 1, -1, 3.14
- Non-empty collections: [1, 2], {"a": 1}, (1,), {1, 2}
- True

FALSY VALUES (evaluate to False):
- None
- False
- Zero numbers: 0, 0.0, 0j
- Empty strings: ""
- Empty collections: [], (), {}, set()

WHY USE TRUTHINESS:
- Cleaner Code: if data: vs if len(data) > 0:
- More Readable: Natural language feel
- Type Flexible: Works with strings, lists, dicts, None, numbers
- Pythonic: Follows community best practices
"""

# Check if list has items
shopping_cart = []
if shopping_cart:
    print("Cart has items")
else:
    print("Cart is empty")

# Provide default value using truthiness
name = input("Enter name (or press enter for Guest): ") or "Guest"
print(f"Hello, {name}!")

# Filter falsy values from list
data = [1, 0, "hello", "", None, 42, [], "world", False]
clean = [x for x in data if x]
print(f"Filtered truthy values: {clean}")  # [1, "hello", 42, "world"]

# Default value pattern
def get_config_value(key: str, default=None):
    """Get config value with default fallback."""
    config = {"theme": "dark", "notifications": True}
    return config.get(key, default)

# Short-circuit evaluation
def process_data(data):
    """Process data only if it exists."""
    # Instead of: if data is not None and len(data) > 0:
    if data:
        return [x * 2 for x in data]
    return []

# Using truthiness in while loops
def get_valid_input():
    """Keep asking until user provides non-empty input."""
    user_input = ""
    while not user_input:  # Loop while input is falsy (empty)
        user_input = input("Enter something (cannot be empty): ").strip()
    return user_input


# =============================================================================
# SECTION 6: MODULES & ORGANIZATION
# =============================================================================

# -----------------------------------------------------------------------------
# 6.1 MODULES
# -----------------------------------------------------------------------------
"""
A module is a single file containing Python code that can be imported.

WHY USE MODULES:
- Organization: Groups related code into logical files
- Reusability: Write once, use across multiple scripts
- Maintainability: Update code in one place
- Namespace Management: Prevents naming conflicts
- Scalability: Makes large projects manageable

THE if __name__ == "__main__" GUARD:
- Code runs only when file is executed directly
- Does NOT run when file is imported as a module
- Enables dual-purpose files (library AND script)
"""

# This guard prevents code from running when imported
if __name__ == "__main__":
    print("This runs only when script is executed directly")
    # main() would be called here

# Example module structure:
"""
# greetings.py (a module file)
def say_hello(name):
    return f"Hello, {name}!"

def say_goodbye(name):
    return f"Goodbye, {name}!"

DEFAULT_GREETING = "Hello"

# main.py (using the module)
import greetings

user_name = input("Enter your name: ")
print(greetings.say_hello(user_name))
"""


# -----------------------------------------------------------------------------
# 6.2 PACKAGES
# -----------------------------------------------------------------------------
"""
A package is a directory containing multiple modules and an __init__.py file.

PACKAGE STRUCTURE:
    my_package/
        __init__.py
        module1.py
        module2.py
        subpackage/
            __init__.py
            submodule.py

THE __init__.py FILE:
- Can be empty or contain initialization code
- Marks directory as a Python package
- Can define __all__ for "from package import *" imports
"""

# Example package structure:
"""
my_package/
    __init__.py
    internet.py
    website.py

# __init__.py can contain:
__version__ = "1.0.0"
__author__ = "Python Developer"

from .internet import connect
from .website import load

__all__ = ['connect', 'load']

# Using the package:
from my_package import internet
from my_package.website import load

internet.connect()
load("http://www.google.com")
"""


# -----------------------------------------------------------------------------
# 6.3 LIBRARIES VS PACKAGES VS MODULES
# -----------------------------------------------------------------------------
"""
Understanding the hierarchy of code organization in Python.

DEFINITIONS:
- Module: Single .py file (e.g., math.py)
- Package: Directory with __init__.py (e.g., urllib/)
- Library: Collection of packages/modules (e.g., requests, pandas)

HIERARCHY:
    LIBRARY (Collection)
        │
        ├── PACKAGE (Directory with __init__.py)
        │       ├── __init__.py
        │       └── module.py
        │
        └── STANDALONE MODULE (single file)

ANALOGY:
- Module = A book
- Package = A section in a library
- Library = The entire library

KEY TAKEAWAYS:
- Libraries are broader than packages (can contain multiple packages)
- A package organizes modules (contains __init__.py)
- Modules are single files (smallest unit)
- Terminology is often used loosely in conversation
"""


# -----------------------------------------------------------------------------
# 6.4 IMPORT METHODS
# -----------------------------------------------------------------------------
"""
Different ways to import modules.

IMPORT METHODS:
Method                      | Syntax                           | Usage
----------------------------|----------------------------------|----------------------
Import entire module        | import module_name               | module_name.function()
Import specific items       | from module import function_name | function_name()
Import with alias           | import module as alias           | alias.function()
Import all (not recommended)| from module import *             | function()
Import multiple items       | from module import func1, func2  | Direct use

WHY AVOID STAR IMPORTS (*):
- Can lead to naming conflicts
- Makes code harder to read (unclear where functions come from)
- Pollutes the namespace
"""

# Standard import (clear origin)
import math
import random

print(f"math.sqrt(16): {math.sqrt(16)}")  # Clear that sqrt comes from math
print(f"random.random(): {random.random()}")  # Clear origin

# Specific import (cleaner code)
from math import sqrt, pi
from random import randint

print(f"sqrt(16): {sqrt(16)}")  # Direct use, no prefix
print(f"pi: {pi}")

# Import with alias
import datetime as dt

print(f"Current time: {dt.datetime.now()}")

# Import multiple items
from math import (sqrt, pi, pow, floor, ceil)

# NOT recommended - star import
# from math import *  # Avoid this!


# =============================================================================
# SECTION 7: BUILT-IN FUNCTIONS
# =============================================================================

# -----------------------------------------------------------------------------
# 7.1 print()
# -----------------------------------------------------------------------------
"""
print() outputs data to the console.

KEY FEATURES:
- Multiple arguments: print("Hello", "World")
- Custom separator: sep parameter
- Custom end character: end parameter (default is newline)
- Formatted output with f-strings or format()
"""

print("Hello, World!")
print("Hello", "World", 123, True)
print("Hello", "World", sep=" - ")  # Output: Hello - World
print("Hello", end=", ")
print("World!")  # Output: Hello, World!


# -----------------------------------------------------------------------------
# 7.2 enumerate()
# -----------------------------------------------------------------------------
"""
enumerate() adds a counter to an iterable and returns (index, item) pairs.

ANALOGY: Like a numbered list where numbers appear automatically

SYNTAX: enumerate(iterable, start=0)
"""

fruits = ['apple', 'banana', 'cherry']

# Without enumerate (manual counter)
index = 0
for fruit in fruits:
    print(f"{index}: {fruit}")
    index += 1

# With enumerate (automatic)
for index, fruit in enumerate(fruits):
    print(f"{index}: {fruit}")

# Custom start index
for index, fruit in enumerate(fruits, start=1):
    print(f"{index}: {fruit}")


# -----------------------------------------------------------------------------
# 7.3 round()
# -----------------------------------------------------------------------------
"""
round() rounds a floating-point number to specified decimal places.

SYNTAX: round(number, ndigits)
"""

print(f"round(3.14159, 2): {round(3.14159, 2)}")  # 3.14
print(f"round(3.14159): {round(3.14159)}")        # 3
print(f"round(265.56): {round(265.56)}")          # 266
print(f"round(266, -1): {round(266, -1)}")        # 270
print(f"round(265, -2): {round(265, -2)}")        # 300


# -----------------------------------------------------------------------------
# 7.4 range()
# -----------------------------------------------------------------------------
"""
range() generates a sequence of numbers (efficient, doesn't store all in memory).

SYNTAX: range(stop) or range(start, stop) or range(start, stop, step)
"""

# Single argument (0 to stop-1)
for i in range(5):
    print(i, end=" ")
print()

# Two arguments (start to stop-1)
for i in range(2, 7):
    print(i, end=" ")
print()

# Three arguments (start, stop, step)
for i in range(0, 10, 2):
    print(i, end=" ")
print()

# Negative step (count down)
for i in range(5, 0, -1):
    print(i, end=" ")
print()

# range object is iterable but not a list
my_range = range(1, 6)
print(f"list(my_range): {list(my_range)}")  # [1, 2, 3, 4, 5]


# -----------------------------------------------------------------------------
# 7.5 slice()
# -----------------------------------------------------------------------------
"""
slice() creates a slice object for reusable slicing.

SYNTAX: slice(start, stop, step)
"""

numbers = [1, 2, 3, 4, 5, 6]

# Create reusable slice
first_three = slice(0, 3)
print(f"numbers[first_three]: {numbers[first_three]}")  # [1, 2, 3]

# Reverse slice
reverse_slice = slice(None, None, -1)
print(f"numbers[reverse_slice]: {numbers[reverse_slice]}")  # [6,5,4,3,2,1]

# Using slice() with strings
text = "Hello, World!"
hello_slice = slice(0, 5)
print(f"text[hello_slice]: {text[hello_slice]}")  # "Hello"


# -----------------------------------------------------------------------------
# 7.6 globals()
# -----------------------------------------------------------------------------
"""
globals() returns dictionary of all global variables in current module.

USES:
- Debugging: See what's in global scope
- Dynamic access to global variables
- (Generally avoid modifying the returned dictionary)
"""

x = 10
y = 20

def test_func():
    pass

globals_dict = globals()
print(f"'x' in globals: {'x' in globals_dict}")  # True
print(f"'test_func' in globals: {'test_func' in globals_dict}")  # True


# -----------------------------------------------------------------------------
# 7.7 locals()
# -----------------------------------------------------------------------------
"""
locals() returns dictionary of current local symbol table.

- In global scope: similar to globals()
- Inside function: shows local variables only
"""

def add(a, b):
    result = a + b
    local_vars = locals()
    print(f"Local variables: {local_vars}")
    return result

add(3, 5)  # Shows {'a': 3, 'b': 5, 'result': 8}


# -----------------------------------------------------------------------------
# 7.8 all()
# -----------------------------------------------------------------------------
"""
all() returns True if ALL items in iterable are truthy.

ANALOGY: "Are ALL items good?"
- Returns True for empty iterable
"""

print(f"all([True, True, True]): {all([True, True, True])}")    # True
print(f"all([True, False, True]): {all([True, False, True])}")  # False
print(f"all([]): {all([])}")  # True (vacuous truth)

# Practical use: Check if all numbers are even
numbers = [2, 4, 6, 8]
all_even = all(n % 2 == 0 for n in numbers)
print(f"All numbers even: {all_even}")  # True


# -----------------------------------------------------------------------------
# 7.9 any()
# -----------------------------------------------------------------------------
"""
any() returns True if AT LEAST ONE item in iterable is truthy.

ANALOGY: "Is ANY item good?"
- Returns False for empty iterable
"""

print(f"any([False, False, True]): {any([False, False, True])}")   # True
print(f"any([False, False, False]): {any([False, False, False])}") # False
print(f"any([]): {any([])}")  # False

# Practical use: Check if any number is positive
numbers = [-2, -4, 6, -8]
has_positive = any(n > 0 for n in numbers)
print(f"Has positive number: {has_positive}")  # True


# -----------------------------------------------------------------------------
# 7.10 isinstance()
# -----------------------------------------------------------------------------
"""
isinstance() checks if an object is an instance of a class or tuple of classes.

WHY USE isinstance() over type():
- Works with inheritance (subclasses return True)
- Can check multiple types with tuple
- More flexible and Pythonic
"""

num = 10
print(f"isinstance(num, int): {isinstance(num, int)}")        # True
print(f"isinstance(num, (int, float)): {isinstance(num, (int, float))}")  # True

# Works with inheritance
class Animal:
    pass

class Dog(Animal):
    pass

dog = Dog()
print(f"isinstance(dog, Dog): {isinstance(dog, Dog)}")        # True
print(f"isinstance(dog, Animal): {isinstance(dog, Animal)}")  # True (inheritance!)


# -----------------------------------------------------------------------------
# 7.11 callable()
# -----------------------------------------------------------------------------
"""
callable() checks if an object can be called (function, method, or class).

RETURNS:
- True: functions, methods, classes, objects with __call__
- False: numbers, strings, lists, other non-callable objects
"""

def my_function():
    pass

class MyClass:
    def __call__(self):
        pass

print(f"callable(my_function): {callable(my_function)}")  # True
print(f"callable(MyClass): {callable(MyClass)}")          # True
print(f"callable(10): {callable(10)}")                    # False
print(f"callable('hello'): {callable('hello')}")          # False


# -----------------------------------------------------------------------------
# 7.12 filter()
# -----------------------------------------------------------------------------
"""
filter() creates an iterator from elements where function returns True.

ANALOGY: Quality control inspector - "keep" or "reject"

SYNTAX: filter(function, iterable)
- If function is None, removes falsy values
"""

numbers = range(1, 21)

# Filter even numbers
def is_even(n):
    return n % 2 == 0

evens = filter(is_even, numbers)
print(f"Even numbers: {list(evens)}")

# Using lambda
odds = filter(lambda x: x % 2 == 1, numbers)
print(f"Odd numbers: {list(odds)}")

# Filter out falsy values (using None)
mixed = [0, 1, 2, None, 3, '', 4, False, 5]
truthy = filter(None, mixed)
print(f"Truthy values: {list(truthy)}")  # [1, 2, 3, 4, 5]


# -----------------------------------------------------------------------------
# 7.13 map()
# -----------------------------------------------------------------------------
"""
map() applies a function to every item in an iterable.

SYNTAX: map(function, iterable)
"""

numbers = [1, 2, 3, 4, 5]

# Double each number
def double(x):
    return x * 2

doubled = map(double, numbers)
print(f"Doubled: {list(doubled)}")  # [2, 4, 6, 8, 10]

# Using lambda
squared = map(lambda x: x ** 2, numbers)
print(f"Squared: {list(squared)}")  # [1, 4, 9, 16, 25]

# Map with multiple iterables
a = [1, 2, 3]
b = [4, 5, 6]
sums = map(lambda x, y: x + y, a, b)
print(f"Sums: {list(sums)}")  # [5, 7, 9]


# -----------------------------------------------------------------------------
# 7.14 sorted()
# -----------------------------------------------------------------------------
"""
sorted() returns a new sorted list from any iterable.

KEY FEATURES:
- key: function to customize sort order
- reverse: sort descending (default False)
- Returns new list (original unchanged)
"""

numbers = [5, 2, 9, 1, 5, 6]
sorted_numbers = sorted(numbers)
print(f"Sorted: {sorted_numbers}")  # [1, 2, 5, 5, 6, 9]

# Descending order
descending = sorted(numbers, reverse=True)
print(f"Descending: {descending}")  # [9, 6, 5, 5, 2, 1]

# Sort by key (e.g., by length)
names = ["Charlie", "Alice", "Bob"]
by_length = sorted(names, key=len)
print(f"By length: {by_length}")  # ['Bob', 'Alice', 'Charlie']

# Sort with custom key (e.g., by last character)
words = ["apple", "banana", "cherry"]
by_last_char = sorted(words, key=lambda x: x[-1])
print(f"By last char: {by_last_char}")


# -----------------------------------------------------------------------------
# 7.15 eval() - Evaluate
# -----------------------------------------------------------------------------
"""
eval() evaluates a string as a Python expression.

WARNING: Dangerous with untrusted input! Can execute arbitrary code.
"""

# Safe usage (with trusted input only)
result = eval("3 + 5")
print(f"eval('3 + 5'): {result}")  # 8

result = eval("2 * 10")
print(f"eval('2 * 10'): {result}")  # 20

# AVOID with user input:
# user_input = input("Enter expression: ")  # Could be harmful!
# eval(user_input)  # DANGEROUS!


# -----------------------------------------------------------------------------
# 7.16 exec() - Execute
# -----------------------------------------------------------------------------
"""
exec() executes a string as Python code (can be multiple statements).

DIFFERENCES FROM eval():
- eval(): Returns value, expressions only
- exec(): Returns None, can run any code (statements, functions, etc.)

WARNING: Also dangerous with untrusted input!
"""

# Execute a block of code
code = """
x = 10
y = 20
print(f"Sum: {x + y}")
"""
exec(code)  # Output: Sum: 30

# Define a function with exec
code_block = """
def greet(name):
    print(f'Hello, {name}!')

greet('Alice')
"""
exec(code_block)  # Output: Hello, Alice!

# AVOID with user input for same security reasons as eval()


# -----------------------------------------------------------------------------
# 7.17 zip()
# -----------------------------------------------------------------------------
"""
zip() combines multiple iterables into tuples of corresponding elements.

ANALOGY: Zipping two zippers together - pairs up elements at same positions

SYNTAX: zip(*iterables)
- Stops at shortest iterable
- Returns iterator of tuples
"""

names = ["Alice", "Bob", "Charlie"]
scores = [85, 92, 78]
grades = ["A", "A-", "B+"]

# Zip two lists
zipped = zip(names, scores)
print(f"Zipped: {list(zipped)}")  # [('Alice', 85), ('Bob', 92), ('Charlie', 78)]

# Zip three lists
full_data = zip(names, scores, grades)
for name, score, grade in full_data:
    print(f"{name}: {score} ({grade})")

# Handle different lengths (stops at shortest)
short = [1, 2]
long = [1, 2, 3, 4]
zipped_uneven = zip(short, long)
print(f"Uneven zip: {list(zipped_uneven)}")  # [(1, 1), (2, 2)]

# Unzipping (using * operator)
pairs = [('Alice', 85), ('Bob', 92), ('Charlie', 78)]
unzipped_names, unzipped_scores = zip(*pairs)
print(f"Unzipped names: {unzipped_names}")
print(f"Unzipped scores: {unzipped_scores}")


# =============================================================================
# SECTION 8: ADVANCED CONCEPTS
# =============================================================================

# -----------------------------------------------------------------------------
# 8.1 DOC STRINGS
# -----------------------------------------------------------------------------
"""
Docstrings are documentation strings for modules, classes, functions, and methods.

ANALOGY: Product manuals or instruction labels

SYNTAX: Triple quotes (""" or ''') immediately after definition

ACCESS: Use help() or .__doc__ attribute

WHY USE DOCSTRINGS:
- Documentation for users of your code
- help() function displays them
- IDEs show them as tooltips
- Auto-documentation tools (Sphinx) can generate docs
"""

def calculate_area(length: float, width: float) -> float:
    """
    Calculate the area of a rectangle.

    Parameters:
    length (float): The length of the rectangle.
    width (float): The width of the rectangle.

    Returns:
    float: The area of the rectangle.

    Example:
    >>> calculate_area(5, 3)
    15
    """
    return length * width

# Access docstring
print(calculate_area.__doc__)
# help(calculate_area)  # Would show formatted documentation

# Module docstring (at top of file)
# Class docstring (right after class definition)


# -----------------------------------------------------------------------------
# 8.2 F-STRINGS (FORMATTED STRING LITERALS)
# -----------------------------------------------------------------------------
"""
F-strings provide a concise way to embed expressions in strings.

SYNTAX: f"text {expression} text"

FEATURES:
- Embed variables: f"Hello {name}"
- Embed expressions: f"Sum: {a + b}"
- Format numbers: f"{price:.2f}"
- Debugging: f"{value=}"
- Multi-line support with triple quotes
"""

name = "Alice"
age = 25
price = 19.99
quantity = 3

# Basic f-string
greeting = f"Hello, {name}! You are {age} years old."
print(greeting)

# Expressions inside f-strings
total = f"Total: ${price * quantity:.2f}"
print(total)

# Debugging (Python 3.8+)
value = 10
print(f"{value=}")  # Output: value=10

# Multi-line f-string
story = f"""
This is a story about {name}.
{name} is {age} years old.
"""
print(story)

# Number formatting
big_number = 12345678.9
formatted = f"{big_number:,.2f}"
print(formatted)  # 12,345,678.90


# -----------------------------------------------------------------------------
# 8.3 ASSERTIONS
# -----------------------------------------------------------------------------
"""
Assertions are debugging checkpoints that ensure conditions are true.

ANALOGY: Quality control checkpoints on an assembly line

SYNTAX: assert condition, "error message"

WHEN TO USE:
- Catch bugs early
- Document assumptions
- Debugging aid
- Test helper

WHEN NOT TO USE:
- Runtime error handling (use exceptions)
- Production critical checks (can be disabled)
"""

def calculate_discount(price: float, discount_percent: float) -> float:
    """Calculate discounted price with validation."""
    assert price > 0, "Price must be positive"
    assert 0 <= discount_percent <= 100, "Discount must be between 0 and 100"
    
    return price * (1 - discount_percent / 100)

# This would raise AssertionError:
# calculate_discount(-10, 20)  # AssertionError: Price must be positive

# Assertions can be disabled with -O flag when running Python
# python -O script.py  # Disables assertions


# -----------------------------------------------------------------------------
# 8.4 UNPACKING
# -----------------------------------------------------------------------------
"""
Unpacking assigns values from an iterable to multiple variables in one statement.

ANALOGY: Unpacking a box and placing items in specific spots

SYNTAX: a, b, c = iterable

FEATURES:
- Unpack tuples, lists, strings
- Ignore values with _
- Nested unpacking
- * for remaining items
"""

# Basic tuple unpacking
point = (10, 20)
x, y = point
print(f"x={x}, y={y}")

# List unpacking
values = [1, 2, 3]
a, b, c = values
print(f"a={a}, b={b}, c={c}")

# String unpacking
first, second, third = "ABC"
print(f"first={first}, second={second}, third={third}")

# Ignoring values with underscore
person = ("Alice", 25, "Engineer")
name, _, job = person
print(f"name={name}, job={job}")

# Extended unpacking with * (gather remaining)
numbers = [1, 2, 3, 4, 5]
first, *rest = numbers
print(f"first={first}, rest={rest}")

first, second, *rest = numbers
print(f"first={first}, second={second}, rest={rest}")

*first, last = numbers
print(f"first={first}, last={last}")

# Swapping variables with unpacking
a, b = 5, 10
print(f"Before: a={a}, b={b}")
a, b = b, a
print(f"After: a={a}, b={b}")

# Unpacking in function calls
def add_three(a, b, c):
    return a + b + c

numbers = [1, 2, 3]
result = add_three(*numbers)
print(f"Unpacked function call: {result}")


# -----------------------------------------------------------------------------
# 8.5 == VS IS
# -----------------------------------------------------------------------------
"""
== (equality operator): Checks if values are equal
is (identity operator): Checks if objects are the same in memory

ANALOGY:
- == : "Are these two twins identical in appearance?"
- is : "Is this the exact same person?"

WHEN TO USE:
- Use == for comparing values (most cases)
- Use is for comparing to None (x is None)
- Use is for singletons (True, False, None)
"""

# Value equality (==)
a = [1, 2, 3]
b = [1, 2, 3]
print(f"a == b: {a == b}")  # True (same values)

# Identity equality (is)
print(f"a is b: {a is b}")  # False (different objects in memory)

# Same object
c = a
print(f"a is c: {a is c}")  # True (same object)

# Comparing to None (always use is)
value = None
if value is None:  # Correct
    print("Value is None")

# if value == None:  # Avoid this - works but not idiomatic

# Small integers are cached (-5 to 256)
x = 256
y = 256
print(f"256 is 256: {x is y}")  # True (cached)

x = 257
y = 257
print(f"257 is 257: {x is y}")  # False (not cached)


# -----------------------------------------------------------------------------
# 8.6 LIST COMPREHENSIONS
# -----------------------------------------------------------------------------
"""
List comprehensions create lists concisely in one line.

ANALOGY: Dishwasher - "Wash ALL the plates" instead of one by one

SYNTAX: [expression for item in iterable if condition]

WHY USE LIST COMPREHENSIONS:
- Conciseness (1 line vs 3-5 lines)
- Readability (for simple operations)
- Performance (generally faster than loops)
- Less error-prone

BEST PRACTICES:
- Keep comprehensions readable (max 2-3 conditions)
- Use for simple transformations
- Avoid nesting more than 2 levels deep
"""

# Basic comprehension
numbers = [1, 2, 3, 4, 5]
squares = [x**2 for x in numbers]
print(f"Squares: {squares}")  # [1, 4, 9, 16, 25]

# With condition
even_squares = [x**2 for x in numbers if x % 2 == 0]
print(f"Even squares: {even_squares}")  # [4, 16]

# With if-else
labels = ["Even" if x % 2 == 0 else "Odd" for x in numbers]
print(f"Labels: {labels}")

# Nested loops
pairs = [(x, y) for x in [1, 2] for y in [3, 4]]
print(f"Pairs: {pairs}")  # [(1, 3), (1, 4), (2, 3), (2, 4)]

# Set comprehension
unique_squares = {x**2 for x in [1, 2, 2, 3, 3, 3]}
print(f"Set comprehension: {unique_squares}")

# Dictionary comprehension
square_dict = {x: x**2 for x in range(5)}
print(f"Dict comprehension: {square_dict}")

# vs traditional loop (more verbose)
squares_loop = []
for x in numbers:
    squares_loop.append(x**2)


# -----------------------------------------------------------------------------
# 8.7 SLICING
# -----------------------------------------------------------------------------
"""
Slicing extracts a subset of elements from a sequence.

ANALOGY: Taking scissors to a list/string - cut out exactly what you want

SYNTAX: sequence[start:stop:step]

RULES:
- start: inclusive (default 0)
- stop: exclusive (default len)
- step: increment (default 1)
- Negative indices count from end
- stop index is where you STOP, not include
"""

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Basic slicing
print(f"First 3: {numbers[0:3]}")    # [1, 2, 3]
print(f"Indices 2-5: {numbers[2:6]}")  # [3, 4, 5, 6]
print(f"From index 3: {numbers[3:]}")  # [4, 5, 6, 7, 8, 9, 10]
print(f"Up to index 5: {numbers[:5]}")  # [1, 2, 3, 4, 5]

# Negative indices
print(f"Last 3: {numbers[-3:]}")     # [8, 9, 10]
print(f"All but last 2: {numbers[:-2]}")  # [1, 2, 3, 4, 5, 6, 7, 8]

# Step parameter
print(f"Every 2nd: {numbers[::2]}")   # [1, 3, 5, 7, 9]
print(f"Every 3rd: {numbers[::3]}")   # [1, 4, 7, 10]
print(f"Reverse: {numbers[::-1]}")    # [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

# Slicing strings
text = "Hello, World!"
print(f"First 5: {text[:5]}")        # "Hello"
print(f"Last 6: {text[-6:]}")        # "World!"
print(f"Reverse: {text[::-1]}")      # "!dlroW ,olleH"

# Slicing creates a copy
original = [1, 2, 3, 4, 5]
sliced = original[1:4]
sliced[0] = 99  # Modifies slice only
print(f"Original unchanged: {original}")  # [1, 2, 3, 4, 5]


# -----------------------------------------------------------------------------
# 8.8 DON'T LOOP & MODIFY
# -----------------------------------------------------------------------------
"""
Never modify a list while iterating over it. It causes unexpected behavior.

THE SIMPLE RULE: Never add, remove, or change items in a list while iterating.

WHY AVOID:
- Index shift: Removing items changes indices of remaining items
- Skipped elements: Next item shifts into removed position
- Index errors: Adding items makes loop run longer than expected

SOLUTIONS:
- Create a new list with comprehension
- Iterate over a copy
- Iterate backwards
"""

# PROBLEMATIC: Modifying while iterating forward
people = ['Anna', 'Bob', 'Chris', 'David', 'Fred']
# for person in people:  # DON'T DO THIS
#     if person == 'Bob':
#         people.remove(person)  # Skips 'Chris'!

# SOLUTION 1: List comprehension (recommended)
people = ['Anna', 'Bob', 'Chris', 'David', 'Fred']
people = [person for person in people if person != 'Bob']
print(f"After comprehension: {people}")

# SOLUTION 2: Iterate over a copy
people = ['Anna', 'Bob', 'Chris', 'David', 'Fred']
for person in people[:]:  # Iterate over copy
    if person == 'Bob':
        people.remove(person)
print(f"After copy iteration: {people}")

# SOLUTION 3: Iterate backwards
people = ['Anna', 'Bob', 'Chris', 'David', 'Fred']
for i in range(len(people) - 1, -1, -1):
    if people[i] == 'Bob':
        people.pop(i)
print(f"After backwards iteration: {people}")


# =============================================================================
# SECTION 9: OBJECT-ORIENTED PROGRAMMING (OOP)
# =============================================================================

# -----------------------------------------------------------------------------
# 9.1 CLASSES & OBJECTS
# -----------------------------------------------------------------------------
"""
OOP organizes code by creating "objects" with data (attributes) and actions (methods).

ANALOGY:
- Class = Blueprint or cookie cutter (the shape)
- Object = Instance or actual cookie (made from the cutter)

WHY USE OOP:
- Reusability: Create multiple instances from one class
- Organization: Group related data and functionality
- Encapsulation: Hide internal data, expose only what's needed
- Modularity: Break complex programs into smaller pieces
- Modeling: Represent real-world entities naturally
"""

class Car:
    """A simple Car class demonstrating OOP basics."""
    
    # Class attribute (shared by all instances)
    wheels = 4
    vehicle_type = "Car"
    
    def __init__(self, brand: str, color: str):
        """Initialize a new Car instance."""
        # Instance attributes (unique to each instance)
        self.brand = brand
        self.color = color
        self.speed = 0
    
    def accelerate(self, amount: int) -> None:
        """Increase speed."""
        self.speed += amount
        print(f"{self.brand} accelerated to {self.speed} km/h")
    
    def brake(self, amount: int) -> None:
        """Decrease speed."""
        self.speed = max(0, self.speed - amount)
        print(f"{self.brand} slowed to {self.speed} km/h")
    
    def describe(self) -> str:
        """Return a description of the car."""
        return f"{self.color} {self.brand} with {self.wheels} wheels"

# Creating objects (instances)
bmw = Car("BMW", "Red")
toyota = Car("Toyota", "Blue")

# Using objects
bmw.accelerate(50)
toyota.accelerate(30)
print(bmw.describe())
print(toyota.describe())

# Accessing attributes
print(f"BMW color: {bmw.color}")
print(f"All cars have {Car.wheels} wheels")


# -----------------------------------------------------------------------------
# 9.2 __init__() METHOD
# -----------------------------------------------------------------------------
"""
__init__() is the initializer/constructor called when creating a new object.

ANALOGY: Factory assembly line - sets up the car when it rolls off the line

PURPOSE:
- Initializes the object's state
- Sets up instance attributes
- Can accept parameters for customization

BEST PRACTICES:
- Keep __init__() simple and focused
- Validate input parameters
- Set default values for optional parameters
- Document what parameters do
"""

class Fruit:
    """Example showing __init__() usage."""
    
    def __init__(self, name: str, weight: float, price_per_kg: float = 0.0):
        """
        Initialize a Fruit object.
        
        Parameters:
        name: Name of the fruit
        weight: Weight in grams
        price_per_kg: Price per kilogram (default 0.0)
        """
        self.name = name
        self.weight = weight
        self.price_per_kg = price_per_kg
        self._calculate_total()
    
    def _calculate_total(self) -> None:
        """Calculate total price based on weight and price_per_kg."""
        self.total_price = (self.weight / 1000) * self.price_per_kg

# Creating objects with __init__
apple = Fruit("Apple", 150, 2.99)
banana = Fruit("Banana", 120)  # Uses default price

print(f"Apple total: ${apple.total_price:.2f}")
print(f"Banana total: ${banana.total_price:.2f}")


# -----------------------------------------------------------------------------
# 9.3 SELF PARAMETER
# -----------------------------------------------------------------------------
"""
self refers to the current instance of the class.

ANALOGY: "me" or "myself" - like wearing a name tag at a conference

PURPOSE:
- Access instance attributes from within the class
- Differentiate instance attributes from local variables
- Each instance maintains its own state

NOTE: self is a convention (could use any name, but always use self)
"""

class Person:
    """Example showing self usage."""
    
    def __init__(self, name: str, age: int):
        # self binds attributes to the specific instance
        self.name = name
        self.age = age
    
    def introduce(self) -> str:
        # self accesses the instance's attributes
        return f"I am {self.name} and I am {self.age} years old"
    
    def have_birthday(self) -> None:
        # self modifies the instance's state
        self.age += 1
        print(f"Happy birthday {self.name}! Now {self.age}")

# Each instance has its own self reference
alice = Person("Alice", 25)
bob = Person("Bob", 30)

print(alice.introduce())  # "I am Alice and I am 25 years old"
print(bob.introduce())    # "I am Bob and I am 30 years old"

alice.have_birthday()     # Alice's age becomes 26
print(alice.introduce())  # "I am Alice and I am 26 years old"


# -----------------------------------------------------------------------------
# 9.4 CLASS & INSTANCE ATTRIBUTES
# -----------------------------------------------------------------------------
"""
Class attributes: Shared across all instances
Instance attributes: Unique to each instance

ANALOGY:
- Class attribute: All humans have 2 legs (shared)
- Instance attribute: Each person has their own name (unique)

WHY USE CLASS ATTRIBUTES:
- Shared configuration (default settings)
- Constants (PI, MAX_SPEED)
- Counters (track number of instances)
- Memory efficiency (stored once per class)
"""

class Employee:
    """Example showing class vs instance attributes."""
    
    # Class attributes (shared by all employees)
    company = "TechCorp"
    min_wage = 15.00
    employee_count = 0
    
    def __init__(self, name: str, salary: float):
        # Instance attributes (unique to each employee)
        self.name = name
        self.salary = salary
        self.id = Employee.employee_count + 1
        
        # Update class attribute
        Employee.employee_count += 1
    
    def get_info(self) -> str:
        return f"{self.name} works at {self.company} (ID: {self.id})"

# Creating instances
alice = Employee("Alice", 50000)
bob = Employee("Bob", 55000)

# Accessing class attributes
print(f"Company: {Employee.company}")  # TechCorp
print(f"Employee count: {Employee.employee_count}")  # 2

# Instance attributes are unique
print(f"Alice's salary: {alice.salary}")  # 50000
print(f"Bob's salary: {bob.salary}")      # 55000

# Class attributes can be accessed via instance (but careful!)
print(f"Alice's company: {alice.company}")  # TechCorp

# Modifying class attribute affects all instances
Employee.company = "NewTechCorp"
print(f"Alice's company now: {alice.company}")  # NewTechCorp


# -----------------------------------------------------------------------------
# 9.5 DUNDER METHODS (MAGIC METHODS)
# -----------------------------------------------------------------------------
"""
Dunder methods (Double UNDERscore) define how objects behave with built-in operations.

ANALOGY: Wiring behind a light switch - makes things work automatically

COMMON DUNDER METHODS:
- __init__: Constructor
- __str__: String representation for users (print())
- __repr__: String representation for developers (debugging)
- __len__: Length for len()
- __getitem__: Indexing support obj[key]
- __eq__: Equality for ==
- __lt__, __le__, __gt__, __ge__: Comparison operators
- __add__, __sub__, __mul__, __truediv__: Arithmetic operators
"""

class Book:
    """Example demonstrating common dunder methods."""
    
    def __init__(self, title: str, author: str, pages: int):
        self.title = title
        self.author = author
        self.pages = pages
    
    def __str__(self) -> str:
        """User-friendly string representation."""
        return f"'{self.title}' by {self.author}"
    
    def __repr__(self) -> str:
        """Developer-friendly representation (should recreate object)."""
        return f"Book('{self.title}', '{self.author}', {self.pages})"
    
    def __len__(self) -> int:
        """Return length for len() function."""
        return self.pages
    
    def __eq__(self, other) -> bool:
        """Define equality for == operator."""
        if not isinstance(other, Book):
            return False
        return self.title == other.title and self.author == other.author

# Usage
book1 = Book("1984", "George Orwell", 328)
book2 = Book("1984", "George Orwell", 328)
book3 = Book("Brave New World", "Aldous Huxley", 268)

print(f"__str__: {book1}")           # '1984' by George Orwell
print(f"__repr__: {repr(book1)}")    # Book('1984', 'George Orwell', 328)
print(f"__len__: {len(book1)}")      # 328
print(f"__eq__: {book1 == book2}")   # True
print(f"__eq__: {book1 == book3}")   # False


# -----------------------------------------------------------------------------
# 9.6 __str__() & __repr__()
# -----------------------------------------------------------------------------
"""
__str__(): "Pretty" version for humans to read
__repr__(): "Exact" version for developers to debug

TARGET AUDIENCE:
- __str__: End users (print(), f-strings)
- __repr__: Developers (debugging, logging, console)

GOAL:
- __str__: Readable and informative
- __repr__: Unambiguous, should recreate object if possible
"""

class Product:
    """Example showing __str__ vs __repr__."""
    
    def __init__(self, name: str, price: float, sku: str):
        self.name = name
        self.price = price
        self.sku = sku
    
    def __str__(self) -> str:
        """User-friendly: shows name and price."""
        return f"{self.name}: ${self.price:.2f}"
    
    def __repr__(self) -> str:
        """Developer-friendly: shows all data, should recreate object."""
        return f"Product('{self.name}', {self.price}, '{self.sku}')"

product = Product("Laptop", 999.99, "LAP-001")

# __str__ is called by print()
print(product)  # Laptop: $999.99

# __repr__ is called by repr() and in console
print(repr(product))  # Product('Laptop', 999.99, 'LAP-001')

# In interactive console, typing product shows __repr__


# -----------------------------------------------------------------------------
# 9.7 __eq__() METHOD
# -----------------------------------------------------------------------------
"""
__eq__() defines what "equal" means for objects when using ==.

WITHOUT __eq__: Python compares memory addresses (are they the same object?)
WITH __eq__: You decide what "equal" means for your objects

WHY IMPLEMENT __eq__:
- Compare objects by what matters (ID, attributes)
- Enable set operations (remove duplicates based on content)
- Use custom objects as dict keys with proper equality
- Write intuitive tests (assert obj1 == obj2)
"""

class Student:
    """Example showing custom equality logic."""
    
    def __init__(self, student_id: int, name: str, grade: str):
        self.student_id = student_id
        self.name = name
        self.grade = grade
    
    def __eq__(self, other) -> bool:
        """Students are equal if they have the same ID."""
        if not isinstance(other, Student):
            return False
        return self.student_id == other.student_id
    
    def __repr__(self) -> str:
        return f"Student({self.student_id}, '{self.name}', '{self.grade}')"

# Two different objects with same ID are considered equal
student1 = Student(101, "Alice", "A")
student2 = Student(101, "Alice", "A")
student3 = Student(102, "Bob", "B")

print(f"Same ID: {student1 == student2}")  # True
print(f"Different ID: {student1 == student3}")  # False

# Set uses __eq__ to determine duplicates
students = {student1, student2, student3}
print(f"Set size: {len(students)}")  # 2 (student1 and student2 are equal)


# -----------------------------------------------------------------------------
# 9.8 METHODS VS FUNCTIONS
# -----------------------------------------------------------------------------
"""
Function: Standalone block of code (doesn't belong to any object)
Method: Function that belongs to an object/class

ANALOGY:
- Function = Calculator app (works the same for anyone)
- Method = TV remote (tied to specific TV, knows its state)

KEY DIFFERENCES:
- Methods have self parameter (access instance data)
- Methods are called on objects (object.method())
- Functions are independent (function())
"""

# Function (standalone)
def greet(name: str) -> str:
    """This is a function - doesn't belong to any class."""
    return f"Hello, {name}!"

# Method (belongs to class)
class Greeter:
    def __init__(self, greeting: str = "Hello"):
        self.greeting = greeting
    
    def greet(self, name: str) -> str:
        """This is a method - belongs to Greeter class."""
        return f"{self.greeting}, {name}!"

# Function usage (no instance needed)
print(greet("Alice"))

# Method usage (requires instance)
greeter = Greeter("Hi")
print(greeter.greet("Bob"))

# Another instance with different state
french_greeter = Greeter("Bonjour")
print(french_greeter.greet("Charlie"))


# -----------------------------------------------------------------------------
# 9.9 INHERITANCE
# -----------------------------------------------------------------------------
"""
Inheritance allows a class (child) to inherit attributes and methods from another
class (parent).

ANALOGY: Child inheriting traits from parents

BENEFITS:
- Code Reusability: Don't rewrite common code
- Extensibility: Add new features without changing existing code
- Logical Hierarchy: Creates natural relationships
- Polymorphism: Treat different objects uniformly

TYPES:
- Single inheritance: One parent class
- Multiple inheritance: Multiple parent classes
- Multilevel inheritance: Grandparent → Parent → Child
"""

class Animal:
    """Base class (parent)."""
    
    def __init__(self, name: str):
        self.name = name
    
    def speak(self) -> str:
        """Base method to be overridden."""
        return "Some animal sound"
    
    def move(self) -> str:
        """Common method for all animals."""
        return f"{self.name} is moving"

class Dog(Animal):
    """Child class inheriting from Animal."""
    
    def speak(self) -> str:
        """Override parent method."""
        return f"{self.name} says Woof!"
    
    def fetch(self) -> str:
        """New method specific to Dog."""
        return f"{self.name} is fetching the ball"

class Cat(Animal):
    """Another child class inheriting from Animal."""
    
    def speak(self) -> str:
        """Override parent method."""
        return f"{self.name} says Meow!"
    
    def climb(self) -> str:
        """New method specific to Cat."""
        return f"{self.name} is climbing a tree"

# Using inheritance
dog = Dog("Rex")
cat = Cat("Whiskers")

print(dog.speak())    # Rex says Woof!
print(cat.speak())    # Whiskers says Meow!
print(dog.move())     # Rex is moving (inherited)
print(dog.fetch())    # Rex is fetching the ball (Dog-specific)

# isinstance() works with inheritance
print(f"dog is Dog: {isinstance(dog, Dog)}")        # True
print(f"dog is Animal: {isinstance(dog, Animal)}")  # True (inheritance!)


# -----------------------------------------------------------------------------
# 9.10 super()
# -----------------------------------------------------------------------------
"""
super() gives access to methods and attributes from a parent class.

ANALOGY: Asking a parent for help while still doing things your own way

WHY USE super():
- Cleaner code (avoids hardcoding parent class names)
- Maintainable (parent name changes in one place)
- Multiple inheritance support (handles MRO correctly)
- Best practice for calling parent methods
"""

class Vehicle:
    """Base class."""
    
    def __init__(self, brand: str, model: str):
        self.brand = brand
        self.model = model
    
    def start(self) -> str:
        return f"{self.brand} {self.model} is starting"

class Car(Vehicle):
    """Child class using super() to call parent."""
    
    def __init__(self, brand: str, model: str, doors: int):
        # Call parent constructor with super()
        super().__init__(brand, model)
        self.doors = doors
    
    def start(self) -> str:
        # Call parent method and extend it
        return super().start() + " (Vroom vroom!)"

class ElectricCar(Car):
    """Another level of inheritance."""
    
    def __init__(self, brand: str, model: str, doors: int, battery_size: int):
        super().__init__(brand, model, doors)
        self.battery_size = battery_size
    
    def start(self) -> str:
        return super().start() + " (Silent electric whir)"

# Usage
tesla = ElectricCar("Tesla", "Model 3", 4, 75)
print(tesla.start())
# Output: Tesla Model 3 is starting (Vroom vroom!) (Silent electric whir)


# -----------------------------------------------------------------------------
# 9.11 @staticmethod
# -----------------------------------------------------------------------------
"""
Static methods belong to the class, not to instances.

ANALOGY: Calculator in a toolbox - doesn't need to know which toolbox it's in

WHY USE STATIC METHODS:
- Organization: Group utility functions inside a class
- Namespace clarity: Shows function belongs conceptually to the class
- No instance needed: Can be called without creating objects

CHARACTERISTICS:
- No self or cls parameter
- Cannot access instance or class data
- Behaves like a regular function, just lives in the class
"""

class MathUtils:
    """Utility class with static methods."""
    
    @staticmethod
    def add(x: float, y: float) -> float:
        """Add two numbers."""
        return x + y
    
    @staticmethod
    def multiply(x: float, y: float) -> float:
        """Multiply two numbers."""
        return x * y
    
    @staticmethod
    def is_even(n: int) -> bool:
        """Check if a number is even."""
        return n % 2 == 0
    
    @staticmethod
    def celsius_to_fahrenheit(celsius: float) -> float:
        """Convert Celsius to Fahrenheit."""
        return (celsius * 9/5) + 32

# Call static methods on the class (no instance needed)
print(f"5 + 3 = {MathUtils.add(5, 3)}")
print(f"5 * 3 = {MathUtils.multiply(5, 3)}")
print(f"Is 4 even? {MathUtils.is_even(4)}")
print(f"25°C = {MathUtils.celsius_to_fahrenheit(25)}°F")

# Can also call on instances (but not typical)
utils = MathUtils()
print(utils.add(10, 20))  # Works but less clear


# -----------------------------------------------------------------------------
# 9.12 @classmethod
# -----------------------------------------------------------------------------
"""
Class methods are bound to the class, not instances. They receive cls as first param.

ANALOGY: Factory manager - oversees entire factory, not individual products

WHY USE CLASS METHODS:
- Factory methods (create instances in different ways)
- Class-level operations (modify class variables)
- Alternative constructors
- Inheritance-friendly

CHARACTERISTICS:
- Takes cls parameter (the class itself)
- Can access/modify class variables
- Cannot access instance data
"""

class Book:
    """Example showing class methods as alternative constructors."""
    
    # Class variable
    total_books = 0
    
    def __init__(self, title: str, author: str):
        self.title = title
        self.author = author
        Book.total_books += 1
    
    @classmethod
    def from_string(cls, book_str: str) -> 'Book':
        """Alternative constructor: create Book from "title,author" string."""
        title, author = book_str.split(',')
        return cls(title.strip(), author.strip())
    
    @classmethod
    def get_total_books(cls) -> int:
        """Class method to access class variable."""
        return cls.total_books
    
    @classmethod
    def create_empty(cls) -> 'Book':
        """Alternative constructor: create empty book."""
        return cls("Untitled", "Unknown")

# Using class methods
book1 = Book("1984", "George Orwell")
book2 = Book.from_string("Brave New World, Aldous Huxley")
book3 = Book.create_empty()

print(f"Book 1: {book1.title} by {book1.author}")
print(f"Book 2: {book2.title} by {book2.author}")
print(f"Book 3: {book3.title} by {book3.author}")
print(f"Total books: {Book.get_total_books()}")  # 3


# -----------------------------------------------------------------------------
# 9.13 @abstractmethod
# -----------------------------------------------------------------------------
"""
Abstract methods are placeholders that subclasses MUST implement.

ANALOGY: Job description requirement - "must be able to code in Python"

WHY USE ABSTRACT METHODS:
- Enforces interface (guarantees all subclasses have same methods)
- Prevents incomplete classes
- Design clarity (makes required methods explicit)
- Enables polymorphism through common interface

NOTE: Cannot instantiate abstract classes
"""

from abc import ABC, abstractmethod

class Shape(ABC):
    """Abstract base class."""
    
    @abstractmethod
    def area(self) -> float:
        """Calculate area - must be implemented by subclasses."""
        pass
    
    @abstractmethod
    def perimeter(self) -> float:
        """Calculate perimeter - must be implemented by subclasses."""
        pass
    
    def describe(self) -> str:
        """Concrete method (not abstract, can be used as-is)."""
        return f"This shape has area {self.area():.2f}"

class Rectangle(Shape):
    """Concrete class implementing all abstract methods."""
    
    def __init__(self, width: float, height: float):
        self.width = width
        self.height = height
    
    def area(self) -> float:
        return self.width * self.height
    
    def perimeter(self) -> float:
        return 2 * (self.width + self.height)

class Circle(Shape):
    """Another concrete class."""
    
    def __init__(self, radius: float):
        self.radius = radius
    
    def area(self) -> float:
        return 3.14159 * self.radius ** 2
    
    def perimeter(self) -> float:
        return 2 * 3.14159 * self.radius

# Using abstract classes
# shape = Shape()  # TypeError: Can't instantiate abstract class

rectangle = Rectangle(5, 3)
circle = Circle(4)

print(f"Rectangle area: {rectangle.area()}")
print(f"Circle perimeter: {circle.perimeter():.2f}")
print(rectangle.describe())
print(circle.describe())

# Polymorphism: treating different shapes uniformly
shapes = [rectangle, circle]
for shape in shapes:
    print(f"Area: {shape.area():.2f}")


# -----------------------------------------------------------------------------
# 9.14 NAME MANGLING
# -----------------------------------------------------------------------------
"""
Name mangling makes class attributes harder to access from outside.

ANALOGY: Locked diary with a secret code

HOW IT WORKS:
- Prefix with __ (double underscore)
- Python renames to _ClassName__attribute
- Makes "private" attributes (convention, not truly hidden)

WHY USE NAME MANGLING:
- Encapsulation: Prevents accidental external access
- Prevents name clashes in subclasses

NOTE: Not truly private - can still access with mangled name
"""

class BankAccount:
    """Example showing name mangling."""
    
    def __init__(self, account_number: str, balance: float):
        self.account_number = account_number
        self.__balance = balance  # Name mangled to _BankAccount__balance
    
    def deposit(self, amount: float) -> None:
        """Public method to modify private attribute."""
        if amount > 0:
            self.__balance += amount
    
    def withdraw(self, amount: float) -> bool:
        """Public method to modify private attribute."""
        if 0 < amount <= self.__balance:
            self.__balance -= amount
            return True
        return False
    
    def get_balance(self) -> float:
        """Public method to access private attribute."""
        return self.__balance

account = BankAccount("12345", 1000)

# Cannot access __balance directly
# print(account.__balance)  # AttributeError

# Can access through public methods
print(f"Balance: ${account.get_balance()}")

# Can still access via mangled name (but don't!)
print(f"Mangled name access: ${account._BankAccount__balance}")

# Name mangling prevents accidental overriding in subclasses
class SavingsAccount(BankAccount):
    def __init__(self, account_number: str, balance: float, interest_rate: float):
        super().__init__(account_number, balance)
        self.__interest_rate = interest_rate  # Different from parent's __balance


# =============================================================================
# SECTION 10: DATA CLASSES
# =============================================================================

# -----------------------------------------------------------------------------
# 10.1 @dataclass
# -----------------------------------------------------------------------------
"""
@dataclass automatically generates common methods (__init__, __repr__, __eq__).

ANALOGY: Pre-printed form template - fill in the blanks

BENEFITS:
- Less boilerplate (no need to write __init__, __repr__, __eq__ manually)
- Readable (clean, concise class definitions)
- Type hints encouraged
- Immutability option (frozen=True)
- Easy default values
- Automatic ordering methods
"""

from dataclasses import dataclass

@dataclass
class Person:
    """Simple data class for a person."""
    name: str
    age: int
    email: str = ""  # Default value

@dataclass(frozen=True)
class ImmutablePoint:
    """Immutable data class (cannot be modified after creation)."""
    x: float
    y: float

# Using data classes
person1 = Person("Alice", 25, "alice@example.com")
person2 = Person("Alice", 25, "alice@example.com")
person3 = Person("Bob", 30)

print(f"Person: {person1}")  # Auto-generated __repr__
print(f"Equality: {person1 == person2}")  # Auto-generated __eq__
print(f"Different: {person1 == person3}")  # False

# Immutable data class
point = ImmutablePoint(3, 4)
# point.x = 5  # FrozenInstanceError: cannot assign to field 'x'


# -----------------------------------------------------------------------------
# 10.2 FIELDS
# -----------------------------------------------------------------------------
"""
Fields in data classes can be customized using field() function.

FIELD PARAMETERS:
- default: Default value
- default_factory: Function to create default (for mutable types)
- init: Include in __init__ (default True)
- repr: Include in __repr__ (default True)
- compare: Include in comparisons (default True)
- hash: Include in __hash__ (default True)
"""

from dataclasses import dataclass, field
from typing import List

@dataclass
class ShoppingList:
    """Data class with customized fields."""
    
    # Regular field with default
    store: str = "Grocery Store"
    
    # Field with default_factory (mutable type)
    items: List[str] = field(default_factory=list)
    
    # Field excluded from __repr__
    _id: int = field(default=0, repr=False)
    
    # Field with metadata
    priority: int = field(default=1, metadata={"help": "1=low, 5=high"})

# Usage
shopping = ShoppingList()
shopping.items.append("Milk")
shopping.items.append("Eggs")

print(shopping)  # _id not shown in repr
print(f"Items: {shopping.items}")
print(f"Field metadata: {shopping.__dataclass_fields__['priority'].metadata}")


# -----------------------------------------------------------------------------
# 10.3 __post_init__
# -----------------------------------------------------------------------------
"""
__post_init__ runs after __init__ for additional initialization.

ANALOGY: Post-processing a form - double-check and complete after filling

WHEN TO USE:
- Calculating derived values
- Data validation
- Post-processing
- Setting up dependencies

NOTE: Runs only once at object creation
"""

@dataclass
class Product:
    """Data class with post-initialization processing."""
    
    name: str
    price: float
    quantity: int
    total: float = field(init=False)  # Computed field
    
    def __post_init__(self):
        """Calculate total after initialization."""
        self.total = self.price * self.quantity
        # Validation
        if self.price < 0:
            raise ValueError("Price cannot be negative")
        if self.quantity < 0:
            raise ValueError("Quantity cannot be negative")

@dataclass
class Rectangle:
    """Another example with validation."""
    
    width: float
    height: float
    area: float = field(init=False)
    
    def __post_init__(self):
        """Validate and compute derived values."""
        if self.width <= 0:
            raise ValueError(f"Width must be positive: {self.width}")
        if self.height <= 0:
            raise ValueError(f"Height must be positive: {self.height}")
        self.area = self.width * self.height

# Usage
product = Product("Laptop", 999.99, 2)
print(f"{product.name}: ${product.total:.2f}")

rectangle = Rectangle(5, 3)
print(f"Rectangle area: {rectangle.area}")


# -----------------------------------------------------------------------------
# 10.4 InitVar
# -----------------------------------------------------------------------------
"""
InitVar defines fields that are only used during initialization (not stored).

WHY USE INITVAR:
- Pass temporary parameters for initialization only
- Keep class clean (no extra stored attributes)
- Encapsulate one-time initialization logic

EXAMPLE: Discount code applied at creation but not stored
"""

from dataclasses import dataclass, InitVar

@dataclass
class Order:
    """Order with one-time discount code."""
    
    item: str
    base_price: float
    discount_code: InitVar[str] = None  # Not stored
    final_price: float = field(init=False)  # Computed
    
    def __post_init__(self, discount_code: str):
        """Apply discount if code provided."""
        price = self.base_price
        
        if discount_code == "SAVE10":
            price *= 0.9
        elif discount_code == "SAVE20":
            price *= 0.8
        
        self.final_price = price

# Usage
order1 = Order("Laptop", 1000, None)
order2 = Order("Laptop", 1000, "SAVE10")

print(f"Order 1: ${order1.final_price}")
print(f"Order 2: ${order2.final_price}")

# discount_code is NOT stored as attribute
print(f"Order attributes: {[attr for attr in dir(order1) if not attr.startswith('_')]}")
# 'final_price' is there, but 'discount_code' is not


# -----------------------------------------------------------------------------
# 10.5 @property
# -----------------------------------------------------------------------------
"""
@property creates computed attributes that behave like instance attributes.

BENEFITS:
- Encapsulation (control access to attributes)
- Validation (check values in setter)
- Computed values (calculate on-the-fly)
- Read-only properties (no setter)

SYNTAX:
- @property: Getter
- @name.setter: Setter
- @name.deleter: Deleter
"""

class Circle:
    """Circle class with property for radius and computed area."""
    
    def __init__(self, radius: float):
        self._radius = radius  # Protected attribute
    
    @property
    def radius(self) -> float:
        """Getter for radius."""
        return self._radius
    
    @radius.setter
    def radius(self, value: float) -> None:
        """Setter with validation."""
        if value < 0:
            raise ValueError("Radius cannot be negative")
        self._radius = value
    
    @radius.deleter
    def radius(self) -> None:
        """Deleter for radius."""
        print("Deleting radius")
        del self._radius
    
    @property
    def area(self) -> float:
        """Computed property (read-only)."""
        return 3.14159 * self._radius ** 2
    
    @property
    def diameter(self) -> float:
        """Another computed property."""
        return self._radius * 2

# Usage
circle = Circle(5)

# Access like an attribute (no parentheses)
print(f"Radius: {circle.radius}")    # 5
print(f"Area: {circle.area:.2f}")    # 78.54
print(f"Diameter: {circle.diameter}")  # 10

# Setter with validation
circle.radius = 10
print(f"New radius: {circle.radius}")  # 10

# This would raise ValueError:
# circle.radius = -5  # ValueError: Radius cannot be negative

# area is read-only (no setter)
# circle.area = 100  # AttributeError: can't set attribute


# =============================================================================
# SECTION 11: ASYNCIO
# =============================================================================

# -----------------------------------------------------------------------------
# 11.1 ASYNCIO BASICS
# -----------------------------------------------------------------------------
"""
AsyncIO enables asynchronous programming for I/O-bound tasks.

KEY CONCEPTS:
- async def: Defines a coroutine (asynchronous function)
- await: Pauses coroutine until awaited task completes
- asyncio.run(): Entry point for async program

WHEN TO USE:
- I/O-bound operations (API calls, database queries, file I/O)
- High concurrency needs
- Multiple independent operations

WHEN NOT TO USE:
- CPU-bound operations (use multiprocessing)
- Simple scripts (adds complexity)
"""

import asyncio

async def fetch_data(delay: float, name: str) -> str:
    """Simulate fetching data from an API."""
    print(f"Starting {name}...")
    await asyncio.sleep(delay)  # Simulate I/O operation
    print(f"Finished {name}!")
    return f"Data from {name}"

async def main():
    """Main async function."""
    print("Starting async operations...")
    
    # Sequential execution (not taking advantage of async)
    result1 = await fetch_data(2, "API 1")
    result2 = await fetch_data(1, "API 2")
    print(f"Results: {result1}, {result2}")

# Run the async program
# asyncio.run(main())


# -----------------------------------------------------------------------------
# 11.2 TASKS
# -----------------------------------------------------------------------------
"""
Tasks allow running multiple coroutines concurrently.

WHY USE TASKS:
- Concurrency: Run multiple operations simultaneously
- Non-blocking: Don't wait for one to finish before starting another
- Cancellation: Stop long-running operations
"""

async def task_example():
    """Example showing task creation and management."""
    
    async def worker(name: str, delay: float):
        """Simulate work."""
        print(f"Worker {name} starting")
        await asyncio.sleep(delay)
        print(f"Worker {name} finished")
        return f"Result from {name}"
    
    # Create tasks (start running concurrently)
    task1 = asyncio.create_task(worker("A", 2))
    task2 = asyncio.create_task(worker("B", 1))
    task3 = asyncio.create_task(worker("C", 3))
    
    print("All tasks started")
    
    # Wait for all tasks to complete
    results = await asyncio.gather(task1, task2, task3)
    print(f"All results: {results}")


# -----------------------------------------------------------------------------
# 11.3 asyncio.gather()
# -----------------------------------------------------------------------------
"""
gather() runs multiple coroutines concurrently and collects results.

BENEFITS:
- Single await for multiple operations
- Results in same order as coroutines
- Cleaner than managing tasks individually
"""

async def gather_example():
    """Example of using asyncio.gather()."""
    
    async def fetch(url: str, delay: float) -> str:
        """Simulate fetching a URL."""
        await asyncio.sleep(delay)
        return f"Data from {url}"
    
    # Run multiple fetches concurrently
    results = await asyncio.gather(
        fetch("api.com/users", 2),
        fetch("api.com/posts", 1),
        fetch("api.com/comments", 3)
    )
    
    print(f"Fetched {len(results)} items")
    for result in results:
        print(f"  {result}")


# =============================================================================
# SECTION 12: FILE HANDLING
# =============================================================================

# -----------------------------------------------------------------------------
# 12.1 OPENING FILES
# -----------------------------------------------------------------------------
"""
File handling: open, read, write, and close files.

FILE MODES:
- 'r': Read (default)
- 'w': Write (overwrites)
- 'a': Append (adds to end)
- 'x': Exclusive creation (fails if exists)
- 'r+': Read and write

ALWAYS USE 'with' STATEMENT:
- Automatically closes file
- Handles exceptions properly
- Prevents resource leaks
"""

# Basic file operations (ALWAYS use with)
def file_operations_example():
    """Demonstrate proper file handling."""
    
    # Writing to a file (creates or overwrites)
    with open('example.txt', 'w') as file:
        file.write("Hello, World!\n")
        file.write("Second line\n")
    
    # Appending to a file
    with open('example.txt', 'a') as file:
        file.write("Appended line\n")
    
    # Reading from a file
    with open('example.txt', 'r') as file:
        content = file.read()
        print(f"File content:\n{content}")
    
    # Reading line by line
    with open('example.txt', 'r') as file:
        for line in file:
            print(f"Line: {line.strip()}")


# -----------------------------------------------------------------------------
# 12.2 READING FILES
# -----------------------------------------------------------------------------
"""
Different ways to read files.

METHODS:
- read(): Read entire file
- readline(): Read one line
- readlines(): Read all lines into list
"""

def read_file_examples():
    """Demonstrate different reading methods."""
    
    # Create a sample file
    with open('sample.txt', 'w') as f:
        f.write("Line 1\nLine 2\nLine 3\n")
    
    # Method 1: read entire file
    with open('sample.txt', 'r') as f:
        entire = f.read()
        print(f"Entire file:\n{entire}")
    
    # Method 2: read line by line
    with open('sample.txt', 'r') as f:
        print("Line by line:")
        for line in f:
            print(f"  {line.strip()}")
    
    # Method 3: read all lines into list
    with open('sample.txt', 'r') as f:
        lines = f.readlines()
        print(f"Lines list: {lines}")
    
    # Method 4: read one line at a time with readline()
    with open('sample.txt', 'r') as f:
        first_line = f.readline()
        second_line = f.readline()
        print(f"First: {first_line.strip()}")
        print(f"Second: {second_line.strip()}")


# -----------------------------------------------------------------------------
# 12.3 WRITING FILES
# -----------------------------------------------------------------------------
"""
Writing to files (overwrites existing content).

WARNING: 'w' mode clears the entire file before writing!
"""

def write_file_examples():
    """Demonstrate different writing methods."""
    
    # Write a single string
    with open('output.txt', 'w') as f:
        f.write("This is line 1\n")
        f.write("This is line 2\n")
    
    # Write multiple lines with writelines()
    lines = ["Line A\n", "Line B\n", "Line C\n"]
    with open('output.txt', 'w') as f:
        f.writelines(lines)
    
    # Write with error handling
    try:
        with open('/invalid/path/file.txt', 'w') as f:
            f.write("This will fail if path doesn't exist")
    except PermissionError:
        print("Permission denied")
    except OSError as e:
        print(f"OS error: {e}")


# -----------------------------------------------------------------------------
# 12.4 APPENDING TO FILES
# -----------------------------------------------------------------------------
"""
Appending adds content to the end of a file without deleting existing content.

MODE: 'a' (append)
- Creates file if it doesn't exist
- Always writes to end
"""

def append_file_examples():
    """Demonstrate appending to files."""
    
    # Create initial content
    with open('log.txt', 'w') as f:
        f.write("Initial content\n")
    
    # Append multiple times
    with open('log.txt', 'a') as f:
        f.write("Appended line 1\n")
    
    with open('log.txt', 'a') as f:
        f.write("Appended line 2\n")
    
    # Append multiple lines at once
    new_lines = ["Line 3\n", "Line 4\n", "Line 5\n"]
    with open('log.txt', 'a') as f:
        f.writelines(new_lines)
    
    # Read back to verify
    with open('log.txt', 'r') as f:
        print(f"Final content:\n{f.read()}")


# -----------------------------------------------------------------------------
# 12.5 WORKING WITH JSON
# -----------------------------------------------------------------------------
"""
JSON (JavaScript Object Notation) for data interchange.

WHY USE JSON:
- Universal format (supported by all languages)
- Human-readable
- Native Python support (json module)
- API standard

JSON vs Python:
- JSON uses double quotes
- JSON null = Python None
- JSON true/false = Python True/False
"""

import json

def json_examples():
    """Demonstrate working with JSON files."""
    
    # Python data to save
    user_data = {
        "username": "alice123",
        "email": "alice@example.com",
        "age": 25,
        "is_active": True,
        "preferences": {
            "theme": "dark",
            "notifications": True
        },
        "scores": [85, 92, 78]
    }
    
    # Write JSON to file
    with open('user.json', 'w') as f:
        json.dump(user_data, f, indent=4)  # indent for readability
    
    # Read JSON from file
    with open('user.json', 'r') as f:
        loaded_data = json.load(f)
    
    print(f"Loaded username: {loaded_data['username']}")
    print(f"Loaded preferences: {loaded_data['preferences']}")
    
    # Convert Python dict to JSON string
    json_string = json.dumps(user_data, indent=2)
    print(f"\nJSON string:\n{json_string}")
    
    # Convert JSON string to Python dict
    json_str = '{"name": "Bob", "age": 30}'
    parsed = json.loads(json_str)
    print(f"Parsed: {parsed}")


# =============================================================================
# SECTION 13: PROJECTS
# =============================================================================

# -----------------------------------------------------------------------------
# 13.1 SIMPLE ADDER
# -----------------------------------------------------------------------------

def simple_adder() -> None:
    """A simple calculator that adds two numbers."""
    print("\n" + "=" * 50)
    print("SIMPLE ADDER")
    print("=" * 50)
    
    print("Welcome to your simple adder")
    print(30 * "-")
    
    try:
        a = int(input("Enter a value for a : "))
        b = int(input("Enter another value for b : "))
        
        print(30 * "-")
        print(f"The result is : {a + b}")
    except ValueError:
        print("Error: Please enter valid numbers!")
    
    print("=" * 50)


# -----------------------------------------------------------------------------
# 13.2 MAD LIBS GAME
# -----------------------------------------------------------------------------

def mad_libs() -> None:
    """A word game where users create a silly story."""
    print("\n" + "=" * 50)
    print("MAD LIBS GAME")
    print("=" * 50)
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


# -----------------------------------------------------------------------------
# 13.3 ROCK, PAPER, SCISSORS
# -----------------------------------------------------------------------------

def rock_paper_scissors() -> None:
    """A complete Rock, Paper, Scissors game against the AI."""
    print("\n" + "=" * 50)
    print("ROCK, PAPER, SCISSORS GAME")
    print("=" * 50)
    
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
    
    player_wins = 0
    ai_wins = 0
    ties = 0
    
    while True:
        user_input = input("\nEnter rock, paper, or scissors: ").lower()
        
        if user_input == "exit":
            print("\n" + "-" * 30)
            print("FINAL SCORE:")
            print(f"  You: {player_wins}")
            print(f"  AI: {ai_wins}")
            print(f"  Ties: {ties}")
            print("Thanks for playing! Goodbye.")
            break
        
        if user_input not in valid_moves:
            print("Invalid input, please try again.")
            continue
        
        ai_move = random.choice(valid_moves)
        
        print(f"\nYou chose: {user_input} {moves[user_input]}")
        print(f"AI chose:  {ai_move} {moves[ai_move]}")
        
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
        
        print(f"\nScore - You: {player_wins} | AI: {ai_wins} | Ties: {ties}")
        print("-" * 30)


# -----------------------------------------------------------------------------
# 13.4 GROCERY LIST
# -----------------------------------------------------------------------------

def grocery_list_app() -> None:
    """A grocery list management application."""
    print("\n" + "=" * 50)
    print("GROCERY LIST APP")
    print("=" * 50)
    
    groceries = []
    
    def show_menu():
        print("\n1: Add an item")
        print("2: Remove an item")
        print("3: List all items")
        print("0: Exit the program")
    
    print("Welcome to Groceries!")
    
    while True:
        show_menu()
        choice = input("Choose an option: ").strip()
        
        if choice == '0':
            print("Exiting the program. Goodbye!")
            break
        
        elif choice == '1':
            item = input("What item would you like to add? ").strip()
            if item:
                groceries.append(item)
                print(f"'{item}' added to your list.")
            else:
                print("Please enter a valid item name.")
        
        elif choice == '2':
            if not groceries:
                print("Your grocery list is empty.")
                continue
            item = input("What item would you like to remove? ").strip()
            if item in groceries:
                groceries.remove(item)
                print(f"'{item}' removed from your list.")
            else:
                print(f"'{item}' not found in the list.")
        
        elif choice == '3':
            if groceries:
                print("\nYour groceries:")
                for i, item in enumerate(groceries, 1):
                    print(f"  {i}. {item}")
            else:
                print("Your grocery list is empty.")
        
        else:
            print("Please pick a valid option (0-3).")


# -----------------------------------------------------------------------------
# 13.5 CHAT BOT
# -----------------------------------------------------------------------------

def chat_bot() -> None:
    """A simple rule-based chat bot."""
    print("\n" + "=" * 50)
    print("CHAT BOT")
    print("=" * 50)
    
    responses = {
        "hello": ["Hey there!", "Hi!", "Hello!", "Greetings!"],
        "how are you": ["I'm good, thanks!", "Doing great!", "All good here!"],
        "what time is it": [datetime.datetime.now().strftime("%I:%M %p")],
        "your name": ["I'm Bot, your virtual assistant!"],
        "joke": [
            "Why do programmers prefer dark mode? Because light attracts bugs!",
            "What do you call a snake that codes? A python!",
            "Why did the programmer quit his job? Because he didn't get arrays!"
        ],
        "thanks": ["You're welcome!", "Happy to help!", "Anytime!"]
    }
    
    def get_response(user_input: str) -> str:
        """Get bot response based on user input."""
        message = user_input.lower()
        for key in responses:
            if key in message:
                return random.choice(responses[key])
        
        default_responses = [
            "I do not understand.",
            "Could you please rephrase that?",
            "Interesting... tell me more!",
            "I'm not sure what you mean."
        ]
        return random.choice(default_responses)
    
    name = input("What's your name? ").strip() or "Friend"
    print(f"\nNice to meet you, {name}!")
    print("Type 'goodbye' to exit.")
    print("-" * 50)
    
    while True:
        user_input = input(f"{name}: ")
        
        if user_input.lower() in ["goodbye", "exit", "quit"]:
            print(f"Bot: Goodbye, {name}! It was nice talking to you!")
            break
        
        response = get_response(user_input)
        print(f"Bot: {response}")


# -----------------------------------------------------------------------------
# 13.6 WEBSITE STATUS CHECKER
# -----------------------------------------------------------------------------
"""
Note: This requires the 'requests' library to be installed:
pip install requests
"""

def website_status_checker() -> None:
    """Check the status of a website."""
    import requests  # Requires: pip install requests
    
    print("\n" + "=" * 50)
    print("WEBSITE STATUS CHECKER")
    print("=" * 50)
    
    url = input("Enter website URL (e.g., https://example.com): ").strip()
    
    try:
        response = requests.get(url, timeout=10)
        print(f"\nStatus Code: {response.status_code}")
        print(f"Status: {'OK' if response.ok else 'Error'}")
        print(f"Encoding: {response.encoding}")
        print(f"Response Time: {response.elapsed.total_seconds():.2f} seconds")
        
        if response.status_code == 200:
            print("✅ Website is accessible!")
        elif response.status_code == 404:
            print("❌ Page not found (404)")
        elif response.status_code == 403:
            print("🔒 Access forbidden (403)")
        else:
            print(f"⚠️  Response: {response.status_code}")
            
    except requests.exceptions.ConnectionError:
        print(f"❌ Cannot connect to {url}")
    except requests.exceptions.Timeout:
        print("❌ Request timed out")
    except Exception as e:
        print(f"❌ Error: {e}")


# -----------------------------------------------------------------------------
# 13.7 NOTE TAKING APP
# -----------------------------------------------------------------------------

@dataclass
class Note:
    """Represents a single note."""
    title: str
    body: str
    created_at: datetime.datetime = field(default_factory=datetime.datetime.now)

class NoteApp:
    """A simple note-taking application."""
    
    def __init__(self):
        self._notes: List[Note] = []
    
    def add_note(self, title: str, body: str) -> None:
        """Add a new note."""
        note = Note(title, body)
        self._notes.append(note)
        print(f"Note '{title}' added successfully.")
    
    def show_notes(self) -> None:
        """Show all notes."""
        if not self._notes:
            print("No notes found.")
            return
        
        print("\n" + "-" * 40)
        for i, note in enumerate(self._notes, 1):
            print(f"{i}. {note.title}")
            print(f"   Created: {note.created_at.strftime('%Y-%m-%d %H:%M')}")
            print(f"   {note.body[:100]}...")
            print()
    
    def delete_note(self, index: int) -> None:
        """Delete a note by index."""
        if 1 <= index <= len(self._notes):
            deleted = self._notes.pop(index - 1)
            print(f"Note '{deleted.title}' deleted.")
        else:
            print("Invalid note number.")

def note_app():
    """Run the note-taking application."""
    print("\n" + "=" * 50)
    print("NOTE TAKING APP")
    print("=" * 50)
    
    app = NoteApp()
    
    while True:
        print("\n1: Add Note")
        print("2: Show Notes")
        print("3: Delete Note")
        print("0: Exit")
        
        choice = input("Choose option: ").strip()
        
        if choice == '0':
            print("Goodbye!")
            break
        elif choice == '1':
            title = input("Title: ").strip()
            body = input("Body: ").strip()
            if title and body:
                app.add_note(title, body)
            else:
                print("Title and body cannot be empty.")
        elif choice == '2':
            app.show_notes()
        elif choice == '3':
            app.show_notes()
            try:
                idx = int(input("Enter note number to delete: "))
                app.delete_note(idx)
            except ValueError:
                print("Please enter a valid number.")
        else:
            print("Invalid option.")


# =============================================================================
# MAIN FUNCTION
# =============================================================================

def main():
    """Main function to run all demonstrations."""
    print("\n" + "=" * 60)
    print("PYTHON FUNDAMENTALS DEMONSTRATION")
    print("=" * 60)
    
    # Uncomment any project to run it
    # simple_adder()
    # mad_libs()
    # rock_paper_scissors()
    # grocery_list_app()
    # chat_bot()
    # note_app()
    
    print("\n" + "=" * 60)
    print("THANK YOU FOR LEARNING PYTHON!")
    print("=" * 60)


# =============================================================================
# MAIN EXECUTION GUARD
# =============================================================================

if __name__ == "__main__":
    main()
