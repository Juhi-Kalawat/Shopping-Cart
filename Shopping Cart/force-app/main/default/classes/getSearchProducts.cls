public with sharing class getSearchProducts {
    @AuraEnabled(cacheable=true)
    public static List<Product2> fetchProducts(String searchKey){
        String keystr =  '%'+searchKey+'%';
        return [SELECT Name, ProductCode, Product_Price__c, Available_Quantity__c FROM Product2 WHERE Name LIKE: keystr];
    }
}