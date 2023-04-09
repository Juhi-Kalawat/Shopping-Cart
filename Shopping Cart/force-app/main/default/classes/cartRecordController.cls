public with sharing class cartRecordController {
    @AuraEnabled(cacheable=true)
    public static List<Cart_Items__c> getCartItems() {
        selector s = new selector();
        return s.getCartItemsSelector();
    }
}

