public with sharing class DeleteCartItemsService {
    public void deleteItemsService(Cart_Items__c item){
        List<Cart_Items__c> cartItem = new List<Cart_Items__c>();
        cartItem = [select name, Units__c from Cart_Items__c where name =: item.name];
        List<Product2> proItem = new List<Product2>();
        proItem = [select name, Available_Quantity__c from Product2 where name =: item.name];
        proItem[0].Available_Quantity__c = proItem[0].Available_Quantity__c + cartItem[0].Units__c;
        update proItem;
        delete cartItem;
    }
}