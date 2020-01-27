/**
 * Created by Evgen on 25.01.2020.
 */

@IsTest
private class AnimalsCalloutsTests {

    static testMethod void testSuccesfulRequest() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);

        AnimalsCallouts.makeGetCallout(1);

        List<Animal__c> animals = [SELECT IdAnimal__c, Name__c From Animal__c where IdAnimal__c =1];

        System.assert(!animals.isEmpty());

    }
}