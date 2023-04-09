public with sharing class CreateOrderService {
    public void createNewOrderService() {
        List<Cart_Items__c> cartItems = new List<Cart_Items__c>();
        cartItems = [select Total__c from Cart_Items__c];
        Integer totalValue = 0;
        Integer cTotal = 0;
        for(Cart_Items__c c : cartItems){
            cTotal = (c.Total__c).intValue();
            totalValue = cTotal + totalValue;
        }
        
        AllOrders__c no = New AllOrders__c();
        no.name = 'Placed';
        no.OrderTotal__c = totalValue;
        insert no;
        delete cartItems;
    }
}