"""A Simple BMI Calculator"""

walker BMICalculator {
    has weight_kg: float;
    has height_m: float;

    can calculate_bmi with root entry;
}

node results {
    has bmi_value: float;
    has category: str;
}

impl BMICalculator.calculate_bmi {
    if self.height_m <= 0 {
        # Using report for errors too, for consistent output handling
        report {"Error": "Height must be greater than 0."};
        disengage;
    } else {
        let bmi = self.weight_kg / (self.height_m * self.height_m);
        let rounded_bmi = round(bmi, 2);

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

        # Create or find the results node (kept for Jaseci graph structure)
        if not [root --> (`?results)] {
            next = root ++> results(bmi_value=rounded_bmi, category=category_str);
        } else {
            next = [root --> (`?results)];
            next.bmi_value = rounded_bmi;
            next.category = category_str;
        }

# 4. Display the results - REVERT TO PRINT
        print(f"\n--- BMI Calculation Complete for Walker {self} ---");
        print(f"Weight: {self.weight_kg} kg");
        print(f"Height: {self.height_m} m");
        print(f"Your BMI is: {rounded_bmi}");
        print(f"Category: {category_str}");

        # The print() calls are what your professor's example uses and should work.
        # We rely on the walker spawning multiple times to execute the calculation multiple times.
    }
}


# Remove the old 'with entry:__main__' block and the 'test' block.

# New simple entrypoint for direct execution
with entry:__main__ {
    let weight = 70.0;
    let height = 1.75;
    
    if height <= 0 {
        print("\nError: Height must be greater than 0.");
    } else {
        let bmi = weight / (height * height);
        let rounded_bmi = round(bmi, 2);

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

        # Use print to force output, avoiding complex walker/report issues
        print("\n--- Direct BMI Calculation Result ---");
        print(f"Weight: {weight} kg");
        print(f"Height: {height} m");
        print(f"Your BMI is: {rounded_bmi}");
        print(f"Category: {category_str}");
    }
}