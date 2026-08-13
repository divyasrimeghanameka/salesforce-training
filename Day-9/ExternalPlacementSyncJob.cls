public class ExternalPlacementSyncJob implements Queueable {

    private Id applicationId;

    public ExternalPlacementSyncJob(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        Application__c app = [
            SELECT Id, Name
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        System.debug(
            'External Placement Sync: ' + app.Name
        );

        System.enqueueJob(
            new PlacementNotificationJob(app.Id)
        );
    }
}