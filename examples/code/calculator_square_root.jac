# import the math library for the square root function
import math;

# 1. Define the Walker
# The walker holds the input (the number) and the ability (the calculation).
walker SquareRootCalculator {
    # The 'has' keyword defines the walker's attributes (its state/inputs)
    has input_num: float;

    # The 'can' keyword defines the walker's ability
    can calculate_root with root entry; 
}

# 2. Implement the Walker's Logic
impl SquareRootCalculator.calculate_root {
    # 'self' refers to the walker object itself.
    let root_val = math.sqrt(self.input_num);
    let rounded_val = round(root_val, 4);

    # The walker's final action: display the result.
    print(f"\n--- Square Root Calculation ---");
    print(f"Input Number: {self.input_num}");
    print(f"Square Root: {rounded_val}");
    # The walker ends its job here (or can "disengage" to clean up).
}

# 3. Execute the Walker
# The main block instructs the Jaseci engine to start the walker.

# with entry:__main__ {
#     # The 'root spawn' command creates a new SquareRootCalculator walker
#     # and tells it to start executing its logic from the graph's root node.
#     root spawn SquareRootCalculator(input_num=25.0);
#     root spawn SquareRootCalculator(input_num=10.0);
# }


# with entry {
#     print("=== Simple Square Root Calculator ===");
#     result = SquareRootCalculator(input_num=25.0);
#     print(f"{result}");

# }

with entry:__main__ {
    # 1. Spawn the walker. This tells the walker to run its 'root entry' ability.
    root spawn SquareRootCalculator(input_num=25.0);
    
    # 2. Spawn a second walker for another test.
    root spawn SquareRootCalculator(input_num=10.0);
    
    # Note: Since the output is done via 'print' INSIDE the walker,
    # you don't need a final print(f"{result}") here.
}