/**
 * ChartOfAccounts_EXT
 * @description
 */ 
public with sharing class ChartOfAccounts_EXT {
    
    /**
     * @description
     */ 
    ApexPages.standardController accountSC = null;
    
    /**
     * ChartOfAccounts_EXT 
     * @param  sc 
     * @return  ChartOfAccounts_EXT
     * @description  
     */ 
    public ChartOfAccounts_EXT(ApexPages.standardController sc) 
    {
        accountSC = sc;
    }
    
    /**
     * SaveandNew 
     * @return   PageReference
     * @description
     */ 
    public PageReference SaveandNew()
    {
        SObject so = accountSC.getRecord();
        try {
            
            upsert so;
            
            String s = '/' + ('' + so.get('Id')).subString(0, 3) + '/e?';
            return new PageReference(s);
            
        } catch(System.DmlException e) {
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(i)));
                }
            return null;
        }
    }
}