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
15. Control & Flow (If, Elif, Else, Loops, Break, Continue)
16. Functions
17. Parameters vs. Arguments
18. Return Statements
19. Lambda Functions
20. Recursion
21. *args and **kwargs
22. Slash (/) and Asterisk (*) in Function Signatures
23. Object-Oriented Programming (OOP) in Python
24. Classes and Objects
25. __init__ Method (Constructor)
26. self Parameter
27. Class Attributes vs. Instance Attributes
28. Methods vs. Functions
29. Inheritance
30. super() Function
31. @staticmethod
32. @classmethod
33. @abstractmethod
34. Name Mangling
35. Dunder Methods (__str__, __repr__, __eq__)
36. Chat Bot (Practical Project)
37. Exception Handling (Try, Except, Else, Finally)
38. The raise Keyword
39. Truthy and Falsy Values
40. Modules
41. Packages
42. Libraries vs. Packages vs. Modules
43. Docstrings
44. Assertions
45. Unpacking
46. Equality (==) vs. Identity (is)
47. Dataclasses
48. Fields in Dataclasses
49. __post_init__ Method
50. @cached_property
51. Monkey Patching
52. Timing Code with timeit
53. File Handling (Writing)
54. JSON in Python


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
    A       | B       | A and B    | A or B    | not A
    --------|---------|------------|-----------|-------
    True    | True    | True       | True      | False
    True    | False   | False      | True      | False
    False   | True    | False      | True      | True
    False   | False   | False      | False     | True


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


===============================================================================
15. CONTROL & FLOW (IF, ELIF, ELSE, LOOPS, BREAK, CONTINUE)
===============================================================================

Conditional statements and loops control program flow.

IF, ELIF, ELSE Statements:
--------------------------------------------------------------------------------
    Why Use Conditional Statements:
    ----------------------------------------------------------------------------
    Reason              | Explanation
    --------------------|------------------------------------------------------
    Decision Making     | Allows programs to make choices based on conditions
    Dynamic Behavior    | Programs can react differently to different inputs
    Error Handling      | Prevent invalid operations by checking conditions
    User Interaction    | Respond appropriately to what the user enters

    Syntax:
    ----------------------------------------------------------------------------
    if condition:
        # Code runs if condition is True
    elif condition:
        # Code runs if previous conditions False and this is True
    else:
        # Code runs if all previous conditions False

    Example:
    ----------------------------------------------------------------------------
    age = 20
    if age >= 21:
        print("You may enter the club.")
    elif age >= 18:
        print("You may enter with supervision.")
    else:
        print("You are not allowed to enter.")

    Ternary Operator (Shorthand if-else):
    ----------------------------------------------------------------------------
    # Syntax: value_if_true if condition else value_if_false
    status = "Adult" if age >= 18 else "Minor"

FOR Loops:
--------------------------------------------------------------------------------
    Why Use For Loops:
    ----------------------------------------------------------------------------
    Reason              | Explanation
    --------------------|------------------------------------------------------
    Automation          | Perform same action multiple times without repetition
    Efficiency          | Process hundreds of items with few lines of code
    Predictability      | Loop runs a fixed number of times
    Data Processing     | Essential for working with collections

    Syntax:
    ----------------------------------------------------------------------------
    for variable in iterable:
        # Code block to execute for each item

    Examples:
    ----------------------------------------------------------------------------
    # Iterate over range
    for i in range(5):
        print(i)  # Prints 0, 1, 2, 3, 4

    # Iterate over list
    fruits = ["apple", "banana", "cherry"]
    for fruit in fruits:
        print(fruit)

    # With enumerate (index and value)
    for i, fruit in enumerate(fruits):
        print(f"{i}: {fruit}")

    # With zip (parallel iteration)
    names = ["Alice", "Bob"]
    scores = [85, 92]
    for name, score in zip(names, scores):
        print(f"{name}: {score}")

WHILE Loops:
--------------------------------------------------------------------------------
    Why Use While Loops:
    ----------------------------------------------------------------------------
    Reason              | Explanation
    --------------------|------------------------------------------------------
    Unknown Iterations  | When you don't know how many times to loop
    User Input          | Loop until user provides valid input
    Game Loops          | Run game until player quits
    Continuous Process  | Keep running until a condition changes

    Syntax:
    ----------------------------------------------------------------------------
    while condition:
        # Code block runs while condition is True

    Examples:
    ----------------------------------------------------------------------------
    # Countdown
    count = 5
    while count > 0:
        print(count)
        count -= 1

    # User input loop
    while True:
        user_input = input("Type 'exit' to quit: ")
        if user_input == "exit":
            break

BREAK and CONTINUE:
--------------------------------------------------------------------------------
    Keyword     | Effect                        | When to Use
    ------------|-------------------------------|-----------------------------------
    break       | Exits the loop completely     | Found what you need, error condition
    continue    | Skips to next iteration       | Invalid data, skip certain values

    Examples:
    ----------------------------------------------------------------------------
    # Break - exit loop when found
    for num in [1, 3, 5, 8, 10]:
        if num % 2 == 0:
            print(f"Found even: {num}")
            break

    # Continue - skip certain values
    for i in range(10):
        if i % 3 == 0:
            continue
        print(i)  # Prints numbers not divisible by 3

ELSE with Loops:
--------------------------------------------------------------------------------
    The else block executes after a loop ONLY if the loop completed without break.

    Example:
    ----------------------------------------------------------------------------
    for item in items:
        if item == target:
            print("Found!")
            break
    else:
        print("Not found.")  # Runs only if break never occurred

Loop Control Summary:
--------------------------------------------------------------------------------
    Concept             | Effect
    --------------------|------------------------------------------------------
    break               | Exits loop entirely
    continue            | Skips current iteration, continues with next
    else (with loop)    | Runs if loop completes without break
    pass                | Does nothing (placeholder)


===============================================================================
16. FUNCTIONS
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


===============================================================================
17. PARAMETERS VS. ARGUMENTS
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


===============================================================================
18. RETURN STATEMENTS
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

Returning Multiple Values:
--------------------------------------------------------------------------------
    def get_min_max(numbers):
        return min(numbers), max(numbers)

    lowest, highest = get_min_max([10, 20, 5, 30, 15])
    print(f"Lowest: {lowest}, Highest: {highest}")
    # Output: Lowest: 5, Highest: 30


===============================================================================
19. LAMBDA FUNCTIONS
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
20. RECURSION
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


===============================================================================
21. *ARGS AND **KWARGS
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


===============================================================================
22. SLASH (/) AND ASTERISK (*) IN FUNCTION SIGNATURES
===============================================================================

The / and * symbols control how arguments can be passed to functions.

Slash (/) - Positional-Only Parameters:
--------------------------------------------------------------------------------
    Parameters before / must be passed as positional arguments (not keyword).

    def func(a, b, /):
        return a + b

    func(1, 2)          # ✓ Valid
    # func(a=1, b=2)    # ✗ TypeError

Asterisk (*) - Keyword-Only Parameters:
--------------------------------------------------------------------------------
    Parameters after * must be passed as keyword arguments.

    def func(a, *, b):
        return a + b

    func(1, b=2)        # ✓ Valid
    # func(1, 2)        # ✗ TypeError

Combining / and *:
--------------------------------------------------------------------------------
    def func(pos1, pos2, /, standard, *, kw1, kw2):
        print(f"Positional-only: {pos1}, {pos2}")
        print(f"Standard: {standard}")
        print(f"Keyword-only: {kw1}, {kw2}")

    # Valid call
    func(1, 2, 3, kw1=4, kw2=5)

Summary Table:
--------------------------------------------------------------------------------
    Syntax                      | Effect
    ----------------------------|----------------------------------------------
    def func(a, b, /):          | a and b must be positional-only
    def func(a, *, b):          | b must be keyword-only
    def func(a, /, b, *, c):    | a positional-only, b either, c keyword-only


===============================================================================
23. OBJECT-ORIENTED PROGRAMMING (OOP) IN PYTHON
===============================================================================

Object-Oriented Programming is a programming paradigm that organizes code
using objects that contain data (attributes) and behavior (methods).

Core Principles of OOP:
--------------------------------------------------------------------------------
    Principle       | Description
    ----------------|----------------------------------------------------------
    Encapsulation   | Bundling data and methods that operate on that data
    Inheritance     | Creating new classes based on existing classes
    Polymorphism    | Same interface, different implementations
    Abstraction     | Hiding complex implementation details

Why Use OOP:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Code Organization   | Group related data and functions together
    Reusability         | Inheritance allows code reuse across classes
    Maintainability     | Changes in one class don't affect others
    Real-world Modeling | Natural way to represent real-world entities


===============================================================================
24. CLASSES AND OBJECTS
===============================================================================

A class is a blueprint for creating objects. An object is an instance of a class.

Class Definition:
--------------------------------------------------------------------------------
    class ClassName:
        """Class docstring."""
        
        # Class attributes (shared by all instances)
        class_attribute = "shared value"
        
        # Instance attributes (unique to each instance)
        def __init__(self, param1, param2):
            self.instance_attr1 = param1
            self.instance_attr2 = param2
        
        # Instance methods
        def method_name(self):
            return f"Working with {self.instance_attr1}"

Creating and Using Objects:
--------------------------------------------------------------------------------
    # Create a class
    class Car:
        """A simple Car class."""
        wheels = 4  # Class attribute
        
        def __init__(self, brand, color):
            self.brand = brand    # Instance attribute
            self.color = color    # Instance attribute
        
        def drive(self):
            return f"The {self.color} {self.brand} is driving!"
    
    # Create objects (instances)
    car1 = Car("Toyota", "red")
    car2 = Car("Honda", "blue")
    
    # Access attributes
    print(car1.brand)     # Output: Toyota
    print(car1.wheels)    # Output: 4
    
    # Call methods
    print(car1.drive())   # Output: The red Toyota is driving!


===============================================================================
25. __INIT__ METHOD (CONSTRUCTOR)
===============================================================================

The __init__ method is a special method that initializes a new object when it
is created. It runs automatically when you instantiate a class.

Purpose of __init__:
--------------------------------------------------------------------------------
    Purpose             | Description
    --------------------|------------------------------------------------------
    Initialization      | Sets up the initial state of the object
    Customization       | Allows each object to have unique attribute values
    Convenience         | Automatically called when creating objects
    Consistency         | Ensures every object starts with a valid state

Syntax:
--------------------------------------------------------------------------------
    class ClassName:
        def __init__(self, parameter1, parameter2):
            self.attribute1 = parameter1
            self.attribute2 = parameter2

Example:
--------------------------------------------------------------------------------
    class Person:
        def __init__(self, name, age):
            self.name = name
            self.age = age
            self.is_alive = True  # Default value
    
    # Creating objects automatically calls __init__
    person1 = Person("Alice", 25)
    person2 = Person("Bob", 30)
    
    print(person1.name)  # Output: Alice
    print(person2.age)   # Output: 30


===============================================================================
26. SELF PARAMETER
===============================================================================

self is a special parameter that refers to the current instance of the class.
It allows you to access instance attributes and methods from within the class.

What is self:
--------------------------------------------------------------------------------
    Aspect              | Description
    --------------------|------------------------------------------------------
    Purpose             | Refers to the current instance of the class
    First Parameter     | Must be the first parameter of instance methods
    Name Convention     | Can be any name but 'self' is strongly recommended
    Automatic           | Python passes self automatically when calling methods

Example:
--------------------------------------------------------------------------------
    class Fruit:
        def __init__(self, name: str, grams: float):
            self.name = name      # 'self' binds name to this instance
            self.grams = grams    # 'self' binds grams to this instance
        
        def describe(self):
            # 'self' accesses instance attributes
            return f"{self.name} weighs {self.grams} grams"
    
    # Each instance has its own 'self'
    apple = Fruit("Apple", 25)
    banana = Fruit("Banana", 10)
    
    print(apple.describe())   # Output: Apple weighs 25 grams
    print(banana.describe())  # Output: Banana weighs 10 grams

Why self is Important:
--------------------------------------------------------------------------------
    Reason              | Explanation
    --------------------|------------------------------------------------------
    Instance Specific   | Ensures attributes are tied to the individual object
    Avoids Confusion    | Distinguishes instance attributes from local variables
    Method Access       | Allows calling other instance methods


===============================================================================
27. CLASS ATTRIBUTES VS. INSTANCE ATTRIBUTES
===============================================================================

Understanding the difference between attributes shared by all instances and
attributes unique to each instance.

Definitions:
--------------------------------------------------------------------------------
    Attribute Type      | Definition                    | Shared Among
    --------------------|-------------------------------|------------------
    Class Attribute     | Shared across all instances   | All instances
    Instance Attribute  | Specific to each object       | Each instance has its own

Class Attributes:
--------------------------------------------------------------------------------
    class Car:
        wheels = 4                    # Class attribute (shared)
        vehicle_count = 0             # Class attribute (counter)
        
        def __init__(self, brand):
            self.brand = brand         # Instance attribute (unique)
            Car.vehicle_count += 1
    
    car1 = Car("Toyota")
    car2 = Car("Honda")
    
    print(car1.wheels)        # Output: 4 (access via instance)
    print(Car.wheels)         # Output: 4 (access via class)
    print(Car.vehicle_count)  # Output: 2

Instance Attributes:
--------------------------------------------------------------------------------
    class Book:
        def __init__(self, title, author):
            self.title = title     # Instance attribute
            self.author = author   # Instance attribute
    
    book1 = Book("1984", "Orwell")
    book2 = Book("Brave New World", "Huxley")
    
    print(book1.title)   # Output: 1984
    print(book2.title)   # Output: Brave New World

When to Use Each:
--------------------------------------------------------------------------------
    Use Case                     | Use
    -----------------------------|-----------------------------------------------
    Shared configuration         | Class attribute
    Constants                    | Class attribute
    Counter (tracking instances) | Class attribute
    Unique data per object       | Instance attribute
    Object-specific state        | Instance attribute


===============================================================================
28. METHODS VS. FUNCTIONS
===============================================================================

Understanding the key differences between methods and functions in Python.

Definitions:
--------------------------------------------------------------------------------
    Term        | Definition                              | Association
    ------------|-----------------------------------------|-------------
    Function    | Standalone block of code                | Independent
    Method      | Function associated with an object/class | Class/Instance

Key Differences:
--------------------------------------------------------------------------------
    Aspect              | Function                     | Method
    --------------------|-----------------------------|-----------------------------
    Association         | Independent                  | Belongs to a class
    First Parameter     | No special parameter         | self (instance) or cls (class)
    Call Syntax         | function_name(args)          | object.method_name(args)
    Access to Data      | Only what's passed in        | Can access instance/class data
    Defined             | At module level              | Inside a class

Example:
--------------------------------------------------------------------------------
    # Function (standalone)
    def greet_function(name):
        return f"Hello, {name}!"
    
    # Method (inside a class)
    class Greeter:
        def __init__(self, prefix):
            self.prefix = prefix
        
        def greet_method(self, name):
            return f"{self.prefix}, {name}!"
    
    # Calling a function
    print(greet_function("Alice"))     # Output: Hello, Alice!
    
    # Calling a method
    greeter = Greeter("Hi")
    print(greeter.greet_method("Bob")) # Output: Hi, Bob!

Analogy:
--------------------------------------------------------------------------------
    Function    = Calculator app (same regardless of who uses it)
    Method      = TV remote (attached to a specific TV, knows its state)


===============================================================================
29. INHERITANCE
===============================================================================

Inheritance allows a class (child/subclass) to inherit attributes and methods
from another class (parent/superclass).

Why Use Inheritance:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Code Reusability    | Don't rewrite the same code
    Extensibility       | Add new features without changing existing code
    Logical Hierarchy   | Creates natural relationships (Dog is an Animal)
    Polymorphism        | Treat different objects uniformly

Syntax:
--------------------------------------------------------------------------------
    class ParentClass:
        # Parent class code
    
    class ChildClass(ParentClass):
        # Child class inherits from ParentClass

Example:
--------------------------------------------------------------------------------
    # Base class (Parent)
    class Animal:
        def __init__(self, name):
            self.name = name
        
        def speak(self):
            return f"{self.name} makes a sound"
        
        def move(self):
            return f"{self.name} moves"
    
    # Derived class (Child)
    class Dog(Animal):
        def speak(self):  # Method overriding
            return f"{self.name} barks: Woof!"
        
        def fetch(self):  # New method
            return f"{self.name} fetches the ball"
    
    class Cat(Animal):
        def speak(self):  # Method overriding
            return f"{self.name} meows: Meow!"
    
    # Usage
    dog = Dog("Rex")
    cat = Cat("Whiskers")
    
    print(dog.speak())    # Output: Rex barks: Woof!
    print(dog.move())     # Output: Rex moves (inherited)
    print(dog.fetch())    # Output: Rex fetches the ball
    print(cat.speak())    # Output: Whiskers meows: Meow!

Types of Inheritance:
--------------------------------------------------------------------------------
    Type                | Description
    --------------------|------------------------------------------------------
    Single Inheritance  | One child inherits from one parent
    Multiple Inheritance| Child inherits from multiple parents
    Multilevel          | Child inherits from parent that inherits from grandparent
    Hierarchical        | Multiple children inherit from one parent


===============================================================================
30. SUPER() FUNCTION
===============================================================================

The super() function is used to call methods from a parent class in a subclass.

Why Use super():
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Cleaner Code        | Avoids hardcoding parent class names
    Maintainable        | If parent class name changes, update only once
    Multiple Inheritance| Handles complex inheritance chains correctly
    Best Practice       | Standard way to call parent class methods

Basic Usage:
--------------------------------------------------------------------------------
    class Parent:
        def __init__(self, name):
            self.name = name
        
        def greet(self):
            return f"Hello from {self.name}"
    
    class Child(Parent):
        def __init__(self, name, age):
            super().__init__(name)  # Call parent's __init__
            self.age = age
        
        def greet(self):
            # Call parent's greet method and extend it
            parent_greeting = super().greet()
            return f"{parent_greeting}. I am {self.age} years old."

Example:
--------------------------------------------------------------------------------
    class Vehicle:
        def __init__(self, brand, wheels):
            self.brand = brand
            self.wheels = wheels
        
        def start(self):
            return f"The {self.brand} is starting"
    
    class ElectricCar(Vehicle):
        def __init__(self, brand, wheels, battery_size):
            super().__init__(brand, wheels)  # Initialize parent
            self.battery_size = battery_size
        
        def start(self):
            # Extend parent's start method
            return super().start() + " silently (electric mode)"
    
    tesla = ElectricCar("Tesla", 4, 100)
    print(tesla.start())  # Output: The Tesla is starting silently (electric mode)

Analogy:
--------------------------------------------------------------------------------
    super() is like asking a parent for help while still doing things your own way.
    A child learning to cook asks their parent for the basic recipe (calls parent's
    method), then adds their own twist (extends the functionality).


===============================================================================
31. @STATICMETHOD
===============================================================================

The @staticmethod decorator defines a method that does not require access to
instance or class data. It behaves like a regular function but lives inside a
class for organization.

Why Use @staticmethod:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Organization        | Groups related utility functions inside a class
    Namespace clarity   | Shows the function belongs conceptually to the class
    No instance needed  | Can be used without creating objects
    Code readability    | Makes intent clear: "this function doesn't depend on state"

Syntax:
--------------------------------------------------------------------------------
    class ClassName:
        @staticmethod
        def utility_function(param1, param2):
            # No self or cls parameter
            return result

Example:
--------------------------------------------------------------------------------
    class MathOperations:
        @staticmethod
        def add(x, y):
            return x + y
        
        @staticmethod
        def multiply(x, y):
            return x * y
        
        @staticmethod
        def is_even(number):
            return number % 2 == 0
    
    # Call on class (no instance needed)
    print(MathOperations.add(5, 3))        # Output: 8
    print(MathOperations.multiply(4, 6))   # Output: 24
    print(MathOperations.is_even(7))       # Output: False
    
    # Can also be called on instances (but not necessary)
    math = MathOperations()
    print(math.add(10, 20))                # Output: 30

When to Use Static Method:
--------------------------------------------------------------------------------
    Use Case                    | Example
    ----------------------------|-----------------------------------------------
    Utility functions           | Helper functions related to the class
    Validation functions        | Input validation for class-related data
    Conversion functions        | Convert data to/from class-related formats
    Pure functions              | Functions with no side effects

Analogy:
--------------------------------------------------------------------------------
    A static method is like a calculator in a toolbox. The calculator doesn't
    need to know which toolbox it's in or what other tools are there. It just
    does its job. You can use it without opening the toolbox (creating an instance).


===============================================================================
32. @CLASSMETHOD
===============================================================================

The @classmethod decorator defines a method that receives the class as the
first argument (cls) instead of the instance (self). It can access and modify
class-level data.

Why Use @classmethod:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Factory Methods     | Create instances in different ways (from string, file, etc.)
    Class-level ops     | Modify or access class variables that affect all instances
    Alternative constructors | Provide multiple ways to instantiate a class
    Inheritance-friendly| Respects subclassing (uses the correct class when inherited)

Syntax:
--------------------------------------------------------------------------------
    class ClassName:
        class_variable = 0
        
        @classmethod
        def class_method(cls, param):
            # cls is the class (not an instance)
            cls.class_variable += param
            return cls.class_variable

Example:
--------------------------------------------------------------------------------
    class Book:
        total_books = 0      # Class variable
        all_books = []       # Class variable
        
        def __init__(self, title, author):
            self.title = title
            self.author = author
            Book.total_books += 1
            Book.all_books.append(self)
        
        @classmethod
        def get_total_books(cls):
            """Class method to access class variable."""
            return f"Total books: {cls.total_books}"
        
        @classmethod
        def from_string(cls, book_string):
            """Factory method: create Book from formatted string."""
            title, author = book_string.split(" by ")
            return cls(title, author)
        
        @classmethod
        def get_book_titles(cls):
            """Class method returning all book titles."""
            return [book.title for book in cls.all_books]
    
    # Using factory method
    book1 = Book.from_string("1984 by George Orwell")
    book2 = Book.from_string("Brave New World by Aldous Huxley")
    
    print(Book.get_total_books())   # Output: Total books: 2
    print(Book.get_book_titles())   # Output: ['1984', 'Brave New World']

Class Method vs Static Method:
--------------------------------------------------------------------------------
    Aspect              | @classmethod                    | @staticmethod
    --------------------|---------------------------------|-------------------------------
    First parameter     | cls (the class)                 | None
    Can access class    | Yes                             | No
    Can modify class    | Yes                             | No
    Inheritance         | Respects subclassing            | No special behavior
    Use case            | Factory methods, class counters | Utility functions

Analogy:
--------------------------------------------------------------------------------
    A class method is like a factory manager. The manager knows how many products
    were made (class-level data) and can create new products using different
    methods (factory methods). The manager doesn't belong to any single product
    but oversees the entire factory operation.


===============================================================================
33. @ABSTRACTMETHOD
===============================================================================

The @abstractmethod decorator defines a method that must be implemented by any
subclass. Abstract methods have no implementation in the base class.

Why Use @abstractmethod:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Enforces Interface  | Guarantees that all subclasses have the same methods
    Prevents Incomplete | Catches errors early if a subclass misses a method
    Design Clarity      | Makes it clear which methods must be implemented
    Polymorphism        | Allows treating different objects uniformly

Syntax:
--------------------------------------------------------------------------------
    from abc import ABC, abstractmethod
    
    class AbstractClass(ABC):
        @abstractmethod
        def required_method(self):
            """This method MUST be implemented by subclasses."""
            pass

Example:
--------------------------------------------------------------------------------
    from abc import ABC, abstractmethod
    from math import pi
    
    class Shape(ABC):
        """Abstract base class for all shapes."""
        
        @abstractmethod
        def area(self):
            """Calculate area - must be implemented."""
            pass
        
        @abstractmethod
        def perimeter(self):
            """Calculate perimeter - must be implemented."""
            pass
    
    class Rectangle(Shape):
        def __init__(self, width, height):
            self.width = width
            self.height = height
        
        def area(self):
            return self.width * self.height
        
        def perimeter(self):
            return 2 * (self.width + self.height)
    
    class Circle(Shape):
        def __init__(self, radius):
            self.radius = radius
        
        def area(self):
            return pi * self.radius ** 2
        
        def perimeter(self):
            return 2 * pi * self.radius
    
    # This works
    rect = Rectangle(10, 5)
    print(rect.area())       # Output: 50
    
    # This would raise TypeError (incomplete implementation)
    # class Triangle(Shape):
    #     pass
    # t = Triangle()  # TypeError: Can't instantiate abstract class

Key Points:
--------------------------------------------------------------------------------
    Point               | Description
    --------------------|------------------------------------------------------
    Requires ABC        | Class must inherit from ABC (or have metaclass=ABCMeta)
    Cannot Instantiate  | Cannot create objects from abstract base classes
    Must Implement All  | Subclasses must implement all abstract methods
    Can Have Concrete   | Abstract classes can also have regular methods


===============================================================================
34. NAME MANGLING
===============================================================================

Name mangling is a technique that makes class attributes harder to access from
outside the class by prefixing the attribute name with two underscores (__).

Why Use Name Mangling:
--------------------------------------------------------------------------------
    Benefit             | Explanation
    --------------------|------------------------------------------------------
    Encapsulation       | Prevents accidental access/modification from outside
    Prevents Conflicts  | Avoids name clashes in subclasses
    Privacy Convention  | Signals "private" attribute (though not truly private)

How It Works:
--------------------------------------------------------------------------------
    When you define an attribute with __ (double underscore), Python internally
    renames it to _ClassName__attributeName.

Example:
--------------------------------------------------------------------------------
    class BankAccount:
        def __init__(self, owner, balance):
            self.owner = owner
            self.__balance = balance  # Name mangled to _BankAccount__balance
        
        def deposit(self, amount):
            if amount > 0:
                self.__balance += amount
        
        def withdraw(self, amount):
            if 0 < amount <= self.__balance:
                self.__balance -= amount
                return True
            return False
        
        def get_balance(self):
            return self.__balance
    
    account = BankAccount("Alice", 1000)
    
    # Direct access fails
    # print(account.__balance)  # AttributeError
    
    # But can still access via mangled name (not recommended)
    print(account._BankAccount__balance)  # Output: 1000
    
    # Proper way: use methods
    account.deposit(500)
    print(account.get_balance())  # Output: 1500

Name Mangling in Inheritance:
--------------------------------------------------------------------------------
    class Parent:
        def __init__(self):
            self.__value = "parent"    # _Parent__value
    
    class Child(Parent):
        def __init__(self):
            super().__init__()
            self.__value = "child"     # _Child__value (different!)
    
    obj = Child()
    # Both attributes exist separately
    print(obj._Parent__value)  # Output: parent
    print(obj._Child__value)   # Output: child

Important Notes:
--------------------------------------------------------------------------------
    Note                | Explanation
    --------------------|------------------------------------------------------
    Not True Privacy    | Still accessible via mangled name (by convention only)
    Only Double Leading | Two underscores (__), not single (_) which is convention
    No Trailing         | __var__ is reserved for special methods (don't use)
    Useful for Avoiding | Prevents accidental override in subclasses


===============================================================================
35. DUNDER METHODS (__STR__, __REPR__, __EQ__)
===============================================================================

Dunder (double underscore) methods are special methods that define how objects
behave with built-in operations.

Common Dunder Methods:
--------------------------------------------------------------------------------
    Category        | Method    | Purpose
    ----------------|-----------|--------------------------------------------------
    Initialization  | __init__  | Constructor, initializes new objects
    Representation  | __str__   | Human-readable string (for print())
    Representation  | __repr__  | Developer-readable string (for debugging)
    Comparison      | __eq__    | Equality operator (==)
    Comparison      | __lt__    | Less than operator (<)
    Arithmetic      | __add__   | Addition operator (+)
    Container       | __len__   | Length function (len())
    Container       | __getitem__| Indexing (obj[key])
    Callable        | __call__  | Object called as function

__str__ vs __repr__:
--------------------------------------------------------------------------------
    Aspect          | __str__                    | __repr__
    ----------------|----------------------------|-------------------------------
    Purpose         | User-friendly string       | Unambiguous, developer-friendly
    Target Audience | End users                  | Developers, debugging
    Called by       | print(), str(), f-strings  | repr(), interactive console
    Goal            | Readable, informative      | Should recreate object if possible

Example:
--------------------------------------------------------------------------------
    class Book:
        def __init__(self, title, author, year):
            self.title = title
            self.author = author
            self.year = year
        
        def __str__(self):
            """User-friendly representation."""
            return f"'{self.title}' by {self.author} ({self.year})"
        
        def __repr__(self):
            """Developer-friendly representation (should recreate object)."""
            return f"Book(title='{self.title}', author='{self.author}', year={self.year})"
        
        def __eq__(self, other):
            """Define equality based on title and author."""
            if isinstance(other, Book):
                return self.title == other.title and self.author == other.author
            return False
        
        def __len__(self):
            """Return length of title."""
            return len(self.title)
    
    book1 = Book("1984", "George Orwell", 1949)
    book2 = Book("1984", "George Orwell", 1949)
    book3 = Book("Brave New World", "Aldous Huxley", 1932)
    
    # __str__ usage
    print(book1)                    # Output: '1984' by George Orwell (1949)
    
    # __repr__ usage
    print(repr(book1))              # Output: Book(title='1984', author='George Orwell', year=1949)
    
    # __eq__ usage
    print(book1 == book2)           # Output: True
    print(book1 == book3)           # Output: False
    
    # __len__ usage
    print(len(book1))               # Output: 4

Guidelines:
--------------------------------------------------------------------------------
    Guideline                       | Explanation
    --------------------------------|--------------------------------------------------
    __str__ for users               | Make it readable and informative
    __repr__ for developers         | Should ideally be valid Python to recreate object
    __eq__ for meaningful equality  | Compare by value, not by memory address
    Implement __repr__ always       | Good practice for debugging
    __str__ falls back to __repr__  | If __str__ missing, Python uses __repr__


===============================================================================
36. CHAT BOT (PRACTICAL PROJECT)
===============================================================================

A simple rule-based chat bot that responds to user input.

Basic Chat Bot:
--------------------------------------------------------------------------------
    import datetime
    import random

    def get_response(user_input):
        responses = {
            "hello": ["Hey there!", "Hi!", "Hello!"],
            "how are you": ["I'm good, thanks!", "Doing great!"],
            "what time is it": [str(datetime.datetime.now().time())],
            "goodbye": ["Goodbye!", "See you later!"],
            "joke": [
                "Why do programmers prefer dark mode? Because light attracts bugs!",
                "What do you call a snake that codes? A python!"
            ]
        }

        message = user_input.lower()
        for key in responses:
            if key in message:
                return random.choice(responses[key])
        return "I do not understand."

    def chat():
        print("Hello, I am a bot! Type 'exit' to quit.")
        while True:
            user_input = input("You: ")
            if user_input.lower() in ["exit", "quit", "goodbye"]:
                print("Bot: Goodbye!")
                break
            bot_response = get_response(user_input)
            print(f"Bot: {bot_response}")

    if __name__ == "__main__":
        chat()


===============================================================================
37. EXCEPTION HANDLING (TRY, EXCEPT, ELSE, FINALLY)
===============================================================================

Exception handling allows your program to respond gracefully to errors.

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

Try-Except-Else-Finally:
--------------------------------------------------------------------------------
    try:
        file = open("data.txt", "r")
        content = file.read()
    except FileNotFoundError:
        print("File not found!")
    else:
        print(f"File has {len(content)} characters")
    finally:
        # This ALWAYS runs
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


===============================================================================
38. THE RAISE KEYWORD
===============================================================================

The raise keyword is used to intentionally trigger an exception.

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

    def withdraw(balance, amount):
        if amount > balance:
            raise InsufficientFundsError(f"Insufficient funds: {balance}")
        return balance - amount


===============================================================================
39. TRUTHY AND FALSY VALUES
===============================================================================

Every value in Python has an inherent truth value.

Truthy Values (Evaluate to True):
--------------------------------------------------------------------------------
    Category            | Examples
    --------------------|------------------------------------------------------
    Non-empty strings   | "hello", " ", "0"
    Non-zero numbers    | 1, -1, 3.14, -5.5
    Non-empty lists     | [1, 2], [0], ["a"]
    Non-empty dicts     | {"key": "value"}

Falsy Values (Evaluate to False):
--------------------------------------------------------------------------------
    Category            | Examples
    --------------------|------------------------------------------------------
    None                | None
    Boolean False       | False
    Zero numbers        | 0, 0.0, 0j
    Empty strings       | ""
    Empty lists         | []
    Empty dicts         | {}

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
40. MODULES
===============================================================================

A module is a single file containing Python code that can be imported.

Importing Modules:
--------------------------------------------------------------------------------
    Method                      | Syntax
    ----------------------------|-----------------------------------------------
    Import entire module        | import greetings
    Import specific function    | from greetings import say_hello
    Import with alias           | import greetings as gr
    Import all (not recommended)| from greetings import *

The if __name__ == "__main__" Guard:
--------------------------------------------------------------------------------
    # This code only runs when the file is executed directly
    # Not when imported as a module
    if __name__ == "__main__":
        print("This runs only when script is executed directly")
        main()


===============================================================================
41. PACKAGES
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

Importing from Packages:
--------------------------------------------------------------------------------
    # Import entire module from package
    from my_package import module1

    # Import specific function
    from my_package.module1 import important_function

    # Import using package alias
    import my_package as mp


===============================================================================
42. LIBRARIES VS. PACKAGES VS. MODULES
===============================================================================

Understanding the hierarchy of code organization.

Definitions:
--------------------------------------------------------------------------------
    Term        | Definition                          | Example
    ------------|-------------------------------------|-------------------
    Module      | Single .py file                    | math.py
    Package     | Directory with __init__.py          | urllib/
    Library     | Collection of packages/modules      | requests, pandas

Hierarchy:
--------------------------------------------------------------------------------
    LIBRARY (Collection)
        │
        ├── PACKAGE 1 (Directory)
        │       ├── __init__.py
        │       └── module1.py
        │
        └── STANDALONE MODULE (single file)


===============================================================================
43. DOCSTRINGS
===============================================================================

Docstrings document modules, classes, methods, and functions.

Syntax:
--------------------------------------------------------------------------------
    def function(param):
        """Return the square of a number."""
        return param ** 2

Accessing Docstrings:
--------------------------------------------------------------------------------
    print(function.__doc__)
    help(function)


===============================================================================
44. ASSERTIONS
===============================================================================

Assertions verify conditions are true during development.

Basic Syntax:
--------------------------------------------------------------------------------
    assert condition, "Error message if condition is False"

Example:
--------------------------------------------------------------------------------
    def divide(a, b):
        assert b != 0, "Cannot divide by zero"
        return a / b


===============================================================================
45. UNPACKING
===============================================================================

Unpacking assigns values from an iterable to multiple variables.

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


===============================================================================
46. EQUALITY (==) VS. IDENTITY (is)
===============================================================================

Understanding value equality vs object identity.

Definitions:
--------------------------------------------------------------------------------
    Operator    | Name        | Checks
    ------------|-------------|------------------------------------------
    ==          | Equality    | If values are equal
    is          | Identity    | If objects are the same in memory

Examples:
--------------------------------------------------------------------------------
    a = [1, 2, 3]
    b = [1, 2, 3]
    c = a

    print(a == b)   # True (same values)
    print(a is b)   # False (different objects)
    print(a is c)   # True (same object)


===============================================================================
47. DATACLASSES
===============================================================================

The @dataclass decorator automatically generates __init__, __repr__, and __eq__.

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
    Frozen instances    | @dataclass(frozen=True) for immutability


===============================================================================
48. FIELDS IN DATACLASSES
===============================================================================

The field() function provides fine-grained control over dataclass fields.

Examples:
--------------------------------------------------------------------------------
    from dataclasses import dataclass, field

    @dataclass
    class ShoppingList:
        items: list = field(default_factory=list)  # New list per instance
        total: float = field(init=False)           # Computed field
        password: str = field(repr=False)          # Hide from repr


===============================================================================
49. __POST_INIT__ METHOD
===============================================================================

The __post_init__ method runs after __init__ for validation and computed fields.

Example:
--------------------------------------------------------------------------------
    @dataclass
    class Rectangle:
        length: float
        width: float
        area: float = field(init=False)

        def __post_init__(self):
            self.area = self.length * self.width

Important Note:
--------------------------------------------------------------------------------
    __post_init__ runs only ONCE at object creation.
    Changing fields later does NOT trigger __post_init__ again.


===============================================================================
50. @CACHED_PROPERTY
===============================================================================

The @cached_property decorator caches the result of an expensive property.

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
51. MONKEY PATCHING
===============================================================================

Monkey patching is modifying code at runtime without altering the original.

Example:
--------------------------------------------------------------------------------
    class WeatherAPI:
        def get_weather(self):
            return "Real weather data"

    def mock_get_weather(self):
        return "Mock weather data"

    # Monkey patch
    WeatherAPI.get_weather = mock_get_weather

Caution: Use sparingly. Prefer unittest.mock for testing.


===============================================================================
52. TIMING CODE WITH TIMEIT
===============================================================================

The timeit module benchmarks small code snippets.

Basic Usage:
--------------------------------------------------------------------------------
    from timeit import timeit

    time = timeit("[x for x in range(1000)]", number=10000)

Example:
--------------------------------------------------------------------------------
    list_time = timeit("[x for x in range(1000)]", number=100000)
    set_time = timeit("{x for x in range(1000)}", number=100000)


===============================================================================
53. FILE HANDLING (WRITING)
===============================================================================

Writing to files using different modes.

File Modes:
--------------------------------------------------------------------------------
    Mode    | Description
    --------|--------------------------------------------------------------
    'w'     | Write - overwrites existing content
    'a'     | Append - adds to end of file
    'x'     | Exclusive creation - fails if file exists

Examples:
--------------------------------------------------------------------------------
    # Write a single line
    with open('file.txt', 'w') as f:
        f.write("Hello, World!\n")

    # Write multiple lines
    lines = ["Line 1\n", "Line 2\n", "Line 3\n"]
    with open('file.txt', 'w') as f:
        f.writelines(lines)


===============================================================================
54. JSON IN PYTHON
===============================================================================

JSON (JavaScript Object Notation) is a lightweight data interchange format.

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
QUICK REFERENCE
===============================================================================

OOP Quick Reference:
--------------------------------------------------------------------------------
    Concept                 | Syntax
    ------------------------|------------------------------------------
    Class definition        | class ClassName:
    Constructor             | def __init__(self, param):
    Instance method         | def method(self):
    Class method            | @classmethod def method(cls):
    Static method           | @staticmethod def method():
    Abstract method         | @abstractmethod def method():
    Inheritance             | class Child(Parent):
    Call parent             | super().__init__()
    Name mangling           | __attribute (becomes _Class__attribute)

Control & Flow Quick Reference:
--------------------------------------------------------------------------------
    Concept                 | Syntax
    ------------------------|------------------------------------------
    If statement            | if condition:
    If-else                 | if condition: else:
    If-elif-else            | if cond1: elif cond2: else:
    Ternary operator        | value_if_true if condition else value_if_false
    For loop                | for item in iterable:
    While loop              | while condition:
    Break                   | break
    Continue                | continue
    Range                   | range(start, stop, step)

Exception Handling Quick Reference:
--------------------------------------------------------------------------------
    Concept                 | Syntax
    ------------------------|------------------------------------------
    Basic try/except        | try: risky() except: handle()
    Specific exception      | except ValueError as e:
    Try-except-else         | try: ... except: ... else: ...
    Try-except-finally      | try: ... except: ... finally: ...
    Raise exception         | raise ValueError("message")

===============================================================================
                        END OF DOCUMENTATION
===============================================================================
EOF
