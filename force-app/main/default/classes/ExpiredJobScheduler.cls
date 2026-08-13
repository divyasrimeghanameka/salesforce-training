public class ExpiredJobScheduler implements Schedulable {

    public void execute(
        SchedulableContext context
    ) {

        Database.executeBatch(
            new ExpiredJobBatch()
        );
    }
}