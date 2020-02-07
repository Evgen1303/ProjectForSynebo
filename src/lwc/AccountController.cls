public with sharing class AccountController {
    @AuraEnabled (cacheable = true)
    public static List<Account> searchAccount(String accName) {


        List<List<sObject>> searchList = [FIND :accName IN ALL FIELDS
                RETURNING Account(Id,Name,Website,Industry, Phone),Contact(FirstName,LastName,Department), Lead(Name,Company)];
        List<Account> accounts = (Account[])searchList[0];
        List<Contact> contacts = (Contact[])searchList[1];
        List<Lead> leads = (Lead[])searchList[2];
        return accounts;
    }

}