public with sharing class InsertOrderLineItems {
    @AuraEnabled
    
    public static string insertOrderItems(Object orderItems) {
        List<OrderLineItem__c> orderLineItemDummy =(List<OrderLineItem__c>)JSON.deserialize(JSON.serialize(orderItems), List<OrderLineItem__c>.class);
        
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new Schema.SObjectType[]{
            Order__c.SObjectType,
            
            OrderLineItem__c.SObjectType
        }
        );
        Decimal totalBill =0;
        for(OrderLineItem__c currOrderLineItem : orderLineItemDummy){
        totalBill+=currOrderLineItem.TotalAmount__c;
        }
        Order__c currOrder = new Order__c();
        currOrder.Order_Total__c=totalBill;
        currOrder.Name='New Orderx';
        currOrder.Status__c='Processing';
        uow.registerNew(currOrder);
        
        for(OrderLineItem__c currLineItem : orderLineItemDummy){
        currLineItem.Order__c=currOrder.id;
        }
        uow.registerNew(orderLineItemDummy);
        uow.commitWork();
        return 'Ok';
        }
    
    }