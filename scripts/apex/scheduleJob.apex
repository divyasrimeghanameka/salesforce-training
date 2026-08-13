String cron = '0 0 6 * * ?';

System.schedule(
    'Expired Job Morning Processing',
    cron,
    new ExpiredJobScheduler()
);