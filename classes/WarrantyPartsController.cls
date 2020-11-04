public with sharing class WarrantyPartsController {
    public String phone {get;set;}
    public ClaimAPI.Claim claimWrapper {get; private set;}
    public String custCell {get; set;}
    public String custPhone {get;set;}
    public String dlrPhone {get;set;}


    public WarrantyPartsController(ApexPages.StandardController controller){
         Id claimId = ApexPages.currentPage().getParameters().get('id');

        claimWrapper = ClaimAPI.claimData(claimId);

        if(claimWrapper.customer != null){
                  //Format Phone Numbers

            if (claimWrapper.customer.IsPersonAccount == true && claimWrapper.customer.PersonHomePhone != null) {
                custPhone = Utility.formatPhoneTen(claimWrapper.customer.PersonHomePhone);
            
            }else if (claimWrapper.customer.Phone != null){
                custPhone = Utility.formatPhoneTen(claimWrapper.customer.Phone);
                
            }
          
            if(claimWrapper.customer.IsPersonAccount == true && claimWrapper.customer.PersonMobilePhone != null){
                custCell = Utility.formatPhoneTen(claimWrapper.customer.PersonMobilePhone);

            }

        }

      
        if (claimWrapper.location != null && claimWrapper.location.dealer__Main_Phone__c != null) {
            dlrPhone = Utility.formatPhoneTen(claimWrapper.location.dealer__Main_Phone__c);

        }
       
    }


    
    
    
     
}