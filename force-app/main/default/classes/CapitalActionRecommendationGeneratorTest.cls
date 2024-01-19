/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-19-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class CapitalActionRecommendationGeneratorTest {
    @testSetup static void setup() {
        // Create common test account
        List<FinServ__FinancialAccountTransaction__c> testTrans = new List<FinServ__FinancialAccountTransaction__c>();
        FinServ__FinancialAccountTransaction__c testTransObj = new FinServ__FinancialAccountTransaction__c();
        testTransObj.FinServ__TransactionStatus__c = 'New';
        testTransObj.FinServ__Amount__c = 1200.00; 
        testTransObj.FinServ__TransactionDate__c = Date.Today(); 
        testTrans.add(testTransObj);
        
        FinServ__FinancialAccountTransaction__c testTransObj2 = new FinServ__FinancialAccountTransaction__c();
        testTransObj2.FinServ__TransactionStatus__c = 'Contacted LP'; 
        testTransObj2.FinServ__Amount__c = 1200.00; 
        testTransObj2.FinServ__TransactionDate__c = Date.Today(); 
        testTrans.add(testTransObj2);
        
        insert testTrans;
    }

    @isTest 
    static void testNewCapitalCall() {
        List<FinServ__FinancialAccountTransaction__c> CapitalCalls = [SELECT id,Name, FinServ__TransactionStatus__c
                                                                    FROM FinServ__FinancialAccountTransaction__c 
                                                                    WHERE FinServ__TransactionStatus__c = 'New'];
        System.assert(CapitalCalls.size() > 0);
                                                                   
        List<List<Recommendation>> result = CapitalCallActionRecommendationGenerator.getCapitalCallsId(CapitalCalls[0].id);
        System.assert(result.size() > 0);
    }
    @isTest 
    static void testContactedCapitalCall() {
        List<FinServ__FinancialAccountTransaction__c> CapitalCalls = [SELECT id,Name, FinServ__TransactionStatus__c
                                                                    FROM FinServ__FinancialAccountTransaction__c 
                                                                    WHERE FinServ__TransactionStatus__c = 'Contacted LP'];
        System.assert(CapitalCalls.size() > 0);
                                                                   
        List<List<Recommendation>> result = CapitalCallActionRecommendationGenerator.getCapitalCallsId(CapitalCalls[0].id);
        System.assert(result.size() > 0);
    }
   
}