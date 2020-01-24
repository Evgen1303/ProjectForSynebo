/**
 * Created by Evgen on 23.01.2020.
 */

trigger CreditTrigger on Credit__c (after insert, after delete, after update ) {

    if (Trigger.isInsert || Trigger.isUpdate) {
        HandlerCreditTrigger.handleQueryCredit(Trigger.new);
    } else if (Trigger.isDelete) {
        HandlerCreditTrigger.handleQueryCredit(Trigger.old);
    }
}