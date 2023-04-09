public with sharing class insertIntoCart {
    @AuraEnabled
    public static void insertCart(Product2 item){

        List<Cart_Items__c> defaultProductList = new List<Cart_Items__c>();
        defaultProductList = [select name, Units__c, Price__c from Cart_Items__c where name =: item.name];
        
        List<Product2> quantityList = new List<Product2>();
        quantityList = [select name, Available_Quantity__c from Product2 where name =: item.name];

        if(defaultProductList.size() == 0){
            Cart_Items__c ci = New Cart_Items__c();
            ci.Name = item.name;
            ci.Product_Code__c = item.ProductCode;
            ci.Price__c = item.Product_Price__c;
            ci.Units__c = 1;
            insert ci;

            for(Product2 p : quantityList){
                p.Available_Quantity__c = p.Available_Quantity__c - 1;
            }
        }else{
            for(Cart_Items__c cc : defaultProductList){
                cc.Units__c = cc.Units__c + 1;
            }
            update defaultProductList;
            for(Product2 p : quantityList){
                p.Available_Quantity__c = p.Available_Quantity__c - 1;
            }
        }
        update quantityList;
    }
}