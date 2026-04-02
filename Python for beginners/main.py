
"""print("Welcome to your simple adder")
print(30* "-")

a: str = input("Enter a value for a :")
b: str = input("Enter another value for b :")

print(30* "-")

print("The result is : ", int(a) + int(b))
"""
import time

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
"""
name: str = input('Enter a name: ')
noun_a: str = input('Enter a noun: ')
verb_a: str = input('Enter a verb: ')
number_a: str = input('Enter a number: ')
number_b: str = input('Enter another number: ')


story: str = f
----------------------------------------------------------------------
This is a story about {name}, a strong (and beautiful) {noun_a} 
loved to {verb_a}.
"""
"""
connected: bool = True

while connected:
    print("Using internet...")
    time.sleep(10)
    connected = False
print("Connection ended")

"""
"""
while True:
    user_input: str = input("You: ")

    if user_input == "Hello":
        print('Bot: Hello World!')
    else:
        print("Bot: yes, that is interesting.")

"""
"""
# Without break - else executes
for i in range(5):
    print(i, end=" ")
else:
    print("\nLoop completed normally")

# Output: 0 1 2 3 4
#         Loop completed normally

# With break - else does NOT execute
for i in range(5):
    if i == 3:
        break
    print(i, end=" ")
else:
    print("\nThis will not print")

# Output: 0 1 2
"""
import random

# Define the game moves
moves = {
    "rock": "🪨",
    "paper": "📄",
    "scissors": "✂️"
}

valid_moves = list(moves.keys())

print("Welcome to Rock, Paper, Scissors!")
print("Type 'exit' to quit the game.")
print("Let's start!")

while True:
    user_input = input("Enter rock, paper, or scissors: ").lower()

    # Check if the user wants to exit
    if user_input == "exit":
        print("Thanks for playing! Goodbye.")
        break

    # Validate user input
    if user_input not in valid_moves:
        print("Invalid input, please try again.")
        continue

    # Generate AI move
    ai_move = random.choice(valid_moves)

    # Show moves
    print(f"You chose {user_input} {moves[user_input]}")
    print(f"AI chose {ai_move} {moves[ai_move]}")

    # Determine the outcome
    if user_input == ai_move:
        print("It's a tie!")
    elif (user_input == "rock" and ai_move == "scissors") or \
         (user_input == "scissors" and ai_move == "paper") or \
         (user_input == "paper" and ai_move == "rock"):
          print("You win!")
    else:
        print("You lose!")