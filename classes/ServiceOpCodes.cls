public with sharing class ServiceOpCodes {

    public ServiceOpCodes() {}
    
    public List<catOpCode> opCodes() {
                List<catOpCode> opL = new List<catOpCode>();
                List<AggregateResult> cats = [Select dealer__Primary_Category__c from dealer__StandardOpCode__c group by dealer__Primary_Category__c];
                List<dealer__StandardOpCode__c> oplist = [Select Id, Name, dealer__Op_Code_Description__c, dealer__Primary_Category__c from dealer__StandardOpCode__c where dealer__Active__c = true order by Name asc limit 1000];
                
                // Netsted iteration, group then ops
                for(AggregateResult cts : cats) {
                    List<dealer__StandardOpCode__c> tmpSOP = new List<dealer__StandardOpCode__c>();
                    for(dealer__StandardOpCode__c sop : oplist) {
                        if(sop.dealer__Primary_Category__c == (string)cts.get('dealer__Primary_Category__c')) {
                            tmpSOP.add(sop);
                        }
                    }
                    
                    // Add op codes list to wrapper object
                    opL.add(new catOpCode((string)cts.get('dealer__Primary_Category__c'), tmpSOP));
                }
                system.debug(opL);
                return opL;
    }
    
    public List<catOpCode> getOpCodes() {
        return opCodes();
    }

    public List<dealer__StandardOpCode__c> getStandardOpCodes() {
        return [Select Id, Name, dealer__Op_Code_Description__c, dealer__Primary_Category__c from dealer__StandardOpCode__c where dealer__Active__c = true order by Name asc limit 1000];
    }
    
    public class catOpCode {
        public String Category {get;set;}
        public List<dealer__StandardOpCode__c> Op {get;set;}
        
        public catOpCode(String c, List<dealer__StandardOpCode__c> ops) {
            Category = c;
            Op = ops;
        }
    }
    
}