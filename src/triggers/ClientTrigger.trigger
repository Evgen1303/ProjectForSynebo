trigger ClientTrigger on Client__c (before insert, before update, before delete) {
    if (Trigger.isInsert) {
HandlerClientTrigger.handleInsert(Trigger.new);
} else if (Trigger.isUpdate) {
HandlerClientTrigger.handleUpdate(Trigger.new);
} else if (Trigger.isDelete) {
HandlerClientTrigger.handleDelete(Trigger.old);
}
}