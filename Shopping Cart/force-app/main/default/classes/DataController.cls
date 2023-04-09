public with sharing class DataController {
    @AuraEnabled (cacheable=true)
    public static List<Order__c> getOrders(){
        return new PurchaseOrder().Orders(1000);
    }
    @AuraEnabled (cacheable=true)
    public static List<Product2> getProduct(String productName){
        return new ProductSelector().getProducts(1000,productName);
    }
}
