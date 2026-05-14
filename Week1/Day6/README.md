# Day 6 – SOQL and Apex Triggers

## 1. Introduction to SOQL
SOQL stands for Salesforce Object Query Language. It is used to fetch records from Salesforce objects and works similarly to SQL.

SOQL is mainly used for retrieving data from the Salesforce database.

### Example
```sql
SELECT Name FROM Student__c
```

👉 This query retrieves student names from the `Student__c` object.

---

## 2. What is an Apex Trigger?
An Apex Trigger is automated Apex code that executes when records are inserted, updated, deleted, or undeleted in Salesforce.

Triggers help automate business processes without manual intervention.

### Example
When a new student record is created, the system automatically sends a welcome email.

---

# 3. Difference Between Flow and Apex Trigger

| Feature | Flow | Apex Trigger |
|---|---|---|
| Development Type | No-code / Low-code | Code-based |
| Usage | Simple automation | Advanced automation |
| User Interface | Drag-and-drop | Written in Apex |
| Flexibility | Moderate | Very high |
| Maintenance | Easier | Requires developers |
| Performance | Good for simple tasks | Better for complex operations |
| Best Suitable For | Notifications & updates | Complex business logic |

---

# 4. Before Trigger vs After Trigger

| Feature | Before Trigger | After Trigger |
|---|---|---|
| Execution Time | Before record save | After record save |
| Main Purpose | Validate or modify data | Work with stored data |
| Record ID Availability | Not available | Available |
| Common Usage | Updating field values | Sending emails or updating related records |

---

# 5. Trigger Use Cases in College Management System

- Student admission completed → Send greeting email
- Course reaches maximum limit → Alert faculty
- Attendance below 75% → Generate warning notification
- Fee payment completed → Change payment status
- Exam marks updated → Automatically assign grade

👉 All these actions occur automatically whenever records are modified.

---

# 6. Sample Query Requirements

- Retrieve all students enrolled in Course A
- Display students from Computer Science department
- Find students with attendance less than 75%
- Show all courses managed by a faculty member
- Retrieve students with pending fee payments
- Find highest scoring students

---

# 7. Why Enterprise Applications Use Automation

Enterprise systems automate processes because:

- They manage large volumes of records
- Manual work consumes more time
- Real-time processing is important
- Automation improves accuracy
- Reduces dependency on human effort
- Supports scalable systems

---

# 8. Reflection Questions

## 1. Why are triggers important?
Triggers automatically execute actions whenever data changes inside the system.

---

## 2. Polling vs Event-Driven Systems

| Polling | Event-Driven |
|---|---|
| Checks continuously for updates | Reacts only when an event occurs |
| Uses more system resources | More efficient |
| Slower response | Faster response |

---

## 3. Importance of Database Queries

- Retrieve required information
- Filter and organize records
- Help in automation
- Generate reports
- Support decision-making

---

## 4. When Should Flow Be Used Instead of Triggers?

- For simple automation
- When coding is unnecessary
- Business-friendly implementations
- Notifications and field updates

---

## 5. Problems Caused by Over Automation

- Difficult debugging
- Performance reduction
- Logic conflicts
- Maintenance challenges
- Unexpected system behavior

---

## 6. Why Should Developers Carefully Design Automation?

- Prevent recursive loops
- Improve system performance
- Maintain proper business logic
- Avoid duplicate processing
- Reduce unnecessary operations

---

# 9. Practice Tasks

## Task 1 – Trigger Thinking (College Management)

| Event | Automated Action | Trigger Type |
|---|---|---|
| Student registration | Send welcome email | Insert |
| Course reaches limit | Notify faculty | Update |
| Low attendance | Send alert | Update |
| Fee completed | Update payment status | Update |
| Marks entered | Calculate grade | Update |

---

## Task 2 – Choosing Between Flow and Trigger

| Scenario | Preferred Tool | Reason |
|---|---|---|
| Email notification | Flow | Easy automation |
| Advanced fee calculation | Trigger | Requires logic |
| Related record updates | Flow / Trigger | Depends on complexity |
| Third-party API integration | Trigger | Coding required |

---

## Task 3 – Query Practice

- Find students enrolled in Course A
- Retrieve courses taught by Faculty X
- Find students with attendance below 75%
- Retrieve Computer Science students
- Find failed students
- Retrieve students with unpaid fees
- Display top rankers

---

## Modules Completed

- Apex Triggers
- Database & .NET Basics
