"""A Simple BMI Calculator using a Walker"""

# The walker carries the inputs and performs the logic
walker BMICalculator {
    has weight_kg: float;
    has height_m: float;

    # This is the main ability of the walker
    can calculate_bmi with root entry;
}

# The node can be used to store results in the graph (good practice)
node results {
    has bmi_value: float;
    has category: str;
}


# The implementation of the walker's ability
impl BMICalculator.calculate_bmi {
    if self.height_m <= 0 {
        print("Error: Height must be greater than 0.");
        disengage;
    } else {
        # 1. Calculate BMI
        let bmi = self.weight_kg / (self.height_m * self.height_m);
        let rounded_bmi = round(bmi, 2);

        # 2. Determine Category
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
        
        # This is where you would typically save the result to a node
        # For this simple example, we will just print the result directly.

        # 3. Print the results to the console
        print("\n--- BMI Calculation Complete (via Walker) ---");
        print(f"Weight: {self.weight_kg} kg");
        print(f"Height: {self.height_m} m");
        print(f"Your BMI is: {rounded_bmi}");
        print(f"Category: {category_str}");
    }
}

# Keep this simple entrypoint for direct testing with 'jac run'
with entry:__main__ {
    print("Main entrypoint executed. To run the walker, use 'jac enter'.");
    print("Example: jac enter bmi_calculator.jac -e BMICalculator weight_kg:=70.0 height_m:=1.75");
}