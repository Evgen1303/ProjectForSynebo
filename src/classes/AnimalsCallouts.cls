/**
 * Created by Evgen on 25.01.2020.
 */

public with sharing class AnimalsCallouts {
    //  @future(callout=true)
    public static void makeGetCallout(Integer idAnimal) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + idAnimal);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug(response.getBody());

        if (response.getStatusCode() == 200) {
            AnimalDTO animalDTO = AnimalDTO.parse(response.getBody());
            Animal__c animal = new Animal__C();
            animal.IdAnimal__c = animalDTO.animal.id;
            animal.Name__c = animalDTO.animal.name;
            animal.Eats__c = animalDTO.animal.eats;
            animal.Says__c = animalDTO.animal.says;

            List<Animal__c> animals = [SELECT IdAnimal__c From Animal__c where IdAnimal__c = :animalDTO.animal.id];
            if (animalDTO.animal.id != 0) {
                if (animals.isEmpty()) {
                    insert animal;
                    System.debug('Record added: ' + animal);
                } else {
                    System.debug('Record already exists');
                }
            } else {
                System.debug('Record id = 0');
            }
        } else {
            System.debug('Error ' + response.getStatus());
        }

    }
    @future(callout=true)
    public static void makeGetCalloutInMyAPI(Integer idAnimal) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://evgeniyapi-developer-edition.eu29.force.com/services/apexrest/Animals/1');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
    }

    public static HttpResponse makePostCallout(String name) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"'+name+'"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }


}