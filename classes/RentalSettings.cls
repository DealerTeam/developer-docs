public with sharing class RentalSettings {
    public dealer__RentalSettings__c rs {get;set;}
    public RentalSettings() {
        rs=dealer__RentalSettings__c.getOrgDefaults();
        if(rs==null) {
            rs=new dealer__RentalSettings__c();
        }
    }
    
    public PageReference Save() {
        // Save Settings
        if(rs.Id==null) {
                insert rs;
            } else {
                update rs;
        }
        PageReference p = Page.RentalSettings;
        p.setRedirect(true);
        return p;
    }
}