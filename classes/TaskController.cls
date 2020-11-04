public with sharing class TaskController {
    
    private ApexPages.StandardController m_stdController;
    private Task m_task;
    private Boolean m_isRelatedToAccount;
    private Boolean m_isRelatedToOpportunity;
    private Boolean m_isRelatedToDealerInventory;
    sObject m_who;
   
    public TaskController(ApexPages.StandardController stdController) 
    {
        m_stdController = stdController;
        m_task = (Task) stdController.getRecord();
    }

    // <name>save</name>
    // <summary>action override for save function to prevent page navigation for mobile view</summary>
    public PageReference save()
    {
        m_stdController.save();
        return null;
    }
    
    // <name>getIsRelatedToAccount</name>
    // <summary>Check task for relationship to Account</summary>    
    public Boolean getIsRelatedToAccount()
    {
        if(m_isRelatedToAccount==null)
        {
            m_isRelatedToAccount = m_task.WhatId != null && ((String)m_task.WhatId).startsWith(Schema.SObjectType.Account.keyPrefix);
        }
        return m_isRelatedToAccount;
    }

    // <name>getIsRelatedToDealerInventory</name>
    // <summary>Is this task related to an inventory item</summary>
    public Boolean getIsRelatedToDealerInventory()
    {
        if(m_isRelatedToDealerInventory==null)
        {
            m_isRelatedToDealerInventory = m_task.WhatId != null && ((String)m_task.WhatId).startsWith(Schema.SObjectType.dealer__Vehicle_Inventory__c.keyPrefix);
        }
        return m_isRelatedToDealerInventory;
    }

    // <name>getPhone</name>
    // <summary>If related to account get Contact phone#</summary>
    public String getPhone()
    {
        return (String) getWho().get('Phone');
    }
    
    // <name>getEmail</name>
    // <summary>If related to an account get contact Email</summary>    
    public String getEmail()
    {
        return (String) getWho().get('Email');
    }

    // <name>getWho</name>
    // <summary>If who ID prefix is of type contact, query selected item</summary>
    private sObject getWho()
    {
        if(m_who==null)
        {
            m_who = new Contact();
            if(m_task.WhoId != null)
            {
                List<SObject> rows;
                if( ((String)m_task.WhoId).startsWith(Schema.SObjectType.Contact.keyPrefix) )
                {
                    rows = [select Phone, Email from Contact where Id = :m_task.WhoId];
                }
                if(rows.size()==1)
                {
                    m_who = rows[0];
                }
            }
        }
        return m_who;
    }
}