node Student {
    has name: str;
    has grade_level: int;
}

walker AttendanceChecker {
    has present_students: list[str] = [];
    has absent_students: list[str] = [];
    has max_checks: int = 5;
    has checks_done: int = 0;

    can check_attendance with Student entry {
        self.checks_done += 1;

        # Simulate checking if student is present (random for demo)
        import random;
        is_present = random.choice([True, False]);

        if is_present {
            print(f"{here.name} is present");
            self.present_students.append(here.name);
        } else {
            print(f"{here.name} is absent");
            self.absent_students.append(here.name);
        }

        # Control flow based on conditions
        if self.checks_done >= self.max_checks {
            print(f"Reached maximum checks ({self.max_checks})");
            self.report_final();
            disengage;  # Stop the walker
        }

        # Skip if no more connections
        connections = [-->];
        if not connections {
            print("No more students to check");
            self.report_final();
            disengage;
        }

        # Continue to next student
        visit [-->];
    }

    def report_final() -> None {
        print(f" Attendance Report:");
        print(f"   Present: {self.present_students}");
        print(f"   Absent: {self.absent_students}");
        print(f"   Total checked: {self.checks_done}");
    }
}

with entry {
    # Create a chain of students
    alice = root ++> Student(name="Alice", grade_level=9);
    bob = alice ++> Student(name="Bob", grade_level=9);
    charlie = bob ++> Student(name="Charlie", grade_level=9);
    diana = charlie ++> Student(name="Diana", grade_level=9);
    eve = diana ++> Student(name="Eve", grade_level=9);

    # Start attendance check
    checker = AttendanceChecker(max_checks=3);
    alice[0] spawn checker;
}