global class CapitalCallActionRecommendationGenerator {
    @InvocableMethod(
        label='Capital Call Action Recommendation Generator'
        description='This function returns recommendations for the Capital Call in our catalog.')
     global static List<List<Recommendation>> getCapitalCalls(List<CapitalCallActionRecommendationGenerateRequest> inputRequests){
        List<List<Recommendation>> outputs = new List<List<Recommendation>>();
        List<Recommendation> recs = new List<Recommendation>(); 
        List<FinServ__FinancialAccountTransaction__c> CapitalCalls;
        for (CapitalCallActionRecommendationGenerateRequest inputRequest : inputRequests)
        {
            if(String.isBlank(inputRequest.CapitalCallId) != null){
                CapitalCalls = [SELECT id,Name, FinServ__TransactionStatus__c
                             FROM FinServ__FinancialAccountTransaction__c 
                             WHERE Id=:inputRequest.CapitalCallId];
                if (CapitalCalls!=null && String.isNotBlank(CapitalCalls[0].FinServ__TransactionStatus__c))
                {
                    if(CapitalCalls[0].FinServ__TransactionStatus__c == 'New'){
                        //Email to LP
                        Recommendation rec1 = new Recommendation(
                        Name = 'Email To Limited Partner',
                        Description = 'Email To Limited Partner',
                        RelatedRecordId__c = CapitalCalls[0].Id,
                        ActionReference = 'Capital_Call_Automated_Actions',                      
                        AcceptanceLabel = 'Send Email To Limited Partner',
                        RejectionLabel = 'Later'
                        );
                        recs.add(rec1);
                        
                        //Cancel
                        Recommendation rec2 = new Recommendation(
                        Name = 'Cancel Capital Call',
                        Description = 'Cancel Capital Call',
                        RelatedRecordId__c = CapitalCalls[0].Id,
                        ActionReference = 'Capital_Call_Automated_Actions',                      
                        AcceptanceLabel = 'Cancel Capital Call',
                        RejectionLabel = 'Ignore'
                        );
                        recs.add(rec2);
                    }else if(CapitalCalls[0].FinServ__TransactionStatus__c == 'Contacted LP'){
                        //Follow up Email to LP
                        Recommendation rec1 = new Recommendation(
                        Name = 'Follow Up Email to LP',
                        Description = 'Follow Up Email to LP',
                        RelatedRecordId__c = CapitalCalls[0].Id,
                        ActionReference = 'Capital_Call_Automated_Actions',                      
                        AcceptanceLabel = 'Send Follow Up Email',
                        RejectionLabel = 'Later'
                        );
                        recs.add(rec1);
                        
                        //Cancel
                        Recommendation rec2 = new Recommendation(
                        Name = 'Capital Received',
                        Description = 'Capital Received',
                        RelatedRecordId__c = CapitalCalls[0].Id,
                        ActionReference = 'Close_Capital_Call',                      
                        AcceptanceLabel = 'Capital Received',
                        RejectionLabel = 'Ignore'
                        );
                        recs.add(rec2);

                        
                        //Cancel
                        Recommendation rec3 = new Recommendation(
                        Name = 'Cancel Capital Call',
                        Description = 'Cancel Capital Call',
                        RelatedRecordId__c = CapitalCalls[0].Id,
                        ActionReference = 'Capital_Call_Automated_Actions',                      
                        AcceptanceLabel = 'Cancel Capital Call',
                        RejectionLabel = 'Ignore'
                        );
                        recs.add(rec3);
                    }
                    
                } else {
                    
                }
            }
            //Database.insert(recs, true);
            outputs.add(recs);
        }
        return outputs; 
    }
    global static List<List<Recommendation>> getCapitalCallsId(String Id){
        List<CapitalCallActionRecommendationGenerateRequest > inputRequests = new List< CapitalCallActionRecommendationGenerateRequest>();
        CapitalCallActionRecommendationGenerateRequest req = new CapitalCallActionRecommendationGenerateRequest();
        req.CapitalCallId = Id;
        inputRequests.add(req);
        List<List<Recommendation>> result = CapitalCallActionRecommendationGenerator.getCapitalCalls(inputRequests);
        return result;
    }
    global class CapitalCallActionRecommendationGenerateRequest {
        @InvocableVariable(label='CapitalCallId')
        global String CapitalCallId;
    }
    
}