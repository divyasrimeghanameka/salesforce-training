import { LightningElement, api } from 'lwc';

export default class StudentSummary extends LightningElement {

    @api recordId;
    @api refreshKey;

    // Sample student details
    studentName = 'Divya Sri Meghana';
    email = 'divyasrimeghana2005@gmail.com';
    branch = 'Computer Science and Engineering';
    cgpa = '8.7';
    backlogs = '0';
    placementStatus = 'Eligible';
    phone = '7036799499';
    graduationYear = '2027';
    skills = 'Java, Python, HTML, CSS, JavaScript';
    preferredLocation = 'Hyderabad';

    get hasData() {
        return true;
    }

    get isLoading() {
        return false;
    }

    get hasError() {
        return false;
    }
}