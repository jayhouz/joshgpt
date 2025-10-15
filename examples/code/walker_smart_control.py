"""
Smart Walker Control
Source: https://www.jac-lang.org/jac_book/chapter_10/#controlling-walker-behavior
""" 

import random

class AttendanceChecker:
    def __init__(self, max_checks: int = 5):
        self.present_students = []
        self.absent_students = []
        self.max_checks = max_checks
        self.checks_done = 0
        self.should_stop = False

    def check_student(self, student, connections):
        if self.should_stop:
            return

        self.checks_done += 1

        # Simulate checking if student is present
        is_present = random.choice([True, False])

        if is_present:
            print(f" {student.name} is present")
            self.present_students.append(student.name)
        else:
            print(f" {student.name} is absent")
            self.absent_students.append(student.name)

        # Control flow based on conditions
        if self.checks_done >= self.max_checks:
            print(f" Reached maximum checks ({self.max_checks})")
            self.report_final()
            return  # Stop checking

        # Continue to next student if available
        next_students = connections.get(student, [])
        if not next_students:
            print(" No more students to check")
            self.report_final()
            return

        # Visit next student
        for next_student in next_students:
            self.check_student(next_student, connections)

    def report_final(self):
        print(f" Attendance Report:")
        print(f"   Present: {self.present_students}")
        print(f"   Absent: {self.absent_students}")
        print(f"   Total checked: {self.checks_done}")

if __name__ == "__main__":
    # Create a chain of students
    alice = Student("Alice", 9)
    bob = Student("Bob", 9)
    charlie = Student("Charlie", 9)
    diana = Student("Diana", 9)
    eve = Student("Eve", 9)

    # Create connections (linear chain)
    connections = {
        alice: [bob],
        bob: [charlie],
        charlie: [diana],
        diana: [eve],
        eve: []
    }

    # Start attendance check
    checker = AttendanceChecker(max_checks=3)
    checker.check_student(alice, connections)