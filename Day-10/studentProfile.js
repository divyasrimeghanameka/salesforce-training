import { LightningElement, api } from 'lwc';
import STUDENT_OBJECT from '@salesforce/schema/Student__c';

import NAME_FIELD from '@salesforce/schema/Student__c.Name';
import PHONE_FIELD from '@salesforce/schema/Student__c.Phone__c';
import EMAIL_FIELD from '@salesforce/schema/Student__c.Email__c';
import BRANCH_FIELD from '@salesforce/schema/Student__c.Branch__c';
import CGPA_FIELD from '@salesforce/schema/Student__c.CGPA__c';
import SKILLS_FIELD from '@salesforce/schema/Student__c.Skills__c';
import LOCATION_FIELD from '@salesforce/schema/Student__c.Preferred_Location__c';

export default class StudentProfile extends LightningElement {

    @api recordId;

    objectApiName = STUDENT_OBJECT;

    fields = {
        name: NAME_FIELD,
        phone: PHONE_FIELD,
        email: EMAIL_FIELD,
        branch: BRANCH_FIELD,
        cgpa: CGPA_FIELD,
        skills: SKILLS_FIELD,
        location: LOCATION_FIELD
    };

    showSuccess = false;
    errorMessage = '';

    handleSuccess() {
    this.showSuccess = true;
    this.errorMessage = '';

    this.dispatchEvent(
        new CustomEvent('profileupdated', {
            detail: {
                recordId: this.recordId
            }
        })
    );

    setTimeout(() => {
        this.showSuccess = false;
    }, 3000);
}

    handleError(event) {
        this.showSuccess = false;

        this.errorMessage =
            event.detail?.message || 'Unable to update the profile.';
    }

    handleSubmit(event) {
        this.showSuccess = false;
        this.errorMessage = '';

        event.preventDefault();

        const fields = event.detail.fields;

        this.template
            .querySelectorAll('lightning-input-field')
            .forEach(field => {
                field.reportValidity();
            });

        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }
}