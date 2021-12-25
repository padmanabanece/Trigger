@isTest
 private class AccountTriggerTest {
    static testMethod void insertContact(){
        Account acc = new Account();
        acc.Name='Test1';
        acc.Rating='warm';
        test.startTest();
            insert acc;
        test.stopTest();
        Contact con =[SELECT Id From Contact WHERE AccountId =:acc.Id];
        System.assert(con.Id !=null);
    }
    
}
