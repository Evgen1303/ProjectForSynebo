global class BatchForUpdateClients implements
                Database.Batchable<sObject>, Database.Stateful {

    global Integer recordsProcessed = 0;
    global Decimal totalCredits = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
                'SELECT ID,Name,Count_Credits__c,' +
                        '(SELECT id from Credits__r) ' +
                        'From Client__c');
    }

    global void execute(Database.BatchableContext bc, List<Client__c> scope) {
        List<Client__c> clients = HandlerClientTrigger.countChild(scope);
        for (Client__c client : clients) {
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