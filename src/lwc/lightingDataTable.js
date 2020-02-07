import { LightningElement, track } from 'lwc';
import searchAccount from '@salesforce/apex/AccountController.searchAccount';
const columnList = [
    {label: 'Id', fieldName: 'Id'},
    {label: 'Name', fieldName: 'Name'},
    {label: 'Website', fieldName: 'Website'},
    {label: 'Industry', fieldName: 'Industry'},
    {label: 'Phone', fieldName: 'Phone'}
];
export default class LightningDataTable extends LightningElement {
@track accountList;
@track columnList = columnList;
@track noRecordsFound = true;
    findAccountResult(event) {
        const accName = event.target.value;
        if(accName) {
            searchAccount ( {accName})
                .then(result => {
                this.accountList = result;
            this.noRecordsFound = false;
        })
        } else {
            this.accountList = undefined;
            this.noRecordsFound = true;
        }
    }
}