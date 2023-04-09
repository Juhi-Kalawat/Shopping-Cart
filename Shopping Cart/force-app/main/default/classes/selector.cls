public with sharing class selector {
    @AuraEnabled(cacheable=true)
    public List<AllOrders__c> getOrdersSelector() {
        return [SELECT Order_Id__c, Name, OrderTotal__c FROM AllOrders__c];
    }

    @AuraEnabled(cacheable=true)
    public List<Product2> getProductSelector() {
        return [SELECT Name, ProductCode, Product_Price__c, Available_Quantity__c FROM Product2];
    }

    @AuraEnabled(cacheable=true)
    public List<Cart_Items__c> getCartItemsSelector() {
        return [SELECT Name, Product_Code__c, Price__c, Units__c, Total__c FROM Cart_Items__c];
    }
}