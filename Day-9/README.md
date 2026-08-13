# Day-9: Building User Experiences with Lightning Web Components

## Overview

Implemented the Salesforce Engineering Sprint tasks covering bulk-safe Apex, trigger handling, Queueable Apex, Queueable chaining, Batch Apex, and Scheduled Apex.

## Sprint 17 – Bulkified Eligibility Validation

- Created `ApplicationTrigger` for `Application__c`.
- Created `ApplicationTriggerHandler`.
- Implemented bulk-safe validation using `Set<Id>` and `Map<Id, SObject>`.
- Added validations for:
  - Student CGPA
  - Active Backlogs
  - Eligible Branch
- Avoided SOQL and DML operations inside loops.

## Sprint 18 – Detect Selection in Bulk

- Updated `ApplicationTrigger` to handle `after update`.
- Used `Trigger.oldMap` to detect when Application Status changes to `Selected`.
- Updated the related Student's `Placement_Status__c` to `Placed`.
- Used bulk-safe collection and a single DML operation.

## Sprint 19 – Queueable Apex

- Created `OfferPostProcessingJob`.
- Implemented `Queueable` interface.
- Passed Application Id through the constructor.
- Executed the Queueable job using `System.enqueueJob()`.
- Verified the job in **Apex Jobs**.

## Sprint 20 – Queueable Chaining

- Created `ExternalPlacementSyncJob`.
- Created `PlacementNotificationJob`.
- Implemented Queueable chaining:
  
  `ExternalPlacementSyncJob → PlacementNotificationJob`

- Verified both jobs in **Apex Jobs**.

## Sprint 21 – Batch Apex

- Created `PlacementCategoryBatch`.
- Implemented `Database.Batchable<SObject>`.
- Used `start()`, `execute()`, and `finish()` methods.
- Processed Application records in batches.
- Verified Batch execution in **Apex Jobs**.

## Sprint 22 – Scheduled Apex

- Created `ExpiredJobBatch`.
- Used `Closing_Date__c` to identify expired Jobs.
- Created `ExpiredJobScheduler`.
- Implemented `Schedulable` interface.
- Scheduler starts the `ExpiredJobBatch`.
- Scheduled the job and verified it under **Scheduled Jobs**.

## Key Concepts Learned

- Apex Triggers
- Trigger Handler Pattern
- Bulkification
- SOQL and DML optimization
- `Trigger.oldMap`
- Queueable Apex
- Queueable Chaining
- Batch Apex
- Scheduled Apex
- Governor Limits
- Asynchronous Processing

## Tools Used

- Salesforce Developer Org
- VS Code
- Salesforce CLI
- Apex
- Git & GitHub

## Result

Completed the practical Salesforce Engineering Sprint tasks from **Sprint 17 to Sprint 22**, including synchronous trigger automation and asynchronous Apex processing.
