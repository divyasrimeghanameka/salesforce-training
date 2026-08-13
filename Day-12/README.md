# Day 12 – Git, Salesforce CLI & Deployment

## 📌 Tasks Completed

### 1. Git & GitHub

- Created and organized the Placement Management Salesforce project in GitHub.
- Practiced `clone`, `add`, `commit`, `push` and `pull`.
- Used feature branches and understood Pull Requests and code review.
- Learned how to resolve Git merge conflicts safely.

### 2. Salesforce CLI

- Connected Salesforce Org with Salesforce CLI using `sf`.
- Used org aliases to identify different environments.
- Retrieved Salesforce metadata into the local project.
- Deployed metadata from the local project to a Salesforce Org.

### 3. Salesforce Metadata

Learned that Salesforce Objects, Fields, Apex, Triggers, Flows and LWC are represented as metadata and can be stored in Git.

### 4. Deployment & Environments

Learned the purpose of:

- **Sandbox** – Separate environment for development and testing.
- **Scratch Org** – Temporary, source-driven Salesforce environment.
- **Changesets** – Salesforce-native method for moving metadata between related orgs.
- **Metadata API** – Programmatic mechanism for retrieving and deploying metadata.

### 5. Deployment Workflow

```text
Feature Branch
     ↓
Commit & Push
     ↓
Pull Request
     ↓
Code Review
     ↓
Test
     ↓
Deploy
     ↓
Verify
```
🎤 Important Interview Questions & Answers

### 1. Why is Git important in Salesforce?

Git provides version control, tracks changes, supports collaboration and maintains the history of Salesforce source code and metadata.

### 2. What is the difference between commit and push?

**Commit** saves changes in the local repository.  
**Push** sends those committed changes to the remote repository such as GitHub.

### 3. What is Salesforce CLI?

Salesforce CLI is a command-line tool used to authenticate Salesforce orgs, retrieve and deploy metadata, run tests and manage Salesforce development.

### 4. What is Salesforce Metadata?

Metadata describes the structure and configuration of a Salesforce application, such as Objects, Fields, Apex, Triggers, Flows and LWC.

### 5. What is a Sandbox?

A Sandbox is a separate Salesforce environment used for development and testing without directly changing Production.

### 6. What is a Scratch Org?

A Scratch Org is a temporary, source-driven Salesforce environment used for development and testing.

### 7. What is a Changeset?

A Changeset is a Salesforce-native mechanism used to move metadata between related Salesforce orgs, commonly in Sandbox-based development.

### 8. What is the Metadata API?

The Metadata API provides programmatic mechanisms to retrieve and deploy Salesforce metadata.

### 9. What is a Git merge conflict?

A merge conflict occurs when Git cannot automatically decide between changes made by different developers. The developer must review the changes and resolve the conflict manually.

### 10. Why should we verify the target Org before deployment?

We should verify the target Org to make sure we are deploying to the correct environment and do not accidentally deploy changes to Production.

### 11. Why can a deployment fail even if the Apex code is correct?

A deployment can fail because the Apex code may depend on other metadata such as Objects, Fields, Classes, Permissions or configuration that is missing in the target Org.

### 12. What is the basic Salesforce deployment flow?

```text
Build → Test → Validate → Deploy → Verify
