public with sharing class FormTestController {

    @AuraEnabled
    public static List<Account> getListAccounts(String name) {
        List<Account> listAccounts = new List<Account>();
        if(name == null || name == ''){
        listAccounts = [SELECT  Id, Name, Rating, Phone, Type FROM  Account];
        }
        else
        {
       listAccounts = [SELECT  Id, Name, Rating, Phone, Type FROM  Account Where Name = :name];
        }
        return listAccounts;
    }

}