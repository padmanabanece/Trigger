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