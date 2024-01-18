/**
 * @description       : 
 * @author            : syed.shabbar@cloudkaptan.com
 * @group             : 
 * @last modified on  : 09-01-2024
 * @last modified by  : syed.shabbar@cloudkaptan.com
**/
public with sharing class VCFundUtility {
    
    /**
    * @description - takes fund Id and returns all commitments associated with it. 
                        This function does not need to be bulkified.
    * @author syed.shabbar@cloudkaptan.com | 09-01-2024 
    * @param fundId 
    * @return List<FinServ__FinancialAccount__c> 
    **/
    @AuraEnabled(cacheable=true)
    public static List<FinServ__FinancialAccount__c> getCommitments(String fundId) {
        if(!String.isBlank(fundId)){
            return [SELECT Id, 
                            Name,
                            FinServ__PrimaryOwner__c,
                            FinServ__TargetLimit__c,
                            FinServ__Balance__c,
                            FinServ__Status__c
                        FROM FinServ__FinancialAccount__c
                        WHERE Fund__c =: fundId];
        } else{
            return [SELECT Id, 
                            Name,
                            FinServ__PrimaryOwner__c,
                            FinServ__TargetLimit__c,
                            FinServ__Balance__c,
                            FinServ__Status__c
                        FROM FinServ__FinancialAccount__c];
        }
    }
}