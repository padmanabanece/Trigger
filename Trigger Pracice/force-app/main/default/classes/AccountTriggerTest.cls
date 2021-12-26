@isTest
 private class AccountTriggerTest {
    static testMethod void insertContact(){
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.Name='Test1';
        acc.Rating='warm';
        accList.add(acc) ;
        Account acc1 = new Account();
        acc1.Name='Test2';
        acc1.Rating='warm';
        accList.add(acc1);
        test.startTest();
            insert accList;
        test.stopTest();
        List<Contact> con =[SELECT Id From Contact WHERE AccountId IN:accList];
        System.assert(con.size()==2);
    }
    static testMethod void createOppurtunity(){
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.Name='Test1';
        acc.Rating='warm';
        accList.add(acc) ;
        insert accList;
        Test.startTest();
        for (Account accLi : accList) {
            accLi.Rating='Hot';
        }
        update accList;
        Test.stopTest();
        Opportunity opp = [SELECT Id FROM Opportunity WHERE AccountId IN :accList];
        System.assert(opp.Id!=null);
    }
    static testMethod void validateAccountBeforeInsertTest(){
       
        Account acc = new Account();
        acc.Name='Test1';
        acc.Rating='Hot';      
        
        Test.startTest();
           Database.SaveResult saveResult=Database.insert(acc, false);
        Test.stopTest();
        
    }
    static testMethod void preventAccouontDeletionTest(){
       
        Account acc = new Account();
        acc.Name='Test1';
        acc.Rating='warm';  
        insert acc;

        Contact con = new Contact();
        con.AccountId=acc.Id;
        con.LastName='testContact';
        con.isPrimary__c=true;
        insert con;   
        
        Test.startTest();
           Database.DeleteResult deleteResult=Database.delete(acc, false);
        Test.stopTest();
        
    }
}
