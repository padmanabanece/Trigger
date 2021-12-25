@isTest
 private class AccountTriggerTest {
    static testMethod void insertContact(){
        Account acc = new Account();
        acc.Name='Test1';
        acc.Rating='warm';
        test.startTest();
            insert acc;
        test.stopTest();
    }
    
}
