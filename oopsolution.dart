import 'dart:io';

// ==================== PERSON CLASS ====================

class Person {
  String _name;
  int _age;

  Person(this._name, this._age);

  // Getters
  String get name => _name;
  int get age => _age;

  // Setter for age with validation
  set age(int value) {
    if (value < 0) {
      print('Age cannot be negative. Keeping previous age: $_age');
    } else {
      _age = value;
    }
  }

  // Introduce the person
  String introduce() {
    return "Hi, I'm $_name, $_age years old.";
  }
}

// ==================== STUDENT CLASS ====================

class Student extends Person {
  String _course;

  Student(String name, int age, this._course) : super(name, age);

  // Getter
  String get course => _course;

  @override
  String introduce() {
    return "Hi, I'm $_name, $_age years old, studying $_course.";
  }
}

// ==================== TEACHER CLASS ====================

class Teacher extends Person {
  String _subject;

  Teacher(String name, int age, this._subject) : super(name, age);

  // Getter
  String get subject => _subject;

  @override
  String introduce() {
    return "Hi, I'm $_name, $_age years old, teaching $_subject.";
  }
}

// ==================== SCHOOL CLASS ====================

class School {
  final List<Person> _people = [];

  // Add a person to the school
  void addPerson(Person p) {
    _people.add(p);
  }

  // Display all people
  void introduceAll() {
    for (var person in _people) {
      print(person.introduce());
    }
  }
}

// ==================== INPUT VALIDATION ====================

// Read non-empty text
String readNonEmptyText(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();

    if (input != null && input.trim().isNotEmpty) {
      return input.trim();
    }

    print('This field cannot be empty. Please try again.');
  }
}

// Read a valid age
int readValidAge(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    int? value = int.tryParse(input ?? '');

    if (value == null) {
      print('Please enter a valid whole number.');
    } else if (value < 0) {
      print('Age cannot be negative. Please try again.');
    } else {
      return value;
    }
  }
}

// Read a valid count
int readValidCount(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    int? value = int.tryParse(input ?? '');

    if (value == null || value < 0) {
      print('Please enter a valid whole number (0 or more).');
    } else {
      return value;
    }
  }
}

// ==================== MAIN FUNCTION ====================

void main() {
  print('=== School Personnel Management ===');

  School school = School();

  // Add students
  int studentCount =
      readValidCount('How many students will you add? ');

  for (int i = 1; i <= studentCount; i++) {
    print('-- Student #$i --');

    String name = readNonEmptyText('Name: ');
    int age = readValidAge('Age: ');
    String course = readNonEmptyText('Course: ');

    school.addPerson(Student(name, age, course));
  }

  // Add teachers
  int teacherCount =
      readValidCount('How many teachers will you add? ');

  for (int i = 1; i <= teacherCount; i++) {
    print('-- Teacher #$i --');

    String name = readNonEmptyText('Name: ');
    int age = readValidAge('Age: ');
    String subject = readNonEmptyText('Subject: ');

    school.addPerson(Teacher(name, age, subject));
  }

  // Display school roster
  print('\n=== School Roster ===');
  school.introduceAll();
}