public with sharing class OperationGroupAPI {
    
    @AuraEnabled(cacheable=true)
	public static String getOpCodeHeaders(){
		List<OperationCodeGroup__c> headerGroups = new List<OperationCodeGroup__c>();
		for(OperationCodeGroup__c ocg :[select Id, name from OperationCodeGroup__c WHERE TopLevelGroup__c = true] ){
			headerGroups.add(ocg);
		}
		return JSON.serializePretty(headerGroups);
	}
	public class OpGroup{
        @AuraEnabled
		public OperationCodeGroup__c Parent {get;set;}
        @AuraEnabled
		public List<OperationCodeGroup__c> Children {get;set;}
        @AuraEnabled
		public List<StandardOpCode__c> OpCodes {get;set;}
		public OpGroup( OperationCodeGroup__c parent, List<OperationCodeGroup__c> children, List<StandardOpCode__c> opCodes){
			this.Parent = parent;
			this.Children = children;
			this.OpCodes = opCodes;
		}
	}

	@AuraEnabled
	public static String selectCodeGroup(String recordId){
		System.assert(recordId != null, 'Parent OperationCodeGroup Id is required to perform this action.');		
		OperationCodeGroup__c parentCodeGroup = [Select Id, Name FROM OperatioNCodeGroup__c WHERE Id =: recordId];
		Boolean bottomTier = false;
		Set<Id> opCodeSet = new Set<Id>();
		Set<Id> codeGroupSet = new Set<Id>();

		for(OperationGroupAssignment__c oga : [SELECT Id, OperationGroupParent__c, OperationGroupChild__c, StandardOperationCode__c FROM OperationGroupAssignment__c WHERE OperationGroupParent__c =: recordId]){
			if(oga.StandardOperationCode__c != null){
				bottomTier = true;
				opCodeSet.add(oga.StandardOperationCode__c);
			} else if(!bottomTier) {
				codeGroupSet.add(oga.OperationGroupChild__c); // Don' tneed to get any children if we've already reached bottom tier
			}
		}

		List<StandardOpCode__c> opCodes = new List<StandardOpCode__c>();
		List<OperationCodeGroup__c> childrenGroups = new List<OperationCodeGroup__c>();
		if(bottomTier){
			//get List of Available Op Codes
			for(StandardOpCode__c soc : [SELECT Id, Name FROM StandardOpCode__c WHERE Id IN: opCodeSet]){
				opCodes.add(soc);
			}
		} else {
			// get list of code group children
			for(OperationCodeGroup__c cg :[select Id, Name FROM OperationCodeGroup__c WHERE Id IN: codeGroupSet]){
				childrenGroups.add(cg);
			}
		}
        OpGroup g = new OpGroup(parentCodeGroup, childrenGroups, opCodes);
		return JSON.serializePretty(g);
	}

}