public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {
        
    }
    public static void validateAccountBeforeInsert(List<Account> accountList){
        for (Account acc : accountList) {
            if (acc.Rating == 'Hot' && acc.Type==null) {
                acc.addError('Account Type is Mandatory when Rating is Hot');
            }

        }
    }
    public static void insertContact(List<Account> accountList){
        List<Contact> conList = new List<Contact>();
        for (Account variable : accountList) {
            Contact con = new Contact();
            con.LastName=variable.Name;
            con.AccountId=variable.Id;
            conList.add(con);
        }
        if (conList!=null && conList.size()>0) {
            insert conList;
        }
    }
    public static void createOppurtunity(Map<Id,Account> newAccMap, Map<Id,Account> oldAccMap){
        List<Opportunity> oppList = new List<Opportunity>();
        for (Account acc : newAccMap.values()) {
            if (newAccMap.get(acc.Id).Rating != oldAccMap.get(acc.Id).Rating 
                        && newAccMap.get(acc.Id).Rating == 'Hot' ) {
                Opportunity opp = new Opportunity();
                opp.AccountId=acc.Id;
                opp.Name=acc.Name;
                opp.StageName='Needs Analysis';
                opp.CloseDate=System.today().addDays(4);
                oppList.add(opp);
            }
        }
        if (oppList != null && opplist.size()>0) {
            try {
                insert oppList;
            } catch (Exception e) {
                System.debug('error'+e.getMessage());
            }
           
        }
    }
    public static void preventAccountDeletion(List<Account> accList){
        Set<Id> accIdSet = new Set<Id>();
        Map<Id,Boolean> isAccountIdsPrimaryMap = new Map<Id,Boolean>();
        for (Account acc : accList) {
            accIdSet.add(acc.Id);
        }
        for (Contact con : [SELECT Id,isPrimary__c,AccountId from Contact
                                WHERE AccountId IN :accIdSet AND isPrimary__c=True]) {
            isAccountIdsPrimaryMap.put(con.Id, con.isPrimary__c);
        }
        for (Account acc : accList) {
            if (isAccountIdsPrimaryMap.containsKey(acc.Id)) {
                acc.addError('This Account Can\'t be deleted.It contains Primary Contact');
            }
        }
    }
}
