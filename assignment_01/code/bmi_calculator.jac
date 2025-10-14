# BMI Application Module - No AI

# with entry {
#     print("This project aims to build a simple BMI calculator. \nEventually we plan to upgrade to incorporate AI capability for recommendation");
# }

"""A Simple BMI Calculator"""

# Define the walker that will carry the user inputs and perform the calculation
walker BMICalculator {
    # Inputs will be passed to the walker when it is spawned
    has weight_kg: float; # Weight in kilograms
    has height_m: float;  # Height in meters

    # The walker's initial entry point
    can calculate_bmi with root entry;
}

# Define a node to store and display the results
node results {
    has bmi_value: float;
    has category: str;
}

# --- WALKER IMPLEMENTATION ---

# The logic for the walker's main action
impl BMICalculator.calculate_bmi {
    # 1. Input Validation and Calculation
    if self.height_m <= 0 {
        print("Error: Height must be greater than 0.");
        disengage; # Stop the walker
    } else {
        # The BMI formula: weight (kg) / [height (m)]^2
        # Use a precision of 2 decimal places for the BMI value
        let bmi = self.weight_kg / (self.height_m * self.height_m);
        let rounded_bmi = round(bmi, 2);

        # 2. Determine the BMI category
        let category_str = "";
        if rounded_bmi < 18.5 {
            category_str = "Underweight";
        } elif rounded_bmi >= 18.5 and rounded_bmi <= 24.9 {
            category_str = "Normal weight";
        } elif rounded_bmi >= 25.0 and rounded_bmi <= 29.9 {
            category_str = "Overweight";
        } else {
            category_str = "Obesity";
        }

        # 3. Create or find the results node and store the data
        if not [root --> (`?results)] {
            # Create a new results node if one doesn't exist
            next = root ++> results(bmi_value=rounded_bmi, category=category_str);
        } else {
            # Update an existing results node
            next = [root --> (`?results)];
            next.bmi_value = rounded_bmi;
            next.category = category_str;
        }

        # 4. Display the results
        # Replace the 'print' statements with 'report' statements
        
        # We can use a single report block to output a list of results
        report {
            "title": "--- BMI Calculation Complete ---",
            "Weight": f"{self.weight_kg} kg",
            "Height": f"{self.height_m} m",
            "Your BMI is": next.bmi_value,
            "Category": next.category
        };
        
        # Note: If you want the output to be a single string for simplicity, 
        # you could also use:
        # report f"""
        # --- BMI Calculation Complete ---
        # Weight: {self.weight_kg} kg
        # Height: {self.height_m} m
        # Your BMI is: {next.bmi_value}
        # Category: {next.category}
        # """;
    }
}


# --- EXECUTION ---

with entry:__main__ {
    # Example 1: Normal Weight (70 kg, 1.75 m -> BMI 22.86)
    root spawn BMICalculator(weight_kg=70.0, height_m=1.75);

    # Example 2: Overweight (85 kg, 1.80 m -> BMI 26.23)
    root spawn BMICalculator(weight_kg=85.0, height_m=1.80);
}