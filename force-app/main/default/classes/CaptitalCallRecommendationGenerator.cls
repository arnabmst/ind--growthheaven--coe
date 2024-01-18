global class CaptitalCallRecommendationGenerator {
    @InvocableMethod(
        label='Initiate Capital Call Recommendation Generator'
        description='This function returns recommendations for the Initiate Capital Call in our catalog.')
     global static List<List<Recommendation>> getcommitments(List<CapitalCallActionRecommendationGenerateRequest> inputRequests){
        List<List<Recommendation>> outputs = new List<List<Recommendation>>();
        List<Recommendation> recs = new List<Recommendation>(); 
        List<FinServ__FinancialAccount__c> commitments;
        for (CapitalCallActionRecommendationGenerateRequest inputRequest : inputRequests)
        {
            if(String.isBlank(inputRequest.FundId) != null){
                  commitments = [SELECT id,Name, Committed_Amount__c, Amount_Received__c
                             FROM FinServ__FinancialAccount__c 
                             WHERE Fund__c =:inputRequest.FundId
                             AND Committed_Amount__c !=null ];
                if (commitments!=null && commitments.size() > 0)
                {
                        for(FinServ__FinancialAccount__c comOb : commitments){
                            if(comOb.Committed_Amount__c != null && comOb.Amount_Received__c != null &&
                                    comOb.Committed_Amount__c > comOb.Amount_Received__c){
                                Recommendation rec = new Recommendation(
                                Name = comOb.Name,
                                Description = 'Commited Amount : '+ comOb.Committed_Amount__c +' Recieved Amount : '+ comOb.Amount_Received__c ,
                                RelatedRecordId__c = comOb.Id,
                                ActionReference = 'Initiate_Capital_Call_Fund',                      
                                AcceptanceLabel = 'Initiate Capital Call',
                                RejectionLabel = 'Ignore'
                                );
                                recs.add(rec);
                             }
                        }
                        
                 }
            }
            //Database.insert(recs, true);
            outputs.add(recs);
        }
        return outputs; 
    }
    global class CapitalCallActionRecommendationGenerateRequest {
        @InvocableVariable(label='FundId')
        global String FundId;
    }
    
}