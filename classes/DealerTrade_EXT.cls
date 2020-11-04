/**
 * DealerTrade_EXT
 * @description
 */
global with sharing class DealerTrade_EXT {

    /**
     * @description
     */
    global Dealer_Trade__c dt {get;set;}
    
    /**
     * @description
     */
    public String createdBy {get;set;}
    
    /**
     * @description
     */
    public String modifiedBy {get;set;}

    /**
     * DealerTrade_EXT 
     * @param  controller 
     * @description
     */
    global DealerTrade_EXT(ApexPages.StandardController controller) 
    {
        Id tradeId   =  (Id)controller.getRecord().Id;
        if (tradeId != null){
            dt = [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, 
                LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate,
                LastViewedDate, LastReferencedDate, dealer__Accessories_Inbound__c, 
                dealer__Accessories_Ours__c, dealer__Advertising_Inbound__c,
                Dealer__r.BillingStreet, Dealer__r.BillingCity,Dealer__r.BillingState,
                Dealer__r.BillingPostalCode,Dealer__r.BillingCountry,Dealer__r.BillingAddress,
                Dealer__r.ShippingState,Dealer__r.ShippingStreet,Dealer__r.Name,
                Dealer__r.ShippingCity, Dealer__r.Phone, Stock_No__r.Name,
                dealer__Balance__c, dealer__Check_for_Check__c, dealer__City_State__c, 
                dealer__Color_Inbound__c, dealer__Date__c, dealer__Dealer_Address__c, 
                dealer__Dealer_Code__c, dealer__Dealer_Contact__c, dealer__Dealer_Phone__c,
                dealer__Dealer__c, dealer__Drive_Fee__c, dealer__Drive_Hours__c, dealer__Driver_2__c, 
                dealer__Driver__c, dealer__Due__c, dealer__Holdback_Inbound__c, dealer__Honda_HN__c, 
                dealer__Invoice_Inbound__c, dealer__Invoice_Outbound__c, dealer__Key_Code__c, 
                dealer__Make_Inbound__c, dealer__Make_Outbound__c, dealer__Model_Inbound__c, 
                dealer__Model_Outbound__c, dealer__Net_Value_In__c, dealer__Net_Value_Out__c, 
                dealer__Our_Advertising__c, dealer__Our_Holdback__c, dealer__Ours_Yours__c, 
                dealer__Outbound_Location__c, dealer__Outgoing_Color__c, dealer__Radio_Code__c,
                dealer__Rental_Car_Used__c, dealer__Sales_Up__c, dealer__Salesperson__c, 
                dealer__Stock_No_Inbound__c, dealer__Stock_No__c, dealer__Store_Location__c, 
                dealer__Trade_Completed__c, dealer__Trade_Notes_Inbound__c, dealer__Trade_Notes__c,
                dealer__Trailered__c, dealer__Transfer_Status__c, dealer__Transfer_Vehicle__c,
                dealer__VIN_Inbound__c, dealer__VIN_Outbound__c, dealer__Year_Inbound__c, 
                dealer__Year_Outbound__c FROM dealer__Dealer_Trade__c WHERE Id =: tradeId];

            createdBy = [SELECT Name From User Where Id=:dt.CreatedById].Name;
            modifiedBy =[SELECT Name From User Where Id=:dt.LastModifiedById].Name;
        }
	}
    
    /**
     * getInvoiceLogo 
     * @return String
     * @description
     */
    global String getInvoiceLogo() 
    {
        Id recordId = dt.id;
        Id loc;
        if(dt.Id != null)
        loc = [SELECT Store_Location__c FROM Dealer_Trade__c WHERE Id=:recordId].Store_Location__c;
        if(loc != null){
            return DealershipLocationAPI.formLogoURL(loc);
        }else{
            Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
            String imageId = doc.Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;
        }
    }
	
    /**
     * @description
     */
    global class DealerTradeException extends Exception {}

}