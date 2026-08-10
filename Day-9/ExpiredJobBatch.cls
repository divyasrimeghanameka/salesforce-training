public class ExpiredJobBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(
        Database.BatchableContext context
    ) {

        return Database.getQueryLocator([
            SELECT Id,
                   Name,
                   Closing_Date__c,
                   Status__c
            FROM Job__c
            WHERE Closing_Date__c < TODAY
            AND Status__c = 'Open'
        ]);
    }

    public void execute(
        Database.BatchableContext context,
        List<Job__c> scope
    ) {

        for (Job__c job : scope) {
            job.Status__c = 'Expired';
        }

        if (!scope.isEmpty()) {
            update scope;
        }
    }

    public void finish(
        Database.BatchableContext context
    ) {

        System.debug('Expired Job Batch Completed');
    }
}