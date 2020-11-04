/**
 * MergeRecordsUtil
 * @description
 */
public without sharing class MergeRecordsUtil {
    
    /**
     * @description This guides the number of merged records
     */ 
    public final static Integer MERGED_RECORDS_COUNT = 3;
    
    /**
     * @description Utility class to handle the master/loosers selection
     */
    public class SelectMasterResult
    {
        public List<SOBject> loserObjs = new List<SObject>();
        public SObject masterObject = null;
    }
    
    /**
     * @description Utility class to handle the single cell
     */ 
    public class InputHiddenValue
    {
        public InputHiddenValue(String name, Boolean isChecked, Boolean isSelectable)
        {
            this.isChecked = isChecked;
            this.isSelectable = isSelectable;
            this.name = name;
        }
        //checked or not to merge into che master record
        public Boolean isChecked{get;set;}
        //avoid formula/unchangeble fields
        public Boolean isSelectable{get;set;}
        //field name
        public String name{get;set;}
    }   
    
    /**
     * @description Utility class to handle field specs
     */
    public class Field
    {
        public Field(String name, String label, Boolean isWritable)
        {
            this.name = name;
            this.label = label;
            this.isWritable = isWritable;
        }
        public String name{get;set;}
        public String label{get;set;}
        public Boolean isWritable{get;set;}
    }
    
    /**
     * mergeRecords 
     * @param  merginObjects 
     * @param  masterId 
     * @return SelectMasterResult
     * @description
     */
    public static SelectMasterResult mergeRecords(List<SObject> merginObjects, String masterId)
    {
        SelectMasterResult res = new SelectMasterResult();
        
        //select the master record and the looser ones
        for(SObject sobj : merginObjects)
        {
            String id = (String)sobj.get('Id');
            if(id==null) continue;
            
            if(id == masterId)
            {
                res.masterObject = sobj;
            }
            else
            {
                res.loserObjs.add(sobj);
            }
        }
        return res;    
    }
    
    /*
        Copy looser records data into master record using the "selectedObjFields" (map of map of InputHddenValue)
    */
    
    /**
        "selectedObjFields" logic is like this:
         
        list of selected fields of all object
        stores:
            {OBJ-ID1, 
                    {FIELD1, TRUE}
                    {FIELD2, TRUE}
                    ...
                    {FIELDN, FALSE}
            OBJ-ID2, 
                    {FIELD1, FALSE}
                    {FIELD2, FALSE}
                    ...
                    {FIELDN, TRUE}
            }
    */  

    /**
     * copyDataIntoMasterRecord 
     * @param  recordSet         
     * @param  selectedObjFields 
     * @return void
     * @description
     */
    public static void copyDataIntoMasterRecord(SelectMasterResult recordSet, Map<ID,Map<String,InputHiddenValue>> selectedObjFields)
    {
        System.assert(recordset != null, 'RecordSet should not be null.');
        System.assert(recordset.masterObject != null, 'Master object should not be null.');
        System.assert(recordset.loserObjs != null && recordset.loserObjs.size()>0, 'Looser objects should not be null and should be more than 0.');
        
        system.debug('the selected fields are'+selectedObjFields);
        
        for(Sobject sobj : recordSet.loserObjs)
        {
            Map<String, InputHiddenValue> flds = selectedObjFields.get((ID)sobj.get('Id'));
            System.assert(flds != null,'Field Selection Map should not be null');
            for(InputHiddenValue inv : flds.values()){
                if(inv.isSelectable == false)continue;
                if(inv.isChecked == false) continue;
                recordSet.masterObject.put(inv.name, sobj.get(inv.name));
                system.debug('the input hidden value is'+inv.name);
            }
        }
    }
    
    /**
     * @description Init all the necessary describes
     */
    public class DescribeResult
    {
        public DescribeResult()
        {
            this.allFields = new Map<String,Field>();
            this.uniqueFields = new Map<String,String>();
        }
        //name fields map (API name / label)
        public String nameField {get;set;}
        public String nameFieldLabel {get;set;}

        //all fields
        public Map<String, MergeRecordsUtil.Field> allFields{get;set;}
        //sorted keyset
        public List<String> allFieldsKeySet{
            get{
    
                List<String> output = new List<String>(allFields.keySet());
                output.sort();
                return output;
            }
        }
        
        //unique fields to show in the search results
        public Map<String,String> uniqueFields {get;set;}
        //returns an ordered "unique fields" keyset
        public List<String> uniqueFieldsKeySet{
            get{
                List<String> ufl = new List<String>(uniqueFields.keySet());
                ufl.sort();
                return ufl;
            }
        }
        public Schema.SobjectType sOType = null;
    }
    
    /**
     * initDescribes 
     * @param  sObjectType 
     * @return DescribeResult
     * @description
     */
    public static DescribeResult initDescribes(String sObjectType)
    {
        DescribeResult result = new DescribeResult();
        
        //SOBject describe
        result.sOType = Schema.getGlobalDescribe().get(sObjectType);
        System.assert(result.sOType!=null ,'No describe for SObject '+result.sOType);
        
        Map<String, Schema.SObjectField> fieldMap = result.sOType.getDescribe().fields.getMap();

        result.nameField = 'Id';
        result.nameFieldLabel = 'Id';
        //search for "name" fields
        for(String name : fieldMap.keySet())
        {
            Schema.SObjectField field = fieldMap.get(name);
            Schema.DescribeFieldResult dfs = field.getDescribe();
            
            //all fields to display
            Boolean isWritable = dfs.isUpdateable();
            result.allFields.put(dfs.getName(),new Field(dfs.getName(),dfs.getlabel(),isWritable));
            
            if(dfs.isNameField())
            {
                result.nameField = dfs.getName();
                result.nameFieldLabel = dfs.getlabel();
            }
            //also adds unique fields
            else if(dfs.isUnique())
            {
                result.uniqueFields.put(dfs.getName(), dfs.getLabel());
            }
        }
        return result;
    }
}