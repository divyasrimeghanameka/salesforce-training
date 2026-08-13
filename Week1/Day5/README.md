# Day 5 – Introduction to Apex

## What is Apex?
Apex is a server-side programming language in Salesforce used to create custom business logic and automation.

It follows object-oriented programming concepts and has syntax similar to Java.

---

## Why Do We Use Apex?
Apex becomes useful when:

- Business logic is too complex for Flow
- Multiple objects must work together
- Huge amounts of data need processing
- Integration with external systems or APIs is required
- Advanced calculations or validations are needed

---

## Flow vs Apex

| Feature | Flow | Apex |
|---|---|---|
| Type | Declarative (No-code) | Programmatic (Code-based) |
| Difficulty | Beginner friendly | Requires coding knowledge |
| Flexibility | Limited | Very flexible |
| Performance | Moderate | Better for heavy processing |
| Handles Complexity | Simple to medium | Medium to advanced |
| Mainly Used By | Admins | Developers |

---

## Configuration vs Apex Coding

| Feature | Configuration | Apex Coding |
|---|---|---|
| Method | Point-and-click setup | Writing code |
| Skills Needed | Admin knowledge | Programming skills |
| Flexibility | Restricted | Highly customizable |
| Development Time | Quick to build | Takes more time |
| Maintenance | Easier | Needs developer support |

---

## Practical Uses of Apex

- Scholarship or fee calculation systems
- Online payment integrations
- Advanced student eligibility checks
- Automated approval processes
- Third-party API connections

---

# College Management System Example

## Custom Objects
- `Student__c`
- `Course__c`
- `Faculty__c`
- `Enrollment__c`

---

## Relationships
- Student ↔ Course → Many-to-Many relationship
- Faculty → Course → Lookup relationship

---

## Validation Rules
- Student email should not be empty
- Age must be 17 or above
- Available seats cannot be less than zero

---

## Flow Automation Examples
- Send confirmation email after enrollment
- Notify faculty when seats become full
- Auto-update enrollment status

---

## Apex Usage Examples
- Complex business logic
- Processing bulk student records
- Integrating external APIs
- Custom validation and automation

---

## Situations Where Flow Is Not Sufficient
- Complicated calculations
- Real-time external integrations
- Handling thousands of records
- Advanced conditional logic

---

## Simple Pseudocode Examples

```text
IF seats <= 0 THEN stop enrollment

IF attendance percentage < 75 THEN send warning message

IF marks >= 90 THEN provide scholarship discount
```

---

# Reflection
- Apex is powerful for handling advanced requirements
- Flow is useful for simpler automation tasks
- Coding provides greater customization and control
- Use Apex only when declarative tools are not enough

---

# Modules Completed

- Apex & .NET Basics
- Apex Basics and Database
