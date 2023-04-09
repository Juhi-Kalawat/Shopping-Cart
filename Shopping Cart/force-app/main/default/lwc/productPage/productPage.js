import { LightningElement, wire, track, api } from 'lwc';
import getProduct from '@salesforce/apex/productRecordController.getProduct';
import fetchProducts from '@salesforce/apex/productRecordController.fetchProducts'
import { createRecord } from 'lightning/uiRecordApi';
import cartObj from '@salesforce/schema/Cart_Items__c';
import cartItemName from '@salesforce/schema/Cart_Items__c.Name';
import cartItemPrice from '@salesforce/schema/Cart_Items__c.Price__c';
import cartItemCode from '@salesforce/schema/Cart_Items__c.Product_Code__c';
import cartItemUnits from '@salesforce/schema/Cart_Items__c.Units__c';
import insertCart from '@salesforce/apex/insertIntoCart.insertCart';

export default class ProductPage extends LightningElement {

    @api show3 = false;
    show3 = true;
    @api show4 = false;
    @api searchKey;

    @track name = cartItemName;
    @track code = cartItemCode;
    @track price = cartItemPrice;
    @track unit = cartItemUnits;

    @track productList;
    @track sortBy;
    @track sortDirection;

    @track selectedRecords = [];
    
    @track columns = [
        { label: 'Name', fieldName: 'Name', sortable: 'true'},
        { label: 'Product Code', fieldName: 'ProductCode', sortable: 'true'},
        { label: 'Price', fieldName: 'Product_Price__c', sortable: 'true'},
        { label: 'Available Quantity', fieldName: 'Available_Quantity__c', sortable: 'true'}
    ]; 

    // pgination variables
   
    records=[];
    totalRecords ; //Total no.of records
    pageSize  =10; //No.of records to be displayed per page
    totalPages; //Total no.of pages
    pageNumber = 1; //Page number    
    
    
    get bDisableFirst() {
        return this.pageNumber == 1;
    }
    get bDisableLast() {
        return this.pageNumber == this.totalPages;
    }
    

    handleRecordsPerPage(event) {
        this.pageSize = event.target.value;
        this.paginationHelper();
    }
    previousPage() {
        this.pageNumber = this.pageNumber - 1;
        this.paginationHelper();
    }
    nextPage() {
        this.pageNumber = this.pageNumber + 1;
        this.paginationHelper();
    }
    firstPage() {
        this.pageNumber = 1;
        this.paginationHelper();
    }
    lastPage() {
        this.pageNumber = this.totalPages;
        this.paginationHelper();
    }
    // JS function to handel pagination logic 
    paginationHelper() {
        this.productList = [];
        // calculate total pages
        this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
        // set page number 
        if (this.pageNumber <= 1) {
            this.pageNumber = 1;
        } else if (this.pageNumber >= this.totalPages) {
            this.pageNumber = this.totalPages;
        }
        // set records to display on current page 
        for (let i = (this.pageNumber - 1) * this.pageSize; i < this.pageNumber * this.pageSize; i++) {
            if (i === this.totalRecords) {
                break;
            }
            this.productList.push(this.records[i]);
            
        }
    }

    @wire (getProduct) wiredOrders({data,error}){ // fetching data from method using wire
        if (data) {
            this.records = data;
            this.totalRecords = data.length;
            alert(this.totalRecords);
            this.paginationHelper();
            console.log(data); 
        } else if (error) {
            console.log(error);
        }
    }
    
    doSorting(event) { //this function is envoked when user clicks on sort arrow button
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) { // main function for sorting being called from doSorting function 
        let parseData = JSON.parse(JSON.stringify(this.productList));
        let keyValue = (a) => {
            return a[fieldname];
        };
        let isReverse = direction === 'asc' ? 1: -1;
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.productList = parseData;
    }

    addToCart(){ // inserts records into cart sObject    
        
        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        
        if(selectedRecords.length > 0){
            console.log('selectedRecords are ', selectedRecords);
            this.selectedRecords = selectedRecords;
        } else{
            alert("No Items Selected");
        }

        selectedRecords.forEach(e => {
            console.log("foreach called");
            console.log(e);
            insertCart({ item: e })
                .then(result => {
                    console.log(JSON.stringify(result));
                }).catch(error=>{
                    alert("Error Adding Items"+error);
                    console.log("error", JSON.stringify(error));
                })
        });
        alert("Items Added Successfully");

            
        
    }
    handleKeyChange(event){
        const searchKey = event.target.value;
        if(searchKey){
            fetchProducts({ searchKey }).then(result => {
                this.productList = result;
            })
            .catch(error => {
                this.error = error;
            });
        }

    }

    goToCart(){ // redirects to cart page 
        this.show3 = false;
        this.show4 = true;
    }
}