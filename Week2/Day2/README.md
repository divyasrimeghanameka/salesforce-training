# Day 2 – LWC Communication and Application Design

## Component Communication in LWC

Component communication enables Lightning Web Components (LWCs) to exchange information and collaborate within an application.

### Benefits

* Share information between components
* Refresh the user interface dynamically
* Respond to user actions efficiently
* Support scalable application development

## Communication Methods

### 1. Parent-to-Child Communication

A parent component sends data to a child component through public properties.

**Example:**
A Student Dashboard passes student details to a Student Information component.

### 2. Child-to-Parent Communication

A child component communicates with its parent by dispatching custom events.

**Example:**
An Attendance component informs the Dashboard when attendance records are updated.

### 3. Event-Driven Communication

Components can communicate indirectly through events without having a direct relationship.

**Example:**
A Notification component displays alerts when another component triggers an event.

---

# Dashboard Architecture

## Student Dashboard

### Components

* Header Component
* Student Profile Component
* Attendance Component
* Course Component
* Notification Component

### Interaction Flow

* Student Profile shares student details with Attendance Component.
* Attendance Component sends low-attendance alerts to Notification Component.
* Course Component displays the student's registered courses.

---

## Faculty Dashboard

### Components

* Faculty Profile Component
* Student Directory Component
* Attendance Management Component
* Course Administration Component

### Interaction Flow

* Attendance Management updates information shown in Student Directory.
* Course Administration shares course-related data with Faculty Profile.

---

## Admin Dashboard

### Components

* User Administration Component
* Department Component
* Reporting Component
* Analytics Component

### Interaction Flow

* Analytics provides data to Reporting Component.
* User Administration works together with Department Component for organizational management.

---

# Data Flow Example

## Student Registration Process

### Step 1 – User Interface

The student fills out and submits a registration form.

⬇️

### Step 2 – Validation

Salesforce verifies:

* Mandatory fields
* Correct email format
* Duplicate registration checks

⬇️

### Step 3 – Automation Flow

A Flow processes the registration request and sends a confirmation email.

⬇️

### Step 4 – Apex Logic

Apex executes additional business rules such as course allocation and enrollment updates.

⬇️

### Step 5 – Data Storage

The registration details are saved in Salesforce records.

⬇️

### Step 6 – User Notification

A success message and confirmation notification are displayed to the student.

---

# Evolution of Salesforce UI Technologies

## Visualforce

Visualforce was Salesforce's first major UI development framework.

### Challenges

* Traditional architecture
* Limited interactivity
* Greater reliance on server-side processing
* Lower performance compared to modern frameworks

---

## Aura Components

Aura introduced a richer user experience but added framework complexity.

### Challenges

* Steeper learning curve
* Additional framework overhead
* Reduced performance compared to LWC

---

## Lightning Web Components (LWC)

LWC is Salesforce's modern component-based framework built on web standards.

### Key Advantages

* High performance
* Modern JavaScript support
* Lightweight framework
* Better browser compatibility
* Easier maintenance
* Improved scalability

---

# Why Salesforce Adopted LWC

Salesforce transitioned from Visualforce and Aura to LWC because it offers:

* Faster rendering
* Better application performance
* Standards-based development
* Enhanced developer productivity
* Simpler maintenance
* Greater scalability for enterprise solutions

LWC provides a streamlined and future-ready approach to building Salesforce applications.

---

# Reflection

Modular architecture is essential for enterprise applications because:

* Large applications become easier to manage
* Components can be reused across projects
* Teams can develop independently
* Maintenance efforts are reduced
* Enhancements can be delivered faster
* Applications scale more effectively

A modular design helps reduce complexity while improving software quality.

---

# Revision Questions

### 1. Why is component communication important?

It enables components to exchange data and coordinate application behavior.

### 2. How does parent-child communication differ from event-based communication?

Parent-child communication is a direct relationship, while event-based communication allows components to interact indirectly.

### 3. What are the advantages of modular architecture?

It improves reusability, maintainability, and scalability.

### 4. Why did Salesforce introduce LWC?

To leverage modern web standards and improve application performance.

### 5. What issues arise in tightly coupled systems?

They are harder to modify, maintain, and scale.

### 6. Why is frontend architecture significant?

It enhances application organization, maintainability, and user experience.

### 7. Why should frontend and backend layers be separated?

Separation improves scalability, security, and maintainability.

### 8. Why are reusable components valuable in large applications?

They minimize duplication, reduce development effort, and accelerate delivery.

---

# Trailhead Modules Completed

* Lightning Web Components and Salesforce Data
* Communicate Between Lightning Web Components
* Visualforce Basics
* Aura Components Basics
