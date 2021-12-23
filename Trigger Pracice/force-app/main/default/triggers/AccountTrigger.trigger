trigger AccountTrigger on Account (before insert, after insert, after update) {
    if(trigger.isInsert && trigger.isBefore){
        AccountTriggerHandler.validateAccountBeforeInsert(trigger.new);
    }

    if (trigger.isInsert && trigger.isAfter) {
        AccountTriggerHandler.insertContact(trigger.new);
        
    }
    if(trigger.isUpdate && trigger.isUpdate){
        AccountTriggerHandler.createOppurtunity(trigger.newMap, trigger.oldMap);
    }
}