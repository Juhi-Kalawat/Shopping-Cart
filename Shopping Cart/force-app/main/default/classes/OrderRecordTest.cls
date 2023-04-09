@IsTest
public with sharing class OrderRecordTest {

    public fflib_ApexMocks mocks = new fflib_ApexMocks();
    public IOrderRecordSelector orderRecordSelectorMock = (IOrderRecordSelector) mocks.mock(OrderRecordController.class);
    
    @IsTest
    public OrderRecordTest() {

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IOrderRecordSelector orderRecordSelectorMock = (IOrderRecordSelector) mocks.mock(OrderRecordController.class);

        mocks.startStubbing();
        List<AllOrders__c> testOrdersList=new List<AllOrders__c>{new AllOrders__c(
            Name = 'test processing',
            Order_Id__c = 69,
            OrderTotal__c = 420
        )};

        mocks.when(orderRecordSelectorMock.sObjectType()).thenReturn(AllOrders__c.SObjectType);
        mocks.when(orderRecordSelectorMock.getAll()).thenReturn(testOrdersList);
        mocks.stopStubbing();

        Application.Selector.setMock(orderRecordSelectorMock);
        List<AllOrders__c> outputList = selector.getOrdersSelector();

        (mocks.verify(orderRecordSelectorMock)).getAll();

        System.assertEquals(testOrdersList, outputList);

    }
}