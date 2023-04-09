public with sharing class ProductSelector extends fflib_SObjectSelector {
    public Schema.SObjectType getSObjectType() {
        return Product2.SObjectType;
    }
    
    public List<Schema.SObjectField> getSObjectFieldList() {
    
        return new List<Schema.SObjectField> {
        Product2.Id,
        Product2.Name,
        Product2.Price__c,
        Product2.ProductCode,
        Product2.Available_Units__c
        };
    }
    
    public override String getOrderBy() {
        return 'Name ASC';
    }
    
    public List<Product2> getProducts(Integer recordLimit, String productName) {
        String productKey ='%'+productName+'%';
        String query = String.format('select {0} from {1} where Name like :productKey order by {2} limit {3}',
                                        new List<String> {
                                        getFieldListString(),
                                        getSObjectName(),
                                        getOrderBy(),
                                        String.valueOf(recordLimit)
                                        });
        return (List<Product2>) Database.query(query);
        }
    }