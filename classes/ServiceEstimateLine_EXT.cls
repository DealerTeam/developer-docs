public with sharing class ServiceEstimateLine_EXT {
    
    public final dealer__Service_Estimate_Line__c sel;
    private String lopName;
    public final dealer__Service_Estimate__c se { get; set; }
    public ApexPages.Standardcontroller controller;
    
    // <name>constructor</name>
    // <summary></summary>
    public ServiceEstimateLine_EXT(ApexPages.Standardcontroller slc) {
        controller = slc;
        sel = (dealer__Service_Estimate_Line__c)slc.getRecord();
        if(ApexPages.currentPage().getParameters().get('sId') != null) {
            se = [Select Id, Name, dealer__Inventory_Vehicle__c From dealer__Service_Estimate__c 
                    where Id = :ApexPages.currentPage().getParameters().get('sId')];    
            if(sel.dealer__Service_Estimate__c == null) {           
                sel.dealer__Service_Estimate__c=se.Id;
            }
        }
    }
    
    // <name>setLaborOpValues</name>
    // <summary>Populate labor operation SObject based on lop Name</summary>
    public PageReference setLaborOpValues() {
        dealer__StandardOpCode__c[] lop = [Select Id, Name, dealer__Estimate__c, dealer__Labor_Estimate__c, dealer__Parts_Estimate__c 
                                            from dealer__StandardOpCode__c where Name = :lopName limit 1];
        if(lop.size() > 0) {                                    
            sel.dealer__Labor__c = lop[0].dealer__Labor_Estimate__c;
        }
        
        return null;
    }

    // <name>save</name>
    // <summary>override default save action</summary>  
    public PageReference save() {
        controller.save();
        PageReference sev = Page.ServiceEstimateView;
        if(this.se != null) {
            sev.getParameters().put('id', string.valueOf(se.Id));
        }
        return sev;
    }

    // <name>setLopName</name>
    // <summary>Setter Method for lopName</summary> 
    public void setlopName(String l) {
        lopName = l;
    }
    
    // <name>getLopName</name>
    // <summary>getter method for lopname</summary> 
    public String getlopName() {
        return lopName;
    }
}