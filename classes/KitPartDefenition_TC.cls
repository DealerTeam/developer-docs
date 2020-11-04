@isTest
public Class KitPartDefenition_TC{
Static testmethod Void Myunittest(){

dealer__Parts_Inventory__c pi=new dealer__Parts_Inventory__c();

dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
            pm.Name = 'Test';
            pm.dealer__Retail_Price__c = 0;
            pm.Manufacturer__c = 'KIT';
            
            insert pm;   
  
 RecordType realizedRecordTypeId = [select id from RecordType where name = 'Sale' limit 1];
 dealer__Chart_of_Accounts__c ca= new dealer__Chart_of_Accounts__c();
ca.Name='12';
ca.dealer__Description__c='Test';
ca.RecordTypeid=realizedRecordTypeId.id;
insert ca;



    dealer__Parts_Stocking_Group__c st= new dealer__Parts_Stocking_Group__c();
    st.dealer__Active__c =true;
    st.dealer__Default__c = true;
    st.dealer__Description__c='Standard Parts Sales';
    st.dealer__Internal_Sales__c=ca.id;
    st.dealer__Retail_Taxable__c=ca.id;
    st.dealer__Retail_Non_Taxable__c=ca.id;
    st.dealer__Wholesale_Taxable__c=ca.id;
    st.dealer__Wholesale_Non_Taxable__c=ca.id;
    insert st; 


    pi.Name='KIT:'+pm.Name;
    pi.dealer__Part_No__c=pm.Name;
     pi.dealer__Cost__c=0;
     pi.dealer__List__c=0;
     //pi.dealer__Description__c=pm.dealer__Description__c;
     pi.dealer__MFG__c='KIT';
     pi.dealer__Stocking_Group__c=st.Id;
     //pi.dealer__Kit__c=pm.Id;
     pi.dealer__Parts_Master__c=pm.Id;
     pi.dealer__Location__c=Utility.lookupUserLocation();  
     pi.dealer__Company_Number__c='CR1';
     
    // insert pi;                                                                                                                                        
}
}