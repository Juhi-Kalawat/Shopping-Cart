public with sharing class createOrder {
    @AuraEnabled(cacheable=true)
    public static void createNewOrder(){

        List<Cart_Items__c> cartItems = new List<Cart_Items__c>();
        cartItems = [select Total__c from Cart_Items__c];
        
        Integer totalValue =100;

        for(Cart_Items__c c : cartItems){
            totalValue = totalValue+(c.Total__c).intValue();
        }
        
        AllOrders__c no = New AllOrders__c();
        no.Name = 'order';
        no.OrderTotal__c = totalValue;
        // no.Order_Id__c = invoiceNo;
        insert no;
        delete cartItems;
    }
}