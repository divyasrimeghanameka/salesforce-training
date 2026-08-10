public class ApplicationTriggerHandler {

    // Sprint 17 - Eligibility Validation
    public static void validateEligibility(
        List<Application__c> applications
    ) {

        Set<Id> studentIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();

        // Collect Student and Job IDs
        for (Application__c app : applications) {

            if (app.Student__c != null) {
                studentIds.add(app.Student__c);
            }

            if (app.Job__c != null) {
                jobIds.add(app.Job__c);
            }
        }

        // Get Students
        Map<Id, Student__c> studentMap =
            new Map<Id, Student__c>([
                SELECT Id,
                       CGPA__c,
                       Active_Backlogs__c,
                       Branch__c
                FROM Student__c
                WHERE Id IN :studentIds
            ]);

        // Get Jobs
        Map<Id, Job__c> jobMap =
            new Map<Id, Job__c>([
                SELECT Id,
                       Minimum_CGPA__c,
                       Allowed_Backlogs__c,
                       Eligible_Branches__c
                FROM Job__c
                WHERE Id IN :jobIds
            ]);

        // Validate Applications
        for (Application__c app : applications) {

            Student__c student =
                studentMap.get(app.Student__c);

            Job__c job =
                jobMap.get(app.Job__c);

            if (student == null || job == null) {
                continue;
            }

            // CGPA Validation
            if (student.CGPA__c < job.Minimum_CGPA__c) {

                app.addError(
                    'Student CGPA is below Job Requirement.'
                );
            }

            // Backlog Validation
            if (student.Active_Backlogs__c >
                job.Allowed_Backlogs__c) {

                app.addError(
                    'Student has more active backlogs.'
                );
            }

            // Branch Validation
            if (job.Eligible_Branches__c != null &&
                student.Branch__c != null &&
                !job.Eligible_Branches__c.contains(
                    student.Branch__c
                )) {

                app.addError(
                    'Student branch is not eligible.'
                );
            }
        }
    }


    // Sprint 18 - Detect Application Selection
    public static void updateStudentPlacement(
        List<Application__c> newApplications,
        Map<Id, Application__c> oldMap
    ) {

        Set<Id> studentIds = new Set<Id>();

        // Find applications whose status changed to Selected
        for (Application__c app : newApplications) {

            Application__c oldApp = oldMap.get(app.Id);

            if (oldApp.Status__c != 'Selected' &&
                app.Status__c == 'Selected' &&
                app.Student__c != null) {

                studentIds.add(app.Student__c);
            }
        }

        // No students to update
        if (studentIds.isEmpty()) {
            return;
        }

        // Query all required Students once
        Map<Id, Student__c> studentMap =
            new Map<Id, Student__c>([
                SELECT Id,
                       Placement_Status__c
                FROM Student__c
                WHERE Id IN :studentIds
            ]);

        List<Student__c> studentsToUpdate =
            new List<Student__c>();

        // Update Students
        for (Student__c student : studentMap.values()) {

            student.Placement_Status__c = 'Placed';

            studentsToUpdate.add(student);
        }

        // One DML operation
        if (!studentsToUpdate.isEmpty()) {
            update studentsToUpdate;
        }
    }
}