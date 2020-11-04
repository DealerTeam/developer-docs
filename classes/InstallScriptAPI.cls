global class InstallScriptAPI{

    public static void createDmsSetting()
    {
        DMSSettings controller = new DMSSettings();
        controller.barnumber='ADP-12345';
        controller.epanumber='EPA-12345';
        controller.defaultTaxRate=Decimal.valueOf('9.99');
        controller.internalLaborRate=Decimal.valueOf('100.12');
        controller.warrantyLaborRate=Decimal.valueOf('115.99');
        controller.laborRate=Decimal.valueOf('125.05');
        controller.partsInvoiceNumber=Decimal.valueOf('4000');
        controller.partsQuoteNumber=Decimal.valueOf('5000');
        controller.serviceInvoiceNumber=Decimal.valueOf('6000');
        controller.printEstimate=false;
        controller.printTechTimes=false;
        controller.serviceTaxIfPartsSoldOnly=true;
        controller.serviceTaxLabor=true;
        controller.dmsIntegrationMode=false;
        controller.serviceLineTotalTrigger=true;
        controller.cashierAutoClose=true;
        controller.leadsAutoAssignManager=true;
        controller.closedDealStatusCodes='A,U';
        controller.dealNumber=1000;
        controller.assignStockNumber = false;
        controller.assignStockNumberBySequence = false;
        controller.assignStockNumberByDate = false;
        controller.serviceAppointmentNumber = 2000;
        controller.dealControlsSalesUp=false;
        controller.linkedEvent=false;
        controller.save();
    }
    
    public static void createVdcSetting()
    {
        SecureVDCSettings vdcs = new SecureVDCSettings();
        vdcs.decoderName         = 'Data One Software';
        vdcs.decoderKey          = '1de4cab15a94d80a33f07d19ecb7eff44032bde7';
        vdcs.apiURL              = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
        vdcs.clientID            = '6310';
        vdcs.useBigObjectStorage = true;
        vdcs.saveVDCSettings();
    }    
    
    public static void createCrmSetting()
    {
        //The creation of a new CRMSettings record sets both the dealer__Native_or_Non_Native_Dupe_Catching__c and the Duplicate_Check_Statuses__c fields
        CRMSettings crm = new CRMSettings();
        crm.Save();
    }
    
    public static void setupPaymentMethods() {
        
        List<dealer__Payment_Methods__c> paymentMethodsForCashiering = [Select Id from dealer__Payment_Methods__c limit 1];

        if(paymentMethodsForCashiering.isEmpty()) {

            paymentMethodsForCashiering.add(new dealer__Payment_Methods__c(
                        dealer__Method__c='Cash',
                        dealer__Type__c='Cash',
                        Name='ActiveCash'   
                    )
            );

            insert paymentMethodsForCashiering;
        }
    } 
}