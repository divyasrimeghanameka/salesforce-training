# Salesforce Day-3
## Placement Management System

## Part 1 – Interview Warm-up

### 1. What is a Validation Rule?

A Validation Rule is used to check whether the entered data is valid. If the data is not valid, Salesforce shows an error message and does not save the record.

---

### 2. What is a Flow?

A Flow is a Salesforce automation tool that performs actions automatically without writing code.

---

### 3. What is an Apex Trigger?

An Apex Trigger is code that runs before or after a record is created, updated, deleted, or restored.

---

### 4. When would you choose a Flow instead of a Trigger?

I choose Flow when the requirement can be completed without coding, such as updating fields, sending emails, or creating related records.

---

### 5. Can a Validation Rule update another field? Why or why not?

No. A Validation Rule only checks data and prevents invalid records from being saved. It cannot update any field.

---

### 6. Which executes first: Validation Rule, Flow, or Trigger?

The general order is:

1. Before-Save Flow
2. Before Trigger
3. Validation Rules
4. After Trigger
5. After-Save Flow

---

### 7. What is a Record-Triggered Flow?

A Record-Triggered Flow automatically runs when a record is created, updated, or deleted.

---

# Part 2 – Business Scenario

## Requirement 1

**Requirement:** Whenever a student submits an application, an email should be sent to the Placement Officer.

**Solution:** Record-Triggered Flow

**Reason:** Flow provides a built-in Email Action that automatically sends emails.

---

## Requirement 2

**Requirement:** Automatically populate the Application Date.

**Solution:** Record-Triggered Flow

**Reason:** Flow can automatically update fields when a record is created.

---

## Requirement 3

**Requirement:** Prevent duplicate applications.

**Solution:** Validation Rule

**Reason:** Validation Rules stop duplicate records from being saved.

---

## Requirement 4

**Requirement:** Reject applications with low CGPA.

**Solution:** Validation Rule

**Reason:** It validates whether the student's CGPA meets the required minimum.

---

## Requirement 5

**Requirement:** Create an Offer Letter record when Status becomes **Selected**.

**Solution:** Record-Triggered Flow

**Reason:** Flow can automatically create related records.

---

# Part 3 – Design Challenge

| Requirement | Solution | Reason |
|--------------|----------|--------|
| Reject duplicate applications | Validation Rule | Prevents duplicate records from being saved |
| Auto-fill Application Date | Record-Triggered Flow | Automatically updates the field |
| Send Email | Record-Triggered Flow | Uses the built-in Email Action |
| Reject Low CGPA | Validation Rule | Ensures eligibility criteria |
| Create Offer Letter Record | Record-Triggered Flow | Automatically creates a related record |

---

# Part 4 – Hands-on Assignment

## Record-Triggered Flow

The Record-Triggered Flow performs the following tasks:

- Automatically sets the Application Date.
- Sends an email notification to the Placement Officer.
- Creates an Offer Letter record when the student's status becomes **Selected**.
- Successfully completes the automation process.


---

# Part 5 – Validation Rule Challenge

## 1. CGPA Validation Rule

**Purpose**

Ensures that the student's CGPA is greater than or equal to the minimum CGPA required for the job.

**Formula**

```text
Student_CGPA__c < Job__r.Minimum_CGPA__c
```

---

## 2. Closing Date Validation Rule

**Purpose**

Prevents users from entering an Application Date after the Job Closing Date.

**Formula**

```text
Application_Date__c > Job__r.Closing_Date__c
```

---

## 3. Mandatory Field Validation Rule

**Purpose**

Ensures that mandatory fields cannot be left blank.

**Formula**

```text
ISBLANK(Student__c)
```

---

# Part 6 – Trigger vs Flow Debate

## 1. Update a field automatically

**Answer:** Record-Triggered Flow

**Reason:** No coding is required.

---

## 2. Create a related record

**Answer:** Record-Triggered Flow

**Reason:** Easy to configure and maintain.

---

## 3. Send an email notification

**Answer:** Record-Triggered Flow

**Reason:** Salesforce provides a built-in Email Action.

---

## 4. Call an External REST API

**Answer:** Apex Trigger

**Reason:** External API integration requires Apex code.

---

## 5. Perform complex calculations involving multiple objects

**Answer:** Apex Trigger

**Reason:** Apex is suitable for complex business logic.

---

## 6. Process 10,000 imported records

**Answer:** Apex Trigger

**Reason:** Apex provides better performance and bulk processing support.

---

# Part 7 – Mini Project Enhancement

The Placement Management System includes the following automation:

- Record-Triggered Flow for automatically setting the Application Date.
- Validation Rules for maintaining data quality.
- Automatic email notification to the Placement Officer.
- Automatic creation of an Offer Letter record when the student's status becomes **Selected**.

---

# Part 8 – Debugging Challenge

## 1. What problem might occur?

If the Trigger, Flow, and Workflow all update the same field, they may repeatedly trigger each other, causing automation conflicts.

---

## 2. Could automation repeatedly execute?

Yes.

This may create an infinite loop where the same automation keeps running multiple times.

---

## 3. How would you redesign this solution?

I would:

- Use Flow wherever possible.
- Avoid multiple automations updating the same field.
- Use Apex only when declarative tools cannot solve the requirement.
- Design automation carefully to prevent recursion.

---

# Part 9 – Interview Questions

## 1. What is the difference between Workflow, Process Builder, and Flow?

| Tool | Description |
|------|-------------|
| Workflow | Basic automation tool with limited features. |
| Process Builder | More advanced than Workflow but now retired. |
| Flow | The most powerful declarative automation tool recommended by Salesforce. |

---

## 2. Why is Flow replacing Workflow Rules?

Flow supports more features, complex logic, better flexibility, and future Salesforce enhancements.

---

## 3. What is a Record-Triggered Flow?

A Record-Triggered Flow automatically runs whenever a record is created, updated, or deleted.

---

## 4. What are Before-Save and After-Save Flows?

### Before-Save Flow

- Runs before the record is saved.
- Mainly used for updating fields.
- Faster than After-Save Flow.

### After-Save Flow

- Runs after the record is saved.
- Used for creating records, sending emails, and other actions.

---

## 5. When should Apex be preferred over Flow?

Use Apex when:

- Complex business logic is required.
- External API integration is needed.
- Large-scale data processing is required.
- Flow cannot meet the business requirement.

---

## 6. Can Flow call Apex?

Yes.

Flow can call Apex methods using Apex Actions.

---

## 7. What are the advantages of declarative automation?

- No coding required.
- Faster development.
- Easy maintenance.
- Better readability.
- Recommended by Salesforce.

---

## 8. Explain one Flow that you built.

I built a Record-Triggered Flow that automatically sets the Application Date, sends an email notification to the Placement Officer, and creates an Offer Letter when the student's status changes to **Selected**.

---

## 9. Explain one Validation Rule that you created.

I created a Validation Rule to ensure that a student's CGPA is greater than or equal to the minimum CGPA required for the job. If the CGPA is below the required value, Salesforce displays an error message and prevents the record from being saved.

---

## 10. If given the choice, why did you use Flow instead of Apex?

I used Flow because it is a no-code solution, easy to build, easy to maintain, and recommended by Salesforce for standard business automation.

---

# Part 10 – Bonus Challenge

## 1. Would you use Validation Rules, Flow, Trigger, or a combination?

I would use a combination of Validation Rules, Record-Triggered Flows, and Apex where required.

---

## 2. Which solution would scale best?

A combination of Flow and Apex provides the best scalability for enterprise applications.

---

## 3. What performance issues should you consider?

- Bulk record processing
- Governor Limits
- Avoid unnecessary SOQL and DML operations
- Prevent recursive automation
- Optimize Flow design

---

## 4. If you had to redesign the complete automation for enterprise scale, what would your architecture look like?

- Validation Rules for maintaining data quality.
- Record-Triggered Flows for standard automation.
- Apex for complex business logic and API integrations.
- Bulk-safe design to handle large volumes of records.
- Proper error handling and logging.

---

# Conclusion

This assignment helped me understand the differences between Validation Rules, Record-Triggered Flows, and Apex Triggers. I learned how to choose the appropriate automation tool based on business requirements and how to build efficient, maintainable Salesforce automation using declarative features whenever possible.
