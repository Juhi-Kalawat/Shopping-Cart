public with sharing class OrderRecordController {
    @AuraEnabled(cacheable=true)
    public static List<AllOrders__c> getOrders() {
        selector s = new selector();
        return s.getOrdersSelector();
    }
}
