import { LightningElement, api } from 'lwc';

export default class EligibleJobs extends LightningElement {

    @api recordId;
    @api refreshKey;

    jobs = [
        {
            id: 'JOB001',
            company: 'Tech Solutions',
            role: 'Salesforce Developer',
            package: '6 LPA',
            location: 'Hyderabad'
        },
        {
            id: 'JOB002',
            company: 'Cloud Systems',
            role: 'Java Developer',
            package: '5 LPA',
            location: 'Bangalore'
        },
        {
            id: 'JOB003',
            company: 'Data Works',
            role: 'Data Analyst',
            package: '4.5 LPA',
            location: 'Chennai'
        }
    ];

    // Stores the complete job selected by the user
    selectedJob;

    // Message shown after View Details / Apply
    message;

    // Stores jobs for which the student has already applied
    appliedJobIds = [];

    // View Details button
    handleViewDetails(event) {

        const jobId = event.detail.jobId;

        // Find the complete job using the Job ID
        this.selectedJob = this.jobs.find(
            job => job.id === jobId
        );

        this.message = '';
    }

    // Apply button
    handleApply(event) {

        const jobId = event.detail.jobId;

        // Find the complete job
        const selectedJob = this.jobs.find(
            job => job.id === jobId
        );

        // Check whether the student already applied
        if (this.appliedJobIds.includes(jobId)) {

            this.message =
                'You have already submitted the application for ' +
                selectedJob.company +
                ' - ' +
                selectedJob.role;

            return;
        }

        // First-time application
        this.appliedJobIds = [
            ...this.appliedJobIds,
            jobId
        ];

        this.selectedJob = selectedJob;

        this.message =
            'Application submitted successfully for ' +
            selectedJob.company +
            ' - ' +
            selectedJob.role;
    }
}