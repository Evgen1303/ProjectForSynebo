@IsTest
private class BatchForUpdateClientsTests {
    @testSetup
    static void generateClientsAndCredits() {

        Integer countClients = 200;
        Integer countCredits = 15;
        List<Client__c> clients = new List<Client__c>();
        List<Credit__c> credits = new List<Credit__c>();


        for (Integer i = 0; i < countClients; i++) {
            clients.add(
                    new Client__c(
                            Name = 'Test name ' + i,
                            Last_name__c = 'Test LastName ' + i
                    ));
        }
        insert clients;

        for (Client__c client : clients) {
            for (integer j = 0; j < countCredits; j++) {
                credits.add(
                        new Credit__c(
                                Name = 'New credit ' + j + 'for ' + client.Name,
                                Amount__c = 5000,
                                Client__c = client.Id));
            }
        }
        insert credits;

    }


    @isTest static void test() {
        Test.startTest();
        BatchForUpdateClients myBatchClassForClients = new BatchForUpdateClients();
        Id batchId = Database.executeBatch(myBatchClassForClients);
        Test.stopTest();
        System.assertEquals(200, [select count() from Client__c]);
        Client__c client = [SELECT id,Description__c from Client__c][0];
        System.assert(client.Description__c.contains('Last general check'));


    }
}