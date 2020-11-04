global class ServiceVehicleAPI {
    

    global static sv svData(Id svId){
		System.assert(svId != null ,'sv Id is required to get sv Data.');

		ServiceVehicleAPI.sv sv = new ServiceVehicleAPI.sv();
        List<Sobject> temp = new List<Sobject>();

		//First get sv header.
		sv.svHeader = (dealer__Service_Vehicle__c)Utility.queryAllFields('dealer__Service_Vehicle__c', svId);

		//Attached Customer Account to service Vehicle
		if(sv.svHeader.dealer__Veh_Owner__c	 != null){
			sv.ownerAcct = (Account)Utility.queryAllFields('Account', sv.svHeader.dealer__Veh_Owner__c	);
		}
		//Attached Customer Contact to service Vehicle
		if(sv.svHeader.dealer__Veh_Owner_Contact__c	 != null){
			sv.ownerContact = (Contact)Utility.queryAllFields('Contact', sv.svHeader.dealer__Veh_Owner_Contact__c	);
		}

		//Attached employee that  created the service Vehicle
		if(sv.svHeader.CreatedById != null){
            // sv.employee = (User)Utility.queryAllFields('User', sv.svHeader.CreatedById);
            sv.employee = [SELECT Id, Name FROM USER WHERE Id =: sv.svHeader.CreatedById];
		}
        
        
        if(sv.svHeader.dealer__Sales_Inventory__c != null){
            sv.vehicle = (Vehicle_Inventory__c)Utility.queryAllFields('dealer__Vehicle_Inventory__c', sv.svHeader.dealer__Sales_Inventory__c);
		}
 
     
        if(sv.svHeader.dealer__Conversion__c != null){
            sv.conversion = (dealer__Parts_Kit__c)Utility.queryAllFields('dealer__Parts_Kit__c', sv.svHeader.dealer__Conversion__c);
		}
    
    // Get SRO's
        List<String> sroIds = new List<String>();

        for(dealer__Service_Repair_Order__c  sro : [SELECT Id FROM dealer__Service_Repair_Order__c WHERE dealer__Vehicle__c =: svId ]){
          sroIds.add(sro.Id);
        }
        if(sroIds.size() >0  ){
			sv.sro = (List<dealer__Service_Repair_Order__c>)Utility.queryAllFields('dealer__Service_Repair_Order__c',sroIds);
		
        }
    // Get Related Equipment
		List<String> equipmentIds = new List<String>();
            for(dealer__Equipment__c equipment : [ SELECT Id FROM dealer__Equipment__c Where dealer__Service_Vehicle__c =: svId]){
                equipmentIds.add(equipment.Id);
            }
            if(equipmentIds.size() > 0 ){
                sv.equipmentInvs = (List<dealer__Equipment__c>)Utility.queryAllFields('dealer__Equipment__c',equipmentIds);
            }

    // Get Related Contracts
		List<String> contractIds = new List<String>();
           for( dealer__Service_Contract__c contract : [ SELECT Id FROM dealer__Service_Contract__c Where dealer__Service_Vehicle__c =: svId]){
               contractIds.add(contract.Id);
           }
            if(contractIds.size() > 0){
                sv.contract = (List<dealer__Service_Contract__c>)Utility.queryAllFields('dealer__Service_Contract__c', contractIds);
            }

    //Get Related Inspection Reports
		List<String> inspectionReportIds = new List<String>();
            for(dealer__Inspection_Report__c inspectionReport : [ SELECT Id FROM dealer__Inspection_Report__c Where dealer__Service_Vehicle__c =: svId]){
                inspectionReportIds.add(inspectionReport.Id);
            }
            if(inspectionReportIds.size() > 0 ){
                sv.inspectionReports =  (List<dealer__Inspection_Report__c>)Utility.queryAllFields('dealer__Inspection_Report__c', InspectionReportIds);
            }
    // Get Related Appraisals
		List<String> AppraisalIds = new List<String>();

            for(dealer__Appraisal__c appraisal : [ SELECT Id FROM dealer__Appraisal__c WHERE Dealer__Service_Vehicle__c =: svId] ){
                AppraisalIds.add(appraisal.Id);
            }
            if(AppraisalIds.size() > 0 ){
                sv.appraisals = (List<dealer__Appraisal__c>)Utility.queryAllFields('dealer__Appraisal__c', AppraisalIds);
            }
		return sv;
	}

	/**
	 * Wrapper class for sv data and related records. 
	 */
	global class sv {

		// Header Data
		global Service_Vehicle__c svHeader {get;set;}

		// // Referential Data records available to create at the same time as the sv object. 

		global Account ownerAcct {get;set;}
		global Contact ownerContact {get;set;}
		global User employee {get;set;}
		global Vehicle_Inventory__c vehicle {get;set;}
		global Parts_Kit__c conversion {get;set;}
        


		// // List Data
		global List<dealer__Equipment__c> equipmentInvs {get;set;}
		global List<dealer__Inspection_Report__c> inspectionReports {get;set;}
        global List<Appraisal__c> appraisals {get;set;}
        global List<Service_Repair_Order__c> sro {get;set;} 
        global List<Service_Contract__c> contract {get;set;}




		global sv() {
            inspectionReports	           			=	new List<dealer__Inspection_Report__c>();
            equipmentInvs	           		        =	new List<dealer__Equipment__c>();
            appraisals                              =   new List<Appraisal__c>();
            sro                                     =   new List<Service_Repair_Order__c>();
            contract                                =   new List<Service_Contract__c>();
		}
	}
	
	global class ServiceVehicleException extends Exception {}
	
}