/**
 * Created by Evgen on 26.01.2020.
 */

@RestResource(urlMapping='/Animals/*')
global with sharing class AnimalsManagerService {
    @HttpGet
    global static Animal__c getAnimalById() {
        RestRequest request = RestContext.request;
        Decimal animalId = Decimal.valueOf(request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1));

        List<Animal__c> result = new List<Animal__c>();
        result = queryAnimals(animalId);

        if(result.isEmpty()) {
         AnimalsCallouts.makeGetCallout(Integer.valueOf(animalId));
            result = queryAnimals(animalId);
            if (!result.isEmpty()) {

                return result.get(0);
            }
            else{
                return null;
            }
        }
        else{
            return result.get(0);
        }
    }

    private static List<Animal__c> queryAnimals(Decimal animalId){
        List<Animal__c> animals = new List<Animal__c>();
        animals = [
                SELECT IdAnimal__c,Name__c,Says__c,Eats__c
                FROM Animal__c
                WHERE IdAnimal__c = :animalId
        ];

        return animals;
    }
}