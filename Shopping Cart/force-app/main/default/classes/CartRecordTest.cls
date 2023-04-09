@IsTest
public with sharing class CartRecordTest {
    public fflib_ApexMocks mocks = new fflib_ApexMocks();
    public ICartRecordSelector cartRecordSelectorMock = (ICartRecordSelector) mocks.mock(cartRecordController.class);
    
    @IsTest
    private static void CartRecordTest() {
       
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        ICartRecordSelector cartRecordSelectorMock = (ICartRecordSelector) mocks.mock(cartRecordController.class);
 // start the stubbing phase 
        mocks.startStubbing();
        List<Cart_Items__c> testCartProductList=new List<Cart_Items__c>{new Cart_Items__c(
            Name= 'test cart product',
            Product_Code__c= 'xxx12345',
            Price__c=50,
            Units__c=5,
            Total__c=250
        )};
// record the execution behavior
        mocks.when(cartRecordSelectorMock.sObjectType()).thenReturn(Cart_Items__c.SObjectType);
        mocks.when(cartRecordSelectorMock.getAll()).thenReturn(testCartProductList);
        // stop - start execution phase
        mocks.stopStubbing();
//  execute test
        Application.Selector.setMock(cartRecordSelectorMock);
        List<Cart_Items__c> outputList = selector.getCartItemsSelector();

        ((ICartRecordSelector)mocks.verify(cartRecordSelectorMock)).getAll();
// assert phase
        System.assertEquals(testCartProductList, outputList);
    }
}