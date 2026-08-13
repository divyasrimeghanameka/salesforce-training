public class PlacementCategoryBatch
    implements Database.Batchable<SObject> {

    public Database.QueryLocator start(
        Database.BatchableContext context
    ) {

        return Database.getQueryLocator([
            SELECT Id, Placement_Category__c
            FROM Application__c
            WHERE Placement_Category__c = NULL
        ]);
    }

    public void execute(
        Database.BatchableContext context,
        List<Application__c> scope
    ) {

        for (Application__c app : scope) {

            // Calculate category here.
        }

        update scope;
    }

    public void finish(
        Database.BatchableContext context
    ) {

        System.debug(
            'Placement Category Batch Completed'
        );
    }
}