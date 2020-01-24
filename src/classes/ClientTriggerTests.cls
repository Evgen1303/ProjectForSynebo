@IsTest
private class ClientTriggerTests {
    @isTest static void testClientTriggerInsertSuccessfully() {

        List<Client__c> clients = genereteClients(10);
        Test.startTest();
        insert clients;
        Test.stopTest();
    }

    @isTest static void testClientTriggerInsertFailed() {
        try {
            Client__c client = new Client__c();
            Test.startTest();
            insert client;
            Test.stopTest();
        } catch (Exception e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('Required fields are missing');
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }

    @isTest static void testClientTriggerDelete() {
        Test.startTest();
        List<Client__c> clients = genereteClients(10);
        insert clients;
        List<Database.DeleteResult> results = Database.delete(clients);

        for (Database.DeleteResult result : results) {
            System.assert(result.isSuccess());
        }
        Test.stopTest();
    }

    @isTest static void testClientTriggerUpdate() {

        List<Client__c> insertClients = genereteClients(10);
        insert insertClients;

        List<Client__c> c = [
                SELECT Id,Description__c
                FROM Client__c
        ];

        List<Client__c>updClients = new List<Client__c>();
        for (Client__c client : c) {
            client.Description__c = 'Test update';
            updClients.add(client);
        }

        update updClients;

        System.AssertEquals(updClients.get(0).Description__c, 'Test update');
    }

    private static List<Client__c> genereteClients(integer a) {
        List<Client__c> c = new List<Client__c>();

        for (Integer i = 0; i < a; i++) {
            Client__c client = new Client__c(
                    Name = 'TestName' + i,
                    Last_name__c = 'TestLastName' + i);
            c.add(client);
        }
        return c;
    }


}