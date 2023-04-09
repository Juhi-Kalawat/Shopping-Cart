public with sharing class PurchaseOrder extends fflib_SObjectSelector {
    public Schema.SObjectType getSObjectType() {
        return Order__c.SObjectType;
    }
    
    public List<Schema.SObjectField> getSObjectFieldList() {
    
        return new List<Schema.SObjectField> {
        Order__c.Id,
        Order__c.Status__c,
        Order__c.Order_Total__c
        };
    }
    public override String getOrderBy() {
        return 'Id ASC';
    }
    
    public List<Order__c> Orders(Integer recordLimit) {
        String query = String.format('select {0} from {1} order by {2} limit {3}',
            new List<String> {
            getFieldListString(),
            getSObjectName(),
            getOrderBy(),
            String.valueOf(recordLimit)
            });
            return (List<Order__c>) Database.query(query);
        }
    }