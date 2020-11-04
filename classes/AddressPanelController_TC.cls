@isTest
public Class AddressPanelController_TC{
Static testmethod Void Myunittest(){

contact con = new contact();
con.LastName= 'Test';
//con.Name ='Test';
con.MailingStreet ='MailingStreet';
insert con;
  
AddressPanelController  apc = new AddressPanelController();
apc.openPanel();
apc.save();
apc.cancel();


  
  
  }
  }