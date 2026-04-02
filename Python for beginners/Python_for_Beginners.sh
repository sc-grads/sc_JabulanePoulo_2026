Python for Beginners


cat << 'EOF'
===============================================================================
                        PYTHON FUNDAMENTALS DOCUMENTATION
===============================================================================

TABLE OF CONTENTS
===============================================================================
1. Syntax
2. Comments
3. Variables
4. Constants
5. Data Types
6. Sequence Types
7. Type Hints (Type Annotations)
8. Integers
9. Floats
10. Comparison Operators
11. Logical Operators
12. Boolean Data Type
13. Strings
14. Type Conversion


===============================================================================
1. SYNTAX
===============================================================================

Syntax is the set of rules, principles, and processes that govern the structure
of sentences in a given language, specifically word order.

In Python, strings are always surrounded by quotes. This is an example of
Python's syntax:

    print("Hello, World!")


===============================================================================
2. COMMENTS
===============================================================================

A comment is a line (or part of a line) of code written in English preceded by
a special symbol that tells Python to ignore that line. In Python, the pound
symbol (#) is used to create comments.

Single-line Comments:
--------------------------------------------------------------------------------
    # This is a comment
    print("Hello")  # This is also a comment

Why Use Comments:
--------------------------------------------------------------------------------
    Purpose                 | Description
    ------------------------|--------------------------------------------------
    Clarify Intent          | Explain why code was written a certain way
    Improve Readability     | Make code easier to understand
    Explain Complex Logic   | Document algorithms or formulas
    Debugging               | Temporarily disable code

Best Practices:
--------------------------------------------------------------------------------
    DO                          | DON'T
    ----------------------------|--------------------------------
    Explain why, not what       | State the obvious
    Use for complex logic       | Comment every line
    Keep comments up to date    | Leave outdated comments
    Write clear, concise        | Write lengthy explanations


===============================================================================
3. VARIABLES
===============================================================================

A variable is a named storage location in memory that holds a value. In Python,
variables are created when you assign a value to them.

Variable Assignment:
--------------------------------------------------------------------------------
    name = "Alice"
    age = 25
    height = 5.7
    is_student = True

    # Multiple assignment
    x, y, z = 10, 20, 30

    # Same value to multiple variables
    a = b = c = 100

Variable Naming Rules:
--------------------------------------------------------------------------------
    Rule                        | Correct        | Incorrect
    ----------------------------|----------------|------------------
    Start with letter/_         | name, _age     | 1st_name
    Letters, numbers, _ only    | user_1         | user-name
    Case-sensitive              | Age and age    |
    No reserved keywords        | total          | if, else, for

Naming Conventions:
--------------------------------------------------------------------------------
    Convention      | Example                | Usage
    ----------------|------------------------|------------------------
    snake_case      | first_name, total      | Variables (recommended)
    PascalCase      | Person, BankAccount    | Class names
    UPPER_CASE      | MAX_SIZE, PI           | Constants

Variable Scope:
--------------------------------------------------------------------------------
    Scope       | Description
    ------------|--------------------------------------------------------
    Local       | Created inside a function; accessible only within
    Global      | Created outside any function; accessible throughout
    Enclosing   | In nested functions, variables from outer function
    Built-in    | Predefined in Python (print, len, etc.)


===============================================================================
4. CONSTANTS
===============================================================================

A constant is a value that never changes. Python does not have built-in
constant support, but by convention, programmers use all uppercase names.

Constants by Convention:
--------------------------------------------------------------------------------
    PI = 3.14159
    GRAVITY = 9.81
    MAX_USERS = 100
    DEFAULT_COLOR = "blue"

Why Use Constants:
--------------------------------------------------------------------------------
    Purpose                 | Explanation
    ------------------------|--------------------------------------------------
    Improve Readability     | PI is clearer than 3.14159
    Simplify Maintenance    | Change value in one place instead of everywhere
    Prevent Errors          | Makes obvious which values should remain fixed


===============================================================================
5. DATA TYPES
===============================================================================

A data type specifies which type of value a variable can hold and what
operations can be performed on it.

Built-in Data Types:
--------------------------------------------------------------------------------
    Category    | Data Types
    ------------|----------------------------------------
    Text        | str
    Numeric     | int, float, complex
    Boolean     | bool
    Sequence    | list, tuple, range
    Mapping     | dict
    Set         | set, frozenset
    Binary      | bytes, bytearray, memoryview
    None        | NoneType

Checking Data Types:
--------------------------------------------------------------------------------
    x = 10
    print(type(x))                    # <class 'int'>
    print(isinstance(x, int))         # True
    print(isinstance(x, (int, float))) # True

Mutable vs. Immutable:
--------------------------------------------------------------------------------
    Mutable (can be changed)    | Immutable (cannot be changed)
    ----------------------------|--------------------------------
    list, dict, set, bytearray  | int, float, str, tuple, bool


===============================================================================
6. SEQUENCE TYPES
===============================================================================

Sequence types represent an ordered collection of items. All sequences support
indexing, slicing, and iteration.

Types of Sequences:
--------------------------------------------------------------------------------
    Type    | Mutable | Description
    --------|---------|------------------------------------------
    list    | Yes     | Ordered, mutable collection of any items
    tuple   | No      | Ordered, immutable collection of any items
    str     | No      | Ordered, immutable sequence of characters
    range   | No      | Immutable sequence of numbers

Common Sequence Operations:
--------------------------------------------------------------------------------
    my_list = [10, 20, 30, 40]

    # Indexing
    print(my_list[0])      # 10
    print(my_list[-1])     # 40

    # Slicing [start:stop:step]
    print(my_list[1:3])    # [20, 30]
    print(my_list[::-1])   # [40, 30, 20, 10]

    # Length
    print(len(my_list))    # 4

    # Concatenation
    new_list = my_list + [50, 60]

    # Repetition
    repeated = [1, 2] * 3  # [1, 2, 1, 2, 1, 2]

    # Membership
    print(20 in my_list)   # True

List:
--------------------------------------------------------------------------------
    # Creation
    empty_list = []
    numbers = [1, 2, 3, 4, 5]
    mixed = [1, "hello", 3.14, True]

    # Methods
    numbers.append(6)       # Add to end
    numbers.insert(2, 99)   # Insert at position
    numbers.pop()           # Remove last
    numbers.remove(3)       # Remove specific value
    numbers.sort()          # Sort in place

Tuple:
--------------------------------------------------------------------------------
    # Creation
    empty_tuple = ()
    point = (10, 20)
    single = (5,)           # Comma required

    # Unpacking
    x, y = point
    print(x)                # 10
    print(y)                # 20

    # Tuples are immutable
    # point[0] = 15         # TypeError

String:
--------------------------------------------------------------------------------
    # Creation
    single = 'Hello'
    double = "World"
    multi = """Multi-line string"""

    # Common methods
    text = "  Python  "
    print(text.strip())      # "Python"
    print(text.upper())      # "  PYTHON  "
    print(text.lower())      # "  python  "
    print(text.replace("Py", "Ja"))  # "  Jathon  "

Range:
--------------------------------------------------------------------------------
    # Creating ranges
    r1 = range(5)           # 0, 1, 2, 3, 4
    r2 = range(2, 8)        # 2, 3, 4, 5, 6, 7
    r3 = range(0, 10, 2)    # 0, 2, 4, 6, 8

    # Convert to list to see values
    print(list(r1))         # [0, 1, 2, 3, 4]


===============================================================================
7. TYPE HINTS (TYPE ANNOTATIONS)
===============================================================================

Type hints indicate the expected data types of variables, function parameters,
and return values. They are ignored at runtime but help with code clarity.

Syntax:
--------------------------------------------------------------------------------
    # Variable type hint
    name: str = "Alice"
    age: int = 25
    prices: list[float] = [19.99, 29.99]

    # Function type hints
    def greet(name: str) -> str:
        return f"Hello, {name}"

    def calculate(a: int, b: int) -> int:
        return a + b

Collection Type Hints:
--------------------------------------------------------------------------------
    # Python 3.9+
    names: list[str] = ["Alice", "Bob"]
    scores: dict[str, int] = {"Alice": 95}
    coordinates: tuple[int, int] = (10, 20)
    unique: set[int] = {1, 2, 3}

Advanced Type Hints:
--------------------------------------------------------------------------------
    from typing import Optional, Union, Any

    # Optional (can be None)
    def find_user(id: int) -> Optional[str]:
        return "Alice" if id == 1 else None

    # Union (multiple possible types)
    def process(data: Union[int, str]) -> str:
        return str(data)

    # Python 3.10+ alternative
    def process(data: int | str) -> str:
        return str(data)

Type Checkers:
--------------------------------------------------------------------------------
    Tool        | Purpose
    ------------|------------------------------------------
    mypy        | Static type checker (most popular)
    pyright     | Microsoft's type checker
    pylance     | Python language server for VS Code
    PyCharm     | Built-in type checking


===============================================================================
8. INTEGERS
===============================================================================

Integers are whole numbers that can be positive, negative, or zero. They are
represented with the int type.

Examples:
--------------------------------------------------------------------------------
    positive = 30
    negative = -50
    zero = 0
    large = 10 ** 100        # Unlimited precision

Integer Operations:
--------------------------------------------------------------------------------
    Operation           | Symbol | Example    | Result
    --------------------|--------|------------|--------
    Addition            | +      | 5 + 3      | 8
    Subtraction         | -      | 10 - 4     | 6
    Multiplication      | *      | 7 * 6      | 42
    Division            | /      | 15 / 2     | 7.5
    Floor Division      | //     | 15 // 2    | 7
    Modulus (remainder) | %      | 15 % 2     | 1
    Exponentiation      | **     | 2 ** 4     | 16

Type Hint:
--------------------------------------------------------------------------------
    age: int = 30
    count: int = 100


===============================================================================
9. FLOATS
===============================================================================

Floats are numbers that contain decimal points. They are represented with the
float type.

Examples:
--------------------------------------------------------------------------------
    pi = 3.14159
    temperature = -2.5
    zero_float = 0.0
    scientific = 2.5e-3      # 0.0025

Precision Limitations:
--------------------------------------------------------------------------------
    # Due to binary representation, some floats are not exact
    print(0.1 + 0.2)          # 0.30000000000000004

    # Workaround
    result = round(0.1 + 0.2, 1)   # 0.3

    # For exact decimals
    from decimal import Decimal
    result = Decimal('0.1') + Decimal('0.2')   # 0.3

Special Float Values:
--------------------------------------------------------------------------------
    positive_inf = float('inf')
    negative_inf = float('-inf')
    not_a_number = float('nan')

Type Hint:
--------------------------------------------------------------------------------
    price: float = 19.99
    temperature: float = 98.6


===============================================================================
10. COMPARISON OPERATORS
===============================================================================

Comparison operators return a boolean value (True or False).

Operators:
--------------------------------------------------------------------------------
    Operator    | Name                     | Example      | Result
    ------------|--------------------------|--------------|--------
    ==          | Equal                    | 5 == 5       | True
    !=          | Not Equal                | 5 != 3       | True
    >           | Greater Than             | 5 > 3        | True
    <           | Less Than                | 5 < 3        | False
    >=          | Greater Than or Equal    | 5 >= 5       | True
    <=          | Less Than or Equal       | 5 <= 3       | False

Examples:
--------------------------------------------------------------------------------
    a = 5
    b = 5

    print(a == b)   # True
    print(a != b)   # False
    print(a > b)    # False
    print(a < b)    # False
    print(a >= b)   # True
    print(a <= b)   # True


===============================================================================
11. LOGICAL OPERATORS
===============================================================================

Logical operators combine multiple conditions.

Operators:
--------------------------------------------------------------------------------
    Operator    | Description                       | Example
    ------------|-----------------------------------|-------------------
    and         | True if both are True             | True and False -> False
    or          | True if at least one is True      | True or False -> True
    not         | Reverses boolean value            | not True -> False

Truth Tables:
--------------------------------------------------------------------------------
    A       | B       | A and B
    --------|---------|--------
    True    | True    | True
    True    | False   | False
    False   | True    | False
    False   | False   | False

    A       | B       | A or B
    --------|---------|-------
    True    | True    | True
    True    | False   | True
    False   | True    | True
    False   | False   | False

    A       | not A
    --------|-------
    True    | False
    False   | True

Examples:
--------------------------------------------------------------------------------
    a = 5
    b = 5
    c = 10
    d = 10

    print((c == d) and (b > a))   # False
    print((c == d) or (b > a))    # True
    print(not (a == b))           # False

Operator Precedence:
--------------------------------------------------------------------------------
    Precedence      | Operator(s)
    ----------------|------------------------------------------
    Highest         | () parentheses
                    | ** exponentiation
                    | *, /, //, %
                    | +, -
                    | ==, !=, >, <, >=, <=
                    | not
                    | and
    Lowest          | or


===============================================================================
12. BOOLEAN DATA TYPE
===============================================================================

Booleans represent two states: True and False.

Examples:
--------------------------------------------------------------------------------
    is_connected = True
    has_money = False
    is_active = True

Numeric Representation:
--------------------------------------------------------------------------------
    print(int(True))    # 1
    print(int(False))   # 0

    # Booleans in arithmetic
    print(True + True)   # 2
    print(False * 10)    # 0

Falsy Values (Convert to False):
--------------------------------------------------------------------------------
    Value               | Boolean Result
    --------------------|----------------
    0, 0.0              | False
    "" (empty string)   | False
    [] (empty list)     | False
    () (empty tuple)    | False
    {} (empty dict)     | False
    None                | False

All other values convert to True.


===============================================================================
13. STRINGS
===============================================================================

Strings are sequences of characters used to represent text.

Creating Strings:
--------------------------------------------------------------------------------
    single = 'Hello'
    double = "World"
    multi = """Multi-line string"""
    empty = ""

String Operations:
--------------------------------------------------------------------------------
    Operation       | Symbol | Example              | Result
    ----------------|--------|----------------------|-----------------
    Concatenation   | +      | "Hello" + " World"   | "Hello World"
    Repetition      | *      | "Hi" * 3             | "HiHiHi"
    Indexing        | [n]    | "Hello"[0]           | "H"
    Slicing         | [s:e]  | "Hello"[1:4]         | "ell"
    Length          | len()  | len("Hello")         | 5

Common String Methods:
--------------------------------------------------------------------------------
    Method      | Description           | Example              | Result
    ------------|-----------------------|----------------------|---------------
    lower()     | Convert to lowercase  | "HELLO".lower()      | "hello"
    upper()     | Convert to uppercase  | "hello".upper()      | "HELLO"
    strip()     | Remove whitespace     | "  hi  ".strip()     | "hi"
    replace()   | Replace substring     | "hello".replace("e","a") | "hallo"
    split()     | Split into list       | "a,b,c".split(",")   | ["a","b","c"]
    join()      | Join list with string | "-".join(["a","b"])  | "a-b"
    find()      | Find substring index  | "hello".find("e")    | 1
    count()     | Count occurrences     | "banana".count("a")  | 3

String Formatting:
--------------------------------------------------------------------------------
    name = "Alice"
    age = 25

    # f-strings (Python 3.6+)
    greeting = f"Hello, {name}! You are {age} years old."

    # format() method
    greeting = "Hello, {}! You are {} years old.".format(name, age)

    # Percent formatting (legacy)
    greeting = "Hello, %s! You are %d years old." % (name, age)

Escape Characters:
--------------------------------------------------------------------------------
    Escape      | Meaning
    ------------|----------------
    \n          | Newline
    \t          | Tab
    \'          | Single quote
    \"          | Double quote
    \\          | Backslash

String Immutability:
--------------------------------------------------------------------------------
    # Strings cannot be changed after creation
    text = "Hello"
    # text[0] = "J"           # TypeError

    # Creating new string instead
    text = "J" + text[1:]     # "Jello"


===============================================================================
14. TYPE CONVERSION
===============================================================================

Type conversion is the process of converting one data type to another.

Implicit Conversion (Automatic):
--------------------------------------------------------------------------------
    # Python automatically converts types when needed
    result = 5 + 2.5          # int -> float, result is 7.5 (float)
    result = 5 + True         # bool -> int, result is 6 (int)

Explicit Conversion (Type Casting):
--------------------------------------------------------------------------------
    Function    | Converts To | Example           | Result
    ------------|-------------|-------------------|------------
    int()       | Integer     | int(3.14)         | 3
    int()       | Integer     | int("123")        | 123
    float()     | Float       | float(5)          | 5.0
    float()     | Float       | float("3.14")     | 3.14
    str()       | String      | str(123)          | "123"
    bool()      | Boolean     | bool(1)           | True
    list()      | List        | list("abc")       | ["a","b","c"]
    tuple()     | Tuple       | tuple([1,2])      | (1,2)
    set()       | Set         | set([1,2,2])      | {1,2}

Converting User Input:
--------------------------------------------------------------------------------
    # User input always returns a string
    age = int(input("Enter your age: "))
    price = float(input("Enter price: "))

Handling Conversion Errors:
--------------------------------------------------------------------------------
    def safe_int(value):
        try:
            return int(value)
        except (ValueError, TypeError):
            return None

    print(safe_int("123"))    # 123
    print(safe_int("ten"))    # None

Valid vs. Invalid Conversions:
--------------------------------------------------------------------------------
    From        | To         | Valid Examples      | Invalid Examples
    ------------|------------|---------------------|------------------
    String      | Integer    | "123", "-456"       | "ten", "12.3"
    String      | Float      | "3.14", "1e-3"      | "abc"
    Float       | Integer    | 3.14 -> 3           | N/A (truncates)


===============================================================================
QUICK REFERENCE
===============================================================================

Common Data Types:
--------------------------------------------------------------------------------
    Type    | Description                    | Example
    --------|--------------------------------|--------------------
    int     | Whole numbers                  | age = 25
    float   | Decimal numbers                | price = 19.99
    str     | Text                           | name = "Alice"
    bool    | True/False                     | is_valid = True
    list    | Ordered, mutable collection    | colors = ["red", "green"]
    tuple   | Ordered, immutable collection  | point = (10, 20)
    dict    | Key-value pairs                | {"name": "Alice"}
    set     | Unordered, unique items        | {1, 2, 3}
    NoneType| Absence of value               | result = None

Common Operators:
--------------------------------------------------------------------------------
    Category        | Operators
    ----------------|------------------------------------------
    Arithmetic      | +, -, *, /, //, %, **
    Comparison      | ==, !=, >, <, >=, <=
    Logical         | and, or, not
    Assignment      | =, +=, -=, *=, /=

===============================================================================
                        END OF DOCUMENTATION
===============================================================================
EOF