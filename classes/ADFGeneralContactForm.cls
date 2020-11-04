/**
 * ADFGeneralContactForm
 * @description Gets contents of General XML and assings to traffic event
 */
public with sharing class ADFGeneralContactForm {

    /**
     * ADFGeneralContactForm 
     * @description
     */
	public ADFGeneralContactForm() {}

    /**
     * parseADF 
     * @param  XML
     * @return boolean
     * @description Makes replacements in the XML and returns true if parsing was successful and false if failed.
     */
	public boolean parseADF(String XML) 
    {
		DOM.Document adfDoc = new Dom.Document();
        try {
            
            XML = XML.replaceAll('[\r\n]+', '');
            XML = XML.replace('<?ADF VERSION "1.0"?>', '');
            XML = XML.replace('<![CDATA[', '');
            XML = XML.replace(']]>', '');
            XML = XML.replace('&', '&amp;');
            
            adfDoc.load(XML);
            
            DOM.Xmlnode root = adfDoc.getRootElement();

            return unpack(root);
        } 
        
        Catch (System.Xmlexception e) 
        {
            new ADFException(e.getMessage());
            return false;        	
        }
	}

    /**
     * unpack 
     * @param nodes
     * @return boolean
     * @description Get contents of General XML and assign contents to traffic event. If successful, return "true".
     */
	public boolean unpack (DOM.Xmlnode nodes) 
    {
        if(nodes==null) 
        {
            throw new ADFException('Malformed ADF General Contact Document');
            return false;
        } 

        dealer__Traffic_Log__c t = new dealer__Traffic_Log__c();
        
        // Get Contents of General XML
        // https://gist.github.com/jarrettkuljis/a0371e43855ef53918af


        DOM.XmlNode contactForm = nodes;

        if(contactForm!=null) {
        	// Unpack form and assign contents to a traffic event
        	DOM.XmlNode contact = contactForm.getChildElement('contact', null);
        	if(contact==null) { throw new ADFException('Malformed ADF General Contact Document (No Contact Element)'); return false; }

        	t.dealer__Type__c = 'Email';
        	t.dealer__Traffic_Notes__c = (contact.getChildElement('comments',null) != null) ?  String.valueOf(contact.getChildElement('comments',null).getText()) : null;
        	t.dealer__First_Name__c = (contact.getChildElement('firstName',null) != null) ? String.valueOf(contact.getChildElement('firstName',null).getText()) : null;
        	t.dealer__Last_Name__c = (contact.getChildElement('lastName',null) != null) ? String.valueOf(contact.getChildElement('lastName',null).getText()) : null;
        	t.dealer__Calling_Number__c = (contact.getChildElement('phone',null) != null) ? String.valueOf(contact.getChildElement('phone',null).getText()) : null;
        	t.dealer__Customer_Email__c = (contact.getChildElement('email', null) != null) ? String.valueOf(contact.getChildElement('email', null).getText()) : null;
        	t.dealer__Form_Name__c = (contactForm.getChildElement('FormName', null) != null) ? String.valueOf(contactForm.getChildElement('FormName', null).getText()) : null;

            t.Name = 'Contact Form : ' + t.dealer__First_Name__c + ' ' +t.dealer__Last_Name__c;
        	
        	try {
        		insert t;
        	} Catch(DmlException e) 
            {
        		throw new ADFException('Unable to create Traffic Event '+e);
        		return false;
        	}

        	return true;
        }
        throw new ADFException('Malformed ADF General Contact Document (No FormEvent Element)');
        return false;
	}
    /**
     * ADFException
     * @description
     */
	public class ADFException extends Exception{}
}