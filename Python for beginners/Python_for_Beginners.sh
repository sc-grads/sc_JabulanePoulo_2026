
# Python Fundamentals Documentation


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
15. EXCEPTION HANDLING (TRY, EXCEPT, ELSE, FINALLY)
16. THE RAISE KEYWORD

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
15	Functions (definition, syntax, scope, docstrings)
16	Parameters vs. Arguments (positional, keyword, default)
17	Return Statements (multiple returns, early exit, returning multiple values)
18	Lambda Functions (anonymous functions, map, filter, sorted)
19	Recursion (base case, recursive case, factorial, fibonacci)
20	*args and **kwargs (variable arguments, unpacking)
21	Slash (/) and Asterisk (*) (positional-only, keyword-only)
22	Chat Bot (practical project with random responses)

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
15. FUNCTIONS
===============================================================================

A function is a block of organized, reusable code that performs a specific task.

Why Use Functions:
--------------------------------------------------------------------------------
    Reason          | Explanation
    ----------------|----------------------------------------------------------
    Reusability     | Write code once and use it multiple times
    Maintainability | Update code in one place instead of multiple locations
    Organization    | Break code into logical sections for better understanding
    Debugging       | Isolate and test individual pieces of code
    Abstraction     | Hide complex logic behind a simple function call

Function Syntax:
--------------------------------------------------------------------------------
    def function_name(parameters):
        """Optional docstring describing the function."""
        # Function body
        return value  # Optional

Simple Function Examples:
--------------------------------------------------------------------------------
    # Function with no parameters and no return value
    def say_hello():
        print("Hello, World!")

    # Function with parameters but no return value
    def greet(name):
        print(f"Hello, {name}!")

    # Function with parameters and a return value
    def add(a, b):
        return a + b

    # Calling functions
    say_hello()              # Output: Hello, World!
    greet("Alice")           # Output: Hello, Alice!
    result = add(5, 3)       # result = 8

Docstrings (Function Documentation):
--------------------------------------------------------------------------------
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
    help(calculate_area)

Variable Scope:
--------------------------------------------------------------------------------
    Scope       | Description
    ------------|------------------------------------------------------------
    Local       | Variables defined inside a function; cannot be accessed outside
    Global      | Variables defined outside any function; accessible everywhere
    Enclosing   | Variables in outer functions for nested functions
    Built-in    | Predefined in Python (print, len, etc.)

    # Local variable example
    def my_function():
        x = 10          # Local variable
        print(x)

    my_function()       # Output: 10
    # print(x)          # NameError: name 'x' is not defined

    # Global variable example
    count = 0           # Global variable

    def increment():
        global count
        count += 1

    increment()
    print(count)        # Output: 1


===============================================================================
16. PARAMETERS VS. ARGUMENTS
===============================================================================

Parameters are variables in a function definition. Arguments are actual values
passed to the function when called.

Definitions:
--------------------------------------------------------------------------------
    Term        | Definition                          | Location
    ------------|-------------------------------------|--------------------
    Parameter   | Variable in function definition    | Function definition
    Argument    | Actual value passed to function     | Function call

Example:
--------------------------------------------------------------------------------
    def greet(name):        # 'name' is a PARAMETER
        print(f"Hello, {name}!")

    greet("Alice")          # "Alice" is an ARGUMENT

Types of Arguments:
--------------------------------------------------------------------------------
    Type                | Description                          | Example
    --------------------|--------------------------------------|-----------------
    Positional          | Assigned by order/position           | func(1, 2, 3)
    Keyword             | Assigned by parameter name           | func(a=1, b=2)
    Default parameters  | Have default values if not provided  | def func(a=10)

Positional Arguments:
--------------------------------------------------------------------------------
    def introduce(name, age, city):
        print(f"{name} is {age} years old and lives in {city}.")

    # Arguments match parameters by position
    introduce("Alice", 25, "New York")
    # Output: Alice is 25 years old and lives in New York.

Keyword Arguments:
--------------------------------------------------------------------------------
    # Order does not matter with keyword arguments
    introduce(city="London", name="Bob", age=30)
    # Output: Bob is 30 years old and lives in London.

Default Parameters:
--------------------------------------------------------------------------------
    def greet(name="Guest"):
        print(f"Hello, {name}!")

    greet()              # Output: Hello, Guest!
    greet("Alice")       # Output: Hello, Alice!

    # Default parameters must come after non-default parameters
    def correct(a, b=10):    # Correct
        pass

    # def wrong(a=10, b):    # SyntaxError
    #     pass


===============================================================================
17. RETURN STATEMENTS
===============================================================================

The return statement exits a function and sends a value back to the caller.

Basic Return:
--------------------------------------------------------------------------------
    def add(a, b):
        return a + b

    result = add(5, 3)
    print(result)       # Output: 8

Functions Without Return (return None):
--------------------------------------------------------------------------------
    def say_hello(name):
        print(f"Hello, {name}!")
        # No return statement

    result = say_hello("Alice")
    print(result)       # Output: None

Multiple Return Statements:
--------------------------------------------------------------------------------
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

Early Exit with Return:
--------------------------------------------------------------------------------
    def process_age(age):
        if age < 0:
            return "Invalid age"    # Early exit
        if age < 18:
            return "Minor"
        if age < 65:
            return "Adult"
        return "Senior"

    print(process_age(-5))   # Output: Invalid age
    print(process_age(15))   # Output: Minor
    print(process_age(30))   # Output: Adult
    print(process_age(70))   # Output: Senior

Returning Multiple Values:
--------------------------------------------------------------------------------
    def get_min_max(numbers):
        return min(numbers), max(numbers)

    lowest, highest = get_min_max([10, 20, 5, 30, 15])
    print(f"Lowest: {lowest}, Highest: {highest}")
    # Output: Lowest: 5, Highest: 30

Return vs. Print:
--------------------------------------------------------------------------------
    Feature         | return                     | print()
    ----------------|----------------------------|------------------
    Purpose         | Send value back to caller  | Display to console
    Can be stored   | Yes                        | No
    Ends function   | Yes                        | No
    Used in expressions | Yes                   | No


===============================================================================
18. LAMBDA FUNCTIONS
===============================================================================

Lambda functions are small, anonymous functions defined in one line.

Syntax:
--------------------------------------------------------------------------------
    lambda parameters: expression

Examples:
--------------------------------------------------------------------------------
    # Regular function
    def square(x):
        return x ** 2

    # Lambda function (same)
    square_lambda = lambda x: x ** 2

    print(square(5))          # Output: 25
    print(square_lambda(5))   # Output: 25

    # Lambda with multiple parameters
    add = lambda a, b: a + b
    print(add(3, 5))          # Output: 8

Lambda with Built-in Functions:
--------------------------------------------------------------------------------
    numbers = [1, 2, 3, 4, 5]

    # Using map() with lambda
    squared = list(map(lambda x: x ** 2, numbers))
    print(squared)            # Output: [1, 4, 9, 16, 25]

    # Using filter() with lambda
    evens = list(filter(lambda x: x % 2 == 0, numbers))
    print(evens)              # Output: [2, 4]

    # Using sorted() with lambda
    pairs = [(1, 2), (3, 1), (5, 0)]
    sorted_pairs = sorted(pairs, key=lambda x: x[1])
    print(sorted_pairs)       # Output: [(5, 0), (3, 1), (1, 2)]


===============================================================================
19. RECURSION
===============================================================================

Recursion is a technique where a function calls itself to solve a problem.

Key Components:
--------------------------------------------------------------------------------
    Component       | Description
    ----------------|----------------------------------------------------------
    Base Case       | Stops recursion (prevents infinite loops)
    Recursive Case  | Function calls itself with modified arguments
    Call Stack      | Each function call is placed on the stack

Factorial Example:
--------------------------------------------------------------------------------
    def factorial(n):
        # Base case
        if n == 0:
            return 1
        # Recursive case
        return n * factorial(n - 1)

    print(factorial(5))   # Output: 120 (5 * 4 * 3 * 2 * 1)

Fibonacci Example:
--------------------------------------------------------------------------------
    def fibonacci(n):
        if n <= 0:
            return 0
        elif n == 1:
            return 1
        else:
            return fibonacci(n - 1) + fibonacci(n - 2)

    print(fibonacci(7))   # Output: 13

Recursion vs. Iteration:
--------------------------------------------------------------------------------
    Aspect          | Recursion                 | Iteration (Loops)
    ----------------|---------------------------|------------------
    Code readability| Clean for tree problems    | Simpler for repetition
    Memory usage    | Uses call stack (more)     | Uses less memory
    Speed           | Slower (function overhead) | Faster
    Risk            | Stack overflow             | No stack overflow

Infinite Recursion (RecursionError):
--------------------------------------------------------------------------------
    def infinite():
        return infinite()    # No base case!

    # infinite()  # RecursionError: maximum recursion depth exceeded

    import sys
    print(sys.getrecursionlimit())   # Default is usually 1000

Recursion Examples:
--------------------------------------------------------------------------------
    # Sum of numbers from 1 to n
    def sum_numbers(n):
        if n <= 0:
            return 0
        return n + sum_numbers(n - 1)

    print(sum_numbers(5))   # Output: 15

    # Power function
    def power(base, exp):
        if exp == 0:
            return 1
        return base * power(base, exp - 1)

    print(power(2, 4))      # Output: 16

    # Palindrome checker
    def is_palindrome(text):
        text = text.lower().replace(" ", "")
        if len(text) <= 1:
            return True
        if text[0] != text[-1]:
            return False
        return is_palindrome(text[1:-1])

    print(is_palindrome("racecar"))        # Output: True
    print(is_palindrome("hello"))          # Output: False


===============================================================================
20. *ARGS AND **KWARGS
===============================================================================

*args and **kwargs allow functions to accept a variable number of arguments.

Definitions:
--------------------------------------------------------------------------------
    Syntax      | Name          | What it receives           | Type
    ------------|---------------|---------------------------|----------
    *args       | Star args     | Variable positional args  | Tuple
    **kwargs    | Double star   | Variable keyword args     | Dict

*args (Positional Arguments):
--------------------------------------------------------------------------------
    def sum_all(*args):
        total = 0
        for num in args:
            total += num
        return total

    print(sum_all(1, 2, 3, 4))      # Output: 10
    print(sum_all(5, 10, 15))       # Output: 30
    print(sum_all())                # Output: 0

**kwargs (Keyword Arguments):
--------------------------------------------------------------------------------
    def print_info(**kwargs):
        for key, value in kwargs.items():
            print(f"{key}: {value}")

    print_info(name="Alice", age=25, city="New York")
    # Output:
    # name: Alice
    # age: 25
    # city: New York

Combining *args and **kwargs:
--------------------------------------------------------------------------------
    def mixed_arguments(param1, *args, **kwargs):
        print(f"Param1: {param1}")
        print(f"Args: {args}")
        print(f"Kwargs: {kwargs}")

    mixed_arguments(1, 2, 3, name="Bob", age=30)
    # Output:
    # Param1: 1
    # Args: (2, 3)
    # Kwargs: {'name': 'Bob', 'age': 30}

Parameter Order:
--------------------------------------------------------------------------------
    # Correct order
    def func(standard, default=10, *args, **kwargs):
        pass

    # Order: standard -> default -> *args -> **kwargs

Unpacking Arguments:
--------------------------------------------------------------------------------
    # Unpacking list with *
    def add(a, b, c):
        return a + b + c

    numbers = [1, 2, 3]
    result = add(*numbers)      # Unpacks to add(1, 2, 3)
    print(result)               # Output: 6

    # Unpacking dict with **
    person = {"name": "Alice", "age": 25, "city": "Boston"}
    print_info(**person)        # Unpacks to print_info(name="Alice", age=25, city="Boston")


===============================================================================
21. SLASH (/) AND ASTERISK (*) IN FUNCTION SIGNATURES
===============================================================================

The / and * symbols control how arguments can be passed to functions.

Slash (/) - Positional-Only Parameters:
--------------------------------------------------------------------------------
    Parameters before / must be passed as positional arguments (not keyword).

    def func(a, b, /):
        return a + b

    func(1, 2)          # ✓ Valid
    # func(a=1, b=2)    # ✗ TypeError

    def describe(name, /, age, city):
        print(f"{name} is {age} and lives in {city}")

    describe("Alice", 25, "New York")     # ✓ Valid
    describe("Bob", city="London", age=30) # ✓ Valid (age, city can be keyword)
    # describe(name="Charlie", 35, "Paris") # ✗ TypeError (name cannot be keyword)

Asterisk (*) - Keyword-Only Parameters:
--------------------------------------------------------------------------------
    Parameters after * must be passed as keyword arguments.

    def func(a, *, b):
        return a + b

    func(1, b=2)        # ✓ Valid
    # func(1, 2)        # ✗ TypeError

    def create_profile(name, *, age, city):
        print(f"Name: {name}, Age: {age}, City: {city}")

    create_profile("Alice", age=25, city="New York")  # ✓ Valid
    create_profile("Bob", city="London", age=30)      # ✓ Valid
    # create_profile("Charlie", 35, "Paris")          # ✗ TypeError

Combining / and *:
--------------------------------------------------------------------------------
    def func(pos1, pos2, /, standard, *, kw1, kw2):
        print(f"Positional-only: {pos1}, {pos2}")
        print(f"Standard: {standard}")
        print(f"Keyword-only: {kw1}, {kw2}")

    # Valid call
    func(1, 2, 3, kw1=4, kw2=5)

    # Categories:
    # pos1, pos2: positional-only (before /)
    # standard: positional-or-keyword (between / and *)
    # kw1, kw2: keyword-only (after *)

Summary Table:
--------------------------------------------------------------------------------
    Syntax                      | Effect
    ----------------------------|----------------------------------------------
    def func(a, b, /):          | a and b must be positional-only
    def func(a, *, b):          | b must be keyword-only
    def func(a, /, b, *, c):    | a positional-only, b either, c keyword-only


===============================================================================
22. CHAT BOT (PRACTICAL PROJECT)
===============================================================================

A simple rule-based chat bot that responds to user input.

Basic Chat Bot:
--------------------------------------------------------------------------------
    import datetime

    def get_response(user_input):
        responses = {
            "hello": "Hey there!",
            "how are you": "I'm good, thanks!",
            "what time is it": str(datetime.datetime.now().time()),
            "goodbye": "Nice talking to you!"
        }

        message = user_input.lower()
        for key in responses:
            if key in message:
                return responses[key]
        return "I do not understand."

    def chat():
        print("Hello, I am a bot! Type 'exit' to quit.")
        while True:
            user_input = input("You: ")
            if user_input.lower() in ["exit", "quit"]:
                print("Bot: Goodbye!")
                break
            bot_response = get_response(user_input)
            print(f"Bot: {bot_response}")

    if __name__ == "__main__":
        chat()




===============================================================================
QUICK REFERENCE ADDITIONS
===============================================================================

Function Related Quick Reference:
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

Common Built-in Functions:
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



===============================================================================
23. EXCEPTION HANDLING (TRY, EXCEPT, ELSE, FINALLY)
===============================================================================

Exception handling allows your program to respond gracefully to errors that may
arise during execution.

Why Use Exception Handling:
--------------------------------------------------------------------------------
    Reason              | Explanation
    --------------------|------------------------------------------------------
    Error Management    | Prevents program crashes on unexpected input
    User Feedback       | Provides clear error messages to users
    Program Stability   | Allows program to continue running after errors
    Resource Cleanup    | Ensures files/connections are closed properly

Basic Try/Except Structure:
--------------------------------------------------------------------------------
    try:
        # Code that might raise an exception
        risky_operation()
    except ExceptionType:
        # Code that runs if exception occurs
        handle_error()

Catching Specific Exceptions:
--------------------------------------------------------------------------------
    try:
        number = int(input("Enter a number: "))
        result = 100 / number
    except ValueError:
        print("Error: Please enter a valid number!")
    except ZeroDivisionError:
        print("Error: Cannot divide by zero!")

Catching Multiple Exceptions:
--------------------------------------------------------------------------------
    try:
        number = int(input("Enter a number: "))
        result = 100 / number
    except (ValueError, ZeroDivisionError) as e:
        print(f"Error: {e}")

Try-Except-Else:
--------------------------------------------------------------------------------
    The else block runs only if no exception occurred.

    try:
        number = int(input("Enter a number: "))
    except ValueError:
        print("Invalid input!")
    else:
        # This runs only if conversion succeeded
        print(f"You entered: {number}")

Try-Except-Else-Finally:
--------------------------------------------------------------------------------
    The finally block ALWAYS runs, regardless of exceptions.

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

Common Exception Types:
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


===============================================================================
24. THE RAISE KEYWORD
===============================================================================

The raise keyword is used to intentionally trigger an exception.

Why Use raise:
--------------------------------------------------------------------------------
    Reason              | Explanation
    --------------------|------------------------------------------------------
    Input Validation    | Signal when input doesn't meet requirements
    Precondition Check  | Ensure conditions are met before execution
    Error Propagation   | Pass errors up the call stack
    API Design          | Create clear error behavior for functions

Basic Syntax:
--------------------------------------------------------------------------------
    raise ExceptionType("Error message")

Examples:
--------------------------------------------------------------------------------
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

Custom Exceptions:
--------------------------------------------------------------------------------
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

Re-raising Exceptions:
--------------------------------------------------------------------------------
    def process_file(filename):
        try:
            file = open(filename, 'r')
            return file.read()
        except FileNotFoundError as e:
            print(f"Log: File {filename} not found")
            raise  # Re-raise the same exception


===============================================================================
25. TRUTHY AND FALSY VALUES
===============================================================================

Every value in Python has an inherent truth value when evaluated in a boolean
context.

Definitions:
--------------------------------------------------------------------------------
    Term        | Definition
    ------------|----------------------------------------------------------
    Truthy      | Value that evaluates to True in a boolean context
    Falsy       | Value that evaluates to False in a boolean context

Truthy Values (Evaluate to True):
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

Falsy Values (Evaluate to False):
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

Why Use Truthiness:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Cleaner Code        | if data: vs if len(data) > 0:
    More Readable       | Natural language feel
    Type Flexible       | Works with strings, lists, dicts, None, numbers
    Pythonic            | Follows community best practices

Examples:
--------------------------------------------------------------------------------
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


===============================================================================
26. MODULES
===============================================================================

A module is a single file containing Python code that can be imported and used
in other scripts.

Why Use Modules:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Organization        | Groups related code into logical files
    Reusability         | Write once, use across multiple scripts
    Maintainability    | Update code in one place
    Namespace Management| Prevents naming conflicts
    Scalability         | Makes large projects manageable

Creating a Module:
--------------------------------------------------------------------------------
    # Save as greetings.py
    def say_hello(name):
        return f"Hello, {name}!"

    def say_goodbye(name):
        return f"Goodbye, {name}!"

    DEFAULT_GREETING = "Hello"

Importing Modules:
--------------------------------------------------------------------------------
    Method                      | Syntax
    ----------------------------|-----------------------------------------------
    Import entire module        | import greetings
    Import specific function    | from greetings import say_hello
    Import with alias           | import greetings as gr
    Import all (not recommended)| from greetings import *
    Import multiple items       | from greetings import say_hello, say_goodbye

Example:
--------------------------------------------------------------------------------
    # main.py
    import greetings

    name = input("Enter your name: ")
    print(greetings.say_hello(name))

The if __name__ == "__main__" Guard:
--------------------------------------------------------------------------------
    # This code only runs when the file is executed directly
    # Not when imported as a module
    if __name__ == "__main__":
        print("This runs only when script is executed directly")
        main()

Benefits of the Guard:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Prevents Unintended Execution | Code doesn't run on import
    Enables Testing     | Test code can be included in module
    Dual Purpose        | Same file can be library AND script
    Clean Imports       | No side effects when importing


===============================================================================
27. PACKAGES
===============================================================================

A package is a directory containing multiple modules and an __init__.py file.

Package Structure:
--------------------------------------------------------------------------------
    my_package/
        __init__.py
        module1.py
        module2.py
        subpackage/
            __init__.py
            submodule.py

The __init__.py File:
--------------------------------------------------------------------------------
    # Can be empty or contain initialization code
    # Marks directory as a Python package

    # __init__.py example
    __version__ = "1.0.0"
    __author__ = "Python Developer"

    from .module1 import important_function
    from .module2 import another_function

    __all__ = ['important_function', 'another_function']

Importing from Packages:
--------------------------------------------------------------------------------
    # Import entire module from package
    from my_package import module1

    # Import specific function
    from my_package.module1 import important_function

    # Import subpackage
    from my_package.subpackage import submodule

    # Import using package alias
    import my_package as mp


===============================================================================
28. LIBRARIES VS. PACKAGES VS. MODULES
===============================================================================

Understanding the hierarchy of code organization in Python.

Definitions:
--------------------------------------------------------------------------------
    Term        | Definition                          | Example
    ------------|-------------------------------------|-------------------
    Module      | Single .py file                    | math.py
    Package     | Directory with __init__.py          | urllib/
    Library     | Collection of packages/modules      | requests, pandas

Relationship Hierarchy:
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

Key Takeaways:
--------------------------------------------------------------------------------
    Takeaway                            | Explanation
    ------------------------------------|----------------------------------------
    Libraries are broader than packages | A library can contain multiple packages
    A package organizes modules         | Packages contain __init__.py
    Modules are single files            | Smallest unit of code organization
    Terminology is often loose          | "Library" used generically in conversation


===============================================================================
QUICK REFERENCE ADDITIONS
===============================================================================

Exception Handling Quick Reference:
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

Truthiness Quick Reference:
--------------------------------------------------------------------------------
    Truthy values:          | if "text":, if 1:, if [1,2]:, if {"a":1}:
    Falsy values:           | if not None:, if not 0:, if not "":, if not []:
    Check truthiness        | bool(value)
    Default value pattern   | value = user_input or "default"
    Filter falsy values     | clean = [x for x in data if x]

Module/Package Quick Reference:
--------------------------------------------------------------------------------
    Concept                 | Syntax
    ------------------------|------------------------------------------
    Import module           | import module_name
    Import function         | from module import function
    Import with alias       | import module as alias
    Module guard            | if __name__ == "__main__":
    Create package          | directory + __init__.py
    Import from package     | from package import module
===============================================================================
 THE RAISE KEYWORD
===============================================================================

The raise keyword is used to intentionally trigger an exception.

Why Use raise:
--------------------------------------------------------------------------------
    Reason              | Explanation
    --------------------|------------------------------------------------------
    Input Validation    | Signal when input doesn't meet requirements
    Precondition Check  | Ensure conditions are met before execution
    Error Propagation   | Pass errors up the call stack
    API Design          | Create clear error behavior for functions

Basic Syntax:
--------------------------------------------------------------------------------
    raise ExceptionType("Error message")

Examples:
--------------------------------------------------------------------------------
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

Custom Exceptions:
--------------------------------------------------------------------------------
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

Re-raising Exceptions:
--------------------------------------------------------------------------------
    def process_file(filename):
        try:
            file = open(filename, 'r')
            return file.read()
        except FileNotFoundError as e:
            print(f"Log: File {filename} not found")
            raise  # Re-raise the same exception


===============================================================================
 TRUTHY AND FALSY VALUES
===============================================================================

Every value in Python has an inherent truth value when evaluated in a boolean
context.

Definitions:
--------------------------------------------------------------------------------
    Term        | Definition
    ------------|----------------------------------------------------------
    Truthy      | Value that evaluates to True in a boolean context
    Falsy       | Value that evaluates to False in a boolean context

Truthy Values (Evaluate to True):
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

Falsy Values (Evaluate to False):
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

Why Use Truthiness:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Cleaner Code        | if data: vs if len(data) > 0:
    More Readable       | Natural language feel
    Type Flexible       | Works with strings, lists, dicts, None, numbers
    Pythonic            | Follows community best practices

Examples:
--------------------------------------------------------------------------------
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


===============================================================================
MODULES
===============================================================================

A module is a single file containing Python code that can be imported and used
in other scripts.

Why Use Modules:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Organization        | Groups related code into logical files
    Reusability         | Write once, use across multiple scripts
    Maintainability    | Update code in one place
    Namespace Management| Prevents naming conflicts
    Scalability         | Makes large projects manageable

Creating a Module:
--------------------------------------------------------------------------------
    # Save as greetings.py
    def say_hello(name):
        return f"Hello, {name}!"

    def say_goodbye(name):
        return f"Goodbye, {name}!"

    DEFAULT_GREETING = "Hello"

Importing Modules:
--------------------------------------------------------------------------------
    Method                      | Syntax
    ----------------------------|-----------------------------------------------
    Import entire module        | import greetings
    Import specific function    | from greetings import say_hello
    Import with alias           | import greetings as gr
    Import all (not recommended)| from greetings import *
    Import multiple items       | from greetings import say_hello, say_goodbye

Example:
--------------------------------------------------------------------------------
    # main.py
    import greetings

    name = input("Enter your name: ")
    print(greetings.say_hello(name))

The if __name__ == "__main__" Guard:
--------------------------------------------------------------------------------
    # This code only runs when the file is executed directly
    # Not when imported as a module
    if __name__ == "__main__":
        print("This runs only when script is executed directly")
        main()

Benefits of the Guard:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Prevents Unintended Execution | Code doesn't run on import
    Enables Testing     | Test code can be included in module
    Dual Purpose        | Same file can be library AND script
    Clean Imports       | No side effects when importing


===============================================================================
PACKAGES
===============================================================================

A package is a directory containing multiple modules and an __init__.py file.

Package Structure:
--------------------------------------------------------------------------------
    my_package/
        __init__.py
        module1.py
        module2.py
        subpackage/
            __init__.py
            submodule.py

The __init__.py File:
--------------------------------------------------------------------------------
    # Can be empty or contain initialization code
    # Marks directory as a Python package

    # __init__.py example
    __version__ = "1.0.0"
    __author__ = "Python Developer"

    from .module1 import important_function
    from .module2 import another_function

    __all__ = ['important_function', 'another_function']

Importing from Packages:
--------------------------------------------------------------------------------
    # Import entire module from package
    from my_package import module1

    # Import specific function
    from my_package.module1 import important_function

    # Import subpackage
    from my_package.subpackage import submodule

    # Import using package alias
    import my_package as mp


===============================================================================
LIBRARIES VS. PACKAGES VS. MODULES
===============================================================================

Understanding the hierarchy of code organization in Python.

Definitions:
--------------------------------------------------------------------------------
    Term        | Definition                          | Example
    ------------|-------------------------------------|-------------------
    Module      | Single .py file                    | math.py
    Package     | Directory with __init__.py          | urllib/
    Library     | Collection of packages/modules      | requests, pandas

Relationship Hierarchy:
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

Key Takeaways:
--------------------------------------------------------------------------------
    Takeaway                            | Explanation
    ------------------------------------|----------------------------------------
    Libraries are broader than packages | A library can contain multiple packages
    A package organizes modules         | Packages contain __init__.py
    Modules are single files            | Smallest unit of code organization
    Terminology is often loose          | "Library" used generically in conversation

cat << 'EOF'


===============================================================================
QUICK REFERENCE: COMPARING FLOATS
===============================================================================

Never use == for float comparison due to precision issues

Recommended approach with tolerance:
--------------------------------------------------------------------------------
    def floats_equal(a, b, tolerance=1e-9):
        return abs(a - b) < tolerance

    # Or use math.isclose()
    import math
    math.isclose(0.1 + 0.2, 0.3)  # True

For precise financial calculations, use decimal.Decimal


===============================================================================
QUICK REFERENCE: SCOPES (LEGB RULE)
===============================================================================

LEGB rule (order of lookup):
--------------------------------------------------------------------------------
    L - Local (inside current function)
    E - Enclosing (outer functions)
    G - Global (module level)
    B - Built-in (Python built-ins)

Global variables: defined outside any function
Local variables: defined inside function

Access global variable in function:
--------------------------------------------------------------------------------
    global_var = 10

    def my_func():
        global global_var
        global_var = 20  # modifies global


===============================================================================
QUICK REFERENCE: GLOBAL KEYWORD
===============================================================================

Allows modification of global variables inside functions

Example:
--------------------------------------------------------------------------------
    counter = 0

    def increment():
        global counter
        counter += 1

Without 'global', Python creates a local variable


===============================================================================
QUICK REFERENCE: NONLOCAL KEYWORD
===============================================================================

Modify variables in enclosing (non-global) scope

Example:
--------------------------------------------------------------------------------
    def outer():
        x = 10
        def inner():
            nonlocal x
            x = 20  # modifies outer's x
        inner()
        print(x)  # 20

Use cases: closures, nested functions maintaining state


===============================================================================
QUICK REFERENCE: LIST COMPREHENSIONS
===============================================================================

Concise way to create lists

Syntax:
--------------------------------------------------------------------------------
    [expression for item in iterable if condition]

Examples:
--------------------------------------------------------------------------------
    squares = [x**2 for x in range(10)]
    evens = [x for x in range(20) if x % 2 == 0]
    matrix = [[j for j in range(5)] for i in range(3)]

Benefits:
    - More concise than traditional loops
    - Generally faster
    - More readable for simple transformations


===============================================================================
QUICK REFERENCE: SLICING
===============================================================================

Extract subsequences from sequences

Syntax: [start:stop:step]

Examples with list:
--------------------------------------------------------------------------------
    numbers = [1, 2, 3, 4, 5, 6, 7, 8]
    numbers[0:3]    # [1, 2, 3]
    numbers[3:]     # [4, 5, 6, 7, 8]
    numbers[:]      # copy of entire list
    numbers[::2]    # [1, 3, 5, 7] (every other)
    numbers[::-1]   # reversed list

Works on strings, tuples, and any sequence


===============================================================================
QUICK REFERENCE: MODIFYING LISTS DURING ITERATION
===============================================================================

Never modify a list while iterating over it

Problem:
--------------------------------------------------------------------------------
    for item in my_list:
        if condition:
            my_list.remove(item)  # SKIPS elements!

Solutions:
--------------------------------------------------------------------------------
    # Create new list
    new_list = [item for item in my_list if condition]

    # Iterate over copy
    for item in my_list[:]:
        if condition:
            my_list.remove(item)

    # Iterate backwards
    for i in range(len(my_list)-1, -1, -1):
        if condition:
            my_list.pop(i)


===============================================================================
QUICK REFERENCE: CLASSES & OBJECTS
===============================================================================

Class: blueprint for creating objects
Object: instance of a class

Example:
--------------------------------------------------------------------------------
    class Car:
        # Class attribute (shared by all instances)
        wheels = 4
        
        # Constructor
        def __init__(self, brand, color):
            # Instance attributes (unique per instance)
            self.brand = brand
            self.color = color
        
        # Method
        def drive(self):
            return f"{self.brand} is driving"

    # Creating objects
    my_car = Car("Toyota", "Red")
    print(my_car.drive())  # "Toyota is driving"


===============================================================================
QUICK REFERENCE: __INIT__ METHOD
===============================================================================

Constructor - initializes new objects
Called automatically when creating instance

Example:
--------------------------------------------------------------------------------
    class Person:
        def __init__(self, name, age):
            self.name = name
            self.age = age

    p = Person("Alice", 25)  # __init__ called automatically

Best practices:
    - Keep it simple
    - Validate input parameters
    - Set default values for optional parameters


===============================================================================
QUICK REFERENCE: SELF PARAMETER
===============================================================================

Reference to current instance
    - First parameter of instance methods
    - Allows access to instance attributes and methods
    - Automatically passed by Python

Example:
--------------------------------------------------------------------------------
    class MyClass:
        def __init__(self, value):
            self.value = value  # self refers to current instance
        
        def display(self):
            print(self.value)  # access instance attribute


===============================================================================
QUICK REFERENCE: CLASS VS INSTANCE ATTRIBUTES
===============================================================================

Class attributes: shared by all instances
Instance attributes: unique per instance

Example:
--------------------------------------------------------------------------------
    class Employee:
        company = "Tech Corp"  # class attribute
        
        def __init__(self, name):
            self.name = name   # instance attribute

    e1 = Employee("Alice")
    e2 = Employee("Bob")
    print(e1.company)  # "Tech Corp" (same for both)
    print(e2.company)  # "Tech Corp"

Modifying class attribute affects all instances
Modifying instance attribute only affects that instance


===============================================================================
QUICK REFERENCE: DUNDER METHODS (MAGIC METHODS)
===============================================================================

Special methods with double underscores

Common dunder methods:
--------------------------------------------------------------------------------
    __init__   - constructor
    __str__    - string representation (user-friendly)
    __repr__   - string representation (developer-friendly)
    __eq__     - equality (==)
    __lt__     - less than (<)
    __len__    - length (len())
    __getitem__ - indexing (obj[key])
    __call__   - object as function

Example:
--------------------------------------------------------------------------------
    class Point:
        def __init__(self, x, y):
            self.x = x
            self.y = y
        
        def __str__(self):
            return f"Point({self.x}, {self.y})"
        
        def __eq__(self, other):
            return self.x == other.x and self.y == other.y


===============================================================================
QUICK REFERENCE: __STR__ VS __REPR__
===============================================================================

__str__: user-friendly, readable (for print(), str())
__repr__: unambiguous, detailed (for debugging, repr())

Example:
--------------------------------------------------------------------------------
    class Book:
        def __init__(self, title, author):
            self.title = title
            self.author = author
        
        def __str__(self):
            return f"{self.title} by {self.author}"
        
        def __repr__(self):
            return f"Book('{self.title}', '{self.author}')"

    book = Book("1984", "Orwell")
    print(str(book))   # "1984 by Orwell"
    print(repr(book))  # "Book('1984', 'Orwell')"


===============================================================================
QUICK REFERENCE: __EQ__ METHOD
===============================================================================

Define custom equality comparison

Example:
--------------------------------------------------------------------------------
    class Person:
        def __init__(self, id, name):
            self.id = id
            self.name = name
        
        def __eq__(self, other):
            if isinstance(other, Person):
                return self.id == other.id
            return NotImplemented

    p1 = Person(1, "Alice")
    p2 = Person(1, "Bob")
    p1 == p2  # True (same id)

Benefits: meaningful comparisons, set operations, dictionary keys


===============================================================================
QUICK REFERENCE: METHODS VS FUNCTIONS
===============================================================================

Functions: standalone, defined with def, called by name
Methods: belong to objects/classes, called on instances

Example:
--------------------------------------------------------------------------------
    # Function
    def calculate(x):
        return x * 2

    # Method
    class Calculator:
        def calculate(self, x):
            return x * 2

Key differences:
    - Methods have access to instance data via self
    - Methods are called on instances: obj.method()
    - Functions are independent: function()


===============================================================================
QUICK REFERENCE: INHERITANCE
===============================================================================

Subclass inherits attributes/methods from superclass

Example:
--------------------------------------------------------------------------------
    class Animal:  # Base class
        def __init__(self, name):
            self.name = name
        
        def speak(self):
            return "Some sound"

    class Dog(Animal):  # Derived class
        def speak(self):  # Override method
            return "Woof!"

    class Cat(Animal):
        def speak(self):
            return "Meow!"

    dog = Dog("Rex")
    print(dog.name)   # "Rex" (inherited)
    print(dog.speak()) # "Woof!" (overridden)

Benefits: code reuse, extensibility, logical hierarchy


===============================================================================
QUICK REFERENCE: SUPER() FUNCTION
===============================================================================

Call parent class methods

Example:
--------------------------------------------------------------------------------
    class Parent:
        def __init__(self, name):
            self.name = name
        
        def greet(self):
            return f"Hello from {self.name}"

    class Child(Parent):
        def __init__(self, name, age):
            super().__init__(name)  # call parent constructor
            self.age = age
        
        def greet(self):
            parent_greet = super().greet()  # call parent method
            return f"{parent_greet} and I'm {self.age}"

Benefits: avoids hardcoding parent class name, supports multiple inheritance


===============================================================================
QUICK REFERENCE: @STATICMETHOD
===============================================================================

Method that doesn't need instance or class access

Example:
--------------------------------------------------------------------------------
    class MathUtils:
        @staticmethod
        def add(x, y):
            return x + y
        
        @staticmethod
        def is_even(num):
            return num % 2 == 0

    # Called on class (no instance needed)
    result = MathUtils.add(5, 3)

Use for utility functions related to class


===============================================================================
QUICK REFERENCE: @CLASSMETHOD
===============================================================================

Method that receives class as first parameter (cls)

Example:
--------------------------------------------------------------------------------
    class Counter:
        count = 0
        
        @classmethod
        def increment(cls):
            cls.count += 1
            return cls.count
        
        @classmethod
        def create_default(cls):
            return cls()  # factory method

Common uses: factory methods, class-level operations


===============================================================================
QUICK REFERENCE: @ABSTRACTMETHOD
===============================================================================

Define methods that subclasses must implement

Example:
--------------------------------------------------------------------------------
    from abc import ABC, abstractmethod

    class Shape(ABC):
        @abstractmethod
        def area(self):
            pass  # No implementation
        
        @abstractmethod
        def perimeter(self):
            pass

    class Rectangle(Shape):
        def __init__(self, width, height):
            self.width = width
            self.height = height
        
        def area(self):
            return self.width * self.height
        
        def perimeter(self):
            return 2 * (self.width + self.height)

    # Cannot instantiate Shape - must use concrete subclass


===============================================================================
QUICK REFERENCE: NAME MANGLING
===============================================================================

Prefix with __ to make attribute "private"

Example:
--------------------------------------------------------------------------------
    class MyClass:
        def __init__(self):
            self.__private = 10  # name mangled to _MyClass__private
        
        def __private_method(self):  # mangled to _MyClass__private_method
            pass

    obj = MyClass()
    # obj.__private  # AttributeError
    print(obj._MyClass__private)  # Accessible but not recommended

Purpose: prevent accidental access, avoid name conflicts in inheritance


===============================================================================
QUICK REFERENCE: PRINT() FUNCTION
===============================================================================

Output to console

Examples:
--------------------------------------------------------------------------------
    print("Hello")                    # basic
    print("Hello", "World")           # multiple arguments (space separator)
    print("Hello", "World", sep="-")  # custom separator
    print("Hello", end="")            # no newline
    print(f"Value: {x}")              # f-string formatting
    print("Value: {}".format(x))      # format method


===============================================================================
QUICK REFERENCE: ENUMERATE()
===============================================================================

Get index and value while iterating

Example:
--------------------------------------------------------------------------------
    fruits = ["apple", "banana", "cherry"]

    for index, fruit in enumerate(fruits):
        print(f"{index}: {fruit}")

    for index, fruit in enumerate(fruits, start=1):
        print(f"{index}: {fruit}")  # start from 1


===============================================================================
QUICK REFERENCE: ROUND()
===============================================================================

Round floating-point numbers

Examples:
--------------------------------------------------------------------------------
    round(3.14159, 2)    # 3.14
    round(3.14159)       # 3 (nearest integer)
    round(123.456, -1)   # 120.0 (nearest ten)

Parameters:
    round(number) - to nearest integer
    round(number, ndigits) - to ndigits decimal places
    round(number, -n) - to nearest 10^n


===============================================================================
QUICK REFERENCE: RANGE()
===============================================================================

Generate sequence of numbers

Syntax:
--------------------------------------------------------------------------------
    range(stop)           # 0 to stop-1
    range(start, stop)    # start to stop-1
    range(start, stop, step)  # with step

Examples:
--------------------------------------------------------------------------------
    list(range(5))        # [0, 1, 2, 3, 4]
    list(range(2, 8))     # [2, 3, 4, 5, 6, 7]
    list(range(0, 10, 2)) # [0, 2, 4, 6, 8]
    list(range(5, 0, -1)) # [5, 4, 3, 2, 1]

Memory efficient - doesn't store all values


===============================================================================
QUICK REFERENCE: SLICE() FUNCTION
===============================================================================

Create reusable slice objects

Example:
--------------------------------------------------------------------------------
    numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    first_three = slice(0, 3)
    print(numbers[first_three])  # [0, 1, 2]

    every_other = slice(None, None, 2)
    print(numbers[every_other])  # [0, 2, 4, 6, 8]

    reverse = slice(None, None, -1)
    print(numbers[reverse])  # [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]


===============================================================================
QUICK REFERENCE: GLOBALS() FUNCTION
===============================================================================

Return dictionary of global symbol table

Example:
--------------------------------------------------------------------------------
    x = 10
    y = "hello"

    def my_func():
        pass

    global_vars = globals()
    print(global_vars.keys())  # includes x, y, my_func

Useful for debugging and introspection


===============================================================================
QUICK REFERENCE: ALL() FUNCTION
===============================================================================

Check if all elements in iterable are truthy

Examples:
--------------------------------------------------------------------------------
    all([True, True, True])   # True
    all([True, False, True])  # False
    all([])                   # True (vacuously true)

Example usage:
--------------------------------------------------------------------------------
    numbers = [2, 4, 6, 8]
    all_even = all(n % 2 == 0 for n in numbers)  # True


===============================================================================
QUICK REFERENCE: ANY() FUNCTION
===============================================================================

Check if any element in iterable is truthy

Examples:
--------------------------------------------------------------------------------
    any([False, False, True])   # True
    any([False, False, False])  # False
    any([])                     # False

Example usage:
--------------------------------------------------------------------------------
    has_positive = any(n > 0 for n in [-1, -2, 3])  # True


===============================================================================
QUICK REFERENCE: ISINSTANCE()
===============================================================================

Check if object is instance of class (or subclass)

Examples:
--------------------------------------------------------------------------------
    isinstance(5, int)           # True
    isinstance("hello", str)     # True
    isinstance(3.14, (int, float))  # True (checks multiple types)

    class Animal: pass
    class Dog(Animal): pass

    dog = Dog()
    isinstance(dog, Dog)     # True
    isinstance(dog, Animal)  # True (subclass)

Better than type() because it handles inheritance


===============================================================================
QUICK REFERENCE: CALLABLE()
===============================================================================

Check if object can be called (function or with __call__)

Examples:
--------------------------------------------------------------------------------
    def my_func():
        pass

    class MyClass:
        def __call__(self):
            pass

    callable(my_func)     # True
    callable(MyClass())   # True (has __call__)
    callable(5)           # False

Useful before attempting to call an object


===============================================================================
QUICK REFERENCE: FILTER() FUNCTION
===============================================================================

Filter iterable using function

Examples:
--------------------------------------------------------------------------------
    def is_even(n):
        return n % 2 == 0

    numbers = [1, 2, 3, 4, 5, 6]
    evens = filter(is_even, numbers)
    print(list(evens))  # [2, 4, 6]

    # With lambda
    odds = filter(lambda x: x % 2 == 1, numbers)
    print(list(odds))  # [1, 3, 5]

    # Remove falsy values
    filtered = filter(None, [0, 1, False, 2, "", 3])
    print(list(filtered))  # [1, 2, 3]


===============================================================================
QUICK REFERENCE: MAP() FUNCTION
===============================================================================

Apply function to every item in iterable

Examples:
--------------------------------------------------------------------------------
    def double(x):
        return x * 2

    numbers = [1, 2, 3, 4]
    doubled = map(double, numbers)
    print(list(doubled))  # [2, 4, 6, 8]

    # With lambda
    squared = map(lambda x: x ** 2, numbers)
    print(list(squared))  # [1, 4, 9, 16]

    # Multiple iterables
    a = [1, 2, 3]
    b = [4, 5, 6]
    sums = map(lambda x, y: x + y, a, b)
    print(list(sums))  # [5, 7, 9]


===============================================================================
QUICK REFERENCE: SORTED() FUNCTION
===============================================================================

Return new sorted list from iterable

Examples:
--------------------------------------------------------------------------------
    numbers = [3, 1, 4, 1, 5, 9]
    sorted_numbers = sorted(numbers)  # [1, 1, 3, 4, 5, 9]

    # Descending
    sorted_desc = sorted(numbers, reverse=True)  # [9, 5, 4, 3, 1, 1]

    # With key function
    words = ["apple", "banana", "cherry", "date"]
    sorted_by_len = sorted(words, key=len)  # ["date", "apple", "banana", "cherry"]

    # Sort by custom criteria
    students = [("Alice", 25), ("Bob", 20), ("Charlie", 23)]
    sorted_by_age = sorted(students, key=lambda x: x[1])

Original iterable unchanged


===============================================================================
QUICK REFERENCE: EVAL() FUNCTION
===============================================================================

Evaluate string as Python expression

Examples:
--------------------------------------------------------------------------------
    result = eval("3 + 5 * 2")  # 13
    x = 10
    result = eval("x * 2")      # 20

WARNING: eval() can execute arbitrary code - security risk!
Never use with untrusted input


===============================================================================
QUICK REFERENCE: EXEC() FUNCTION
===============================================================================

Execute Python code from string

Example:
--------------------------------------------------------------------------------
    code = """
    def greet(name):
        return f"Hello, {name}!"

    result = greet("Alice")
    """
    exec(code)  # defines function and executes code

    # Can access results
    print(result)  # "Hello, Alice!"

WARNING: Same security concerns as eval()


===============================================================================
QUICK REFERENCE: ZIP() FUNCTION
===============================================================================

Combine iterables element-wise

Examples:
--------------------------------------------------------------------------------
    names = ["Alice", "Bob", "Charlie"]
    ages = [25, 30, 35]
    cities = ["NYC", "LA", "Chicago"]

    zipped = zip(names, ages)
    print(list(zipped))  # [('Alice', 25), ('Bob', 30), ('Charlie', 35)]

    # With three iterables
    combined = zip(names, ages, cities)
    for name, age, city in combined:
        print(f"{name} is {age} in {city}")

    # Unzipping
    pairs = [('Alice', 25), ('Bob', 30)]
    names, ages = zip(*pairs)

Stops at shortest iterable


===============================================================================
QUICK REFERENCE: DOCSTRINGS
===============================================================================

Documentation strings for modules, classes, functions

Example:
--------------------------------------------------------------------------------
    def calculate_area(radius):
        """
        Calculate the area of a circle.
        
        Args:
            radius (float): The radius of the circle
            
        Returns:
            float: The area of the circle
            
        Example:
            >>> calculate_area(5)
            78.53981633974483
        """
        import math
        return math.pi * radius ** 2

Access with help(calculate_area) or calculate_area.__doc__


===============================================================================
QUICK REFERENCE: F-STRINGS (FORMATTED STRING LITERALS)
===============================================================================

String formatting with embedded expressions

Examples:
--------------------------------------------------------------------------------
    name = "Alice"
    age = 25
    print(f"Hello, {name}! You are {age} years old.")

    # Expressions
    print(f"Sum: {5 + 3}")

    # Formatting numbers
    price = 19.99
    print(f"Price: ${price:.2f}")  # $19.99

    big_num = 1234567
    print(f"{big_num:,}")  # 1,234,567

    # Debugging (Python 3.8+)
    x = 10
    print(f"{x=}")  # x=10

    # Multiline
    message = f"""
    Name: {name}
    Age: {age}
    """


===============================================================================
QUICK REFERENCE: ASSERTIONS
===============================================================================

Debugging tool - check conditions

Example:
--------------------------------------------------------------------------------
    def divide(a, b):
        assert b != 0, "Cannot divide by zero"
        return a / b

    # Assertions can be disabled with -O flag
    # Use for debugging, not production error handling

    assert condition, "error message"

Raises AssertionError if condition is False


===============================================================================
QUICK REFERENCE: UNPACKING
===============================================================================

Assign iterable elements to variables

Examples:
--------------------------------------------------------------------------------
    # Tuple unpacking
    point = (10, 20)
    x, y = point

    # List unpacking
    values = [1, 2, 3]
    a, b, c = values

    # Ignore values with _
    a, _, c = [1, 2, 3]  # a=1, c=3

    # Extended unpacking (*)
    first, *rest = [1, 2, 3, 4]  # first=1, rest=[2,3,4]
    *begin, last = [1, 2, 3, 4]  # begin=[1,2,3], last=4

    # Swapping variables
    a, b = b, a

    # Function arguments
    def func(a, b, c):
        pass

    args = (1, 2, 3)
    func(*args)  # unpack tuple as arguments

    kwargs = {"a": 1, "b": 2, "c": 3}
    func(**kwargs)  # unpack dict as keyword arguments


===============================================================================
QUICK REFERENCE: == VS IS
===============================================================================

==  : equality operator (compares values)
is  : identity operator (compares memory addresses)

Example:
--------------------------------------------------------------------------------
    a = [1, 2, 3]
    b = [1, 2, 3]
    c = a

    print(a == b)  # True (same values)
    print(a is b)  # False (different objects)
    print(a is c)  # True (same object)

    # Use 'is' for None, True, False
    if value is None:
        pass

    # Use '==' for value comparison
    if value == 0:
        pass


===============================================================================
QUICK REFERENCE: @DATACLASS
===============================================================================

Automatically generate __init__, __repr__, __eq__

Example:
--------------------------------------------------------------------------------
    from dataclasses import dataclass

    @dataclass
    class Person:
        name: str
        age: int
        email: str = ""  # default value

    # Generated methods:
    p1 = Person("Alice", 25)
    p2 = Person("Alice", 25)
    print(p1)           # Person(name='Alice', age=25, email='')
    print(p1 == p2)     # True

    # Frozen (immutable)
    @dataclass(frozen=True)
    class Point:
        x: int
        y: int


===============================================================================
QUICK REFERENCE: FIELDS IN DATACLASS
===============================================================================

Customize field behavior

Example:
--------------------------------------------------------------------------------
    from dataclasses import dataclass, field
    from typing import List

    @dataclass
    class ShoppingList:
        items: List[str] = field(default_factory=list)  # mutable default
        name: str = field(default="Groceries")
        id: int = field(init=False)  # not in __init__
        
        def __post_init__(self):
            self.id = hash(self.name)  # computed field


===============================================================================
QUICK REFERENCE: __POST_INIT__
===============================================================================

Post-initialization processing

Example:
--------------------------------------------------------------------------------
    @dataclass
    class Rectangle:
        width: float
        height: float
        area: float = field(init=False)
        
        def __post_init__(self):
            self.area = self.width * self.height
            assert self.width > 0 and self.height > 0, "Dimensions must be positive"

Runs automatically after __init__


===============================================================================
QUICK REFERENCE: INITVAR
===============================================================================

Init-only variables (not stored as attribute)

Example:
--------------------------------------------------------------------------------
    from dataclasses import dataclass, InitVar

    @dataclass
    class Product:
        name: str
        price: float
        tax_rate: InitVar[float]  # passed to __init__ but not stored
        
        def __post_init__(self, tax_rate):
            self.price_with_tax = self.price * (1 + tax_rate)

    p = Product("Book", 20.00, 0.08)
    print(p.price_with_tax)  # 21.6
    # p.tax_rate would raise AttributeError


===============================================================================
QUICK REFERENCE: @PROPERTY
===============================================================================

Create getters/setters with attribute syntax

Example:
--------------------------------------------------------------------------------
    class Circle:
        def __init__(self, radius):
            self._radius = radius
        
        @property
        def radius(self):
            return self._radius
        
        @radius.setter
        def radius(self, value):
            if value < 0:
                raise ValueError("Radius cannot be negative")
            self._radius = value
        
        @property
        def area(self):  # computed property (read-only)
            return 3.14159 * self._radius ** 2

    c = Circle(5)
    print(c.radius)  # 5 (getter)
    c.radius = 10    # setter
    print(c.area)    # 314.159 (computed)


===============================================================================
QUICK REFERENCE: ASYNC/AWAIT (AsyncIO)
===============================================================================

Asynchronous programming for I/O-bound tasks

Example:
--------------------------------------------------------------------------------
    import asyncio

    async def fetch_data():
        await asyncio.sleep(2)  # Simulate I/O
        return {"data": "Hello"}

    async def main():
        result = await fetch_data()
        print(result)

    asyncio.run(main())


===============================================================================
QUICK REFERENCE: TASKS (AsyncIO)
===============================================================================

Run coroutines concurrently

Example:
--------------------------------------------------------------------------------
    import asyncio

    async def task(name, delay):
        await asyncio.sleep(delay)
        return f"{name} finished"

    async def main():
        # Create tasks
        task1 = asyncio.create_task(task("Task1", 2))
        task2 = asyncio.create_task(task("Task2", 1))
        
        # Wait for completion
        result1 = await task1
        result2 = await task2
        print(result1, result2)

    asyncio.run(main())


===============================================================================
QUICK REFERENCE: GATHER() (AsyncIO)
===============================================================================

Run multiple coroutines concurrently

Example:
--------------------------------------------------------------------------------
    import asyncio

    async def fetch_data(id, delay):
        await asyncio.sleep(delay)
        return f"Data {id}"

    async def main():
        results = await asyncio.gather(
            fetch_data(1, 2),
            fetch_data(2, 1),
            fetch_data(3, 3)
        )
        print(results)  # ['Data 1', 'Data 2', 'Data 3']

    asyncio.run(main())


===============================================================================
QUICK REFERENCE: MYPY (Static Type Checker)
===============================================================================

Check type annotations

Install: pip install mypy
Run: mypy script.py

Example with type hints:
--------------------------------------------------------------------------------
    def greet(name: str) -> str:
        return f"Hello, {name}"

    greet(42)  # mypy will report error


===============================================================================
QUICK REFERENCE: WALRUS OPERATOR (:=)
===============================================================================

Assign and use in same expression (Python 3.8+)

Examples:
--------------------------------------------------------------------------------
    # Without walrus
    n = len(data)
    if n > 10:
        print(f"Length: {n}")

    # With walrus
    if (n := len(data)) > 10:
        print(f"Length: {n}")

    # In list comprehension
    results = [y for x in data if (y := process(x)) is not None]


===============================================================================
QUICK REFERENCE: LAMBDA FUNCTIONS
===============================================================================

Anonymous functions (single expression)

Examples:
--------------------------------------------------------------------------------
    # Basic lambda
    square = lambda x: x ** 2
    print(square(5))  # 25

    # With filter
    evens = list(filter(lambda x: x % 2 == 0, [1, 2, 3, 4]))

    # With map
    doubled = list(map(lambda x: x * 2, [1, 2, 3]))

    # Sorting with key
    sorted(data, key=lambda x: x["age"])


===============================================================================
QUICK REFERENCE: GENERATORS
===============================================================================

Yield values lazily (memory efficient)

Example:
--------------------------------------------------------------------------------
    def count_up_to(n):
        i = 0
        while i < n:
            yield i
            i += 1

    for num in count_up_to(5):
        print(num)  # 0,1,2,3,4

    # Generator expression
    squares = (x**2 for x in range(1000000))  # lazy

    # vs list comprehension (eager)
    squares_list = [x**2 for x in range(1000000)]  # memory heavy


===============================================================================
QUICK REFERENCE: MATCH-CASE (Pattern Matching - Python 3.10+)
===============================================================================

Syntax:
--------------------------------------------------------------------------------
    match value:
        case pattern1:
            # action
        case pattern2:
            # action
        case _:  # default
            # action

Example:
--------------------------------------------------------------------------------
    def http_status(code):
        match code:
            case 200:
                return "OK"
            case 404:
                return "Not Found"
            case 403:
                return "Forbidden"
            case _:
                return "Unknown"


===============================================================================
QUICK REFERENCE: DECORATORS
===============================================================================

Modify function behavior

Example:
--------------------------------------------------------------------------------
    from functools import wraps

    def timer(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            import time
            start = time.time()
            result = func(*args, **kwargs)
            print(f"{func.__name__} took {time.time() - start:.2f}s")
            return result
        return wrapper

    @timer
    def slow_function():
        import time
        time.sleep(1)

    # Decorator with arguments
    def repeat(times):
        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                for _ in range(times):
                    result = func(*args, **kwargs)
                return result
            return wrapper
        return decorator

    @repeat(3)
    def greet(name):
        print(f"Hello, {name}")


===============================================================================
QUICK REFERENCE: ENUMS
===============================================================================

Named constant values

Example:
--------------------------------------------------------------------------------
    from enum import Enum, auto

    class Color(Enum):
        RED = 1
        GREEN = 2
        BLUE = 3

    class Status(Enum):
        PENDING = auto()  # auto-assigns values
        APPROVED = auto()
        REJECTED = auto()

    # Usage
    color = Color.RED
    print(color.name)   # "RED"
    print(color.value)  # 1

    # Comparison
    if color == Color.RED:
        print("It's red")

    # Iteration
    for status in Status:
        print(status)


===============================================================================
QUICK REFERENCE: MEMOIZATION (functools.lru_cache)
===============================================================================

Cache function results

Example:
--------------------------------------------------------------------------------
    from functools import lru_cache

    @lru_cache(maxsize=128)
    def fibonacci(n):
        if n < 2:
            return n
        return fibonacci(n-1) + fibonacci(n-2)

    # Check cache stats
    print(fibonacci.cache_info())

    # Clear cache
    fibonacci.cache_clear()


===============================================================================
QUICK REFERENCE: @CACHED_PROPERTY
===============================================================================

Cache property results per instance (Python 3.8+)

Example:
--------------------------------------------------------------------------------
    from functools import cached_property

    class DataProcessor:
        def __init__(self, data):
            self.data = data
        
        @cached_property
        def processed_data(self):
            print("Processing...")  # runs once
            return [x * 2 for x in self.data]

    dp = DataProcessor([1, 2, 3])
    print(dp.processed_data)  # runs processing
    print(dp.processed_data)  # uses cached value


===============================================================================
QUICK REFERENCE: MONKEY PATCHING
===============================================================================

Modify behavior at runtime

Example:
--------------------------------------------------------------------------------
    class Calculator:
        def add(self, a, b):
            return a + b

    # Monkey patch
    def multiply(self, a, b):
        return a * b

    Calculator.multiply = multiply

    calc = Calculator()
    print(calc.multiply(3, 4))  # 12

    # Patch method for testing
    def mock_api_call(self):
        return {"mock": "data"}

    MyClass.api_call = mock_api_call


===============================================================================
QUICK REFERENCE: TIMING CODE (timeit)
===============================================================================

Measure execution time

Examples:
--------------------------------------------------------------------------------
    from timeit import timeit

    # Time a code string
    code = "[x**2 for x in range(1000)]"
    time = timeit(code, number=10000)
    print(f"Time: {time:.4f} seconds")

    # Time a function
    def my_function():
        return [x**2 for x in range(1000)]

    time = timeit(my_function, number=10000)

    # With setup
    time = timeit


===============================================================================
DOCSTRINGS
===============================================================================

Docstrings are special strings that serve as documentation for modules, classes,
methods, and functions. They are located at the beginning of these definitions.

Why Use Docstrings:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Documentation       | Provides clear explanation of code functionality
    Help System         | help() function displays docstrings
    IDE Support         | IDEs show docstrings as tooltips
    Code Maintainability| Makes code easier to understand
    Automatic Docs      | Tools like Sphinx generate documentation

Syntax:
--------------------------------------------------------------------------------
    """This is a docstring."""

    def function(param):
        """Return the square of a number."""
        return param ** 2

Accessing Docstrings:
--------------------------------------------------------------------------------
    print(function.__doc__)  # Return the square of a number.
    help(function)           # Displays formatted documentation


===============================================================================
ASSERTIONS
===============================================================================

Assertions are debugging tools that verify conditions are true during development.

Why Use Assertions:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Catch Bugs Early    | Detect invalid conditions as soon as they occur
    Document Assumptions| Make implicit assumptions explicit
    Debugging Aid       | Quickly identify where logic went wrong
    Fail Fast           | Stop execution when an invalid state is detected

Basic Syntax:
--------------------------------------------------------------------------------
    assert condition, "Error message if condition is False"

Examples:
--------------------------------------------------------------------------------
    def divide(a, b):
        assert b != 0, "Cannot divide by zero"
        return a / b

    # Assertion can be disabled with -O flag
    # Not for production error handling


===============================================================================
UNPACKING
===============================================================================

Unpacking allows assigning values from an iterable to multiple variables in one
statement.

Basic Unpacking:
--------------------------------------------------------------------------------
    a, b = 5, 10                    # a=5, b=10
    x, y = (1, 2)                   # Unpack tuple
    first, *rest = [1, 2, 3, 4]     # first=1, rest=[2,3,4]

Ignoring Values (Underscore):
--------------------------------------------------------------------------------
    a, _, b = (1, 2, 3)             # a=1, b=3 (2 ignored)

Swapping Variables:
--------------------------------------------------------------------------------
    a, b = b, a                     # Swap without temporary variable

Function Argument Unpacking:
--------------------------------------------------------------------------------
    def add(a, b): return a + b
    numbers = (5, 3)
    result = add(*numbers)          # Unpacks tuple as arguments


===============================================================================
EQUALITY (==) VS. IDENTITY (is)
===============================================================================

Understanding the difference between value equality and object identity.

Definitions:
--------------------------------------------------------------------------------
    Operator    | Name        | Checks
    ------------|-------------|------------------------------------------
    ==          | Equality    | If values are equal
    is          | Identity    | If objects are the same in memory

When to Use Each:
--------------------------------------------------------------------------------
    Use == for value comparisons (strings, numbers, lists)
    Use is for identity checks (None, singleton checks)

Examples:
--------------------------------------------------------------------------------
    a = [1, 2, 3]
    b = [1, 2, 3]
    c = a

    print(a == b)   # True (same values)
    print(a is b)   # False (different objects)
    print(a is c)   # True (same object)


===============================================================================
DATACLASSES
===============================================================================

The @dataclass decorator automatically generates __init__, __repr__, and __eq__
methods, reducing boilerplate code.

Basic Syntax:
--------------------------------------------------------------------------------
    from dataclasses import dataclass

    @dataclass
    class Person:
        name: str
        age: int
        city: str = "Unknown"

Features:
--------------------------------------------------------------------------------
    Feature             | Description
    --------------------|------------------------------------------------------
    Auto __init__       | Constructor with all fields
    Auto __repr__       | Readable string representation
    Auto __eq__         | Value-based equality
    Default values      | Assign default values to fields
    Mutable defaults    | Use field(default_factory=list)
    Frozen instances    | @dataclass(frozen=True) for immutability
    __post_init__       | Hook for validation/computed fields


===============================================================================
FIELDS IN DATACLASSES
===============================================================================

The field() function provides fine-grained control over dataclass fields.

field() Parameters:
--------------------------------------------------------------------------------
    Parameter           | Description
    --------------------|------------------------------------------------------
    default             | Default value for the field
    default_factory     | Callable that creates default value
    init                | Include field in __init__ (default True)
    repr                | Include field in __repr__ (default True)
    compare             | Include field in comparisons (default True)
    metadata            | Additional information

Examples:
--------------------------------------------------------------------------------
    from dataclasses import dataclass, field

    @dataclass
    class ShoppingList:
        items: list = field(default_factory=list)  # New list per instance
        total: float = field(init=False)           # Computed field
        password: str = field(repr=False)          # Hide from repr


===============================================================================
__POST_INIT__ METHOD
===============================================================================

The __post_init__ method runs after __init__ for validation and computed fields.

Why Use __post_init__:
--------------------------------------------------------------------------------
    Use Case            | Description
    --------------------|------------------------------------------------------
    Validation          | Check that field values are valid
    Computed Fields     | Calculate values based on other fields
    Data Normalization  | Transform or format data after initialization

Important Note:
--------------------------------------------------------------------------------
    __post_init__ runs only ONCE at object creation.
    Changing fields later does NOT trigger __post_init__ again.
    Use properties for values that need to stay in sync.

Example:
--------------------------------------------------------------------------------
    @dataclass
    class Rectangle:
        length: float
        width: float
        area: float = field(init=False)

        def __post_init__(self):
            self.area = self.length * self.width


===============================================================================
@CACHED_PROPERTY
===============================================================================

The @cached_property decorator caches the result of an expensive property after
the first access.

Why Use @cached_property:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Performance         | Avoids repeated expensive computations
    Lazy Evaluation     | Computes only when first accessed
    Thread-safe         | Safe for multi-threaded environments (Python 3.8+)

Example:
--------------------------------------------------------------------------------
    from functools import cached_property

    class DataProcessor:
        def __init__(self, data):
            self.data = data

        @cached_property
        def total(self):
            print("Computing total...")  # Runs only once
            return sum(self.data)


===============================================================================
MONKEY PATCHING
===============================================================================

Monkey patching is modifying or extending code at runtime without altering the
original source.

Why Use Monkey Patching:
--------------------------------------------------------------------------------
    Use Case            | Description
    --------------------|------------------------------------------------------
    Testing             | Replace real API calls with mock data
    Quick Fixes         | Fix bugs in third-party libraries
    Hotfixes            | Patch production code without redeploying

Example:
--------------------------------------------------------------------------------
    class WeatherAPI:
        def get_weather(self):
            return "Real weather data"

    def mock_get_weather(self):
        return "Mock weather data"

    # Monkey patch
    WeatherAPI.get_weather = mock_get_weather

Caution:
--------------------------------------------------------------------------------
    Monkey patching can make code hard to debug. Use sparingly and prefer
    unittest.mock for testing scenarios.


===============================================================================
TIMING CODE WITH TIMEIT
===============================================================================

The timeit module is used for benchmarking small code snippets.

Basic Usage:
--------------------------------------------------------------------------------
    from timeit import timeit

    time = timeit("[x for x in range(1000)]", number=10000)

Parameters:
--------------------------------------------------------------------------------
    Parameter           | Description
    --------------------|------------------------------------------------------
    stmt                | Code to be timed
    setup               | Code to run once before timing
    number              | Number of executions
    globals             | Dictionary of global namespace

Example:
--------------------------------------------------------------------------------
    list_time = timeit("[x for x in range(1000)]", number=100000)
    set_time = timeit("{x for x in range(1000)}", number=100000)


===============================================================================
FILE HANDLING (WRITING)
===============================================================================

Writing to files in Python using the open() function with different modes.

File Modes for Writing:
--------------------------------------------------------------------------------
    Mode    | Description
    --------|--------------------------------------------------------------
    'w'     | Write - overwrites existing content
    'a'     | Append - adds to end of file
    'x'     | Exclusive creation - fails if file exists
    'w+'    | Write and read - overwrites existing

Basic Write Operations:
--------------------------------------------------------------------------------
    # Write a single line
    with open('file.txt', 'w') as f:
        f.write("Hello, World!\n")

    # Write multiple lines
    lines = ["Line 1\n", "Line 2\n", "Line 3\n"]
    with open('file.txt', 'w') as f:
        f.writelines(lines)

Important Note:
--------------------------------------------------------------------------------
    Write mode ('w') erases all existing content. Use append mode ('a') to add
    to existing files without deleting.


===============================================================================
JSON IN PYTHON
===============================================================================

JSON (JavaScript Object Notation) is a lightweight data interchange format.

JSON vs Python:
--------------------------------------------------------------------------------
    JSON                | Python
    --------------------|----------------------------------------------
    object              | dict
    array               | list
    string              | str
    number              | int / float
    true / false        | True / False
    null                | None

Key Functions:
--------------------------------------------------------------------------------
    Function            | Description
    --------------------|------------------------------------------------------
    json.dumps()        | Convert Python dict to JSON string
    json.dump()         | Write Python dict to JSON file
    json.loads()        | Convert JSON string to Python dict
    json.load()         | Read JSON file to Python dict

Examples:
--------------------------------------------------------------------------------
    import json

    data = {"name": "Alice", "age": 30}

    # Write to file
    with open('data.json', 'w') as f:
        json.dump(data, f, indent=4)

    # Read from file
    with open('data.json', 'r') as f:
        loaded = json.load(f)


===============================================================================
QUICK REFERENCE ADDITIONS
===============================================================================

Exception Handling Quick Reference:
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

Truthiness Quick Reference:
--------------------------------------------------------------------------------
    Truthy values:          | if "text":, if 1:, if [1,2]:, if {"a":1}:
    Falsy values:           | if not None:, if not 0:, if not "":, if not []:
    Check truthiness        | bool(value)
    Default value pattern   | value = user_input or "default"

Module/Package Quick Reference:
--------------------------------------------------------------------------------
    Concept                 | Syntax
    ------------------------|------------------------------------------
    Import module           | import module_name
    Import function         | from module import function
    Import with alias       | import module as alias
    Module guard            | if __name__ == "__main__":
    Create package          | directory + __init__.py
    Import from package     | from package import module

Docstring Quick Reference:
--------------------------------------------------------------------------------
    Function docstring      | def func(): """Description."""
    Access docstring        | func.__doc__ or help(func)

Assertion Quick Reference:
--------------------------------------------------------------------------------
    Basic assertion         | assert condition
    With message            | assert condition, "Error message"

Unpacking Quick Reference:
--------------------------------------------------------------------------------
    Basic unpacking         | a, b = (1, 2)
    Extended unpacking      | first, *rest = [1, 2, 3]
    Ignore values           | a, _, b = (1, 2, 3)
    Swap variables          | a, b = b, a

Equality vs Identity Quick Reference:
--------------------------------------------------------------------------------
    Value equality          | a == b
    Object identity         | a is b
    Check None              | x is None

Dataclass Quick Reference:
--------------------------------------------------------------------------------
    Basic dataclass         | @dataclass class C: a: int
    Frozen dataclass        | @dataclass(frozen=True)
    Custom field            | field(default_factory=list)
    Post-init               | def __post_init__(self):

Cached Property Quick Reference:
--------------------------------------------------------------------------------
    Basic usage             | @cached_property def prop(self):

File Writing Quick Reference:
--------------------------------------------------------------------------------
    Write to file           | with open('f.txt', 'w') as f: f.write()
    Append to file          | with open('f.txt', 'a') as f: f.write()
    Write lines             | f.writelines(lines)

JSON Quick Reference:
--------------------------------------------------------------------------------
    Dict to JSON string     | json.dumps(data)
    Dict to JSON file       | json.dump(data, file)
    JSON string to dict     | json.loads(json_string)
    JSON file to dict       | json.load(file)

===============================================================================
                        END OF DOCUMENTATION
===============================================================================
EOF

