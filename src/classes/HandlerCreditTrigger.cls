/**
 * Created by Evgen on 23.01.2020.
 */

public with sharing class HandlerCreditTrigger {

    public static void handleQueryCredit(List<Credit__c> credits) {
        List<id> idClients = new List<Id>();
        For (Credit__c credit : credits) {
            idClients.add(credit.Client__c);
        }
        List<Client__c> clients = [SELECT Id FROM Client__c WHERE id in :idClients];
        update clients;
    }

}