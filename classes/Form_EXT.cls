/**
 * Form_EXT - Form manager and interaction class
 */
public with sharing class Form_EXT {
	
	public dealer__Form__c form {get;set;}
	public String documentId {get;set;}
	public String fdf {get;set;}
	public Document document {
		get {
			if(document==null) {
				document = new Document();
			}
			return document;
		}
		set;
	}

	/**
	 * Form_EXT (Constructor)
	 * @param  sc ApexPages Standard Controller
	 */
	public Form_EXT(ApexPages.StandardController sc) {

		form = (dealer__Form__c)sc.getRecord();
		if(ApexPages.currentPage().getParameters().get('recordId')!=null) {
            form = [SELECT Id, Name, DocumentContentId__c, FDF_Code__c FROM Form__c 
            where Id=:ApexPages.currentPage().getParameters().get('recordId')
            limit 1];  
			if(form.FDF_Code__c != null){
				fdf = 'has fdf'; 
			}

        }
	}

	/**
	 * uploadPDF - Upload the form content in BASE64 to the docgen server for storage in the database
	 * @return PageReference
	 */
	public PageReference uploadPDF() {

		/*
		// Perform PDF Upload
    	HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint('https://apsv1.dealerteam.com/docgen/uploadPDF.php');
        req.setMethod('POST');
        req.setBody('content='+EncodingUtil.base64Encode(document.body));
        req.setCompressed(true); // otherwise we hit a limit of 32000

        try {
            res = http.send(req);

        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }	
        */	

		return null;	
	}

	public void handleUpload(){
		form.documentContentId__c = documentId;
		update form;

		documentId = form.documentContentId__c;
	}

	public Pagereference handleFDF(){
		form.FDF_Code__c = fdf;
		update form;		
		
		return null;
	}
}