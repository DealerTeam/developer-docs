/**
 * 2016.08.29       |Sneha                |Case#1978
 *   Comment RO Number assignment code as its added in trigger
 *       
 */
public class RepairOrder{
    
    public Id we_oweId {get; set; }
    dealer__We_Owe__c weoweObj; 
    dealer__Deal__c deal;// = new dealer__Deal__c();
    dealer__Service_Repair_Order__c sro;
    dealer__Dealer_Location__c location;
    
    dealer__StandardOpCode__c[] sop;
    List<dealer__We_Owe_Line__c> weOweLineItemList = new List<dealer__We_Owe_Line__c>();
    List<dealer__Service_Job__c> serviceJobUpdateList = new List<dealer__Service_Job__c>();
    
    public pageReference createRepairOrder(){
        pageReference pr =null;
        
        //Fetching the details of We_Owe and its line item.
        weoweObj = [Select Id, Name, dealer__Car_Deal__c, dealer__Service_Repair_Order__c,
                    (SELECT id,dealer__After_Market_Id__c, dealer__Cost__c,dealer__Description__c,dealer__Gross__c,dealer__Labor_Hours__c,dealer__Labor_Sale__c,
                    dealer__List_Price__c,dealer__Parts_Kit__c,dealer__Parts_Sale__c,dealer__Sale_Price__c,
                    dealer__Taxable__c, dealer__We_Owe__r.dealer__Car_Deal__c FROM dealer__We_Owe_Lines__r                    
                    )
                    FROM dealer__We_Owe__c WHERE Id =:ApexPages.currentPage().getParameters().get('weOweId')];
        
        //Fetching deal related to we-owe record
        if(weoweObj.dealer__Car_Deal__c != null){
            deal = [SELECT id, dealer__Store_Location__c, dealer__Store_Location__r.Name, dealer__Store_Location__r.dealer__Company_Number__c, 
                    dealer__Store_Location__r.dealer__Service_Director__c, 
                    dealer__Mileage__c, dealer__Buyer__c,dealer__Vehicle__c, dealer__DeliveryRepairOrder__c 
                    FROM dealer__Deal__c  WHERE Id =:weoweObj.dealer__Car_Deal__c LIMIT 1];       
            
            //Fetching the store location
            //location = [Select Id,  Name, dealer__Company_Number__c, dealer__Service_Director__c 
                        //From dealer__Dealer_Location__c WHERE Id =:deal.dealer__Store_Location__c limit 1];
            sop = [Select Id, Name from dealer__StandardOpCode__c where Name = '99PROD' limit 1];
        }
        
        
        if(weoweObj.dealer__Service_Repair_Order__c == null){
            try{
                sro = repairOrder();
                insert sro; 
                weoweObj.dealer__Service_Repair_Order__c = sro.Id;
                update weoweObj;
                
                if(deal.dealer__DeliveryRepairOrder__c == null){
                    deal.dealer__DeliveryRepairOrder__c = sro.id; 
                    update deal;
                }
            }catch(Exception e){
                
            }
        }else{
            try{
                sro = fetchRepairOrder(weoweObj.dealer__Service_Repair_Order__c);
                update sro;
            }catch(Exception e){
                
            }
        }
        /*
        if(deal.dealer__DeliveryRepairOrder__c == null){
            deal.dealer__DeliveryRepairOrder__c = sro.id; 
            update deal;    
        }
        */
        serviceJobUpdateList = syncWeOweLines();
         
       //Inserting the records into Service job Line Item and also updating the delivery repair order field of Deal
       try{
            insert serviceJobUpdateList;
            pr = new apexpages.standardController(weoweObj).view();
        }catch(Exception e){
            Apexpages.AddMessage(new Apexpages.message(Apexpages.Severity.Error,e.getMessage()));
        }
          return pr;
    }
    
    //Method to create Service Repair Order
    public dealer__Service_Repair_Order__c repairOrder(){
        //Setting up the fields of Repair order.           
        dealer__Service_Repair_Order__c ro = new dealer__Service_Repair_Order__c ();
        ro.dealer__Customer__c = deal.dealer__Buyer__c;
        ro.dealer__Company__c = deal.dealer__Store_Location__c;                
        
        if(deal.dealer__Mileage__c == null) { 
            deal.dealer__Mileage__c = 0;
        }
        //ro.dealer__Company_Number__c = location.dealer__Company_Number__c;
        //ro.dealer__Company__c  = location.Id; 
        ro.dealer__Create_Date_Time__c = Datetime.now();
        ro.dealer__Service_Advisor__c = deal.dealer__Store_Location__r.dealer__Service_Director__c;
        ro.dealer__Vehicle_Inventory__c = deal.dealer__Vehicle__c;
        ro.dealer__Mileage_In__c = deal.dealer__Mileage__c;
        ro.dealer__Customer__c = deal.dealer__Buyer__c;
        // ro.dealer__Service_Repair_Order__c = weoweObj.Id;
        //Inserting the record into Repair order.
        //insert ro;
        return ro;
    }
    
    //Method to fetch Service Repair Order
    public dealer__Service_Repair_Order__c fetchRepairOrder(Id sroId){
        
        return [Select Id, Name From dealer__Service_Repair_Order__c Where id =:sroId];
    }
    
    //Method to create Service Job Lines
    public List<dealer__Service_Job__c> syncWeOweLines(){
        
        List<dealer__Service_Job__c> newServiceJobList = new List<dealer__Service_Job__c>();
        List<dealer__Service_Job__c> serviceJobList = new List<dealer__Service_Job__c>();
        Map<String, dealer__Service_Job__c> weOweLineToJobMap = new  Map<String, dealer__Service_Job__c>();
        List<dealer__We_Owe_Line__c> checkList = new List<dealer__We_Owe_Line__c>();
        
        Map<Id, dealer__We_Owe_Line__c> weOweLinesMap = new Map<Id, dealer__We_Owe_Line__c>(checkList);
        
        serviceJobList = [SELECT id, dealer__We_Owe_Line_Id__c FROM dealer__Service_Job__c 
                        WHERE dealer__Service_Repair_Order__c =:weoweObj.dealer__Service_Repair_Order__c];
        
        for(dealer__Service_Job__c s :serviceJobList){
            if(s.dealer__We_Owe_Line_Id__c != null){
                weOweLineToJobMap.put(s.dealer__We_Owe_Line_Id__c, s);
            }
        }
        
        checkList = [Select id, dealer__After_Market_Id__c, dealer__Cost__c,dealer__Description__c,dealer__Gross__c,dealer__Labor_Hours__c,dealer__Labor_Sale__c,
                    dealer__List_Price__c,dealer__Parts_Kit__c,dealer__Parts_Sale__c,dealer__Sale_Price__c,
                    dealer__Taxable__c, dealer__We_Owe__r.dealer__Car_Deal__c FROM dealer__We_Owe_Line__c WHERE dealer__We_Owe__c =:ApexPages.currentPage().getParameters().get('weOweId')];
          
        for(dealer__We_Owe_Line__c wOL : checkList){
            if(!weOweLineToJobMap.containsKey(wOL.Id)){
                dealer__Service_Job__c line = new dealer__Service_Job__c();
                if(sop.size()>0) {
                    line.dealer__Standard_Operation_Code__c = sop[0].Id;
                    line.dealer__Op_Code__c = sop[0].Name;
                }
            
                line.dealer__Parts_Cost__c = wOL.dealer__Cost__c;
                line.dealer__Op_Description__c = wOL.dealer__Description__c;
                line.dealer__Labor_Charges__c = wOL.dealer__Labor_Sale__c;
                line.dealer__Parts_Total__c = wOL.dealer__Sale_Price__c;
                line.dealer__Parts_Cost__c = wOL.dealer__Parts_Sale__c;
                line.dealer__Service_Repair_Order__c= weoweObj.dealer__Service_Repair_Order__c;
                line.dealer__We_Owe_Line_Id__c =  wOL.Id;
                newServiceJobList.add(line);
            }
        }
        return newServiceJobList;
    }

}