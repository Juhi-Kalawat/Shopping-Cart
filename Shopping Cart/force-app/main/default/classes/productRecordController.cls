public with sharing class productRecordController {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProduct() {
        selector s = new selector();
        return s.getProductSelector();
    }
    @AuraEnabled(cacheable=true)
    public static List<Product2> fetchProducts(String searchKey){
        String keystr = '%'+searchKey+'%';
        return [select id, name, Price__c, productCode, available_units__c from Product2 WHERE Name LIKE: keystr];
    }
}