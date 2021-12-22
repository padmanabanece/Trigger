public with sharing class OppWonAccountHotHandler {
    public OppWonAccountHotHandler() {

    }
    public static void insertService(List<Opportunity> oppList){
        List<Id> accId = new List<Id>();
        List<Account> accList = new List<Account>();
        for(Opportunity opp : oppList){
            if (opp.StageName=='Closed won' && opp.AccountId !=null) {
                accId.add(opp.AccountId);
            }
        }
        List<Account> accListResult =[SELECT Id,Rating FROM Account 
            WHERE Id In:accId];
        for (Account account : accListResult) {
            account.Rating='Hot';
            accList.add(account);
        }
        if (accList.size()>0) {
            update accList;
        }
        
    }
    public static void updateService(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        List<Id> accId = new List<Id>();
        List<Account> accList = new List<Account>();
        for(Opportunity opp : oppList){
            if (opp.StageName=='Closed won' && opp.AccountId !=null
                                && opp.StageName!=  oldMap.get(opp.Id).StageName) {
                accId.add(opp.AccountId);
            }
        }
        List<Account> accListResult =[SELECT Id,Rating FROM Account 
            WHERE Id In:accId];
        for (Account account : accListResult) {
            account.Rating='Hot';
            accList.add(account);
        }
        if (accList.size()>0) {
            update accList;
        }
        
    
     }
}
