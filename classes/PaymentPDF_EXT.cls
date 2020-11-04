/**
* Date            |Developer            |Work#
* Notes
* --
*
*2016.09.22       |Gaurav               |Case2069
*   Payment PDF for Cashier receipt
*
*2016.11.30       |Sneha               |Case2069
*   Added fields of cashier's account for printing name, address of account
*
* 3/13/2019        |Josh                |W-002202
*   Added Ability to Get Location Information from cashering event even if it isn't attached to an SRO
**/
public with sharing class PaymentPDF_EXT {

public dealer__Dealer_Location__c userLoc {get;set;}
public dealer__Cashering__c objCashering{get;set;}
public DateTime invoiceTime {get;set;}
public dealer__Service_Repair_Order__c objSRO{get;set;}
public dealer__Parts_Invoice__c objPI{get;set;}
public dealer__Vehicle_Inventory__c objVehicleInventory{get;private set;}

    public PaymentPDF_EXT(ApexPages.StandardController controller) {
    
        if(ApexPages.currentPage().getParameters().get('id') != null){        
            objCashering = [SELECT Id, Name, dealer__Amount__c, dealer__Close_Date__c, dealer__Company_Number__c, dealer__Location__c , dealer__Credit_Card_Authorization_Code__c, 
                            dealer__Customer__c, dealer__Customer__r.Name,dealer__Customer__r.IsPersonAccount, dealer__Customer__r.PersonMailingStreet,   //Case2069
                            dealer__Customer__r.PersonMailingCity, dealer__Customer__r.PersonMailingState, dealer__Customer__r.PersonMailingPostalCode,   //Case2069
                            dealer__Customer__r.BillingStreet, dealer__Customer__r.BillingCity, dealer__Customer__r.BillingState, dealer__Customer__r.Phone, //Case2069
                            dealer__Customer__r.PersonMobilePhone, dealer__Customer__r.PersonEmail,dealer__Customer__r.BillingPostalCode,dealer__Deposit__c, //Case2069
                            dealer__Parts_Invoice__c, dealer__Payment_Method__c, dealer__Rental_Agreement__c, dealer__Service_Repair_Order__c, 
                            dealer__Payment_Receipt_Details__c FROM dealer__Cashering__c WHERE ID =: ApexPages.currentPage().getParameters().get('id')];
            if(objCashering.dealer__Service_Repair_Order__c != null){
                objSRO = [SELECT Id, Name, dealer__Company__c, dealer__Vehicle__r.VIN__c,dealer__Invoiced_Date_Time__c, dealer__Customer_Invoice_Total__c, dealer__Customer__r.Name,
                          dealer__Customer__r.IsPersonAccount, dealer__Customer__r.PersonMailingStreet, dealer__Customer__r.PersonMailingCity, 
                          dealer__Customer__r.PersonMailingState, dealer__Customer__r.PersonMailingPostalCode, dealer__Customer__r.BillingStreet, 
                          dealer__Customer__r.BillingCity, dealer__Customer__r.BillingState, dealer__Customer__r.BillingPostalCode, dealer__Mileage_In__c,
                          dealer__Service_Advisor__r.Name, dealer__Create_Date_Time__c, dealer__Promise_Date__c, dealer__Tag__c, dealer__Vehicle__r.dealer__Year__c,
                          dealer__Vehicle__r.dealer__Make__c, dealer__Vehicle__r.dealer__Carline__c, Conversion_Manufacturer__c, dealer__Vehicle__r.dealer__Licence__c,                          
                          dealer__Customer__r.Phone, dealer__Customer__r.PersonMobilePhone, dealer__Customer__r.PersonEmail, dealer__Vehicle__c, dealer__Vehicle_Inventory__c                           
                          FROM dealer__Service_Repair_Order__c WHERE ID =: objCashering.dealer__Service_Repair_Order__c];
                if(objSRO.dealer__Company__c != null){             
                    userLoc = [select Id, Name, dealer__Address__c, dealer__City__c, dealer__Company_Number__c, dealer__Main_Phone__c, dealer__Postal_Code__c, 
                               dealer__State__c, dealer__Website__c, BAR_Number__c, EPA_Number__c, Tax_ID__c, Customer_Pay_Labor_Rate__c FROM dealer__Dealer_Location__c 
                               WHERE Id =: objSRO.dealer__Company__c]; 
                }
                if(objSRO.dealer__Vehicle_Inventory__c != null){
                    objVehicleInventory = [select Id,dealer__VIN__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__License__c, 
                                           dealer__Stock_Number__c FROM dealer__Vehicle_Inventory__c WHERE Id =: objSRO.dealer__Vehicle_Inventory__c]; 
                }   
                invoiceTime = null;
                if(objSRO.dealer__Invoiced_Date_Time__c!=null) {
                    TimeZone tz = UserInfo.getTimeZone();
                    invoiceTime = objSRO.dealer__Invoiced_Date_Time__c.AddSeconds(tz.getOffset(objSRO.dealer__Invoiced_Date_Time__c)/1000);
                }                          

            } else if(objCashering.dealer__Parts_Invoice__c != null){
                objPI = [SELECT Id, Name, dealer__Location__c, dealer__Invoice_Date_Time__c, dealer__Customer__r.Name,
                          dealer__Customer__r.IsPersonAccount, dealer__Customer__r.PersonMailingStreet, dealer__Customer__r.PersonMailingCity, 
                          dealer__Customer__r.PersonMailingState, dealer__Customer__r.PersonMailingPostalCode, dealer__Customer__r.BillingStreet, 
                          dealer__Customer__r.BillingCity, dealer__Customer__r.BillingState, dealer__Customer__r.BillingPostalCode,
                          dealer__Customer__r.Phone, dealer__Customer__r.PersonMobilePhone, dealer__Customer__r.PersonEmail                      
                          FROM  dealer__Parts_Invoice__c WHERE ID =: objCashering.dealer__Parts_Invoice__c];
                if(objPI.dealer__Location__c != null){             
                    userLoc = [select Id, Name, dealer__Address__c, dealer__City__c, dealer__Company_Number__c, dealer__Main_Phone__c, dealer__Postal_Code__c, 
                               dealer__State__c, dealer__Website__c, BAR_Number__c, EPA_Number__c, Tax_ID__c, Customer_Pay_Labor_Rate__c FROM dealer__Dealer_Location__c 
                               WHERE Id =: objPI.dealer__Location__c]; 
                } 
                invoiceTime = null;
                if(objPI.dealer__Invoice_Date_Time__c!=null) {
                    TimeZone tz = UserInfo.getTimeZone();
                    invoiceTime = objPI.dealer__Invoice_Date_Time__c.AddSeconds(tz.getOffset(objPI.dealer__Invoice_Date_Time__c)/1000);
                }                          
            } 

        }

        setUserLoc();

    }

    private void setUserLoc() {

        User me = [SELECT Id, Division FROM User WHERE Id=:UserInfo.getUserId() LIMIT 1];

        if(me.Division==null) {
            userLoc = new Dealer_Location__c();
        } else {
        	Dealer_Location__c[] locs = [SELECT Id, Name, Street__c, City__c, Company_Number__c, 
                                         		Main_Phone__c, Postal_Code__c, State__c, Website__c, 
                                         		Company_Contracting_Name__c,BAR_Number__c, EPA_Number__c, Tax_ID__c 
                                            FROM Dealer_Location__c 
                                            WHERE Company_Number__c =: me.Division LIMIT 1]; 
            if(locs.size()==1) {
            	userLoc = locs[0];    
            }
            
		}
    }


    public String getInvoiceLogo() {
        
        if(userLoc==null || userLoc.Id == null) {
            Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
            String imageId = doc.Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;
        }
        
        return DealershipLocationAPI.formLogoURL(userLoc.Id);
    }

    public string getprintDateTime() { 
        datetime dt = datetime.now();
        return dt.format('MM/dd/yyyy HH:mm a');        
    }          

}