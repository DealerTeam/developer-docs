/**
 * MergedPDFController
 * @description
 */
public with sharing class MergedPDFController {
   
    /**
     * @description
     */
    public List<String> listBlobString{get;set;}
   
    /**
     * @description
     */
    public String pageString{get;set;}
   
    /**
     * @description
     */
    public string blobString{get;set;}

    /**
     * MergedPDFController 
     * @param  controller 
     * @description
     */
    public MergedPDFController(ApexPages.StandardController controller) 
    {

        pageString = '';     
        
        //Get pageName url parameter value          
        String pageNames = ApexPages.currentPage().getParameters().get('pageNames');
        Id dealId = ApexPages.currentPage().getParameters().get('id');  
        listBlobString=new List<String>();              
        
        //if any of form selected 
        if(pageNames!=null && pageNames!='' ){
            for(String str: pageNames.split(',')){
                
                //Get the pagereference 
                Pagereference myPage = new Pagereference('/apex/'+str.trim());
                
                System.debug('***'+myPage);
                Blob pageBlob;
                if(!Test.isRunningTest()){
                    pageBlob = myPage.getContent();                
                    pageString +=EncodingUtil.base64encode(pageBlob); 
                }
                listBlobString.add(pageString);               
            }            
                     
            blobString = pageString ;

        }   
    }

}