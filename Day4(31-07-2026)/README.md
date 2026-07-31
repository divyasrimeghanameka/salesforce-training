# 🚀 Salesforce Interview Readiness Bootcamp – Day 4
## Your First Lightning Web Component (LWC)

---

# 📌 Overview

Day 4 focused on building the frontend of the Placement Management System using Lightning Web Components (LWC). Until now, I worked mainly with backend concepts such as Data Model, SOQL, Apex Triggers, and Automation. This session helped me understand how Salesforce users interact with the application through the UI.

---

# 🎯 Learning Objectives

- Understand Lightning Web Components (LWC)
- Create and deploy an LWC
- Learn data binding and event handling
- Build a simple Placement Management dashboard
- Understand how LWC communicates with Apex

---

# 🏗 Salesforce Architecture

```
User
   │
   ▼
Lightning Web Component
   │
   ▼
Apex
   │
   ▼
SOQL
   │
   ▼
Salesforce Database
```

The user interacts with the Lightning Web Component, which communicates with Apex. Apex retrieves data using SOQL from the Salesforce database.

---

# 💡 Think Before Coding

### Why do users need a graphical interface?

A graphical interface makes the application easy to use. Users can perform actions without writing queries or code.

### Why can't users execute SOQL directly?

SOQL is used to access Salesforce data and should be executed only through Apex for security and business logic.

### Why is JavaScript required?

JavaScript adds functionality such as variables, button clicks, dynamic updates, and communication with Apex.

### What are the responsibilities of the UI?

The UI displays information, accepts user input, and handles user interactions.

### What are the responsibilities of Apex?

Apex performs business logic, executes SOQL, validates data, and communicates with the database.

---

# ⚡ What is Lightning Web Components (LWC)?

Lightning Web Components (LWC) is Salesforce's modern UI framework built using HTML, JavaScript, and CSS. It is used to create reusable, responsive, and interactive user interfaces.

---

# ❓ Why did Salesforce introduce LWC?

Salesforce introduced LWC to provide a faster and simpler framework based on web standards. It improves performance and makes UI development easier.

---

# 🔄 Difference Between LWC and Aura

| LWC | Aura |
|-----|------|
| Modern framework | Older framework |
| Uses HTML, CSS, JavaScript | Uses Aura syntax |
| Better performance | Comparatively slower |
| Recommended for new projects | Mainly used in legacy projects |

---

# 📂 LWC File Structure

### placementHome.html

Contains the page layout, text, buttons, and Lightning components.

### placementHome.js

Contains JavaScript logic, variables, and event handling.

### placementHome.js-meta.xml

Makes the component available in Lightning App Builder.

### placementHome.css

Adds custom styling and improves the appearance of the component.

---

# 🛠 Hands-on Activities

## Activity 1

Created an LWC named **placementHome** and displayed **Welcome to Vishnu Placement Portal** on a Lightning Page.

## Activity 2

Displayed Student Name, Roll Number, and Department using JavaScript variables and observed data binding.

## Activity 3

Created a **Show Welcome Message** button that displays a welcome message using JavaScript.

## Activity 4

Implemented an **Apply** button that changes the application status from **Not Applied** to **Applied**.

---

# 📊 Mini Project

Built the first screen of the Placement Management System. The dashboard displays today's date, welcome message, companies, jobs, and applications using hard-coded values.

---

# 🔄 Understanding Data Binding

Data binding connects JavaScript variables with HTML. Whenever a variable changes, the updated value is automatically displayed on the screen.

---

# 💬 Interview Questions

### What is LWC?

LWC is Salesforce's modern framework used to build fast and reusable user interfaces using HTML, JavaScript, and CSS.

### Why LWC instead of Aura?

LWC is faster, simpler, and based on standard web technologies, making it the preferred framework.

### Can LWC execute SOQL directly?

No. LWC communicates with Apex, and Apex executes SOQL queries.

### Why does LWC need Apex?

Apex is required to retrieve Salesforce data, execute business logic, and perform DML operations.

### Where is the component deployed?

The component is deployed using Lightning App Builder on Home Pages, App Pages, or Record Pages.

---

# ⭐ Bonus Challenge

Enhanced the Placement Portal by adding an institute logo, welcome banner, and four dashboard cards for Students, Companies, Jobs, and Applications. Used only LWC, HTML, JavaScript, and CSS without Apex.

---

# 🛠 Technologies Used

- Salesforce
- Lightning Web Components
- HTML
- JavaScript
- CSS
- VS Code
- Salesforce CLI
- Lightning App Builder

---

# 📁 Project Structure

```
PlacementManagement
│
├── force-app
│   └── main
│       └── default
│           └── lwc
│               └── placementHome
├── Screenshots
└── README.md
```

---

# 📸 Screenshots

The Screenshots folder contains images of the LWC creation, deployment, student details, button actions, dashboard, and final Placement Portal UI.

---

# 📖 What I Learned

Today, I learned how to create and deploy my first Lightning Web Component. I understood LWC architecture, file structure, data binding, event handling, and how the UI connects with Apex for future data integration.

---

# ✅ Conclusion

Day 4 helped me understand Salesforce frontend development using Lightning Web Components. It provided a strong foundation for building interactive applications and prepared me to integrate LWC with Apex in upcoming sessions.
