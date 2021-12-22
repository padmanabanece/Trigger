trigger AccountTrigger on Account (before insert, after insert) {
    if(trigger.isInsert && trigger.isBefore){
        AccountTriggerHandler.validateAccountBeforeInsert(trigger.new);
    }

    if (trigger.isInsert && trigger.isAfter) {
        AccountTriggerHandler.insertContact(trigger.new);
        
    }
}