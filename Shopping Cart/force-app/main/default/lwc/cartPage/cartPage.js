import { LightningElement, wire, track, api } from 'lwc';
import getCartItems from '@salesforce/apex/cartRecordController.getCartItems';
import deleteItems from '@salesforce/apex/deleteCartItems.deleteItems';

export default class CartPage extends LightningElement {

    @api show5 = false; 
    @api show6 = false;
    @api back = false;
    show5 = true;
    @track columns = [
        { label: 'Name', fieldName: 'Name', sortable: 'true'},
        { label: 'Product Code', fieldName: 'Product_Code__c', sortable: 'true'},
        { label: 'Price', fieldName: 'Price__c', sortable: 'true'},
        { label: 'Units', fieldName: 'Units__c', sortable: 'true'}
    ]; 

    @track cartItemsList;
    @track sortBy;
    @track sortDirection;

    @track selectedRecords = [];

    @wire (getCartItems) wiredOrders({data,error}){
        if (data) {
            this.cartItemsList = data;
            console.log(data);
        } else if (error) {
            console.log(error);
        }
    }

    doSorting(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(this.cartItemsList));
        let keyValue = (a) => {
            return a[fieldname];
        };
        let isReverse = direction === 'asc' ? 1: -1;
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.cartItemsList = parseData;
    }

    createOrder(){
        if(Object.keys(this.cartItemsList).length > 0 ){
            this.show5 = false;
            this.show6 = true;
        }else{
            alert("Cart Is Empty!")
        }
    }

    backToProducts(){
        this.show5 = false;
        this.back = true;
    }

    deleteItems(){
        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        if(selectedRecords.length > 0){
            console.log('selectedRecords are ', selectedRecords);
            this.selectedRecords = selectedRecords;
        } else{
            alert("No Items Selected");
        }

        selectedRecords.forEach(e => {
            
            console.log(e);
            deleteItems({ item: e })
                .then(result => {
                    alert("Items Deleted Successfully");
                    console.log(JSON.stringify(result));
                }).catch(error=>{
                    alert("Error Deleting Items"+error);
                    console.log("error", JSON.stringify(error));
                })
        });

    }

}