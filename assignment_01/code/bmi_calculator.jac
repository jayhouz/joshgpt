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

        # **CRITICAL CHANGE: Use a report block to structure the output**
        # This is the standard way to return data that the CLI will display.
        report {
            "title": "BMI Calculation Result",
            "Inputs": {
                "Weight": f"{self.weight_kg} kg",
                "Height": f"{self.height_m} m"
            },
            "BMI": next.bmi_value,
            "Category": next.category
        };
    }
}


# --- EXECUTION / TESTING ---

# For reliable output, we can use a test block to execute the walker directly.
test simple_bmi_runs {
    # Test 1: Normal Weight (70 kg, 1.75 m -> BMI 22.86)
    root spawn BMICalculator(weight_kg=70.0, height_m=1.75);

    # Test 2: Overweight (85 kg, 1.80 m -> BMI 26.23)
    root spawn BMICalculator(weight_kg=85.0, height_m=1.80);
}

# Remove the 'with entry:__main__' block if you use the 'jac test' command
# If you keep 'with entry:__main__', it's best to run the walker directly.
with entry:__main__ {
    root spawn BMICalculator(weight_kg=70.0, height_m=1.75);
    root spawn BMICalculator(weight_kg=85.0, height_m=1.80);
}