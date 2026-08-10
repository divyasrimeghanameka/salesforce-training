public class OfferPostProcessingJob implements Queueable {

    private Id offerId;

    public OfferPostProcessingJob(Id offerId) {
        this.offerId = offerId;
    }

    public void execute(QueueableContext context) {

        Application__c app = [
            SELECT Id, Name
            FROM Application__c
            WHERE Id = :offerId
            LIMIT 1
        ];

        System.debug(
            'Processing Application: ' + app.Name
        );
    }
}