import { LightningElement, api } from 'lwc';

export default class StudentPortal extends LightningElement {
    @api recordId;

    refreshKey = 0;

    handleProfileUpdated() {
        this.refreshKey++;
    }
}