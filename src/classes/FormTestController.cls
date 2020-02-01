public with sharing class FormTestController {

    @AuraEnabled
    public static List<Account> getListAccounts(String name) {
        List<Account> listAccounts = new List<Account>();
        String queryString = 'SELECT  Id, Name, BillingState, Website, Phone, Industry, Type, UrlLink__c FROM  Account ';

       if(String.isNotBlank(name)){
			 queryString = queryString +' WHERE Name LIKE  \'%'+name+ '%\'';
        }
	  
        listAccounts = Database.query(queryString);
        
        for(Account acc: listAccounts){
            acc.UrlLink__c = 'https://evgeniytest-dev-ed.lightning.force.com/c/AccountApp.app?GetIdFromUrl='+acc.Id;
        }
        
        return listAccounts;
    }

}