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
}
