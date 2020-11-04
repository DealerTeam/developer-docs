@isTest
private class TestCRMSettings {
    static testmethod void testBaseSettings() { 
        // Save with no settings
        
        CRMSettings crs = new CRMSettings();
        crs.Save();
        // Modify Settings and Save Again
        CRMSettings cru = new CRMSettings();
        system.assert(cru.crm.Id!=null);
        cru.Save();

        // Getters
        crs.getDupeOptions();

        // MPI Default Op Code Test of Save Method
        StandardOpCode__c mpiUpsellOp = new StandardOpCode__c(
                                                Name='Upsell Op', 
                                                Active__c=true, 
                                                Cause__c='Base Cause',
                                                dealer__Op_Code_Description__c='upsell operation code',
                                                dealer__Op_Code__c='01-MPI-UPSELL'
                                            );
        insert mpiUpsellOp;

        // Set the MPI Op on the CRM settings
        crs.crm.dealer__MPI_Upsell_OpCode__c = mpiUpsellOp.Id;
        crs.save();

        // Test the exception handling
        crs.crm.Sales_Up_Record_Prefix__c = 'LINGERTHAN24LINGERTHAN24LINGERTHAN24LINGERTHAN24LINGERTHAN24LINGERTHAN24LINGERTHAN24LINGERTHAN24LINGERTHAN24';
        crs.save();

        // PageReference Methods
        crs.deleteRecord();
        

        
    }

    static testmethod void testRentalSettings() {
        RentalSettings rs = new RentalSettings();
        rs.Save();
        RentalSettings rsa = new RentalSettings();
        System.assert(rsa.rs.Id!=null);
        //rsa.Save();
    }
}