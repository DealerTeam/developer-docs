/**
 * DMSImportsAPI
 * @description
 */
public with sharing class DMSImportsAPI {
    
    /* Header Level Items */

    /**
     * upsertAccounts 
     * @param  jobId   
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertAccounts(String jobId, String objJSON){
        List<Account> accounts = new List<Account>();
        List<String> successes = new List<String>();
        List<String> sRErrors = new List<String>();
        List<String> errors = new List<String>();
        try{
            Schema.DescribeFieldResult f = Account.External_ID__c.getDescribe();
            Schema.sObjectField externalIdField = f.getSObjectField();
            accounts = (List<Account>)JSON.deserialize(objJSON,List<Account>.class);

            // From Person Account Change Event.
            if(accounts.size() == 1 && accounts[0].Id != null){ 
                Id recordId = accounts[0].Id;
                String externalId = accounts[0].External_ID__c;
                String sObjectName = recordId.getSObjectType().getDescribe().getName();
                if(sObjectName == 'Contact'){
                    Contact c = [SELECT Id, AccountId FROM Contact WHERE Id =: recordId];
                    if(c.AccountId != null){
                        accounts = new List<Account>();
                        accounts.add(new Account(Id = c.AccountId, External_ID__c = externalId));
                    }
                }
            }

            List<Account> externalIdAccounts = new List<Account>();
            List<Account> idAccounts = new List<Account>();
            for(Account acc : accounts){
                if(acc.Id != null){
                    idAccounts.add(acc);
                }
                else if(acc.External_ID__c != null){
                    externalIdAccounts.add(acc);
                }
            }
            
            Set<Id> successfulAccounts = new Set<Id>();
            if(idAccounts.size() > 0){
                Database.UpsertResult[] idsr = Database.upsert(idAccounts, false);
                for(Database.UpsertResult sr :idsr){
                    if(sr.isSuccess()){
                        successfulAccounts.add(sr.getId());
                    }else{
                        for(Database.Error err :sr.getErrors()){
                            sRErrors.add(err.getStatusCode() + ': '+err.getMessage());
                        }
                    }
                }
            }

            if(externalIdAccounts.size() > 0){
                Database.UpsertResult[] xidsr = Database.upsert(externalIdAccounts, externalIdField,false);
                for(Database.UpsertResult sr :xidsr){
                    if(sr.isSuccess()){
                        successfulAccounts.add(sr.getId());
                    }else{
                        for(Database.Error err :sr.getErrors()){
                            sRErrors.add(err.getStatusCode() + ': '+err.getMessage());
                        }
                    }
                }
            }

            Map<String, Account> successExtIdMap = new Map<String, Account>();
            Map<String, Account> successIdMap = new Map<String, Account>();
            for(Account a : [Select Id, External_ID__c FROM Account where Id IN: successfulAccounts]){
                successIdMap.put(a.Id, a);
                if(a.External_ID__c != null){
                    successExtIdMap.put(a.External_ID__c, a);
                }
                Successes.add(a.External_ID__c);
            }

            for(Account a : accounts){
                if(successExtIdMap.get(a.External_ID__c) == null && successIdMap.get(a.Id) == null){
                    //Was not upserted Successfully
                    errors.add('Error creating or updating CRM Account. CRM Account Id: '+a.Id+'. DMS CustId: '+a.External_ID__c);
                }
            }
            if(sRErrors.size() > 0){
                errors.add(JSON.serializePretty(sRErrors));
            }
        }catch(JSONException e){
            errors.add(e.getMessage());
        }catch(DMLException e){
            errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }

    /**
     * upsertLocations 
     * @param  jobId  
     * @param  objJSON 
     * @return String
     * @description
     */ 
    public static String upsertLocations(String jobId, String objJSON)
    {
        List<Dealer_Location__c> locations = new List<Dealer_Location__c>();
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{

            Schema.DescribeFieldResult F = Dealer_Location__c.Company_Number__c.getDescribe();
            Schema.sObjectField externalIdField = F.getSObjectField();
            
            locations = (List<Dealer_Location__c>)JSON.deserialize(objJSON,List<Dealer_Location__c>.class);
            Database.UpsertResult[] srList = Database.upsert(locations,externalIdField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed dealer__Dealer_Location__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }
        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }

    /**
     * upsertStandardOpCodes 
     * @param  jobId   
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertStandardOpCodes(String jobId, String objJSON)
    {
        List<StandardOpCode__c> sopCodes = new List<StandardOpCode__c>();
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{

            Schema.DescribeFieldResult F = StandardOpCode__c.Op_Code__c.getDescribe();
            Schema.sObjectField externalIdField = F.getSObjectField();
            sopCodes = (List<StandardOpCode__c>)JSON.deserialize(objJSON,List<StandardOpCode__c>.class);
            Database.UpsertResult[] srList = Database.upsert(sopCodes,externalIdField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed dealer__StandardOpCode__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }
        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }

    /**
     * upsertVehicleInventory 
     * @param  jobId  
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertVehicleInventory(String jobId, String objJSON)
    {
        List<Vehicle_Inventory__c> vehicles = new List<Vehicle_Inventory__c>();
        Map<Id,Vehicle_Inventory__c> successMap = new Map<Id, Vehicle_Inventory__c>();
        List<String> Successes = new List<String>();
        List<String> sRErrors = new List<String>();
        List<String> errors = new List<String>();
        try{
           vehicles = (List<Vehicle_Inventory__c>)JSON.deserialize(objJSON,  List<Vehicle_Inventory__c>.class);
            Set<String> companyNumberSet = new Set<String>();
            for(Vehicle_Inventory__c inv : vehicles){
                if(inv.Store_Location__c != null)
                    companyNumberSet.add(inv.Store_Location__c);
            }
            Map<String, Dealer_Location__c> companyMap = new Map<String,Dealer_Location__c>();
            for(Dealer_Location__c loc : [SELECT Id, Company_Number__c FROM Dealer_Location__c WHERE Company_Number__c IN: companyNumberSet]){
                companyMap.put(loc.Company_Number__c, loc);
            }
            for(Vehicle_Inventory__c inv: vehicles){
                if(inv.Store_Location__c != null && companyMap.get(inv.Store_Location__c) != null)
                    inv.Store_Location__c = companyMap.get(inv.Store_Location__c).Id;
                inv.Store_Location__c = Utility.isValidId(inv.Store_Location__c) ? inv.Store_Location__c : null;
            }

            Set<Id> successfulVehicles = new Set<Id>();
            Database.UpsertResult[] srList = Database.upsert(vehicles, false);
            
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    successfulVehicles.add(sr.getId());
                    // Successes.add('Successfully processed dealer__Vehicle_Inventory__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        sRErrors.add(err.getFields() + ': '+err.getMessage());
                    }
                }
            }

            Map<String, Vehicle_Inventory__c> successExtIdMap = new Map<String, Vehicle_Inventory__c>();
            Map<String, Vehicle_Inventory__c> successIdMap = new Map<String, Vehicle_Inventory__c>();

            for(Vehicle_Inventory__c v : [Select Id, Stock_Number__c FROM Vehicle_Inventory__c where Id IN: successfulVehicles]){
                successMap.put(v.Id, v);

                successIdMap.put(v.Id, v);
                if(v.Stock_Number__c != null){
                    successExtIdMap.put(v.Stock_Number__c, v);
                }
                Successes.add(v.Id);
            }

            for(Vehicle_Inventory__c v : vehicles){
                if(successExtIdMap.get(v.Stock_Number__c) == null && successIdMap.get(v.Id) == null){
                    //Was not upserted Successfully
                    errors.add('Error creating or updating Vehicle Inventory with Stock Number: '+v.Stock_Number__c);
                }
            }
            if(sRErrors.size() > 0){
                errors.add(JSON.serializePretty(sRErrors));
            }

        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new vehicleResult(successMap,Errors));
    }

    /**
     * upsertServiceVehicle 
     * @param  jobId 
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String deleteVehicleInventory(String objJSON){
        List<String> successes = new List<String>();
        List<String> errors = new List<String>();


        try{
            List<Vehicle_Inventory__c> vehiclesFromDMS = (List<Vehicle_Inventory__c>)JSON.deserialize(objJSON,  List<Vehicle_Inventory__c>.class);
            Set<Id> vehicleIdSet = new Set<Id>();
            Set<String> stockNumberSet = new Set<String>();
            
            for(Vehicle_Inventory__c v : (List<Vehicle_Inventory__c>)JSON.deserialize(objJSON,  List<Vehicle_Inventory__c>.class)){
                stockNumberSet.add(v.Stock_Number__c); 
            }

            Vehicle_Inventory__c [] vehicles = [SELECT Id, Stock_Number__c FROM Vehicle_Inventory__c WHERE Stock_Number__c IN: stockNumberSet];
            
            if(vehicles.size() > 0){
                delete vehicles;
                successes.add('Successfully deleted Vehicle: '+vehiclesFromDMS[0].Stock_Number__c);
            } else {
                errors.add('Attempted to delete a Vehicle that does not exist in CRM: '+vehiclesFromDMS[0].Stock_Number__c);
            }

        } catch(DmlException e){
            errors.add('Error deleting Vehicle Inventory: '+e.getMessage());
        } catch(JSONException e){
            errors.add('Error deleting Vehicle Inventory: '+e.getMessage());
        } catch(Exception e){
            errors.add('Error deleting Vehicle Inventory: '+e.getMessage());
        }

        return(JSON.serializePretty(new result(successes,errors)));
    }

    public class vehicleResult{
        public Map<Id, Vehicle_Inventory__c> Successes;
        public List<String> Errors;
        public vehicleResult(Map<Id, Vehicle_Inventory__c> Successes, List<String> Errors){
            this.Successes = successes;
            this.Errors = Errors;
        }
    }
    
    /**
     * upsertServiceVehicle 
     * @param  jobId 
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertServiceVehicle(String jobId, String objJSON)
    {
          
        List<Service_Vehicle__c> vehicles = new List<Service_Vehicle__c>();
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        
        try{
            
            Set<String> custIdSet = new Set<String>();
            for(Service_Vehicle__c veh :(List<Service_Vehicle__c>)JSON.deserialize(objJSON,List<Service_Vehicle__c>.class)){
               if(veh.VIN__c != null && veh.VIN__c.length() == 17){
                   vehicles.add(veh);
                    if(veh.dealer__Customer_Key__c != null)
                        custIdSet.add(veh.dealer__Customer_Key__c);
               } else {
                   Errors.add('Service Vehicle VIN: '+veh.VIN__c+' is invalid.');
               }
            }
            
            Map<String, Account> accountMap = new Map<String,Account>();
            for(Account acc : [SELECT Id, External_ID__c FROM Account WHERE External_ID__c IN: custIdSet]){
                accountMap.put(acc.External_ID__c, acc);
            }

            for(Service_Vehicle__c veh: vehicles){
                //associate vehicle owner to account
                if(veh.Customer_Key__c != null && accountMap.get(veh.Customer_Key__c) != null)
                    veh.dealer__Veh_Owner__c = accountMap.get(veh.Customer_Key__c).Id;
                veh.dealer__Veh_Owner__c = Utility.isValidId(veh.Customer_Key__c) ? veh.Customer_Key__c : null;
            }

            Schema.DescribeFieldResult F = Service_Vehicle__c.VIN__c.getDescribe();
            Schema.sObjectField VINFIeld = F.getSObjectField();

            Database.UpsertResult[] srList = Database.upsert(vehicles, VINFIeld, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed Service_Vehicle__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }
        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }
    
    /**
     * upsertServiceRepairOrders 
     * @param  jobId   
     * @param  objJSON 
     * @return String
     * @description
     */ 
    public static String upsertServiceRepairOrders(String jobId, String objJSON)
    {
        List<Service_Repair_Order__c> sros = new List<Service_Repair_Order__c>();
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{
            sros = (List<Service_Repair_Order__c>)JSON.deserialize(objJSON,List<Service_Repair_Order__c>.class);
            
            Set<String> companyNumberSet = new Set<String>();
            Set<String> custIdSet = new Set<String>();
            Set<String> VINSet = new Set<String>();

            for(Service_Repair_Order__c sro : sros){
                if(sro.Company__c != null)
                    companyNumberSet.add(sro.Company__c);
                if(sro.Customer__c != null)
                    custIdSet.add(sro.Customer__c);
                if(sro.VIN__c != null)
                    VINSet.add(sro.VIN__c);
            }

            Map<String, Dealer_Location__c> companyMap = new Map<String,Dealer_Location__c>();
            for(Dealer_Location__c loc : [SELECT Id, Company_Number__c FROM Dealer_Location__c WHERE Company_Number__c IN: companyNumberSet]){
                companyMap.put(loc.Company_Number__c, loc);
            }

            Map<String, Account> accountMap = new Map<String,Account>();
            for(Account acc : [SELECT Id, External_ID__c FROM Account WHERE External_ID__c IN: custIdSet]){
                accountMap.put(acc.External_ID__c, acc);
            }

            Map<String, Service_Vehicle__c> svMap = new Map<String,Service_Vehicle__c>();
            for(Service_Vehicle__c sv : [SELECT Id, VIN__c FROM Service_Vehicle__c WHERE VIN__c IN: VINSet]){
                svMap.put(sv.VIN__c, sv);
            }

            for(Service_Repair_Order__c sro: sros){
                if(sro.Company__c != null && companyMap.get(sro.Company__c) != null)
                    sro.Company__c = companyMap.get(sro.Company__c).Id;
                sro.Company__c = Utility.isValidId(sro.Company__c) ? sro.Company__c : null;

                if(sro.Customer__c != null && accountMap.get(sro.Customer__c) != null)
                    sro.Customer__c = accountMap.get(sro.Customer__c).Id;
                sro.Customer__c = Utility.isValidId(sro.Customer__c) ? sro.Customer__c : null;

                if(sro.VIN__c != null && svMap.get(sro.VIN__c) != null)
                    sro.Vehicle__c = svMap.get(sro.VIN__c).Id;
                    
            }

            Schema.DescribeFieldResult F = Service_Repair_Order__c.RO_Number__c.getDescribe();
            Schema.sObjectField RoNumberField = F.getSObjectField();
            Database.UpsertResult[] srList = Database.upsert(sros,RoNumberField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed dealer__Service_Repair_Order__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }
        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }
    
    /**
     * upsertDeals 
     * @param  jobId  
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertDeals(String jobId, String objJSON)
    {
        List<Deal__c> deals = new List<Deal__c>();
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{
            deals = (List<Deal__c>)JSON.deserialize(objJSON,List<Deal__c>.class);
            
            Set<String> stockSet = new Set<String>();
            Set<String> companyNumberSet = new Set<String>();
            Set<String> custIdSet = new Set<String>();
            Set<String> userNameSet = new Set<String>();

            for(Deal__c deal : deals){
               
                if(deal.Store_Location__c != null)
                    companyNumberSet.add(deal.Store_Location__c);
               
                if(deal.Stock_Number__c != null) //VIN is set to Vehicle_Inventory__c from middelware.
                    stockSet.add(deal.Stock_Number__c);
                
                if(deal.Buyer__c != null)
                    custIdSet.add(deal.Buyer__c);

                if(deal.Co_Buyer__c != null)
                    custIdSet.add(deal.Co_Buyer__c);
               
                if(deal.Salesperson_1__c != null)
                    userNameSet.add(deal.Salesperson_1__c);
               
                if(deal.Salesperson_2__c != null)
                    userNameSet.add(deal.Salesperson_2__c);
                
            }
           /** User map of Name,User to map salesperson 1 and 2 */
            Map<String, User> userNameMap = new Map<String, User>();
            for(User usr : [SELECT Id, Name FROM USER WHERE Name IN: userNameSet]){
                userNameMap.put(usr.Name, usr);
            }
           
            Map<String, Vehicle_Inventory__c> vehStockMap = new Map<String, Vehicle_Inventory__c>();
            for(Vehicle_Inventory__c veh : [SELECT Id, Stock_Number__c FROM Vehicle_Inventory__c WHERE Stock_Number__c IN: stockSet]){
                vehStockMap.put(veh.Stock_Number__c, veh);
            }
           
            Map<String, Dealer_Location__c> companyMap = new Map<String,Dealer_Location__c>();
            for(Dealer_Location__c loc : [SELECT Id, Company_Number__c FROM Dealer_Location__c WHERE Company_Number__c IN: companyNumberSet]){
                companyMap.put(loc.Company_Number__c, loc);
            }
           
            Map<String, Account> accountMap = new Map<String,Account>();
            for(Account acc : [SELECT Id, External_ID__c FROM Account WHERE External_ID__c IN: custIdSet]){
                accountMap.put(acc.External_ID__c, acc);
            }

            for(Deal__c deal: deals){
                if(deal.Store_Location__c != null && companyMap.get(deal.Store_Location__c) != null)
                    deal.Store_Location__c = companyMap.get(deal.Store_Location__c).Id;
                deal.Store_Location__c = Utility.isValidId(deal.Store_Location__c) ? deal.Store_Location__c : null;
                
                if(deal.Stock_Number__c != null && vehStockMap.get(deal.Stock_Number__c) != null)
                    deal.Vehicle__c = vehStockMap.get(deal.Stock_Number__c).Id;
                deal.Store_Location__c = Utility.isValidId(deal.Store_Location__c) ? deal.Store_Location__c : null;
                
                if(deal.Buyer__c != null && accountMap.get(deal.Buyer__c) != null)
                    deal.Buyer__c = accountMap.get(deal.Buyer__c).Id;
                deal.Buyer__c = Utility.isValidId(deal.Buyer__c) ? deal.Buyer__c : null;

                if(deal.Co_Buyer__c != null && accountMap.get(deal.Co_Buyer__c) != null)
                    deal.Co_Buyer__c = accountMap.get(deal.Co_Buyer__c).Id;
                deal.Co_Buyer__c = Utility.isValidId(deal.Co_Buyer__c) ? deal.Co_Buyer__c : null;

                if(deal.Salesperson_1__c != null && userNameMap.get(deal.Salesperson_1__c) != null)
                    deal.Salesperson_1__c = userNameMap.get(deal.Salesperson_1__c).Id;
                deal.Salesperson_1__c = Utility.isValidId(deal.Salesperson_1__c) ? deal.Salesperson_1__c : null;
                
                if(deal.Salesperson_2__c != null && userNameMap.get(deal.Salesperson_2__c) != null)
                    deal.Salesperson_2__c = userNameMap.get(deal.Salesperson_2__c).Id;
                deal.Salesperson_2__c = Utility.isValidId(deal.Salesperson_2__c) ? deal.Salesperson_2__c : null;
            }
            
            Schema.DescribeFieldResult F = Deal__c.Deal_ID__c.getDescribe();
            Schema.sObjectField dealId = F.getSObjectField();
            Database.UpsertResult[] srList = Database.upsert(deals,dealId, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed Deal__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }
        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }
    
    /**
     * upsertPartsMasters 
     * @param  jobId  
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertPartsMasters(String jobId, String objJSON)
    {
        List<Parts_Master__c> partsMasters = new List<Parts_Master__c>();
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{

            Schema.DescribeFieldResult F = Parts_Master__c.Part_No__c.getDescribe();
            Schema.sObjectField externalIdField = F.getSObjectField();
           
            for(Parts_Master__c pm : (List<Parts_Master__c>)JSON.deserialize(objJSON,List<Parts_Master__c>.class)){
                if(pm.Name != null && pm.Manufacturer__c != null){
                    pm.Part_No__c = pm.Manufacturer__c+':'+pm.Name;
                }
                partsMasters.add(pm);
            }
            Database.UpsertResult[] srList = Database.upsert(partsMasters,externalIdField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed Parts_Master__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }
        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }

    /* Related Items */

    /**
     * upsertServiceJobLines 
     * @param  jobId   
     * @param  objJSON 
     * @return String
     * @description
     */ 
    public static String upsertServiceJobLines(String jobId, String objJSON)
    {
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{
            Schema.DescribeFieldResult F = Service_Job__c.Job_Line_Id__c.getDescribe();
            Schema.sObjectField LineIdField = F.getSObjectField();

            List<Service_Job__c> lines = (List<Service_Job__c>)JSON.deserialize(objJSON,List<Service_Job__c>.class);

            Set<String> RoNameSet = new Set<String>();
            for(Service_Job__c sj : lines ){
                if(sj.Service_Repair_Order__c != null)
                    RoNameSet.add(sj.Service_Repair_Order__c);
            }

            Map<String, Service_Repair_Order__c> roNumberMap = new Map<String, Service_Repair_Order__c>();
            for(Service_Repair_Order__c sro : [SELECT Id, Name, RO_Number__c FROM Service_Repair_Order__c WHERE RO_Number__c IN: RoNameSet]){
                roNumberMap.put(sro.RO_Number__c, sro);
            }

            List<Service_Job__c> newLines = new List<Service_Job__c>();
            for(Service_Job__c sj : lines){
                if(sj.Service_Repair_Order__c != null && roNumberMap.get(sj.Service_Repair_Order__c) != null){
                    sj.Service_Repair_Order__c = roNumberMap.get(sj.Service_Repair_Order__c).Id;
                    newLines.add(sj);
                }
            }
            Database.UpsertResult[] srList = Database.upsert(newLines, LineIdField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed dealer__Service_Job__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }

        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }
    
    /**
     * upsertSalesFees 
     * @param  jobId   
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertSalesFees(String jobId, String objJSON)
    {
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{
            Schema.DescribeFieldResult F = Sales_Fee__c.FeeId__c.getDescribe();
            Schema.sObjectField LineIdField = F.getSObjectField();

            List<Sales_Fee__c> fees = (List<Sales_Fee__c>)JSON.deserialize(objJSON,List<Sales_Fee__c>.class);
            // dealer__Deal_ID__c
            Set<String> DealIdSet = new Set<String>();
            for(Sales_Fee__c fee : fees ){
                if(fee.Car_Deal__c != null)
                    DealIdSet.add(fee.Car_Deal__c);
            }

            Map<String, Deal__c> dealIdMap = new Map<String, Deal__c>();
            for(Deal__c deal : [SELECT Id, Name, Deal_ID__c FROM Deal__c WHERE Deal_Id__c IN: DealIdSet]){
                dealIdMap.put(deal.Deal_ID__c, deal);
            }

            List<Sales_Fee__c> newFees = new List<Sales_Fee__c>();
            for(Sales_Fee__c fee : fees){
                if(fee.Car_Deal__c != null && dealIdMap.get(fee.Car_Deal__c) != null){
                    fee.Car_Deal__c = dealIdMap.get(fee.Car_Deal__c).Id;
                    newFees.add(fee);
                }
            }

            Database.UpsertResult[] srList = Database.upsert(newFees, LineIdField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed Sales_Fee__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }

        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }
    
    /**
     * upsertTradeIns 
     * @param  jobId   
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertTradeIns(String jobId, String objJSON)
    {
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{
            Schema.DescribeFieldResult F = Trade_In__c.TradeInId__c.getDescribe();
            Schema.sObjectField LineIdField = F.getSObjectField();

            List<Trade_In__c> trades = (List<Trade_In__c>)JSON.deserialize(objJSON,List<Trade_In__c>.class);
            // dealer__Deal_ID__c
            Set<String> DealIdSet = new Set<String>();
            for(Trade_In__c trade : trades ){
                if(trade.Car_Deal__c != null)
                    DealIdSet.add(trade.Car_Deal__c);
            }

            Map<String, Deal__c> dealIdMap = new Map<String, Deal__c>();
            for(Deal__c deal : [SELECT Id, Name, Deal_ID__c FROM Deal__c WHERE Deal_Id__c IN: DealIdSet]){
                dealIdMap.put(deal.Deal_ID__c, deal);
            }

            List<Trade_In__c> newTrades = new List<Trade_In__c>();
            for(Trade_In__c trade : trades){
                if(trade.Car_Deal__c != null && dealIdMap.get(trade.Car_Deal__c) != null){
                    trade.Car_Deal__c = dealIdMap.get(trade.Car_Deal__c).Id;
                    newTrades.add(trade);
                }
            }

            Database.UpsertResult[] srList = Database.upsert(newTrades, LineIdField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed Trade_In__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            }

        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }

    /**
     * upsertPartsInventory 
     * @param  jobId   
     * @param  objJSON 
     * @return String
     * @description
     */
    public static String upsertPartsInventory(String jobId, String objJSON)
    {
        List<String> Successes = new List<String>();
        List<String> Errors = new List<String>();
        try{
            Schema.DescribeFieldResult F = Parts_Inventory__c.dealer__Part_No__c.getDescribe();
            Schema.sObjectField LineIdField = F.getSObjectField();
            
            List<Parts_Inventory__c> pinv = (List<Parts_Inventory__c>)JSON.deserialize(objJSON,List<Parts_Inventory__c>.class);
           
            Set<String> companySet = new Set<String>();
            for(Parts_Inventory__c p : pinv){
                if(!companySet.contains(p.Location__c)){
                    companySet.add(p.Location__c); //Comes in from Middleware as company number, not id
                }
            }

            Map<String, Dealer_Location__c> companyNumberMap = new Map<String,Dealer_Location__c>();
            for(Dealer_Location__c loc : [SELECT Id, Name, Company_Number__c FROM Dealer_Location__c WHERE Company_Number__c IN: companySet]){
                companyNumberMap.put(loc.Company_Number__c, loc);
            }

            List<Parts_Inventory__c> newPinv = new List<Parts_Inventory__c>();
            for(Parts_Inventory__c p : pinv){
                if(p.Location__c != null && companyNumberMap.get(p.Location__c) != null && p.MFG__c != null && p.Name != null ){
                    Dealer_Location__c loc = companyNumberMap.get(p.location__c);
                    p.Location__c = loc.Id;
                    p.Part_No__c = loc.Company_Number__c+':'+p.MFG__c+':'+p.Name;
                    newPinv.add(p);
                }
            }
            Database.UpsertResult[] srList = Database.upsert(newPinv, LineIdField, false);
            for(Database.UpsertResult sr :srList){
                if(sr.isSuccess()){
                    Successes.add('Successfully processed Parts_Inventory__c. Id: '+sr.getId());
                }else{
                    for(Database.Error err :sr.getErrors()){
                        system.debug('ERR= '+err.getMessage());
                        Errors.add(err.getStatusCode() + ': '+err.getMessage());
                    }
                }
            } 

        }catch(JSONException e){
            Errors.add(e.getMessage());
        }catch(DMLException e){
            Errors.add(e.getMessage());
        }
        if(jobId != null){
            Utility.generateDoc(jobId,JSON.serializePretty(new result(Successes,Errors)));
        }
        return JSON.serializePretty(new result(Successes,Errors));
    }


    /**
     * Routes Object to correct method 
     * @param  type    
     * @param  objJSON 
     * @param  jobId  
     * @return String
     * @description
     */ 
    public static String routeObject(String type, String objJSON, String jobId)
    {
        switch on type {
            when 'Account' {
                return DMSImportsAPI.upsertAccounts(jobId, objJSON);
            }
            when 'dealer__Dealer_Location__c' {
                return DMSImportsAPI.upsertLocations(jobId, objJSON);
            }
            when 'dealer__StandardOpCode__c' {
                return DMSImportsAPI.upsertStandardOpCodes(jobId, objJSON);
            }
            when 'dealer__Vehicle_Inventory__c' {
                return DMSImportsAPI.upsertVehicleInventory(jobId, objJSON);
            }
            when 'dealer__Service_Vehicle__c' {
                return DMSImportsAPI.upsertServiceVehicle(jobId, objJSON);
            }
            when 'dealer__Service_Repair_Order__c' {
                return DMSImportsAPI.upsertServiceRepairOrders(jobId, objJSON);
            }
            when 'dealer__Service_Job__c' {
                return DMSImportsAPI.upsertServiceJobLines(jobId, objJSON);
            }
            when 'dealer__Deal__c' {
                return DMSImportsAPI.upsertDeals(jobId, objJSON);
            }
            when 'dealer__Sales_Fee__c' {
                return DMSImportsAPI.upsertSalesFees(jobId,objJSON);
            }
            when 'dealer__Trade_In__c' {
                return DMSImportsAPI.upsertTradeIns(jobId,objJSON);
            }
            when 'dealer__Parts_Master__c' {
                return DMSImportsAPI.upsertPartsMasters(jobId,objJSON);
            }
            when 'dealer__Parts_Inventory__c' {
                return DMSImportsAPI.upsertPartsInventory(jobId,objJSON);
            }
        }
        return JSON.serializePretty(new result(new List<String>(),new List<String>{type+' is not yet supported.'}));
    }
    /**
    * cleanAccounts
    * @description compares data from DMS to CRM and removes invalid External Ids from Accounts
    */
    public static void cleanAccounts(List<Account> sfAccts, List<Account> dmsAccts ){
        Set<String> dmsCustIdSet = new Set<String>();
        for(Account a : dmsAccts){
            dmsCustIdSet.add(a.External_ID__c);
        }
        List<Account> acctsToClean = new List<Account>();
        for(Account a : sfAccts){
            if(!dmsCustIdSet.contains(a.External_ID__c)){
                acctsToClean.add(new Account(
                    Id = a.Id,
                    External_ID__c = null
                ));
            }
        }
        try{
            update acctsToClean;
        } catch(DMLException e){
            system.debug(e.getMessage());
        }
    }
    
    public static String cleanRecords(String type, String objJSON){
        DMSBatchCleanRecords batch = new DMSBatchCleanRecords(type,objJSON);
        Id batchId = Database.executeBatch(batch);
        return batchId;
    }

    public static void syncAccount(String AccountJSON){
        //Send request to HEMI
        Account account = (Account)JSON.deserialize(AccountJSON, Account.class);
        String extId = account.dealer__External_Id__c != null ? account.dealer__External_Id__c : null;
        String baseUrl = (!Utility.isSandbox()) ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
        String resp = (Test.isRunningTest()) ? '' :  EnterpriseControllerAPI.CallOut(baseUrl + '/dealerstar/account/update/'+extId, AccountJSON);
    }

    /* Result Wrapper */
    
    /**
     * @description
     */
    public class result{
        public List<String> Successes;
        public List<String> Errors;
        public result(List<STring> successes, List<String> errors){
            this.Successes = successes;
            this.Errors = errors;
        }
    }
}