/**
 * Created by Evgen on 26.01.2020.
 */

@RestResource(urlMapping='/Animals/*')
global with sharing class AnimalsManagerService {
    @HttpGet
    global static Animal__c getAnimalById() {
        RestRequest request = RestContext.request;
        String requestindex = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);
        if (!requestindex.isNumeric()) {
            RestContext.response.statusCode = 400;
            return null;
        }
        Decimal animalId = Decimal.valueOf(requestindex);
        List<Animal__c> result = new List<Animal__c>();
        result = queryAnimals(animalId);

        if (result.isEmpty()) {
            AnimalsCallouts.makeGetCallout(Integer.valueOf(animalId));
            result = queryAnimals(animalId);
            if (!result.isEmpty()) {

                return result.get(0);
            } else {
                RestContext.response.statusCode = 404;
                return null;
            }
        } else {
            return result.get(0);
        }

    }
    @HttpPost
    global static Animal__c createAnimal(String name, String eats,
            String says) {
        Animal__c animal = new Animal__c(
                Name__c = name,
                Eats__c = eats,
                Says__c = says
        );
        insert animal;
        return animal;
    }
    private static List<Animal__c> queryAnimals(Decimal animalId) {
        List<Animal__c> animals = new List<Animal__c>();
        animals = [
                SELECT IdAnimal__c,Name__c,Says__c,Eats__c
                FROM Animal__c
                WHERE IdAnimal__c = :animalId
        ];
        return animals;
    }
}