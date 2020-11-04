@isTest (seeAllData=true)
private class TestInboundEmailNotification{
      static testMethod void testInboundEmail() {
     
     TestClassUtil TCU = new TestClassUtil();
		
	insert new Contact(FirstName='UniqueXX', LastName='NoDupesZZ', Email='formally_uniquexx@example.com');
          
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
     
      // setup the data for the email
          List<String> toAddresses = new List<String>();
          toAddresses.add('jarrett@dealerteam.com');
          email.toAddresses=toAddresses; 
      email.subject = 'Test Job Applicant';
      email.htmlBody= '<p>This is my reply</p>';
      email.plainTextBody = 'Bogus plain text body';
      env.fromAddress = 'formally_uniquexx@example.com';
     
      // add an attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfile.txt';
      attachment.mimeTypeSubType = 'text/plain';
     
      email.binaryAttachments =
        new Messaging.inboundEmail.BinaryAttachment[] { attachment };
     
      // call the email service class and test it with the data in the testMethod
      InboundEmailNotifications emailProcess = new InboundEmailNotifications();
      emailProcess.handleInboundEmail(email, env);
     
      // query for the contact the email service created
      Contact contact = [select id, firstName, lastName, email from contact
        where email =:env.fromAddress limit 1];
     
      // find the attachment
     // Attachment a = [select name from attachment where parentId = :contact.id];
     
      //System.assertEquals(a.name,'textfile.txt');
     
    }
}