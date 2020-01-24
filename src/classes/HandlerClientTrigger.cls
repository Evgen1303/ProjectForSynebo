public with sharing class HandlerClientTrigger {

    //Counts the number of clients added
    public static integer handleInsert(List<Client__c> newClients) {
        system.debug(newClients.size() + ' new clients added');

        for (Client__c client : newClients) {
            system.debug('added: ' + client.Name);
        }
        return newClients.size();
    }

    //For updated records, counts the number of child objects
    public static List<Client__c> handleUpdate(List<Client__c> clients) {
        List<Client__c> updClients = [
                SELECT Id, Name, (SELECT id from Credits__r)
                FROM Client__c
                WHERE Id IN :clients
        ];
        for (Client__c client : clients) {
            for (Client__c uClient : updClients) {
                if (client.Id == uClient.Id) {
                    client.Count_Credits__c = uClient.Credits__r.size();
                    break;
                }

            }
        }
        return clients;
    }

    //For deleted records, counts the number of child objects and deletes child objects
    public static List<Client__c> handleDelete(List<Client__c> delClients) {
        List<Client__c> clients = [
                SELECT Id, Name, (SELECT id from Credits__r)
                FROM Client__c
                WHERE Id IN :delClients
        ];
        List<Client__c> clntList = countChild(clients);
        List<Credit__c> credits = [
                SELECT Id,Client__c
                FROM Credit__c
                WHERE Client__c IN :delClients
        ];
        delete credits;
        system.debug(clntList.size() + ' clients deleted');
        return clntList;
    }

    //Method for counting the number of children
    public static List<Client__c> countChild(List<Client__c> clients) {
        for (Client__c client : clients) {
            client.Count_Credits__c = client.Credits__r.size();
        }
        return clients;
    }

}