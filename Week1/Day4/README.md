# Day 4 - Flow Builder and Automation

## What is Flow Builder?
Flow Builder is a no-code automation tool in Salesforce used to automate different business activities and processes.

It helps organizations to:

- Minimize manual tasks  
- Increase efficiency  
- Save processing time  
- Maintain workflow consistency  

---

## Types of Flows

### Screen Flow
A Screen Flow collects input from users through interactive screens.

**Example:**  
Online student admission form where students fill in their information.

### Record-Triggered Flow
This flow runs automatically whenever a record is created, updated, or deleted.

**Example:**  
Automatically sending a welcome email after a student registers.

---

# Automation Ideas for College Management System

### 1. Automatic Confirmation Email
Send a confirmation message once student registration is completed.

### 2. Update Seat Availability
Automatically decrease available seats after admission confirmation.

### 3. Faculty Notification
Notify faculty members when a course reaches maximum capacity.

### 4. Student ID Generation
Generate a unique student ID automatically for every new admission.

### 5. Payment Due Reminder
Send reminders to students before the fee due date.

---

# Benefits of Automation

- Reduces repetitive work  
- Saves staff effort and time  
- Minimizes human errors  
- Improves operational speed  
- Ensures consistency in tasks  

---

# Flow Design Example

## Selected Automation
**Automatic Confirmation Email After Registration**

### Flow Structure

```text
Trigger:
Student Record Created
        ↓
Verify Email Field
        ↓
Decision:
Email Present?
   ↓ Yes      ↓ No
Send Email    End Flow
        ↓
Confirmation Delivered
```

---

# Manual Process vs Automated Process

## Manual Process
Staff members manually verify student registration details and send emails individually.

### Issues with Manual Process

- Takes more time  
- Chances of forgetting tasks  
- Possible human mistakes  
- Delayed communication  

---

## Automated Process
The system automatically sends a confirmation email after a student record is created.

### Advantages

- Quick response  
- More accurate  
- Reliable workflow  
- Uniform communication  

---

# Reflection

Businesses automate repetitive processes to:

- improve workflow efficiency  
- reduce operational expenses  
- avoid repetitive manual activities  
- increase employee productivity  
- maintain process consistency  

Automation helps employees focus more on important business activities instead of routine tasks.

---

# Reflective Questions

### 1. Why do organizations automate workflows?
To improve productivity, save time, and reduce manual errors.

### 2. What are the disadvantages of manual processes?
They are slower, less reliable, and more prone to mistakes.

### 3. What is the difference between Screen Flow and Record-Triggered Flow?
Screen Flow needs user interaction, while Record-Triggered Flow works automatically in the background.

### 4. Why is no-code automation important?
It enables users to build automation without coding skills.

### 5. When should automation not be used?
When decision-making or human approvals are necessary.

### 6. How does automation improve productivity and consistency?
Automation performs tasks in a standardized way and reduces manual workload.

---

# Trailhead Modules Completed

- Flow Builder Basics  
- Data and Actions in Flows  
