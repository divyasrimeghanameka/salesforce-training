# Sprint 11 -- Crossing the Salesforce Boundary

## Salesforce APIs, REST Integration, Named Credentials & External Systems

This README documents the concepts, architecture, tasks, implementation
flow, reliability considerations, and interview preparation covered in
**Sprint 11 -- Crossing the Salesforce Boundary** for the **Placement
Management System**.

> **Note:** This README is based on the provided Sprint 11 PDF. The PDF
> defines the tasks and expected implementation; where it describes a
> task rather than showing completed project evidence, this README
> describes it as the work to be performed/implemented rather than
> claiming an unverified deployment.

------------------------------------------------------------------------

## 1. Sprint Overview

The Placement Management System initially works completely inside
Salesforce. In this sprint, the system is extended so that Salesforce
can communicate with an **external recruitment platform**.

### Business Requirement

When a student is selected for a job:

``` text
Salesforce
   |
   | Candidate information
   v
External Recruitment System
```

The external company may also send information back to Salesforce, such
as interview results.

The main engineering idea is:

> **An integration is a business conversation between two independent
> systems, not simply an HTTP request.**

The PDF explains that APIs provide the agreed method of communication
between systems. It also emphasizes handling authentication, failures,
retries, duplicates, data ownership, and monitoring.

------------------------------------------------------------------------

# 2. Learning Outcomes

By completing this sprint, the developer should be able to:

-   Explain why Salesforce integrations are required in enterprise
    applications.
-   Understand the basic idea of an API.
-   Explain REST APIs using business scenarios.
-   Understand HTTP methods:
    -   GET
    -   POST
    -   PUT
    -   PATCH
    -   DELETE
-   Understand request and response structures.
-   Read and work with JSON.
-   Perform a basic Salesforce Apex HTTP callout.
-   Understand why callouts should be separated appropriately from
    database operations.
-   Understand Named Credentials.
-   Explain authentication at a practical level.
-   Distinguish authentication from authorization.
-   Understand Salesforce Connect and External Objects.
-   Compare point-to-point and middleware-based integration.
-   Choose synchronous or asynchronous integration based on the
    requirement.
-   Design an external recruitment integration.
-   Explain common Salesforce integration interview questions.

------------------------------------------------------------------------

# 3. Project Context -- Placement Management System

Before this sprint, the Placement Management System already contains:

-   Student profiles
-   Job management
-   Eligibility checking
-   Applications
-   Interview processing
-   Offers
-   Apex business logic
-   Triggers
-   Queueable Apex
-   Batch Apex
-   Lightning Web Components

The new requirement is to cross the Salesforce boundary and communicate
with an external recruitment platform.

### Overall Architecture

``` text
Student
   |
   v
Lightning Web Component
   |
   v
Apex Service
   |
   +----------------------+
   |                      |
   v                      v
Salesforce Database    Queueable Apex
                          |
                          v
                    Named Credential
                          |
                          v
                      REST API
                          |
                          v
                External Recruitment
                     Platform
```

------------------------------------------------------------------------

# 4. What Is an API?

**API = Application Programming Interface**

An API can be understood as a **contract for communication between
software systems**.

For example, an external recruitment system may expose:

``` http
POST /candidates
```

and expect:

``` json
{
  "name": "Ananya",
  "email": "ananya@example.com",
  "branch": "CSE",
  "cgpa": 8.4
}
```

Salesforce sends a request, the external system processes it, and the
external system returns a response.

### Simple Interview Answer

> An API is an interface or contract that allows two independent
> software systems to communicate using agreed rules for requests,
> responses, data formats, and authentication.

------------------------------------------------------------------------

# 5. REST API

REST is one of the common styles used for web API communication.

REST APIs commonly use HTTP methods.

  HTTP Method   Typical Meaning
  ------------- -----------------------------
  GET           Retrieve data
  POST          Create/process something
  PUT           Replace/update a resource
  PATCH         Partially update a resource
  DELETE        Remove a resource

### Placement Example

``` text
GET /jobs
```

Retrieve jobs.

``` text
GET /jobs/123
```

Retrieve a specific job.

``` text
POST /applications
```

Create/process an application.

``` text
PATCH /applications/123
```

Partially update an application.

------------------------------------------------------------------------

# 6. GET vs POST

### GET

Used mainly to retrieve information.

Example:

``` http
GET /jobs
```

The request asks the external system for jobs.

### POST

Used mainly to create or submit something.

Example:

``` http
POST /candidates
```

Salesforce sends candidate information to the external recruitment
system.

### Interview Answer

> GET is generally used to retrieve data, whereas POST is generally used
> to create or submit data. The HTTP method communicates the intended
> operation.

------------------------------------------------------------------------

# 7. HTTP Request Structure

A request normally contains:

``` text
REQUEST
----------------
HTTP Method
URL / Endpoint
Headers
Authentication Information
Body
```

Example:

``` text
Method: POST
Endpoint: /candidates
Content-Type: application/json
Authorization: handled through Named Credential
Body: Candidate JSON
```

------------------------------------------------------------------------

# 8. HTTP Response Structure

A response normally contains:

``` text
RESPONSE
----------------
Status Code
Headers
Body
```

The Salesforce integration must inspect the response instead of assuming
that every request succeeds.

------------------------------------------------------------------------

# 9. Important HTTP Status Codes

  Status Code   Meaning
  ------------- ------------------------------------------
  200           Successful request
  201           Resource successfully created
  204           Successful request with no response body
  400           Bad request
  401           Authentication required/failed
  403           Forbidden
  404           Resource not found
  500           Server-side error

### Important Difference

**401**

Usually investigate authentication.

**403**

Usually investigate whether the authenticated identity has sufficient
permission.

------------------------------------------------------------------------

# 10. JSON

Modern REST APIs frequently exchange data using JSON.

Example:

``` json
{
  "studentId": "STU10045",
  "name": "Ananya",
  "email": "ananya@example.com",
  "cgpa": 8.4,
  "branch": "CSE"
}
```

JSON contains:

-   Keys
-   Values
-   Objects
-   Arrays

### Example from the sprint

``` json
{
  "jobId": "JOB1007",
  "company": "KSquare",
  "role": "Salesforce Developer",
  "location": "Hyderabad",
  "eligibleBranches": [
    "CSE",
    "IT",
    "AIML"
  ],
  "minimumCgpa": 7.0
}
```

Here:

-   Job Id = `JOB1007`
-   Minimum CGPA = `7.0`
-   Eligible branches = 3
-   `eligibleBranches` is an array

------------------------------------------------------------------------

# 11. Candidate Data Sent to External System

When an application becomes **Selected**, the integration should send:

-   Student Id
-   Name
-   Email
-   Branch
-   CGPA
-   Job Id
-   Company
-   Role
-   Selection Date

Conceptual payload:

``` json
{
  "studentId": "STU10045",
  "name": "Student Name",
  "email": "student@example.com",
  "branch": "CSE",
  "cgpa": 8.5,
  "jobId": "JOB1007",
  "company": "Company Name",
  "role": "Salesforce Developer",
  "selectionDate": "2026-08-11"
}
```

The exact values depend on the actual Salesforce records and external
API contract.

------------------------------------------------------------------------

# 12. Tasks Performed / Implementation Work

The Sprint 11 PDF defines the following major implementation tasks for
the Placement Management System.

## Task 1 -- Define the API Contract

Before writing Apex, document:

-   Endpoint
-   HTTP method
-   Request JSON
-   Expected success response
-   Error responses
-   Authentication approach
-   Retry strategy
-   Idempotency strategy

### Example

``` text
Endpoint:
POST /candidates

Method:
POST

Content-Type:
application/json
```

Possible errors:

``` text
400 – Bad Request
401 – Authentication Failure
403 – Forbidden
500 – Server Error
```

------------------------------------------------------------------------

## Task 2 -- Create Candidate Sync Queueable

Create a Queueable Apex class:

``` text
CandidateSyncQueueable
```

### Responsibility

Its responsibility is to send a selected candidate to the external
recruitment system.

The PDF specifically recommends:

``` text
Application
   |
   v
Selected?
   |
   v
Queueable
   |
   v
Build Request
   |
   v
Named Credential
   |
   v
REST API
   |
   v
Process Response
```

### Why Queueable?

The external communication is secondary to the immediate Salesforce
business transaction.

The student selection should be completed in Salesforce without forcing
the user to wait for the external system.

------------------------------------------------------------------------

# 13. Task 3 -- Configure Named Credential

A **Named Credential** is used to manage the external endpoint and
authentication configuration.

Instead of putting secrets directly in Apex:

``` apex
request.setHeader(
    'Authorization',
    'Bearer abc123...'
);
```

the integration should use a Named Credential.

Conceptually:

``` text
Apex
  |
  v
Named Credential
  |
  v
Authentication
  |
  v
External API
```

### Why?

Hard-coded credentials can:

-   Leak into Git
-   Appear during code reviews
-   Be copied accidentally
-   Become difficult to rotate
-   Create security risks

------------------------------------------------------------------------

# 14. Task 4 -- Build the HTTP Request

Apex provides classes for making HTTP requests.

Basic flow:

``` text
HttpRequest
     |
     v
Configure request
     |
     v
Http
     |
     v
send()
     |
     v
HttpResponse
```

Example from the sprint:

``` apex
HttpRequest request = new HttpRequest();

request.setEndpoint(
    'callout:Recruitment_API/candidates'
);

request.setMethod('POST');

request.setHeader(
    'Content-Type',
    'application/json'
);

request.setBody(
    JSON.serialize(candidate)
);

Http http = new Http();

HttpResponse response =
    http.send(request);
```

### Meaning of Each Part

  Component        Purpose
  ---------------- -------------------------------------------------
  `HttpRequest`    Represents the request Salesforce wants to send
  Endpoint         Destination of the request
  Method           Operation being requested
  Headers          Additional information required by receiver
  Body             Data being sent
  `Http`           Performs the HTTP request
  `HttpResponse`   Contains the response from external system

------------------------------------------------------------------------

# 15. Task 5 -- Process the Response

The integration should distinguish between:

``` text
Success
Authentication Failure
Bad Request
Server Error
Unexpected Response
```

Do not simply treat every non-200 response as:

``` text
Something went wrong
```

Instead, interpret what the external system actually returned.

------------------------------------------------------------------------

# 16. Integration Status Tracking

The sprint recommends tracking integration state.

Possible field:

``` text
Integration_Status__c
```

Possible values:

``` text
Pending
Sent
Failed
Retry Required
```

The mini-project also suggests fields such as:

``` text
Integration Status
External Candidate Id
Last Integration Attempt
Integration Error
```

### Example Flow

``` text
Selected
   |
   v
Pending
   |
   v
Queueable
   |
   +----> Success ----> Sent
   |
   +----> Failure ----> Retry Required
```

This makes it possible for an administrator to identify failed
integrations.

------------------------------------------------------------------------

# 17. Handling External System Failure

Suppose:

``` text
Salesforce
    |
    v
External API
    X
Unavailable
```

The student's selection should not necessarily disappear.

There are two separate truths:

``` text
Salesforce business transaction = successful
External synchronization = failed
```

Therefore, the system can store:

``` text
Integration Status = Failed
```

or:

``` text
Integration Status = Retry Required
```

This separates the core business transaction from external
communication.

------------------------------------------------------------------------

# 18. Retry Strategy

If the external API returns:

``` text
500 Internal Server Error
```

the system should not automatically assume permanent failure.

The external service may recover.

A retry mechanism can be considered.

However, retries can cause duplicate records.

Therefore:

> **Retry + idempotency must be considered together.**

------------------------------------------------------------------------

# 19. Idempotency

Idempotency means that repeating the same logical request should not
incorrectly create multiple business results.

### Example Problem

Suppose Salesforce sends:

``` text
Candidate STU10045
```

The external system creates the candidate but Salesforce does not
receive the response because of a network problem.

Salesforce retries.

If the external system creates another candidate, there will be
duplicates.

### Possible Strategies

Use:

-   External Reference Id
-   Salesforce Application Id
-   Idempotency Key
-   Existing-record lookup
-   Synchronization status

A unique business identifier should be selected.

------------------------------------------------------------------------

# 20. Authentication vs Authorization

This is a common interview question.

### Authentication

> **Who are you?**

It verifies identity.

### Authorization

> **What are you allowed to do?**

It verifies permissions.

### Easy Example

A university ID card proves who you are.

That is authentication.

Permission to enter a laboratory but not a server room is authorization.

### HTTP Relationship

``` text
401 → Investigate authentication
403 → Investigate authorization/permission
```

------------------------------------------------------------------------

# 21. Auth Provider

An **Auth Provider** can help Salesforce handle authentication with
supported external identity providers.

Conceptual architecture:

``` text
External Identity Provider
          |
          v
     Auth Provider
          |
          v
Salesforce Authentication Configuration
          |
          v
   Named Credential
          |
          v
      Apex Callout
          |
          v
    External API
```

The exact setup depends on the external provider and authentication
protocol.

------------------------------------------------------------------------

# 22. Salesforce Connect and External Objects

This is a different integration approach.

Sometimes the requirement is not:

> Copy all external data into Salesforce.

Instead, the requirement may be:

> Allow Salesforce users to access external data without storing all of
> it inside Salesforce.

That is where **Salesforce Connect and External Objects** can be
relevant.

Conceptually:

``` text
External System
      |
      v
External Object
      |
      v
Salesforce UI
```

The data remains primarily in the external system.

------------------------------------------------------------------------

# 23. Copy Data vs Access Data

## Option A -- Copy Data

``` text
External System
      |
      v
Integration
      |
      v
Salesforce Records
```

### Advantages

-   Salesforce-native reporting
-   Salesforce automation
-   Local data access
-   Easier use by Salesforce processes

### Costs

-   Data duplication
-   Synchronization complexity
-   Storage
-   Risk of stale data

------------------------------------------------------------------------

## Option B -- External Object

``` text
External System
      ^
      |
External Object
      ^
      |
Salesforce User
```

### Advantages

-   Less duplication
-   Access external data without copying everything

### Considerations

-   Query limitations
-   Latency
-   Dependency on external system
-   Different reporting/automation capabilities

### Architecture Decision Depends On

-   Data ownership
-   Data volume
-   Latency
-   Reporting requirements
-   Security
-   Integration requirements
-   Business criticality

------------------------------------------------------------------------

# 24. Point-to-Point Integration

In point-to-point integration:

``` text
Salesforce
     |
     v
External System
```

Salesforce directly communicates with the external system.

### Advantage

It is simple when there is only one external system.

### Problem

With many external systems:

``` text
Salesforce ↔ HR
Salesforce ↔ Recruitment
Salesforce ↔ Finance
Salesforce ↔ University
Salesforce ↔ Analytics
```

The number of direct integrations increases and complexity grows.

------------------------------------------------------------------------

# 25. Middleware Integration

Middleware sits between Salesforce and external systems.

``` text
Salesforce
     |
     v
Middleware
     |
     v
External Systems
```

Middleware may handle:

-   Transformation
-   Routing
-   Orchestration
-   Monitoring
-   Retries
-   Protocol conversion

The sprint mentions **MuleSoft** as a preferred skill in the JD.

### When Middleware Becomes Useful

When the organization has many systems and integrations, centralized
integration management can become more attractive.

------------------------------------------------------------------------

# 26. Synchronous vs Asynchronous Integration

## Synchronous

``` text
Salesforce
    |
    v
External API
    |
    v
Response
    |
    v
Salesforce
```

The user may wait for the response.

### Use When

The immediate response is genuinely required.

### Example

A student enters a certification number and Salesforce must immediately
verify it.

------------------------------------------------------------------------

## Asynchronous

``` text
Salesforce
    |
    v
Queueable
    |
    v
External API
```

The user does not wait.

### Use When

The integration is secondary or can safely happen later.

### Example

A student is selected and candidate information needs to be sent to a
company system.

------------------------------------------------------------------------

# 27. Three Integration Architecture Scenarios

## Scenario A -- Immediate Verification

Requirement:

> Student enters a certification number and Salesforce must immediately
> verify it.

Architecture:

``` text
LWC
 |
 v
Apex
 |
 v
External API
 |
 v
Response
 |
 v
LWC
```

### Choice

Synchronous integration can be appropriate because the user needs the
answer immediately.

------------------------------------------------------------------------

## Scenario B -- Candidate Synchronization

Requirement:

> When a student is selected, send candidate details to the external
> company.

Architecture:

``` text
Trigger
   |
   v
Queueable
   |
   v
External API
```

### Choice

Asynchronous processing is preferable because the user does not need to
wait.

------------------------------------------------------------------------

## Scenario C -- Historical Synchronization

Requirement:

> Every night, process 200,000 external records.

Architecture:

``` text
Scheduled Apex
      |
      v
Batch Apex
      |
      v
Integration
      |
      v
External System
      |
      v
Error Handling / Retry
```

A single synchronous user request is not appropriate for this volume.

------------------------------------------------------------------------

# 28. Why Callouts Should Be Separated From Core DML

Salesforce has restrictions around uncommitted work and callouts.

A cleaner pattern is:

``` text
Immediate Transaction
       |
       v
Commit Essential Salesforce Work
       |
       v
Queueable
       |
       v
Callout
```

This separates:

``` text
Business Commitment
```

from:

``` text
External Communication
```

It also prevents an external dependency from unnecessarily blocking the
primary Salesforce operation.

------------------------------------------------------------------------

# 29. Trigger → Service → Queueable → Callout

A clean enterprise-style architecture is:

``` text
Application Status
       |
       v
Trigger
       |
       v
Service
       |
       v
Queueable Apex
       |
       v
HTTP Callout
       |
       v
External Recruitment API
```

### Responsibilities

**Trigger**

Detects the business event.

**Service**

Applies business logic.

**Queueable**

Moves secondary work to the background.

**Callout**

Communicates with the external system.

This keeps responsibilities separated.

------------------------------------------------------------------------

# 30. Integration Reliability

A reliable integration should consider:

-   Timeouts
-   Authentication failures
-   Bad requests
-   Server failures
-   Unexpected responses
-   External system downtime
-   Retries
-   Duplicate processing
-   Idempotency
-   Integration status
-   Error logging
-   Monitoring

The sprint emphasizes that:

``` text
Salesforce Success
      ≠
External System Success
```

They are separate systems and must be reconciled.

------------------------------------------------------------------------

# 31. Debug This -- Answers

## Situation 1

An Apex class contains:

-   Username
-   Password
-   API URL
-   Access Token

directly in source code.

### Answer

This is insecure.

Credentials and secrets should not be hard-coded in Apex because they
may leak into source control, code reviews, or logs and are harder to
rotate.

Use Salesforce credential/configuration mechanisms such as Named
Credentials.

------------------------------------------------------------------------

## Situation 2

A Trigger directly performs an external callout every time a student is
selected.

### Answer

Concerns include:

-   Trigger responsibility becomes too large.
-   External dependency can affect the transaction.
-   Callout/DML transaction restrictions must be considered.
-   The user/business transaction may become dependent on the external
    system.
-   Retry and failure handling become harder.

A better architecture is generally:

``` text
Trigger
  |
  v
Service
  |
  v
Queueable
  |
  v
Callout
```

when the integration is secondary.

------------------------------------------------------------------------

## Situation 3

A Queueable sends a candidate to the external system. The call fails,
but the Salesforce record remains marked `Synced`.

### Answer

The integration status is incorrect.

If the external system failed, Salesforce should not claim successful
synchronization.

Use statuses such as:

``` text
Pending
Sent
Failed
Retry Required
```

and store the error information.

------------------------------------------------------------------------

## Situation 4

Integration retries automatically, but every retry creates another
candidate.

### Answer

The missing engineering concept is **idempotency**.

The system needs a strategy to ensure that the same business transaction
does not create duplicate candidates.

Possible approaches:

-   External Reference Id
-   Salesforce Application Id
-   Idempotency key
-   Existing record lookup

------------------------------------------------------------------------

## Situation 5

A company has ten external systems and Salesforce has a separate direct
integration with every system.

### Answer

The architecture may become difficult to maintain and scale.

A middleware/integration platform can centralize:

-   Routing
-   Transformation
-   Orchestration
-   Monitoring
-   Retry
-   Protocol conversion

------------------------------------------------------------------------

# 32. Mini Project -- External Recruitment Gateway

The PDF defines the **External Recruitment Gateway** as the mini-project
challenge.

## Requirement 1 -- Send Selected Candidates

When an Application becomes Selected:

``` text
Application
    |
    v
Queueable
    |
    v
External API
```

Candidate information should be sent.

------------------------------------------------------------------------

## Requirement 2 -- Track Integration Status

Create appropriate fields such as:

``` text
Integration Status
External Candidate Id
Last Integration Attempt
Integration Error
```

------------------------------------------------------------------------

## Requirement 3 -- Use Named Credentials

No hard-coded:

-   Secrets
-   Passwords
-   Access tokens

A Named Credential should be used.

------------------------------------------------------------------------

## Requirement 4 -- Handle Responses

At minimum handle:

``` text
Success
400
401
403
500
Unexpected Error
```

------------------------------------------------------------------------

## Requirement 5 -- Retry Thinking

Document:

> What happens if the external system is temporarily unavailable?

A failed request may be moved to:

``` text
Retry Required
```

rather than permanently failed immediately.

------------------------------------------------------------------------

## Requirement 6 -- Prevent Duplicates

Document:

> What uniquely identifies this candidate submission?

Possible identifier:

``` text
Salesforce Application Id
```

or another agreed external reference/idempotency key.

------------------------------------------------------------------------

## Requirement 7 -- Document API Contract

README/API documentation should contain:

-   Endpoint
-   HTTP Method
-   Request JSON
-   Response JSON
-   Authentication approach
-   Error handling
-   Retry strategy
-   Idempotency strategy
-   Mock API information, if applicable

------------------------------------------------------------------------

# 33. Recommended Repository Structure

The PDF suggests a repository structure similar to:

``` text
Sprint-11-Integration
│
├── README.md
│
├── architecture/
│   ├── integration-flow.png
│   ├── sequence-diagram.png
│   └── integration-pattern.png
│
├── force-app/
│
├── api-contract/
│   └── candidate-api.md
│
├── screenshots/
│
└── learning-notes/
    └── sprint-11.md
```

------------------------------------------------------------------------

# 34. What the README Should Explain

The sprint specifically expects documentation covering:

### Business Problem

Why does the integration exist?

### External System

What does the external recruitment system provide?

### Data Flow

How does data travel between Salesforce and the external system?

### Authentication

How is the external system authenticated?

### Error Handling

What happens when the API fails?

### Retry

What happens after a temporary failure?

### Idempotency

How are duplicate submissions prevented?

### Integration Pattern

Why was point-to-point or middleware chosen?

### Synchronous vs Asynchronous

Why was the selected approach chosen?

------------------------------------------------------------------------

# 35. Interview Questions and Answers

## Q1. What is an API?

**Answer:**

An API is an interface or contract that allows two independent software
systems to communicate using agreed rules for requests, responses, data
formats, and authentication.

------------------------------------------------------------------------

## Q2. What is REST?

**Answer:**

REST is a common architectural style for web APIs that commonly uses
HTTP methods such as GET, POST, PUT, PATCH, and DELETE to operate on
resources.

------------------------------------------------------------------------

## Q3. Difference between GET and POST?

**Answer:**

GET is generally used to retrieve data, while POST is generally used to
create or submit data.

------------------------------------------------------------------------

## Q4. What is JSON?

**Answer:**

JSON is a lightweight data-interchange format commonly used by REST
APIs. It represents data using key-value pairs, objects, and arrays.

------------------------------------------------------------------------

## Q5. What is an HTTP status code?

**Answer:**

An HTTP status code tells the caller the result of an HTTP request, such
as success, authentication failure, forbidden access, missing resource,
or server error.

------------------------------------------------------------------------

## Q6. What is a callout in Salesforce?

**Answer:**

A callout is a request made from Salesforce Apex to an external system
or web service, commonly using HTTP/REST APIs.

------------------------------------------------------------------------

## Q7. Why should credentials not be hard-coded in Apex?

**Answer:**

Hard-coded credentials can leak through source control and code reviews,
are difficult to rotate, and create security risks. Salesforce Named
Credentials should be used to manage endpoint and authentication
configuration.

------------------------------------------------------------------------

## Q8. What is a Named Credential?

**Answer:**

A Named Credential is Salesforce-managed configuration for an external
endpoint and its authentication setup, allowing Apex to make callouts
without embedding credentials directly in code.

------------------------------------------------------------------------

## Q9. Authentication vs Authorization?

**Answer:**

Authentication answers **"Who are you?"**

Authorization answers **"What are you allowed to do?"**

------------------------------------------------------------------------

## Q10. What is an Auth Provider?

**Answer:**

An Auth Provider helps Salesforce handle authentication with supported
external identity providers. It can be part of the authentication
configuration used with external integrations.

------------------------------------------------------------------------

## Q11. When would you use Salesforce Connect and External Objects?

**Answer:**

When Salesforce users need to access external data without copying all
of that data into Salesforce, Salesforce Connect and External Objects
can be considered.

------------------------------------------------------------------------

## Q12. What is point-to-point integration?

**Answer:**

Point-to-point integration means Salesforce communicates directly with
an external system without an intermediate middleware platform.

------------------------------------------------------------------------

## Q13. Why is middleware useful?

**Answer:**

Middleware becomes useful when many systems need to communicate. It can
centralize transformation, routing, orchestration, monitoring, retries,
and protocol conversion.

------------------------------------------------------------------------

## Q14. When would you prefer asynchronous integration?

**Answer:**

When the external operation is secondary and the user does not need the
response immediately. Queueable Apex can perform the callout in the
background.

------------------------------------------------------------------------

## Q15. What is idempotency?

**Answer:**

Idempotency is the ability to safely repeat the same logical operation
without producing unintended duplicate business results. It is
especially important when integrations retry failed requests.

------------------------------------------------------------------------

# 36. Important Interview Scenario

### Question

> When an Opportunity becomes Closed Won, Salesforce must send customer
> information to an external ERP. The user should not wait for the ERP.
> Design the solution.

### Strong Answer

``` text
Opportunity Update
       |
       v
Trigger / Service
       |
       v
Queueable Apex
       |
       v
Named Credential
       |
       v
REST Callout
       |
       v
External ERP
       |
       v
Response
       |
       v
Integration Status
```

Then explain:

-   Authentication is handled through the configured credential
    mechanism.
-   The user does not wait because the callout is asynchronous.
-   Failure should be recorded.
-   Temporary failures can be retried.
-   Idempotency should prevent duplicate processing.
-   Integration status should support monitoring.

A stronger answer discusses the complete design rather than simply
saying:

> "Use a REST API."

------------------------------------------------------------------------

# 37. Common Follow-up Interview Questions

### Why Queueable?

Because the external synchronization is secondary and the user should
not have to wait for the external system.

### Why Named Credential?

To separate endpoint/authentication configuration from Apex code and
avoid hard-coded secrets.

### What if the API is down?

The Salesforce business transaction should not necessarily fail if the
external synchronization is secondary. Record the integration failure
and support retry processing where appropriate.

### What if the same request executes twice?

Use an idempotency strategy such as an Application Id, external
reference, idempotency key, or existing-record lookup.

### What if API returns 401?

Investigate authentication and credential configuration.

### What if API returns 403?

Investigate whether the authenticated identity has the required
permission.

### What if API returns 500?

Treat it as a server-side failure. Consider recording the failure and
retrying according to the integration's retry strategy.

### Why not store all external data directly?

Because copying everything creates duplication, synchronization
complexity, storage requirements, and stale-data risks.

### Why not use Salesforce Connect?

If Salesforce needs to own and manipulate the data as part of its core
business process, storing relevant data in Salesforce may be more
suitable. If the requirement is primarily to access external data
without copying it, Salesforce Connect/External Objects may be more
appropriate.

------------------------------------------------------------------------

# 38. Architecture Decision Guide

  -----------------------------------------------------------------------
  Requirement                         Suitable Approach
  ----------------------------------- -----------------------------------
  Immediate external verification     Synchronous callout

  Secondary candidate synchronization Queueable + callout

  Large nightly synchronization       Scheduled Apex + Batch +
                                      integration

  External data should remain outside External Objects / Salesforce
  Salesforce                          Connect

  One simple external system          Point-to-point may be sufficient

  Many external systems               Middleware may be more suitable

  Sensitive authentication            Named Credential
  information                         

  Temporary API failure               Error status + retry strategy

  Duplicate retry risk                Idempotency strategy
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# 39. End-to-End Candidate Synchronization Flow

``` text
Student Application
        |
        v
Application Status = Selected
        |
        v
Trigger
        |
        v
Service Layer
        |
        v
Queueable Apex
        |
        v
Build Candidate Payload
        |
        v
JSON.serialize()
        |
        v
Named Credential
        |
        v
POST /candidates
        |
        v
External Recruitment API
        |
        +-----------------------------+
        |                             |
        v                             v
     Success                       Failure
        |                             |
        v                             v
External Candidate Id          Integration Error
        |                             |
        v                             v
Integration Status = Sent     Retry Required / Failed
```

------------------------------------------------------------------------

# 40. Key Engineering Principles Learned

## 1. API = Communication Contract

Two systems do not need to know each other's internal implementation.

They only need to follow the agreed contract.

## 2. Do Not Trust External Systems

The external system may be:

-   Slow
-   Unavailable
-   Incorrectly configured
-   Temporarily overloaded
-   Changed without warning
-   Authenticated differently
-   Returning unexpected data

## 3. Separate Core Business Transaction From Integration

The Salesforce business transaction should establish the essential
business truth.

External synchronization can happen afterward when appropriate.

## 4. Design for Failure

Always consider:

-   Timeouts
-   Errors
-   Authentication failures
-   Retries
-   Duplicates
-   Monitoring

## 5. Security Is Part of Integration Design

Credentials should not be hard-coded.

## 6. Retry Requires Idempotency

A retry mechanism without duplicate protection can create duplicate
business records.

## 7. Architecture Depends on Business Requirements

There is no single integration pattern that is correct for every
scenario.

------------------------------------------------------------------------

# 41. Final Sprint Checklist

## API & REST

-   [x] Understand API concept
-   [x] Understand REST
-   [x] Understand GET
-   [x] Understand POST
-   [x] Understand PUT
-   [x] Understand PATCH
-   [x] Understand DELETE
-   [x] Understand request structure
-   [x] Understand response structure
-   [x] Understand HTTP status codes

## JSON

-   [x] Read JSON
-   [x] Understand objects
-   [x] Understand arrays
-   [x] Understand key-value pairs
-   [x] Understand JSON serialization concept

## Salesforce Callouts

-   [x] Understand `HttpRequest`
-   [x] Understand endpoint
-   [x] Understand headers
-   [x] Understand request body
-   [x] Understand `Http`
-   [x] Understand `HttpResponse`
-   [x] Understand callout architecture

## Security

-   [x] Understand why credentials must not be hard-coded
-   [x] Understand Named Credentials
-   [x] Understand Auth Providers
-   [x] Understand authentication
-   [x] Understand authorization

## Integration Architecture

-   [x] Trigger → Service → Queueable → Callout
-   [x] Understand synchronous integration
-   [x] Understand asynchronous integration
-   [x] Understand point-to-point integration
-   [x] Understand middleware
-   [x] Understand Salesforce Connect
-   [x] Understand External Objects

## Reliability

-   [x] Integration status tracking
-   [x] Error handling
-   [x] Retry thinking
-   [x] Idempotency
-   [x] Duplicate prevention
-   [x] External-system failure handling
-   [x] Monitoring considerations

## Documentation

-   [x] API contract
-   [x] Endpoint
-   [x] HTTP method
-   [x] Request JSON
-   [x] Response JSON
-   [x] Authentication approach
-   [x] Error handling
-   [x] Retry strategy
-   [x] Idempotency strategy

## Interview Preparation

-   [x] API questions
-   [x] REST questions
-   [x] HTTP method questions
-   [x] JSON questions
-   [x] Callout questions
-   [x] Named Credential questions
-   [x] Authentication vs authorization
-   [x] Auth Provider
-   [x] Salesforce Connect
-   [x] External Objects
-   [x] Middleware
-   [x] Synchronous vs asynchronous
-   [x] Idempotency
-   [x] Integration failure scenarios

------------------------------------------------------------------------

# 42. One-Minute Interview Explanation

> "In Sprint 11, I worked on integrating the Salesforce Placement
> Management System with an external recruitment platform. The main
> requirement was to send selected candidate information from Salesforce
> to the external system. The architecture uses a Trigger to detect the
> business event, a Service layer for business logic, and Queueable Apex
> to perform the external callout asynchronously. The HTTP request uses
> a REST API and JSON payload, while a Named Credential is used for
> endpoint and authentication configuration instead of hard-coding
> credentials. I also considered response handling for 400, 401, 403 and
> 500 errors, integration status tracking, retry handling and
> idempotency to prevent duplicate candidate creation. I studied
> Salesforce Connect and External Objects for cases where external data
> should remain outside Salesforce, and compared point-to-point
> integration with middleware-based integration. The main principle I
> learned is that a reliable integration must be designed for failures,
> retries, authentication, duplicates and monitoring rather than
> assuming the external system will always be available."

------------------------------------------------------------------------

# 43. Quick Revision -- Most Important Points

If there is very little time before an interview, remember these:

``` text
API
↓
Contract between systems

REST
↓
HTTP-based API style

GET
↓
Retrieve

POST
↓
Create/Submit

PATCH
↓
Partial Update

JSON
↓
Data exchange format

Callout
↓
Salesforce → External System

Named Credential
↓
Endpoint + Authentication configuration

Authentication
↓
Who are you?

Authorization
↓
What can you do?

Queueable
↓
Background/asynchronous processing

Salesforce Connect / External Object
↓
Access external data without copying everything

Point-to-Point
↓
Direct system-to-system integration

Middleware
↓
Central integration layer for multiple systems

Idempotency
↓
Prevent duplicate results during retries

Integration Status
↓
Pending / Sent / Failed / Retry Required

Reliable Integration
↓
Authentication + Errors + Retry + Idempotency + Monitoring
```

------------------------------------------------------------------------

# 44. Final Takeaway

The most important lesson from this sprint is:

> **An integration is successful not when one API call works, but when
> two independent systems can continue working correctly even when the
> other system does not.**

The Placement Management System has therefore evolved from a
Salesforce-only application into an enterprise-style system:

``` text
Students
   |
   v
Lightning Web Components
   |
   v
Apex Services
   |
   +----------------------+
   |                      |
   v                      v
Salesforce Database    Queueable / Batch
                          |
                          v
                    External APIs
                          |
                          v
                  External Systems
```

The developer's responsibility is not only to make the API call, but to
design the **complete integration conversation**:

``` text
Business Event
     ↓
API Contract
     ↓
Authentication
     ↓
Request
     ↓
Response
     ↓
Error Handling
     ↓
Retry
     ↓
Idempotency
     ↓
Status Tracking
     ↓
Monitoring
```

This is the core of **Crossing the Salesforce Boundary**.
