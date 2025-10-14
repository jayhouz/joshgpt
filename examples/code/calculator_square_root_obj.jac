import math;

# 1. Define the Calculator as an Object (obj)
# An obj is a standard data structure, similar to a Python class.
obj SquareRootCalculator {
    has input_num: float;

    # The constructor is automatically created by Jac.
    # The attributes (input_num) are initialized when the object is created.
    
    # 2. Define the method (def) to perform the calculation
    # This method takes no extra arguments beyond 'self'.
    def calculate_root() -> float {
        # Check for invalid input (negative numbers)
        if self.input_num < 0.0 {
            print(f"Error: Cannot calculate square root of a negative number: {self.input_num}");
            return -1.0; # Return an error value
        }
        
        let root_val = math.sqrt(self.input_num);
        let rounded_val = round(root_val, 4);
        return rounded_val;
    }

    # 3. Define a method to get the formatted output
    def get_info() -> str {
        let result = self.calculate_root();
        
        if result == -1.0 {
            return f"Input: {self.input_num}. Result: Error.";
        } else {
            return f"Input Number: {self.input_num} | Square Root: {result}";
        }
    }
}


# 4. Main Execution Block
with entry:__main__ {
    print("\n=== Object-Oriented Square Root Calculator ===");

    # Test 1: Positive number (25.0)
    # Create the object and call its method directly.
    calculator_1: SquareRootCalculator = SquareRootCalculator(input_num=25.0);
    print(calculator_1.get_info());

    # Test 2: Another positive number (10.0)
    calculator_2: SquareRootCalculator = SquareRootCalculator(input_num=10.0);
    print(calculator_2.get_info());
    
    # Test 3: Negative number (Error case)
    calculator_3: SquareRootCalculator = SquareRootCalculator(input_num=-4.0);
    print(calculator_3.get_info()); 
}