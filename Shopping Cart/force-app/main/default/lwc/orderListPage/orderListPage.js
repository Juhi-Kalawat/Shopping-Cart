import { LightningElement, wire, track, api } from 'lwc';
import getOrders from '@salesforce/apex/OrderRecordController.getOrders';

export default class OrderListPage extends LightningElement {

    @api show = false; 
    @api show2 = false;

    @track sortBy;
    @track sortDirection;
    
    @track columns = [
        { label: 'Id', fieldName: 'Order_Id__c', sortable: 'true'},
        { label: 'Order Name', fieldName: 'Name', sortable: 'true'},
        { label: 'Order Value', fieldName: 'OrderTotal__c', sortable: 'true'}
    ];  
    @track ordersList;
    
    show=true;

    @wire (getOrders) wiredOrders({data,error}){
        if (data) {
            this.ordersList = data; 
        } else if (error) {
            console.log(error);
        }
    }

    handleClick() {
        this.show = false;
        this.show2 = true;  
    }

    doSorting(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(this.ordersList));
        let keyValue = (a) => {
            return a[fieldname];
        };
        let isReverse = direction === 'asc' ? 1: -1;
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.ordersList = parseData;
    }
}