/**
 * 2016-06-30   |Jarrett Kuljis |
 * Updated to create custom settings for Payment Methods on Install and insert new settings on update if none exist.
 *
 * 2016.10.25      |Abhishek Goel         |W-000572
 * Run batch class to update service lookup on Vehicle Inventory 
 *
 * 2016.10.27      |Abhishek Goel         |W-000622
 * Update new equipped field with old mis-spelled equiped field for version <= 1.582
 *
 */
global class InstallScript implements InstallHandler {
    global void onInstall(InstallContext context) {
        if(context.previousVersion() == null) {
           
            InstallScriptOrgAPI.createDmsSetting();

            InstallScriptOrgAPI.createVdcSetting();

            InstallScriptOrgAPI.createCrmSetting();

            InstallScriptOrgAPI.setupPaymentMethods();

        }

        if(context.isUpgrade()){

            InstallScriptOrgAPI.onUpgradeSettingUpdate();

            if(context.previousVersion().compareTo(new Version(1,582))  <= 0)
            {
                InstallScriptOrgAPI.onUpgradeDataUpdate();
            }

            // W-001541 - Active__c added to the VIN Decode Protected Settings.  This setting must be set to true on upgrade.  
            if(context.previousVersion().compareTo(new Version(3,21))  <= 0) 
            {
                InstallScriptOrgAPI.updateVDCActiveFlag();
            }
            
            // When upgrading the package from 5.28 or lower run batch to update internal charges on Vehicle Inventory records from related SROs
            if (context.previousVersion().CompareTo(new Version (5,28)) <= 0)
            {
                BatchUpdateVehicleInternalCharges bvi = new BatchUpdateVehicleInternalCharges();
				database.executeBatch(bvi);
            }
        }
    }

    public class InstallException extends Exception {}
}