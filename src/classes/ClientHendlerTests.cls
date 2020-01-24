@IsTest
private class ClientHendlerTests {
    @isTest static void testInsert() {
        integer count = 10;

        List<Client__c> clients = genereteClients(count);
        System.assertEquals(HandlerClientTrigger.handleInsert(clients), count);
    }

    @isTest static void testUpdate() {
        Integer countClients = 5;
        Integer countCredits = 3;

        List<Client__c> clients =
                genereteClientsAndCredits(countClients, countCredits);

        List<Client__c> updClients = HandlerClientTrigger.handleUpdate(clients);

        for (Client__c client : updClients) {
            System.assertEquals(client.Count_Credits__c, countCredits);
        }
    }

    @isTest static void testDelete() {
        Integer countClients = 5;
        Integer countCredits = 3;

        List<Client__c> clients = genereteClientsAndCredits(countClients, countCredits);

        List<Client__c> delClients = HandlerClientTrigger.handleDelete(clients);

        for (Client__c client : delClients) {
            System.assertEquals(client.Count_Credits__c, countCredits);
        }
        Client__c clt = [
                SELECT Id, Name, (SELECT id from Credits__r)
                FROM Client__c
                LIMIT 1
        ];
        System.assertEquals(clt.Credits__r.size(), 0);
    }

    private static List<Client__c> genereteClients(integer a) {
        List<Client__c> c = new List<Client__c>();

        for (Integer i = 0; i < a; i++) {
            Client__c client = new Client__c(
                    Name = 'TestName' + i,
                    Last_name__c = 'TestLastName' + i);
            c.add(client);
        }

        insert c;
        return c;
    }

    private static List<Client__c> genereteClientsAndCredits(integer countClients, integer countCredits) {

        List<Client__c> clients = genereteClients(countClients);
        List<Credit__c> credits = new List<Credit__c>();

        for (Client__c c : clients) {
            for (Integer j = 0; j < countCredits; j++) {
                credits.add(
                        new Credit__c(
                                Name = 'New credit',
                                Amount__c = 5000,
                                Client__c = c.Id));
            }
        }
        insert credits;
        return clients;
    }
}