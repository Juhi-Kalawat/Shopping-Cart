@IsTest
public with sharing class ProductRecordTest {

    public fflib_ApexMocks mocks = new fflib_ApexMocks();
    public IProductRecordSelector productRecordSelectorMock = (IProductRecordSelector) mocks.mock(ProductRecordController.class);
    
    @IsTest
    public ProductRecordTest() {

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IProductRecordSelector productRecordSelectorMock = (IProductRecordSelector) mocks.mock(ProductRecordController.class);

        mocks.startStubbing();
        List<Product2> testProductList=new List<Product2>{new Product2(
            Name = 'test Product',
            ProductCode = 69,
            Product_Price__c = 420,
            Available_Quantity__c = 420
        )};

        mocks.when(productRecordSelectorMock.sObjectType()).thenReturn(Product2.SObjectType);
        mocks.when(productRecordSelectorMock.getAll()).thenReturn(testProductList);
        mocks.stopStubbing();

        Application.Selector.setMock(productRecordSelectorMock);
        List<Product2> outputList = selector.getProductSelector();

        ((IProductRecordSelector)mocks.verify(productRecordSelectorMock)).getAll();

        System.assertEquals(testProductList, outputList);

    }
}