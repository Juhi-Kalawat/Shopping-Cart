import { LightningElement, api, wire, track } from 'lwc';
import getCartItems from '@salesforce/apex/cartRecordController.getCartItems';
import createNewOrder from '@salesforce/apex/createOrder.createNewOrder';

export default class InvoicePage extends LightningElement {
    @api show7 = false; 
    @api show8 = false; 
    show7 = true;
    @api date = new Date().toLocaleDateString();
    @api invoiceNumber = Math.floor(Math.random() * 1000000000);
    
    @track columns = [
        { label: 'Name', fieldName: 'Name'},
        { label: 'Product Code', fieldName: 'Product_Code__c'},
        { label: 'Price', fieldName: 'Price__c'},
        { label: 'Units', fieldName: 'Units__c'},
        { label: 'Total', fieldName: 'Total__c'}
    ]; 

    @track cartItemsList;
    @track sortBy;
    @track sortDirection;

    @wire (getCartItems) wiredOrders({data,error}){
        if (data) {
            this.cartItemsList = data;
        } else if (error) {
            console.log(error);
        }
    }

    placeOrder(){
        const successEvent = new CustomEvent('success', {
            detail: { message: 'Order Placed Successfully !!' },
        });
        this.dispatchEvent(successEvent);
    //     this.show7 = false;
    //     this.show8 = true;

    //     createNewOrder()
    //         .then(result => {
    //             alert("Order Placed Successfully");
    //             console.log(JSON.stringify(result));
    //         }).catch(error=>{
    //             alert("Sorry Cannot Place Your Order");
    //             console.log("error", JSON.stringify(error));
    //         })
    // }
}