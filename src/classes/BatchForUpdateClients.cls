global class BatchForUpdateClients implements
                Database.Batchable<sObject>, Database.Stateful {

    global Integer recordsProcessed = 0;
    global Decimal totalCredits = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
                'SELECT ID, Name, Count_Credits__c, Description__c From Client__c');
    }

    global void execute(Database.BatchableContext bc, List<Client__c> scope) {
        List<Credit__c> credits = [SELECT Id, Client__c FROM  Credit__c WHERE Client__c in :scope];
        for (Client__c client : scope) {
            Integer count_child = 0;
            for (Credit__c credit: credits){
                if(credit.Client__c == client.Id){
                    count_child++;
                }
            }

            client.Count_Credits__c = count_child;
            client.Description__c = 'Count of credits: ' +
                    client.Count_Credits__c +
                    '. Last general check: ' +
                    System.now();

            System.debug(client.Name + ': ' + client.Description__c);
            totalCredits = totalCredits + client.Count_Credits__c;
            recordsProcessed = recordsProcessed + 1;
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {

        System.debug('Processed records: ' + recordsProcessed);
        System.debug('total number of loans: ' + totalCredits);

    }
}