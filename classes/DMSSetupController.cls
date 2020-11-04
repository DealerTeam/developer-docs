public class DMSSetupController{
	public dealer__DMS_Settings__c DMS {get;set;}
    public DMSSetupController() {
        DMS=dealer__DMS_Settings__c.getOrgDefaults();
        if(DMS==null) {
            DMS=new dealer__DMS_Settings__c();
        }
    }
    
    public PageReference Save() {
        // Save Settings
        if(DMS.Id==null) {
                insert DMS;
            } else {
                update DMS;
        }
        PageReference p = Page.DMSSettings;
        p.setRedirect(true);
        return p;
    }
}