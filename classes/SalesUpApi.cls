//APi for the sales Up Object
//Tested by SalesUpControllerTest
public without sharing class SalesUpApi {
  
    public static Sales_Up__c createSalesUp(SalesUp.SalesUpWrapper sup) {
        Savepoint sp = Database.setSavepoint();
        try {
            Contact c = new Contact();
            Account a = upsertAccount(sup.buyerAccount, sup.BypassDuplicateMatching);

            Boolean isPersonAccount = [SELECT IsPersonAccount FROM Account WHERE Id =: sup.buyerAccount.id].IsPersonAccount;
            if (sup.buyerContact != null && !isPersonAccount) {
                sup.buyerContact.AccountId = a.id; 
                c = upsertContact(sup.buyerContact, sup.BypassDuplicateMatching);
                sup.salesUp.Buyer_Contact__c = c.Id;
            }
            if(isPersonAccount){
                sup.salesUp.Buyer_Contact__c =[SELECT Id FROM Contact WHERE Account.Id =: a.id].Id;
            }
            User currentUser = [SELECT In_BDC__c FROM USER WHERE Id =: userInfo.getUserId()];
            if(currentUser.In_BDC__c != null && currentUser.In_BDC__c == true){
                sup.salesUp.dealer__CCC_Rep__c = userInfo.getuserId();
            }else{
                sup.salesUp.Salesperson_1__c = userInfo.getUserId();
            }
            if(sup.TrafficLogs.size() > 0){
                insert sup.TrafficLogs;                                                  
                sup.salesUp.dealer__Traffic_Log_Entry__c=sup.TrafficLogs[0].Id;
            }

            sup.salesUp.Customer_Account__c = a.Id;
            insert sup.salesUp;

            if(sup.TrafficLogs.size() > 0){
                for(Traffic_Log__c log : sup.TrafficLogs){
                    log.dealer__Sales_Lead__c=sup.salesUp.Id;
                }
                
                update sup.TrafficLogs;
            }
        } catch (DMLException e) {
            throw new AuraHandledException('Error creating Sales Up: '
                + e.getMessage());
            Database.rollback(sp);
        } catch (QueryException e){
            throw new AuraHandledException('Error Creating Sales Up: '
            +e.getMessage());
            Database.rollback(sp);
        }
        return sup.salesUp;
    }
    public static SalesUp getSalesUpRecord(Sales_Up__c sup){
        return new SalesUp(sup);
    }
    //to be called after duplicate check.
    public static Account upsertAccount(Account account, Boolean allowSave) {
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = allowSave;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        if (account.id != null) {
            upsert account;
        } else { //insert event with duplicate override 
            Database.SaveResult accSr = Database.insert(account, dml);
        }
        return account;
    }
    public static Contact upsertContact(Contact contact, Boolean allowSave){
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = allowSave;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        if(contact.Id == null){
            Database.SaveResult contactSR = Database.insert(contact,dml);
        }else{
           upsert contact;
        }
        

        return contact;
    }
    public static List < sObject > findCustomerDuplicates(Account account) {
        Savepoint sp = Database.setSavepoint();
        List < sObject > duplicateResults = new List < sobJect > ();
        Database.UpsertResult saveResult = Database.upsert(account, false);
        if (!SaveResult.isSuccess()) {
            for (Database.Error error: saveResult.getErrors()) {
                if (error instanceOf Database.DuplicateError) {

                    //handle duplicate error
                    Database.DuplicateError duplicateError = (database.DuplicateError) error;
                    Datacloud.DuplicateResult duplicateResult = duplicateError.getDuplicateResult();

                    //create duplicate result list:
                    Datacloud.MatchResult[] matchResults =
                    duplicateResult.getMatchResults();

                    Datacloud.MatchResult matchResult = matchResults[0];
                    Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();

                    for (Datacloud.MatchRecord matchRecord: matchRecords) {
                        duplicateResults.add(matchRecord.getRecord());
                    }
                }
            }
        } else { //is success
            Database.rollback(sp);
        }
        set < Id > drSet = new Set < Id > ();
        for (sObject dr: duplicateResults) {
            drSet.add(dr.Id);
        }

        return [SELECT Id, Name, FirstName, LastName, 
        IsPersonAccount, PersonEmail, PersonMailingState,
        PersonMailingStreet, PersonMailingCity, PersonMailingPostalCode,
        PersonMailingCountry, Phone, PersonMobilePhone,
        BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry
        FROM Account WHERE Id In: drSet];
    }

    public class SalesUp{
        @AuraEnabled public Sales_up__c header;
        @AuraEnabled public Dealer_Location__c location;
        @AuraEnabled public Contact buyer;
        @AuraEnabled public Contact coBuyer;
        @AuraEnabled public Vehicle_Inventory__c vehicle;
        @AuraEnabled public Service_Vehicle__c tradeIn;
        @AuraEnabled public Parts_Kit__c conversion;

        public SalesUp(Sales_Up__c sup){
            header = sup.Id != null ? (Sales_up__c)Utility.queryAllFields('dealer__Sales_Up__c', sup.Id) : new Sales_up__c();
            location = new Dealer_Location__c();
            buyer = new Contact();
            coBuyer = new Contact();
            vehicle = new Vehicle_Inventory__c();
            tradeIn = new Service_Vehicle__c();
            conversion = new Parts_Kit__c();
            
            sup = sup.Id == null ? new Sales_up__c() : [
                SELECT Id, Name,
                Store_Location__c, Store_Location__r.Name, Store_Location__r.Company_Number__c,
                Buyer_Contact__c, Buyer_Contact__r.Name,       
                Co_Buyer_Contact__c, Co_Buyer_Contact__r.Name,  
                Desired_Stock_Num__c, Desired_Stock_Num__r.Name,
                Service_Vehicle__c, Service_Vehicle__r.Name,
                ConversionPartsKit__c, ConversionPartsKit__r.Name, ConversionPartsKit__r.Description__c
                FROM Sales_up__c WHERE id =: sup.Id
            ];

            if(sup.Store_Location__c != null){
                location = sup.Store_Location__r;
            }
            if(sup.Buyer_Contact__c != null){
                buyer = sup.Buyer_Contact__r;
            }
            if(sup.Co_Buyer_Contact__c != null){
                coBuyer = sup.Co_Buyer_Contact__r;
            }
            if(sup.Desired_Stock_Num__c != null){
                vehicle = sup.Desired_Stock_Num__r;
            }
            if(sup.Service_Vehicle__c != null){
                tradeIn = sup.Service_Vehicle__r;
            }
            if(sup.ConversionPartsKit__c != null){
                conversion = sup.ConversionPartsKit__r;
            }
        }
    }
}