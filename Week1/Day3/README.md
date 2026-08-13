#  Day 3 - Data Modeling and Business Logic

##  Understanding Core Salesforce Concepts

### App
An App is a collection of related tabs, objects, and tools used for a specific purpose in an organization.

### Object
An Object is a storage structure in Salesforce that keeps similar types of data together.

#### Examples
- Student
- Lecturer
- Semester

### Record
A Record is a single entry stored inside an object.

#### Example
- Student Name: Anjali Reddy

### Field
A Field stores one specific detail about a record.

#### Examples
- Roll Number
- Department Name
- Student Email

---

#  Standard Objects vs Custom Objects

## Standard Objects
These are built-in Salesforce objects available by default.

### Examples
- Account
- Contact
- Lead

## Custom Objects
These are user-created objects designed according to business or college requirements.

### Examples
- Student
- Subject
- Attendance
- Examination

---

#  College Management System Data Structure

## Objects Used
- Student
- Lecturer
- Subject
- Department

## Relationships Between Objects
- Department connected to Lecturer
- Department connected to Subject
- Subject connected to Student

## Relationship Type
Lookup Relationships are used to connect related records while allowing each object to work independently.

---

#  Formula Fields

## 1. Student Full Name
Automatically joins first name and last name into one field.

## 2. Internal Marks Percentage
Calculates percentage based on marks obtained.

## 3. Remaining Classroom Capacity
Displays available seats after student admissions.

---

#  Importance of Formula Fields

Formula fields are useful because they:
- Perform automatic calculations
- Reduce manual calculations
- Improve consistency
- Save time for users

---

#  Validation Rules

## 1. Student Phone Number Cannot Be Blank
Ensures important contact details are entered.

## 2. Attendance Percentage Cannot Exceed 100
Prevents invalid attendance values.

## 3. Exam Marks Cannot Be Negative
Stops users from entering incorrect marks.

---

#  Why Validation Rules Are Important

Validation rules help organizations:
- Maintain accurate records
- Prevent wrong data entry
- Improve system quality
- Enforce business standards

---

#  Reflection

Educational institutions manage large amounts of student and academic data every day. Using structured systems instead of spreadsheets helps maintain better organization and accuracy.

Salesforce helps colleges:
- Store data securely
- Connect related information
- Generate reports easily
- Reduce duplicate entries
- Improve overall management processes

---

#  Trailhead Modules Completed

- Data Modeling
- Formulas and Validations
