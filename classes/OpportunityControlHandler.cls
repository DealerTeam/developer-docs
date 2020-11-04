public class OpportunityControlHandler {
    public void createSalesUp(List<Opportunity> triggerNew) {
        //Check if Sales Cloud Connector is enabled
        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];

        if(!dms.isEmpty()){

            if(dms[0].dealer__SalesCloudConnector__c == true){
                
                //Get field mapping from Opportunity to Sales Up
                List<SalesCloudConnectorMapping__mdt> sc = [SELECT Id, dealer__SourceObject__r.label, dealer__SourceField__r.label, 
                                    dealer__MappedObject__r.label, dealer__MappedField__r.label, dealer__MappedField__r.QualifiedApiName, dealer__SourceField__r.QualifiedApiName
                                    FROM dealer__SalesCloudConnectorMapping__mdt 
                                    WHERE dealer__MappedObject__r.QualifiedApiName = 'dealer__Sales_Up__c' AND dealer__SourceObject__r.QualifiedApiName = 'Opportunity'];
            
                List<dealer__Sales_Up__c> supList = new List<dealer__Sales_Up__c>();
                List<Id> supIds = new List<Id>();
                Map<Id, dealer__Sales_Up__c> supMap = new Map<Id, dealer__Sales_Up__c>();

                for(Opportunity opp : triggerNew){
                    supIds.add(opp.dealer__Sales_Up__c);
                }

                List<dealer__Sales_Up__c> existingSups = [SELECT Id, dealer__Opportunity__c FROM dealer__Sales_Up__c WHERE Id IN: supIds];
                for(dealer__Sales_Up__c sup : existingSups){
                    supMap.put(sup.Id, sup);
                }

                for(Opportunity o: triggerNew){
                    if(o.dealer__Sales_Up__c == null){
                        Sales_Up__c sup = new Sales_Up__c();
                        sup.dealer__Opportunity__c = o.Id;

                        for(SalesCloudConnectorMapping__mdt field : sc){
                            if(field.dealer__MappedField__c != null){
                                sup.put(field.dealer__MappedField__r.QualifiedApiName, o.get(field.dealer__SourceField__r.QualifiedApiName));
                            }
                        }
                    
                        supList.add(sup);
                    }

                    if(o.dealer__Sales_Up__c != null){
                        supMap.get(o.dealer__Sales_Up__c).dealer__Opportunity__c = o.Id;
                        supList.add(supMap.get(o.dealer__Sales_Up__c));
                    }   
                }

                if(!supList.isEmpty()){
                    upsert supList;
                }     
            }   
        }
    }

    public void updateSalesUp(List<Opportunity> triggerNew) {
        //Check if Sales Cloud Connector is enabled
        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        
        if(!dms.isEmpty()){
            if(dms[0].dealer__SalesCloudConnector__c == true){
                
                //Get field mapping from Opportunity to Sales Up
                List<SalesCloudConnectorMapping__mdt> sc = [SELECT Id, dealer__SourceObject__r.label, dealer__SourceField__r.label, 
                                    dealer__MappedObject__r.label, dealer__MappedField__r.label, dealer__MappedField__r.QualifiedApiName, dealer__SourceField__r.QualifiedApiName
                                    FROM dealer__SalesCloudConnectorMapping__mdt 
                                    WHERE dealer__MappedObject__r.QualifiedApiName = 'dealer__Sales_Up__c' AND dealer__SourceObject__r.QualifiedApiName = 'Opportunity'];
            
                List<dealer__Sales_Up__c> supList = new List<dealer__Sales_Up__c>();
                // List<Id> supIds = new List<Id>();
                // Map<Id, dealer__Sales_Up__c> supMap = new Map<Id, dealer__Sales_Up__c>();

                // for(Opportunity opp : triggerNew){
                //     supIds.add(opp.dealer__Sales_Up__c);
                // }

                // List<dealer__Sales_Up__c> existingSups = [SELECT Id, dealer__Opportunity__c FROM dealer__Sales_Up__c WHERE Id IN: supIds];
                // for(dealer__Sales_Up__c sup : existingSups){
                //     supMap.put(sup.Id, sup);
                // }

                for(Opportunity o: triggerNew){
                    if(o.dealer__Sales_Up__c != null){
                        Sales_Up__c sup = new Sales_Up__c();
                        sup.Id = o.dealer__Sales_Up__c;

                        for(SalesCloudConnectorMapping__mdt field : sc){
                            if(field.dealer__MappedField__c != null){
                                sup.put(field.dealer__MappedField__r.QualifiedApiName, o.get(field.dealer__SourceField__r.QualifiedApiName));
                            }
                            
                        }
                        supList.add(sup);
                    }

                    // if(o.dealer__Sales_Up__c != null){
                    //     supMap.get(o.dealer__Sales_Up__c).dealer__Opportunity__c = o.Id;
                    //     supList.add(supMap.get(o.dealer__Sales_Up__c));
                    // }
                    

                }
                if(!supList.isEmpty()){
                    update supList;
                }     
            }   
        }
    }

    public void handlePartnerRole(List<Opportunity> triggerNew){


        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];

        if(!dms.isEmpty()){

            if(dms[0].dealer__SalesCloudConnector__c == true){
                
                //Get field mapping from Opportunity to Sales Up
                List<SalesCloudConnectorMapping__mdt> mdList = [SELECT Id, dealer__SourceObject__r.QualifiedApiName, dealer__SourceField__r.label, dealer__Role__c, dealer__SourceField__r.DataType,
                                    dealer__MappedObject__r.label, dealer__MappedField__r.label, dealer__MappedField__r.QualifiedApiName, dealer__SourceField__r.QualifiedApiName
                                    FROM dealer__SalesCloudConnectorMapping__mdt 
                                    WHERE dealer__Role__c != null AND dealer__Role__c != ''];
                List<SalesCloudConnectorMapping__mdt> sc = new List<SalesCloudConnectorMapping__mdt>();
                //filter the results for only the right datatype
                for(SalesCloudConnectorMapping__mdt md : mdList){
                    if(md.dealer__SourceField__r.DataType == 'Lookup(Account)'){
                        sc.add(md);
                    }
                }
  
                Set<Id> oppIds = new Set<Id>();
                Set<Id> supIds = new Set<Id>();
                Map<Id, Partner> pMap = new Map<Id, Partner>();

                for(Opportunity opp : triggerNew){
                    oppIds.add(opp.Id);
                    supIds.add(opp.dealer__Sales_Up__c);
                }

                String dealQuery = 'SELECT ';
                String supQuery = 'SELECT ';
                for(SalesCloudConnectorMapping__mdt md : sc){
                    if(md.dealer__SourceObject__r.QualifiedApiName == 'dealer__Deal__c'){
                        dealQuery = dealQuery + md.dealer__SourceField__r.QualifiedApiName + ', ';
                    }
                    if(md.dealer__SourceObject__r.QualifiedApiName == 'dealer__Sales_Up__c'){
                        supQuery = supQuery + md.dealer__SourceField__r.QualifiedApiName + ', ';
                    }
                }

                dealQuery = dealQuery + 'Id FROM dealer__Deal__c WHERE dealer__Sales_Lead__c IN: supIds AND dealer__Sales_Lead__c != null';
                supQuery = supQuery + 'Id, dealer__Car_Deal__c FROM dealer__Sales_Up__c WHERE dealer__Opportunity__c IN: oppIds AND dealer__Opportunity__c != null';
                List<dealer__Deal__c> dealList = Database.query(dealQuery);
                List<dealer__Sales_Up__c> supList = Database.query(supQuery);
                Map<Id, dealer__Deal__c> dealMap = new Map<Id, dealer__Deal__c>();
                Map<Id, dealer__Sales_Up__c> supMap = new Map<Id, dealer__Sales_Up__c>();
                
                //get the associated deals in a map
                for(dealer__Deal__c d : dealList){
                    dealMap.put(d.Id, d);
                }
                //get associated sales ups in a map
                for(dealer__Sales_Up__c sup : supList){
                    supMap.put(sup.Id, sup);
                }

                List<Partner> partnerList = [SELECT Id, AccountToId, OpportunityId, Role FROM Partner WHERE OpportunityId IN: oppIds];
                for(Partner p : partnerList){
                    pMap.put(p.OpportunityId, p);
                }

                List<Partner> partnerUpdate = new List<Partner>();
                for(Opportunity o: triggerNew){

                    for(SalesCloudConnectorMapping__mdt field : sc){
                        //logic for deal partner fields
                        if(field.dealer__SourceObject__r.QualifiedApiName == 'dealer__Deal__c'){
                            Id dealId = supMap.get(o.dealer__Sales_Up__c).dealer__Car_Deal__c;
                            dealer__Deal__c d = dealMap.get(dealId);
                            Partner pRole = new Partner();
                            pRole = pMap.get(o.Id);
                            if(pRole != null){
                                if(pRole.AccountToId == d.get(field.dealer__SourceField__r.QualifiedApiName)){
                                    pRole.Role = field.role__c;
                                    partnerUpdate.add(pRole);
                                }
                            }
                            else{
                                pRole = new Partner();
                                pRole.put('AccountToId', d.get(field.dealer__SourceField__r.QualifiedApiName));
                                pRole.Role = field.role__c;
                                pRole.OpportunityId = o.Id;

                                //validate the account is not primary opp account
                                if(pRole.AccountToId != o.AccountId && pRole.AccountToId != null){
                                    partnerUpdate.add(pRole);
                                }
                            }
                        }
                        //logic for sales up partner fields
                        if(field.dealer__SourceObject__r.QualifiedApiName == 'dealer__Sales_Up__c'){
                            dealer__Sales_Up__c su = supMap.get(o.dealer__Sales_Up__c);
                            Partner pRole = new Partner();
                            pRole = pMap.get(o.Id);
                            if(pRole != null){
                                if(pRole.AccountToId == su.get(field.dealer__SourceField__r.QualifiedApiName)){
                                    pRole.Role = field.role__c;
                                    partnerUpdate.add(pRole);
                                }
                            }
                            else{
                                pRole = new Partner();     
                                pRole.put('AccountToId', su.get(field.dealer__SourceField__r.QualifiedApiName));
                                pRole.Role = field.role__c;
                                pRole.OpportunityId = o.Id;
                                

                                //validate the account is not primary opp account
                                if(pRole.AccountToId != o.AccountId && pRole.AccountToId != null){
                                    partnerUpdate.add(pRole);
                                }
                            }
                        }
                            
                        
                    }
                }

                if(!partnerUpdate.isEmpty()){
                    upsert partnerUpdate;
                }
            }
        }
    
    }

    public void handleContactRole(List<Opportunity> triggerNew){
   
        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];

        if(!dms.isEmpty()){

            if(dms[0].dealer__SalesCloudConnector__c == true){
                
                //Get field mapping from Opportunity to Sales Up
                List<SalesCloudConnectorMapping__mdt> mdList = [SELECT Id, dealer__SourceObject__r.QualifiedApiName, dealer__SourceField__r.label, dealer__Role__c, dealer__SourceField__r.DataType,
                                    dealer__MappedObject__r.label, dealer__MappedField__r.label, dealer__MappedField__r.QualifiedApiName, dealer__SourceField__r.QualifiedApiName
                                    FROM dealer__SalesCloudConnectorMapping__mdt 
                                    WHERE dealer__Role__c != null AND dealer__Role__c != ''];
                List<SalesCloudConnectorMapping__mdt> sc = new List<SalesCloudConnectorMapping__mdt>();
                //filter the results for only the right datatype
                for(SalesCloudConnectorMapping__mdt md : mdList){
                    if(md.dealer__SourceField__r.DataType == 'Lookup(Contact)'){
                        sc.add(md);
                    }
                }
  
                Set<Id> oppIds = new Set<Id>();
                Set<Id> supIds = new Set<Id>();
                Map<Id, opportunityContactRole> crMap = new Map<Id, opportunityContactRole>();

                for(Opportunity opp : triggerNew){
                    oppIds.add(opp.Id);
                    supIds.add(opp.dealer__Sales_Up__c);
                }

                String dealQuery = 'SELECT ';
                String supQuery = 'SELECT ';
                for(SalesCloudConnectorMapping__mdt md : sc){
                    if(md.dealer__SourceObject__r.QualifiedApiName == 'dealer__Deal__c'){
                        dealQuery = dealQuery + md.dealer__SourceField__r.QualifiedApiName + ', ';
                    }
                    if(md.dealer__SourceObject__r.QualifiedApiName == 'dealer__Sales_Up__c'){
                        supQuery = supQuery + md.dealer__SourceField__r.QualifiedApiName + ', ';
                    }
                }

                dealQuery = dealQuery + 'Id FROM dealer__Deal__c WHERE dealer__Sales_Lead__c IN: supIds AND dealer__Sales_Lead__c != null';
                supQuery = supQuery + 'Id, dealer__Car_Deal__c FROM dealer__Sales_Up__c WHERE dealer__Opportunity__c IN: oppIds AND dealer__Opportunity__c != null';
                List<dealer__Deal__c> dealList = Database.query(dealQuery);
                List<dealer__Sales_Up__c> supList = Database.query(supQuery);
                Map<Id, dealer__Deal__c> dealMap = new Map<Id, dealer__Deal__c>();
                Map<Id, dealer__Sales_Up__c> supMap = new Map<Id, dealer__Sales_Up__c>();
                
                //get the associated deals in a map
                for(dealer__Deal__c d : dealList){
                    dealMap.put(d.Id, d);
                }
                //get associated sales ups in a map
                for(dealer__Sales_Up__c sup : supList){
                    supMap.put(sup.Id, sup);
                }

                List<opportunityContactRole> crList = [SELECT Id, ContactId, OpportunityId, Role FROM opportunityContactRole WHERE OpportunityId IN: oppIds];
                for(opportunityContactRole cr : crList){
                    crMap.put(cr.OpportunityId, cr);
                }

                List<opportunityContactRole> crUpdate = new List<opportunityContactRole>();
                for(Opportunity o: triggerNew){

                    for(SalesCloudConnectorMapping__mdt field : sc){
                        //logic for deal contact role fields
                        if(field.dealer__SourceObject__r.QualifiedApiName == 'dealer__Deal__c'){
                            Id dealId = supMap.get(o.dealer__Sales_Up__c).dealer__Car_Deal__c;
                            dealer__Deal__c d = dealMap.get(dealId);
                            opportunityContactRole cRole = new opportunityContactRole();
                            cRole = crMap.get(o.Id);
                            if(cRole != null){
                                if(cRole.ContactId == d.get(field.dealer__SourceField__r.QualifiedApiName)){
                                    cRole.Role = field.role__c;
                                    crUpdate.add(cRole);
                                }
                            }
                            else{
                                cRole = new opportunityContactRole();
                                cRole.put('ContactId', d.get(field.dealer__SourceField__r.QualifiedApiName));
                                cRole.Role = field.role__c;
                                cRole.OpportunityId = o.Id;

                                //validate the contact field has a value
                                if(cRole.ContactId != null){
                                    crUpdate.add(cRole);
                                }
                            }
                        }
                        //logic for sales up contact role fields
                        if(field.dealer__SourceObject__r.QualifiedApiName == 'dealer__Sales_Up__c'){
                            dealer__Sales_Up__c su = supMap.get(o.dealer__Sales_Up__c);
                            opportunityContactRole cRole = new opportunityContactRole();
                            cRole = crMap.get(o.Id);
                            if(cRole != null){
                                if(cRole.ContactId == su.get(field.dealer__SourceField__r.QualifiedApiName)){
                                    cRole.Role = field.role__c;
                                    crUpdate.add(cRole);
                                }
                            }
                            else{
                                cRole = new opportunityContactRole();     
                                cRole.put('ContactId', su.get(field.dealer__SourceField__r.QualifiedApiName));
                                cRole.Role = field.role__c;
                                cRole.OpportunityId = o.Id;
                                

                                //validate the contact field has a value
                                if(cRole.ContactId != null){
                                    crUpdate.add(cRole);
                                }
                            }
                        }
                            
                        
                    }
                }

                if(!crUpdate.isEmpty()){
                    upsert crUpdate;
                }
            }
        }
    }
}