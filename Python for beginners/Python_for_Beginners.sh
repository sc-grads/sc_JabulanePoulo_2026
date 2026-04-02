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
                        END OF DOCUMENTATION
===============================================================================

EOF
