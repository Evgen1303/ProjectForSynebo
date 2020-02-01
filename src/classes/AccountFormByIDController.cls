public class AccountFormByIDController {
    @AuraEnabled
    public static Account find_AccById(Id get_accountid) {
        Account account  = new Account();
        if(get_accountid != null ) {
            account = [SELECT Id, Name, Type, Industry from Account where ID = :get_accountid];
        }
        else{
            account =  [SELECT ID,  Name, Type, Industry from Account LIMIT 1];
        }
        return account;
        
    }
 
}