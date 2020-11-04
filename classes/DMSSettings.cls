/**
 * DMSSettings - controller to apply custom protected settings that determin how the product works.
 * @notes The properties in this class are referenced at package install time with the package install script.
 * @test Test_HelperClasses.cls
 */
public with sharing class DMSSettings {
    
    /**
     * @description
     */
    public dealer__DMS_Settings__c dms;

    /**
     * @description
     */
    public String barnumber {get;set;}
    
    /**
     * @description
     */
    public String epanumber {get;set;} 
    
    /**
     * @description
     */
    public String corporate_website {get;set;}
    
    /**
     * @description
     */
    public String corporate_facebook {get;set;}
    
    /**
     * @description
     */
    public Decimal defaultTaxRate {get;set;}
    
    /**
     * @description
     */
    public Decimal partsInvoiceNumber {get;set;}
    
    /**
     * @description
     */
    public Decimal partsQuoteNumber {get;set;}
    
    /**
     * @description
     */
    public Decimal serviceInvoiceNumber {get;set;}
    
    /**
     * @description
     */
    public Decimal laborRate {get;set;}
    
    /**
     * @description
     */
    public Decimal warrantyLaborRate {get;set;}
    
    /**
     * @description
     */
    public Decimal internalLaborRate {get;set;}
    
    /**
     * @description
     */
    public boolean printEstimate {get;set;}
    
    /**
     * @description
     */
    public boolean printTechTimes {get;set;}
    
    /**
     * @description
     */ 
    public boolean serviceTaxIfPartsSoldOnly {get;set;}
    
    /**
     * @description
     */ 
    public boolean serviceTaxLabor {get;set;}
    
    /**
     * @description
     */ 
    public boolean dmsIntegrationMode {get;set;}
    
    /**
     * @description
     */ 
    public boolean serviceLineTotalTrigger {get;set;}
    
    /**
     * @description
     */ 
    public boolean cashierAutoClose {get;set;}
   
    /**
     * @description
     */ 
    public boolean leadsAutoAssignManager {get;set;}
    
    /**
     * @description
     */ 
    public String closedDealStatusCodes {get;set;}
    
    /**
     * @description
     */ 
    public String dmsName {get;set;}
    
    /**
     * @description
     */ 
    public Decimal dealNumber {get;set;}
    
    /**
     * @description
     */ 
    public Boolean assignStockNumber {get;set;}
    
    /**
     * @description
     */ 
    public Boolean assignStockNumberBySequence {get;set;}
    
    /**
     * @description
     */ 
    public Boolean assignStockNumberBook {get;set;}
    
    /**
     * @description
     */ 
    public Boolean assignStockNumberByDate {get;set;}
    
    /**
     * @description
     */ 
    public String assignStockNumberByCustomField {get;set;}
    
    /**
     * @description
     */ 
    public Decimal stocknumberindex {get;set;}
    
    /**
     * @description
     */ 
    public Decimal stockLength {get;set;}
    
    /**
     * @description
     */ 
    public Decimal serviceAppointmentNumber {get;set;}

    /**
     * @description
     */ 
    public Decimal rentalMiles {get;set;}
    
    /**
     * @description
     */ 
    public Decimal rentalFuelRate {get;set;}
    
    /**
     * @description
     */ 
    public Decimal rentalMilesFee {get;set;}
    
    /**
     * @description
     */ 
    public Decimal rentalReFuelFee {get;set;}

    // Deal settings

    /**
     * @description
     */ 
    public Double deal_days {get;set;} // dealer__Deal_Default_Days__c
    
    /**
     * @description
     */ 
    public Double deal_payments {get;set;} //dealer__Deal_Default_Payments_Per_Year__c
    
    /**
     * @description
     */ 
    public Double deal_rate {get;set;} //dealer__Deal_Default_Rate__c
    
    /**
     * @description
     */ 
    public Double deal_term {get;set;} //dealer__Deal_Default_Term__c
    
    /**
     * @description
     */ 
    public Double deal_docfee {get;set;} //dealer__Deal_Doc_Fee_Retail__c

    /**
     * @description Status value to create RO - KVP
     */ 
    public String status {get;set;} 
    
    /**
     * @description
     */
    public decimal askingPrice {get;set;}
    
    /**
     * @description
     */
    public decimal auctionFee {get;set;}
    
    /**
     * @description
     */
    public decimal certification {get;set;}
    
    /**
     * @description
     */
    public decimal profitObjective {get;set;}
    
    /**
     * @description
     */
    public decimal transportation {get;set;}
    
    /**
     * @description
     */
    public String dealStatusForInv {get;set;}
    
    /**
     * @description
     */
    public String salesupStatusForInv {get;set;}
    
    /**
     * @description
     */
    public String roStatus {get;set;}
    
    /**
     * @description
     */
    public String vehSearchDefaultStatus {get;set;}
    
    /**
     * @description
     */
    public String dealCreatedDefaultStatus {get;set;}
    
    /**
     * @description
     */
    public String inStockDefaultStatus {get;set;}
    
    /**
     * @description
     */
    public String invStatusForSoldVehicle {get;set;}

    /**
     * @description
     */
    public String inegratedFinancials {get;set;}
    
    /**
     * @description
     */
    public boolean dealControlsSalesUp {get;set;}

    /**
     * @description
     */
    public String fdfRenderer {get;set;}

    /**
     * @description
     */
    public boolean linkedEvent {get;set;}

    /**
     * @description
     */
    public boolean isDMSPopulate {get;set;}

    /**
     * @description
     */
    public boolean isVDCPopulate {get;set;}

    /**
     * @description
     */
    public boolean isCRMPopulate {get;set;}
    
    /**
     * @description
     */
    public boolean isPaymentPopulate {get;set;}
    
    /**
     * @description
     */
    public boolean isUpdateEquipment {get;set;}
    
    /**
     * DMSSettings description
     * @description
     */
    public DMSSettings() 
    {
        
        isDMSPopulate = false;
        isVDCPopulate = false;
        isCRMPopulate = false;
        isPaymentPopulate = false;
        isUpdateEquipment = false;
        
        dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        
        assignStockNumber = false;

        if(dms != null) {
            barnumber=dms.dealer__BAR__c;
            epanumber=dms.dealer__EPA__c;
            defaultTaxRate=dms.dealer__Default_Tax_Rate__c;
            partsInvoiceNumber=dms.dealer__Parts_Current_Invoice_Number__c.setScale(0);
            partsQuoteNumber=dms.dealer__Parts_Current_Quote_Number__c;
            laborRate=dms.dealer__Service_CP_Labor_Rate__c;
            warrantyLaborRate=dms.dealer__Service_Warranty_Labor_Rate__c;
            internalLaborRate=dms.dealer__Service_Internal_Labor_Rate__c;
            serviceInvoiceNumber=dms.dealer__Service_Current_Invoice_Number__c;
            printEstimate=dms.dealer__Service_Print_Estimate_on_Repair_Order__c;
            printTechTimes=dms.dealer__Service_Print_Tech_Punch_on_Invoices__c;
            corporate_website=dms.dealer__Corporate_Website__c;
            corporate_facebook=dms.dealer__Corporate_Facebook_Page__c;
            serviceTaxIfPartsSoldOnly=dms.dealer__Service_RO_Tax_if_Parts_Sold__c;
            serviceTaxLabor=dms.dealer__Labor_Taxable__c;
            
            dmsIntegrationMode=dms.dealer__StandAloneMode__c;
            serviceLineTotalTrigger=dms.dealer__ServiceLineTotalTrigger__c;
            cashierAutoClose=dms.dealer__Cashier_Auto_Close__c;
            leadsAutoAssignManager=dms.dealer__Sales_Lead_Auto_Assign_Manager__c;
            closedDealStatusCodes=dms.dealer__Closed_Deal_Status_Codes__c;
            dmsName=dms.dealer__DMSName__c;

            deal_days = dms.dealer__Deal_Default_Days__c;
            deal_payments = dms.dealer__Deal_Default_Payments_Per_Year__c;
            deal_rate = dms.dealer__Deal_Default_Rate__c;
            deal_term = dms.dealer__Deal_Default_Term__c;
            deal_docfee = dms.dealer__Deal_Doc_Fee_Retail__c;

            assignStockNumber = dms.dealer__Assign_Stock_Number__c;
            assignStockNumberBySequence = dms.dealer__Assign_Stock_Number_by_Sequence__c;
            assignStockNumberBook=dms.dealer__Assign_Stock_Number_By_Stock_Book__c;
            assignStockNumberByCustomField=dms.Assign_Stock_Number_by_Custom_Field__c;
            assignStockNumberByDate = dms.AssignStockNumberByDate__c;

            dealNumber=dms.dealer__Deal_Number__c;
            stocknumberindex=dms.dealer__Stock_Number_Current_Index__c;
            stockLength=dms.dealer__Stock_Number_Length__c;
            serviceAppointmentNumber=dms.dealer__Service_Appointment_Sequence_Number__c;
            status = dms.dealer__Status__c;
            askingPrice = dms.dealer__Asking_Price__c;
            auctionFee = dms.dealer__Auction_Fee__c;
            certification = dms.dealer__Certification__c;
            profitObjective = dms.dealer__Profit_Objective__c;
            transportation = dms.dealer__Transportation__c;
            dealStatusForInv = dms.dealer__Deal_status_for_inventory__c;
            salesupStatusForInv = dms.dealer__Salesup_status_for_inventory__c;
            roStatus = dms.dealer__RO_Status__c;
            vehSearchDefaultStatus = dms.dealer__Vehicle_Search_Default_Status__c;
            dealCreatedDefaultStatus = dms.dealer__Deal_Created_Default_Status__c;
            inStockDefaultStatus = dms.dealer__In_Stock_Default_Status__c;
            InvStatusForSoldVehicle = dms.dealer__Inventory_Status_for_Sold_Vehicle__c;
            dealControlsSalesUp = dms.dealer__Deal_Status_Controls_Sales_Up_Status__c;
            inegratedFinancials = dms.dealer__Integrated_Financial_Application__c;
            fdfRenderer = dms.FDF_Renderer__c;
            linkedEvent = dms.dealer__SalesAppointmentLinkedEvent__c;
        }
    }
     public void installData()
    {
        if(isDMSPopulate)
        {
            // InstallScriptOrgAPI.createDmsSetting();
        }
        
        if(isVDCPopulate)
        {
            InstallScriptOrgAPI.createVdcSetting();
        }
        
        if(isCRMPopulate)
        {
            InstallScriptOrgAPI.createCrmSetting();
        }
        
        if(isPaymentPopulate)
        {
            InstallScriptOrgAPI.setupPaymentMethods();
        }
        
        if(isUpdateEquipment)
        {
            InstallScriptOrgAPI.onUpgradeDataUpdate();
        }
    }
    
    /**
     * save 
     * @return PageReference
     * @description
     */
    public PageReference save() 
    {
        
        installData();

        dms = DMS_Settings__c.getValues('ActiveSettings');
        
        System.debug(dms);

        if(dms==null) {
            dealer__DMS_Settings__c initialSetup = new dealer__DMS_Settings__c(
                                                                                Name='ActiveSettings',
                                                                                // dealer__BAR__c=String.valueOf(barnumber),
                                                                                // dealer__EPA__c=String.valueOf(epanumber),
                                                                                dealer__Default_Tax_Rate__c=defaultTaxRate,
                                                                                dealer__Parts_Current_Invoice_Number__c=partsInvoiceNumber,
                                                                                dealer__Parts_Current_Quote_Number__c=partsQuoteNumber,
                                                                                dealer__Service_CP_Labor_Rate__c=laborRate,
                                                                                dealer__Service_Internal_Labor_Rate__c=internalLaborRate,
                                                                                dealer__Service_Warranty_Labor_Rate__c=warrantyLaborRate,
                                                                                dealer__Service_Current_Invoice_Number__c=serviceInvoiceNumber,
                                                                                dealer__Service_Print_Estimate_on_Repair_Order__c=printEstimate,
                                                                                dealer__Service_Print_Tech_Punch_on_Invoices__c=printTechTimes,
                                                                                dealer__Corporate_Facebook_Page__c=corporate_facebook,
                                                                                dealer__Corporate_Website__c=corporate_website,
                                                                                dealer__Service_RO_Tax_if_Parts_Sold__c=serviceTaxIfPartsSoldOnly,
                                                                                dealer__Labor_Taxable__c=serviceTaxLabor,
                                                                                dealer__StandAloneMode__c=dmsIntegrationMode,
                                                                                dealer__ServiceLineTotalTrigger__c=serviceLineTotalTrigger,
                                                                                dealer__Cashier_Auto_Close__c=cashierAutoClose,
                                                                                dealer__Sales_Lead_Auto_Assign_Manager__c=leadsAutoAssignManager,
                                                                                dealer__Closed_Deal_Status_Codes__c=closedDealStatusCodes,
                                                                                dealer__DMSName__c=dmsName,
                                                                                dealer__Deal_Number__c=dealNumber,
                                                                                dealer__Deal_Default_Days__c=deal_days,
                                                                                dealer__Deal_Default_Payments_Per_Year__c=deal_payments,
                                                                                dealer__Deal_Default_Rate__c=deal_rate,
                                                                                dealer__Deal_Default_Term__c=deal_term,
                                                                                dealer__Deal_Doc_Fee_Retail__c=deal_docfee,
                                                                                dealer__Assign_Stock_Number__c=assignStockNumber,
                                                                                dealer__Assign_Stock_Number_by_Sequence__c = assignStockNumberBySequence,
                                                                                dealer__Stock_Number_Current_Index__c=stocknumberindex,
                                                                                dealer__AssignStockNumberByDate__c = assignStockNumberByDate,
                                                                                dealer__Stock_Number_Length__c=stockLength,
                                                                                dealer__Service_Appointment_Sequence_Number__c=serviceAppointmentNumber, 
                                                                                dealer__Status__c = status, 
                                                                                dealer__Asking_Price__c = askingPrice,
																				dealer__Auction_Fee__c = auctionFee,
																				dealer__Certification__c = certification,
																				dealer__Profit_Objective__c = profitObjective,
																				dealer__Transportation__c = transportation,
																				dealer__Deal_status_for_inventory__c = dealStatusForInv,
																				dealer__Salesup_status_for_inventory__c = salesupStatusForInv,
																				dealer__RO_Status__c = roStatus,
																				dealer__Vehicle_Search_Default_Status__c = vehSearchDefaultStatus, 
																				dealer__Deal_Created_Default_Status__c = dealCreatedDefaultStatus, 
																				dealer__In_Stock_Default_Status__c = inStockDefaultStatus, 
																				dealer__Inventory_Status_for_Sold_Vehicle__c = invStatusForSoldVehicle,
                                                                                dealer__Deal_Status_Controls_Sales_Up_Status__c = dealControlsSalesUp,
                                                                                dealer__Integrated_Financial_Application__c=inegratedFinancials,
                                                                                FDF_Renderer__c=fdfRenderer,
                                                                                dealer__SalesAppointmentLinkedEvent__c = linkedEvent
                                                                                );
                
            insert initialSetup;

        } else {
            dms.dealer__BAR__c=String.valueOf(barnumber);
            dms.dealer__EPA__c=String.valueOf(epanumber);
            dms.dealer__Default_Tax_Rate__c=defaultTaxRate;
            dms.dealer__Parts_Current_Invoice_Number__c=partsInvoiceNumber;
            dms.dealer__Parts_Current_Quote_Number__c=partsQuoteNumber;
            dms.dealer__Service_CP_Labor_Rate__c=laborRate;
            dms.dealer__Service_Internal_Labor_Rate__c=internalLaborRate;
            dms.dealer__Service_Warranty_Labor_Rate__c=warrantyLaborRate;
            dms.dealer__Service_Current_Invoice_Number__c=serviceInvoiceNumber;
            dms.dealer__Service_Print_Estimate_on_Repair_Order__c=printEstimate;
            dms.dealer__Service_Print_Tech_Punch_on_Invoices__c=printTechTimes;
            dms.dealer__Corporate_Website__c=corporate_website;
            dms.dealer__Corporate_Facebook_Page__c=corporate_facebook;
            dms.dealer__Service_RO_Tax_if_Parts_Sold__c=serviceTaxIfPartsSoldOnly;
            dms.dealer__Labor_Taxable__c=serviceTaxLabor;
            dms.dealer__StandAloneMode__c=dmsIntegrationMode;
            dms.dealer__serviceLineTotalTrigger__c=serviceLineTotalTrigger;
            dms.dealer__Cashier_Auto_Close__c=cashierAutoClose;
            dms.dealer__Sales_Lead_Auto_Assign_Manager__c=leadsAutoAssignManager;
            dms.dealer__Closed_Deal_Status_Codes__c=closedDealStatusCodes;
            dms.dealer__DMSName__c=dmsName;
            dms.dealer__Deal_Number__c=dealNumber;
            dms.dealer__Assign_Stock_Number__c = assignStockNumber;

            dms.dealer__Deal_Default_Days__c=deal_days;
            dms.dealer__Deal_Default_Payments_Per_Year__c=deal_payments;
            dms.dealer__Deal_Default_Rate__c=deal_rate;
            dms.dealer__Deal_Default_Term__c=deal_term;
            dms.dealer__Deal_Doc_Fee_Retail__c=deal_docfee;
            dms.dealer__Assign_Stock_Number_by_Sequence__c=assignStockNumberBySequence;
            dms.dealer__Assign_Stock_Number_By_Stock_Book__c=assignStockNumberBook;
            dms.Assign_Stock_Number_by_Custom_Field__c = assignStockNumberByCustomField;
            dms.AssignStockNumberByDate__c = assignStockNumberByDate;
            dms.dealer__Stock_Number_Current_Index__c=stocknumberindex;
            dms.dealer__Stock_Number_Length__c=stockLength;
            dms.dealer__Service_Appointment_Sequence_Number__c=serviceAppointmentNumber;
            dms.dealer__Status__c = status;
            dms.dealer__Asking_Price__c = askingPrice;
			dms.dealer__Auction_Fee__c = auctionFee;
			dms.dealer__Certification__c = certification;
			dms.dealer__Profit_Objective__c = profitObjective;
			dms.dealer__Transportation__c = transportation;
			dms.dealer__Deal_status_for_inventory__c = dealStatusForInv;
			dms.dealer__Salesup_status_for_inventory__c = salesupStatusForInv;
			dms.dealer__RO_Status__c = roStatus;
			dms.dealer__Vehicle_Search_Default_Status__c = vehSearchDefaultStatus;
			dms.dealer__Deal_Created_Default_Status__c = dealCreatedDefaultStatus;
			dms.dealer__In_Stock_Default_Status__c = inStockDefaultStatus;
			dms.dealer__Inventory_Status_for_Sold_Vehicle__c = invStatusForSoldVehicle;
            dms.dealer__Deal_Status_Controls_Sales_Up_Status__c = dealControlsSalesUp;
            dms.dealer__Integrated_Financial_Application__c = inegratedFinancials;
            dms.FDF_Renderer__c = fdfRenderer;
            dms.dealer__SalesAppointmentLinkedEvent__c = linkedEvent;
            update dms;

            if(dms.AssignStockNumberByDate__c == true){
                List<CronTrigger> jobs = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.Name = 'Reset Stock Number Index'];
                if(jobs.size() == 0){
                    VehicleInventoryAPI.resetStockSequence();
                }
            }
            else if(dms.AssignStockNumberByDate__c == false){
                List<CronTrigger> jobs = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.Name = 'Reset Stock Number Index'];
                for(CronTrigger job : jobs){
                    System.abortJob(job.Id);
                }
            }
        }
        
        return null;
    }
    
}