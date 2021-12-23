trigger AccountTrigger on Account (before insert, after insert, after update) {
    if(trigger.isInsert && trigger.isBefore){
        AccountTriggerHandler.validateAccountBeforeInsert(trigger.new);
    }

    if (trigger.isInsert && trigger.isAfter) {
        AccountTriggerHandler.insertContact(trigger.new);
        
    }
    if(trigger.isUpdate && trigger.isAfter){
        AccountTriggerHandler.createOppurtunity(trigger.newMap, trigger.oldMap);
    }
    if (trigger.isDelete && trigger.isBefore) {
        AccountTriggerHandler.preventAccountDeletion(trigger.old);
    }
}