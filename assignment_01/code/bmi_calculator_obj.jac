"""
BMI Calculator Module using the object (obj) structure.

This structure allows the logic to be executed reliably within the 
'with entry' block without relying on complex graph walker spawning.
"""

# 1. Define the Calculator as an Object
obj BMICalculator {
    # Attributes hold the state (inputs)
    has weight_kg: float;
    has height_m: float;

    # 2. Method to perform the core calculation
    def calculate_bmi() -> float {
        if self.height_m <= 0.0 {
            # Use 0.0 or raise an error for invalid height
            print("Error: Height must be greater than 0.");
            return 0.0;
        }
        
        let bmi = self.weight_kg / (self.height_m * self.height_m);
        return round(bmi, 2);
    }

    # 3. Method to determine the category based on the calculated BMI
    def get_category(bmi: float) -> str {
        if bmi == 0.0 {
            return "Invalid Input";
        } elif bmi < 18.5 {
            return "Underweight";
        } elif bmi <= 24.9 {
            return "Normal weight";
        } elif bmi <= 29.9 {
            return "Overweight";
        } else {
            return "Obesity";
        }
    }

    # 4. Method to format and return the complete information
    def get_report() -> str {
        let bmi_value = self.calculate_bmi();
        let category = self.get_category(bmi_value);
        
        let header = "\n--- BMI Calculation Report ---";
        let inputs = f"Weight: {self.weight_kg} kg | Height: {self.height_m} m";
        let results = f"BMI: {bmi_value} | Category: {category}";
        
        return f"{header}\n{inputs}\n{results}";
    }
}


# 5. Main Execution Block
with entry:__main__ {
    print("=== Running Object-Oriented BMI Tests ===");

    # Test 1: Normal Weight (70 kg, 1.75 m -> BMI 22.86)
    calculator_1: BMICalculator = BMICalculator(weight_kg=70.0, height_m=1.75);
    print(calculator_1.get_report());

    # Test 2: Overweight (85 kg, 1.80 m -> BMI 26.23)
    calculator_2: BMICalculator = BMICalculator(weight_kg=85.0, height_m=1.80);
    print(calculator_2.get_report());

    # Test 3: Invalid Input (Height 0)
    calculator_3: BMICalculator = BMICalculator(weight_kg=70.0, height_m=0.0);
    print(calculator_3.get_report());
}