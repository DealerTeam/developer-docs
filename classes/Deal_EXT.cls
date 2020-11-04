/**
 * Deal_EXT
 * @description
 */
public with sharing class Deal_EXT {
    
    /**
     * @description
     */ 
    private dealer__Deal__c deal {get;set;}
    
    /**
     * @description
     */ 
    public list<dealer__DMS_Settings__c> dealDefaults = dealer__DMS_Settings__c.getall().values();
    
    /**
     * @description
     */ 
    public Contact buyer;
    
    /**
     * @description
     */ 
    public List<dealer__Form__c> forms {get;set;}
    
    /**
     * @description
     */ 
    public String dealTitle;
    
    /**
     * Deal_EXT 
     * @param  stdController 
     * @description
     */
    public Deal_EXT(ApexPages.StandardController stdController) 
    {
        System.debug('Controller Fired');
        // Catch Application Cache Error
        if(dealDefaults.size()==0) {
            throw new DealException('No deal defaults have been set.  Please contact the systems administrator.');
        }
        
        // Load Forms
        forms = [Select Id, dealer__Active__c, dealer__Revision_Date__c, dealer__Sequence__c, dealer__Library__c, 
                        dealer__Page_Name__c, dealer__Proofed_by__c, dealer__Form_ID__c, dealer__Print_Type__c, CreatedDate,
                        Name
                 FROM dealer__Form__c 
                 WHERE dealer__Active__c = true 
                 LIMIT 1000];
        
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Deal__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            stdController.addFields(af);
        }
        
        this.deal = (dealer__Deal__c)stdController.getRecord();
        
        // Set Defaults on First Load
        if(deal == new dealer__Deal__c()) {
            // Populate Defaults
            System.debug('Defaults being set on the first run');
            deal.dealer__Deal_Date__c = Date.today();
            deal.dealer__Rate__c = dealDefaults[0].dealer__Deal_Default_Rate__c;
            deal.dealer__Term__c = dealDefaults[0].dealer__Deal_Default_Term__c;
            deal.dealer__Days__c = dealDefaults[0].dealer__Deal_Default_Days__c;
            deal.Days_to_First__c= dealDefaults[0].dealer__Deal_Default_Days__c;
            deal.dealer__Payments_Per_Year__c = dealDefaults[0].dealer__Deal_Default_Payments_Per_Year__c;
            deal.dealer__Doc_Fee__c = dealDefaults[0].dealer__Deal_Doc_Fee_Retail__c;
        }
        
        // If Buyer, Co-Buyer, Company or Broker are passed as GET Method Arguments, load into Object.
        if(ApexPages.currentPage().getParameters().get('buyer')!=null) {
            buyer   =   Deal_EXT.lookupBuyer(ApexPages.currentPage().getParameters().get('buyer'));
            if(buyer != new Contact()) { 
                populateBuyerData(buyer);
            }
        }
    }

    /**
     * lookupBuyer 
     * @param  bid 
     * @return  Contact
     * @description
     */
    public static Contact lookupBuyer(String bid) 
    {
        Contact[] b = [Select Id, FirstName, LastName, Phone, MobilePhone, Email, MailingStreet, MailingCity, MailingPostalCode, MailingState  
                       from Contact 
                       where Id=:bid limit 1];
        if(b.size()!=1) { return null; }
        return b[0];
    } 
    
    /**
     * populateBuyerData 
     * @param  c 
     * @return void
     * @description
     */ 
    public void populateBuyerData(Contact c) 
    {
        deal.dealer__Buyer_Contact__c = c.Id;
        deal.dealer__Buyer_Address__c = c.MailingStreet;
        deal.dealer__Buyer_First_Name__c = c.FirstName;
        deal.dealer__Buyer_Last_Name__c = c.LastName;
    }
    
    /**
     * selectStockNumber 
     * @param  stkno 
     * @return List<dealer__Vehicle_Inventory__c>
     * @description      
     */ 
    @RemoteAction
    public static List<dealer__Vehicle_Inventory__c> selectStockNumber(String stkno) 
    {
        List<dealer__Vehicle_Inventory__c> inventory = [Select d.dealer__Year__c, d.dealer__Vehicle_Type__c, d.dealer__Vehicle_Size__c, 
                                                                d.dealer__Vehicle_Cost__c, d.dealer__VIN__c, d.dealer__Stock_Number__c, d.dealer__Status_Code__c, 
                                                                d.dealer__Sale_Date__c, d.dealer__Retail_Price__c, d.dealer__Reserve_Price__c, d.dealer__New_Tires__c, 
                                                                d.dealer__NUO__c, d.dealer__Model__c, d.dealer__Model_Code__c, d.dealer__Mileage__c, 
                                                                d.dealer__Memo_Two__c, d.dealer__Memo_One__c, d.dealer__Make__c, d.dealer__Location__c, 
                                                                d.dealer__License__c, d.dealer__License_Exp__c, d.dealer__Inventory_Date__c, 
                                                                d.dealer__In_Stock__c, d.dealer__Holdback__c, d.dealer__Days_in_Stock__c, d.dealer__Coded_Cost__c, 
                                                                d.dealer__Body_Type__c, d.dealer__Keyless_Entry_Code__c, d.dealer__Demo_Indicator__c, 
                                                                d.dealer__Ignition_Key_Code__c, d.dealer__MSRP__c, dealer__Pack__c 
                                                                From dealer__Vehicle_Inventory__c d 
                                                                where d.Id = :stkno
                                                                and d.IsDeleted=false 
                                                                Limit 1];
        return inventory;
    }
    
    /**
     * getdealTitle 
     * @return String
     * @description
     */
    public String getdealTitle() 
    {
        if(deal.Id==null) {
            return 'New Deal';
        } else {
            return deal.dealer__Stock_Number__c+' '+deal.dealer__Buyer_Last_Name__c+', '+deal.dealer__Buyer_First_Name__c;
        }
    }
    
    /**
     * save 
     * @return PageReference
     * @description
     */
    public PageReference save() 
    {
        System.debug('Deal Object '+deal);
        return null;
    }
    
    /**
     * @desciption Default Settings for a new Deal
     */
    public Date DealDate 
    { 
        get { 
            if(this.deal.Deal_Date__c == null) {
                return date.today();
            } else {
                return this.deal.Deal_Date__c;
            }
        }
        set {}
    }
    
    /**
     * @description
     */ 
    public Decimal Rate 
    { 
        get {
            if(this.deal.Rate__c != null && this.deal.Rate__c != 0) {
                return this.deal.Rate__c;
            } else {
                return dealDefaults[0].Deal_Default_Rate__c;
            }
        }
        set {
            
        }
    }
    
    /**
     * @description
     */
    public Decimal Term 
    {
        get {
            if(this.deal.Term__c != null && this.deal.Term__c != 0) {
                return this.deal.Term__c;
            } else {
                return dealDefaults[0].Deal_Default_Term__c;
            }
        }
        set { }
    }
    
    /**
     * @description
     */
    public Decimal Days 
    { 
        get {
            if(this.deal.Days__c != null && this.deal.Days__c != 0) {
                return this.deal.Days__c;
            } else {
                return dealDefaults[0].Deal_Default_Days__c;
            }
        }
        set { }
    } 
    
    /**
     * @description
     */
    public Decimal PPY 
    { 
        get {
            if(this.deal.Payments_Per_Year__c != null && this.deal.Payments_Per_Year__c != 0) {
                return this.deal.Payments_Per_Year__c;
            } else {
                return dealDefaults[0].Deal_Default_Payments_Per_Year__c;
            }
        }
        set { }
    }  

    /**
     * @description
     */   
    public Date DateofFirstPayment 
    { 
        get {
            if(this.deal.First_Payment_Date__c != null) {
                return this.deal.First_Payment_Date__c;
            } else {
                Date tmpDate = date.today();
                return tmpDate + integer.valueOf(dealDefaults[0].dealer__Deal_Default_Days__c);
            }
        }
        set { }
    }   
    
    /**
     * @description
     */
    public Decimal DocFee 
    {
        get {
            if(this.deal.Doc_Fee__c != null && this.deal.Doc_Fee__c != 0) {
                return this.deal.Doc_Fee__c;
            } else {
                return dealDefaults[0].dealer__Deal_Doc_Fee_Retail__c;
            }  
       } 
       set { }
    }
    
    public class DealException extends Exception{}
    
    //Added by KVP to update the salesup status once the deal is created
    @future
    public Static void updateSalesUp(List<Id> supIdLst){
        
        List<dealer__Sales_Up__c> supLstToUpdate = new List<dealer__Sales_Up__c>();
        
        for(Id supId :supIdLst){
            dealer__Sales_Up__c sup = new dealer__Sales_Up__c(id = supId);
            sup.dealer__Change_Status__c = false;
            supLstToUpdate.add(sup);
        }
        
        update supLstToUpdate;
    }
}