//
// Documented : 
public class ServiceContractLinkHandler 
{

    public void BeforeHandlerMapLookup (List <Service_Contract__c> ListServiceContract){

        set< Id > carDealIds = new set < Id >();
        Map<Id, dealer__Service_Contract__c> serviceLocation = new Map<Id, dealer__Service_Contract__c>();
        for(dealer__Service_Contract__c objServiceContract : ListServiceContract){
             if(objServiceContract.dealer__Car_Deal__c != null){
            	carDealIds.add(objServiceContract.dealer__Car_Deal__c);
                serviceLocation.put(objServiceContract.dealer__Car_Deal__c, objServiceContract);
            }   
        }

        Map<String, String> contactDealMap = new Map<String, String>();
        Map<String, String> accountDealMap = new Map<String, String>();
        Map<String, String> VINDealMap = new Map<String, String>();
        Map<String, String> companyNumberMap = new Map<String, String>();
        Map<String, String> VINVehicleMap = new Map<String, String>();
        set<String> VINIds = new set<String>();
        List<dealer__Deal__c> dealList = [ Select id,
                                                dealer__Buyer_Contact__c,
                                                dealer__Buyer__c,
                                                dealer__VIN__c,
                                          		dealer__Store_Location__c,
                                                dealer__Company_Number__c from 
                                                dealer__Deal__c where id in: carDealIds];

         for(dealer__Deal__c objDeal : dealList){
            contactDealMap.put(objDeal.id,objDeal.dealer__Buyer_Contact__c );
            accountDealMap.put(objDeal.id, objDeal.dealer__Buyer__c);
            VINDealMap.put(objDeal.id, objDeal.dealer__VIN__c);
            companyNumberMap.put(objDeal.id, objDeal.dealer__Company_Number__c);
            VINIds.add(objDeal.dealer__VIN__c);
            
             //Set Deal Location to Service Contract
             if(objDeal.dealer__Store_Location__c != null){
                
                 dealer__Service_Contract__c temp = serviceLocation.get(objDeal.Id);
                 temp.dealer__Location__c = objDeal.dealer__Store_Location__c;
                
             }
        }
    
        List<dealer__Service_Vehicle__c> serviceList = [SELECT id,
                                                             dealer__VIN__c from dealer__Service_Vehicle__c where  
                                                             dealer__VIN__c in : VINIds];
                                                                
                                                                
        for(dealer__Service_Vehicle__c objServiceVechile : serviceList){
            VINVehicleMap.put(objServiceVechile.dealer__VIN__c, objServiceVechile.id);
        }
         
         
        for(dealer__Service_Contract__c objServiceContract : ListServiceContract){
            if(objServiceContract.dealer__Car_Deal__c != null){            
                objServiceContract.dealer__Customer_Contact__c = contactDealMap.get(objServiceContract.dealer__Car_Deal__c);
                objServiceContract.dealer__Customer__c = accountDealMap.get(objServiceContract.dealer__Car_Deal__c);
                objServiceContract.dealer__Company_Number__c = companyNumberMap.get(objServiceContract.dealer__Car_Deal__c);
                if(VINDealMap.get(objServiceContract.dealer__Car_Deal__c) != null){
                     objServiceContract.dealer__Service_Vehicle__c = VINVehicleMap.get(VINDealMap.get(objServiceContract.dealer__Car_Deal__c));
                }
                 
            }  
            /* Work W-000529 Begin*/
            if(objServiceContract.dealer__Start_Date__c != null && objServiceContract.dealer__Expiration_Months__c != null){
           
                if(objServiceContract.dealer__Expiration_Months__c >0){
                    objServiceContract.dealer__End_Date__c = objServiceContract.dealer__Start_Date__c;
                    objServiceContract.dealer__End_Date__c = objServiceContract.dealer__End_Date__c.addMonths(Integer.valueOf(objServiceContract.dealer__Expiration_Months__c));
                }
               
                else{
                    objServiceContract.addError('Please enter positive value of Expiration month');
                }
            }
            /* Work W-000529 End*/

        }   

    }

    /** This method performs roll-up values on the deal object
        Potental Values Impacted
            Warranty_Cost__c
            Warranty_Premium__c
            Total_Service_Contracts_Cost__c
            Total_Service_Contracts_Gross__c
            Total_Service_Contracts_Premium__c
            Other_Premium__c (Svc Contract)
            GAP_Cost__c
            GAP_Gross__c
            GAP_Premium__c
            GAP_Term__c
            GAP_Company__c
    */
    public void sumDealTotalValues(List<Service_Contract__c> newList) {

        // What deals may need re-total?
        Set<Id> dealsToSum = new Set<Id>();
        for(Service_Contract__c sc : newList) {
            if(sc.Car_Deal__c!=null)
	            dealsToSum.add(sc.Car_Deal__c);
        }
        
        if(dealsToSum.isEmpty())
            return; // Nothing to process

        // Get assocaited Deals
        Map<Id, Deal__c> dealValues = new Map<Id, Deal__c>([
            SELECT Id, Total_Service_Contracts_Cost__c, Maintenance_Cost__c, Maintenance_Premium__c, Maintenance_Gross__c, Total_Service_Contracts_Gross__c, Total_Service_Contracts_Premium__c, 
                Other_Premium__c, Other_Cost__c, Other_Gross__c, GAP_Cost__c, GAP_Gross__c, GAP_Premium__c, GAP_Term__c, GAP_Company__c, 
                Warranty_Cost__c, Warranty_Premium__c
            FROM Deal__c
            WHERE Id IN:dealsToSum
        ]);

        // Get SUM Values
        AggregateResult[] sumOfSales = [SELECT Car_Deal__c deal, Type__c type, SUM(Cost__c) cost, SUM(Sale_Price__c) price, SUM(Gross__c) gross 
                                            FROM Service_Contract__c
                                            WHERE Car_Deal__c IN:dealsToSum
                                            GROUP BY Car_Deal__c,Type__c];

        // Force calculation if value changes necessitate.
        Map<Id, Decimal> dealCost = new Map<Id, Decimal>();
        Map<Id, Decimal> dealPrice = new Map<Id, Decimal>();
        Map<Id, Decimal> dealGross = new Map<Id, Decimal>();

        Set<Id> dealSet = new Set<Id>();

        // Iterate Aggregate Results and Update if Necessary
        Map<Id, Deal__c> dealsToUpdate = new Map<Id, Deal__c>();
        for(AggregateResult ar : sumOfSales) {

            // Working Deal for Compairson 
            Deal__c workingDeal = dealValues.get((Id)ar.get('deal'));

            // Challenge items that are up to date

            // 1) Service Contract Total Sales
            if(ar.get('type') == 'Extended Service Contract' 
                && (workingDeal.Total_Service_Contracts_Cost__c != (Decimal)ar.get('cost')
                    || workingDeal.Total_Service_Contracts_Premium__c != (Decimal)ar.get('price')
                    || workingDeal.Total_Service_Contracts_Gross__c != (Decimal)ar.get('gross'))
                ) 
            {

                // Instantiate a new Deal Object or Retrive Existing from Mem
                Deal__c dealUpdateRecord = (dealsToUpdate.get(workingDeal.Id)!=null) ? dealsToUpdate.get(workingDeal.Id) : new Deal__c(Id=workingDeal.Id);                
                dealUpdateRecord.Total_Service_Contracts_Cost__c = (Decimal)ar.get('cost');
                dealUpdateRecord.Total_Service_Contracts_Premium__c = (Decimal)ar.get('price');
                dealUpdateRecord.Total_Service_Contracts_Gross__c = (Decimal)ar.get('gross');
                dealsToUpdate.put(workingDeal.Id, dealUpdateRecord);
            }

            // 2) Maintenance Contract Type Sales
            if(ar.get('type') == 'Maintenance Contract' 
                && (workingDeal.Maintenance_Cost__c != (Decimal)ar.get('cost')
                    || workingDeal.Maintenance_Premium__c != (Decimal)ar.get('price')
                    || workingDeal.Maintenance_Gross__c != (Decimal)ar.get('gross'))
                ) 
            {

                // Instantiate a new Deal Object or Retrive Existing from Mem
                Deal__c dealUpdateRecord = (dealsToUpdate.get(workingDeal.Id)!=null) ? dealsToUpdate.get(workingDeal.Id) : new Deal__c(Id=workingDeal.Id);                
                dealUpdateRecord.Maintenance_Cost__c = (Decimal)ar.get('cost');
                dealUpdateRecord.Maintenance_Premium__c = (Decimal)ar.get('price');
                dealUpdateRecord.Maintenance_Gross__c = (Decimal)ar.get('gross');
                dealsToUpdate.put(workingDeal.Id, dealUpdateRecord);
            }  

            // 3) GAP related contract sales totals
            if(ar.get('type') == 'GAP' 
                && (workingDeal.GAP_Cost__c != (Decimal)ar.get('cost')
                    || workingDeal.GAP_Premium__c != (Decimal)ar.get('price')
                    || workingDeal.GAP_Gross__c != (Decimal)ar.get('gross'))
                ) 
            {

                // Instantiate a new Deal Object or Retrive Existing from Mem
                Deal__c dealUpdateRecord = (dealsToUpdate.get(workingDeal.Id)!=null) ? dealsToUpdate.get(workingDeal.Id) : new Deal__c(Id=workingDeal.Id);                
                dealUpdateRecord.GAP_Cost__c = (Decimal)ar.get('cost');
                dealUpdateRecord.GAP_Premium__c = (Decimal)ar.get('price');
                dealUpdateRecord.GAP_Gross__c = (Decimal)ar.get('gross');
                dealsToUpdate.put(workingDeal.Id, dealUpdateRecord);
            } 

            // 4) Other Type (Custom Type) Service Contracts
            if(ar.get('type') != 'GAP' && ar.get('type') != 'Maintenance Contract' && ar.get('type') != 'Extended Service Contract' 
                && (workingDeal.Other_Cost__c != (Decimal)ar.get('cost')
                    || workingDeal.Other_Premium__c != (Decimal)ar.get('price')
                    || workingDeal.Other_Gross__c != (Decimal)ar.get('gross'))
                ) 
            {
                // Instantiate a new Deal Object or Retrive Existing from Mem
                Deal__c dealUpdateRecord = (dealsToUpdate.get(workingDeal.Id)!=null) ? dealsToUpdate.get(workingDeal.Id) : new Deal__c(Id=workingDeal.Id);                
                dealUpdateRecord.Other_Cost__c = (Decimal)ar.get('cost');
                dealUpdateRecord.Other_Premium__c = (Decimal)ar.get('price');
                dealUpdateRecord.Other_Gross__c = (Decimal)ar.get('gross');
                dealsToUpdate.put(workingDeal.Id, dealUpdateRecord);
            }                                      
        }


        // If we have deals to update, perform the DML
        try {

            if(!dealsToUpdate.isEmpty())
                update dealsToUpdate.values();

        } Catch(DmlException e) {
            throw new ServiceContractException(e.getMessage());
        }
    }
    
    public class ServiceContractException extends Exception {}
}