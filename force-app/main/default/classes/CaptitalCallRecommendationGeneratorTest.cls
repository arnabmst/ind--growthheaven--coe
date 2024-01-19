@isTest
private class CaptitalCallRecommendationGeneratorTest {
    @testSetup static void setup() {
        // Create common test Account
        Account testacc = new Account();
        testacc.Name = 'VC Funds'; 
        insert testacc;  
        // Create common test Funds
        FinServ__FinancialAccount__c testfundObj = new FinServ__FinancialAccount__c();
        testfundObj.Name = 'CK Large Cap Fund'; 
        testfundObj.FinServ__PrimaryOwner__c = testacc.Id;
        insert testfundObj;  

        // Create common test Commitments
        FinServ__FinancialAccount__c testCommObj = new FinServ__FinancialAccount__c();
        testCommObj.Name = 'Test CK Commitment';
        testCommObj.Fund__c = testfundObj.id; 
        testCommObj.Committed_Amount__c = 200000;
        testCommObj.Amount_Received__c = 100000;
        testCommObj.FinServ__PrimaryOwner__c = testacc.Id;
        insert testCommObj;        
    }

    @isTest 
    static void testNewCapitalCall() {
        List<FinServ__FinancialAccount__c> funds = [SELECT id,
                                                            Name
                                                    FROM FinServ__FinancialAccount__c 
                                                    WHERE Name =: 'CK Large Cap Fund'];
        System.assert(funds.size() > 0);
        List<List<Recommendation>> result = CaptitalCallRecommendationGenerator.getCommitmentsById(funds[0].id);
        System.assert(result.size() > 0);
    }
   
}