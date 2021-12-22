// Trigger functionality on Opportunity stage is 'closed won' 
//     then corresponding Account record should be update with Rating is 'Hot'

trigger OppWonAccountHotTrigger on Opportunity (after insert,after update) {
    List<Opportunity> oppList = trigger.new;
    Map<Id,Opportunity> oppMap=trigger.oldMap;

    if (trigger.isAfter && trigger.isInsert) {
        OppWonAccountHotHandler.insertService(oppList);
    }
    if (trigger.isAfter && trigger.isUpdate) {
        OppWonAccountHotHandler.updateService(oppList,oppMap);
    }
}