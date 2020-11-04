/**
 * Date            |Developer            |Work#
 * Notes
 * --
 * 2016.11.23      |Sneha Utture            |Case #2193
 * Created FormAPI class based on the FormControl class to use static methods to perform functions as the service layer of the application
 *
 */

public with sharing class FormControl {
  
  public String form_id {get;set;}
  public String form_id_editor {get;set;}
  public String deal_id {get;set;}
  public String appraisal_id {get;set;}
  public String deal_name {get;set;}
  public String formCode {get;set;}
  public dealer__Appraisal__c appraisal {get;set;}
  public dealer__Form__c form {get;set;}
  public dealer__Form__c newForm { get; set; }
  public dealer__Sales_Up__c sup {get; set;} // here to get a native deal lookup

  public dealer__Deal__c deal {get;set;}
  public dealer__Vehicle_Inventory__c vehicle {get;set;}
  public dealer__Dealer_Location__c location {get;set;}
  public dealer__Finance_Company__c financeCo {get;set;}

  public List<dealer__Trade_In__c> tradeInList {get; set;}

  public List<dealer__Deal_Tax__c> taxList {get; set;}
  public List<dealer__Discount_Rebate__c> discountList {get; set;}
  public List<dealer__After_Market__c> aftermarketList {get; set;}
  public List<dealer__Service_Contract__c> serviceContractList {get; set;}

  public List<dealer__Trade_In__c> tradeInList2 {get; set;}
  public dealer__Trade_In__c tradeIn1 {get; set;}
  public dealer__Trade_In__c tradeIn2 {get; set;}
  public dealer__Trade_In__c tradeIn3 {get; set;}

  public Map<Integer, List<List<String>>> formLines = new Map<Integer, List<List<String>>>();
  public dealer__SalesDeskLogSettings__c config = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
  public dealer__SalesDeskLogSettings__c getConfig() {
    return config;
  }
  
  public FormControl() {

    newForm   =   new dealer__Form__c();
    form      =   new dealer__Form__c();
    sup       =   new dealer__Sales_Up__c();
    appraisal =   new dealer__Appraisal__c();

    if(ApexPages.currentPage()!=null) {

      form_id         =   ApexPages.currentPage().getParameters().get('fid');
      form_id_editor  =   ApexPages.currentPage().getParameters().get('id');
      deal_id         =   ApexPages.currentPage().getParameters().get('did');
      appraisal_id    =   ApexPages.currentPage().getParameters().get('aprid');

      if(form_id!=null) {
        form = lookupForm(ID.valueOf(form_id));
        if (! Utility.IsBlank(form.dealer__Impact_Code__c)) {
          formCode = base64Decode(form.dealer__Impact_Code__c);
        }
      } 
    

      if(appraisal_id!=null) {
        appraisal = lookupAppraisal(ID.valueOf(appraisal_id));
      }

      if(form_id_editor!=null) {
        form = lookupForm(ID.valueOf(form_id_editor));
        formCode = base64Decode(form.dealer__Impact_Code__c);
      } 

      if(deal_id!=null) {
        deal = lookupDeal(ID.valueOf(deal_Id));
      }
    
      // Making Finance company Available
      if( deal != null ) {
        if(deal.dealer__Store_Location__r != null) {
          this.location = deal.dealer__Store_Location__r;
        }
        if(deal.dealer__Vehicle__r != null) {
          this.vehicle = deal.dealer__Vehicle__r;
        }
        if(deal.dealer__Finance_Institution_Account__r != null) {
          this.financeCo = deal.dealer__Finance_Institution_Account__r;
        }

          tradeInList2 = lookupTradeIns(deal_id);
        if(tradeInList2.size() > 0 && tradeInList2[0] != null) {
          tradeIn1 = tradeInList2[0];
        }
        if(tradeInList2.size() > 1 && tradeInList2[1] != null) {
          tradeIn2 = tradeInList2[1];
        }
        if(tradeInList2.size() > 2 && tradeInList2[2] != null) {
          tradeIn3 = tradeInList2[2];
        }

          taxList = retreiveTaxList();
          discountList = retreiveDiscountList();
          aftermarketList = retreiveAftermarketList();
          serviceContractList = retreiveServiceContractList();
      }
    }
  }

  public List<String> getObjectFieldNames() {
        return FormAPI.getObjectFieldNames(); //Case #2193
  }

  public String getObjectFieldNamesSimple() {
        return FormAPI.getObjectFieldNamesSimple(); //Case #2193
  }

  public PageReference newForm() {
    return Page.ImpactFormNew;
  }

  public PageReference saveNewForm() {

    dealer__Form__c insertForm = new dealer__Form__c();

    System.debug(newForm);
    System.debug(form);
    
        if(newForm.Name != null) {
          insertForm.dealer__Print_Type__c = 'Impact';
          insertForm.Name = newForm.Name;
          insertForm.Form_ID__c = newForm.Form_ID__c;
          insertForm.Sequence__c = newForm.Sequence__c;
        } else {
          insertForm = form.clone();
        }

    insert insertForm;
    return Page.ImpactForms;
  }

  public PageReference updateForm() {
    update form;
    return Page.ImpactForms;
  }

  public PageReference formsList() {
    return Page.ImpactForms;
  }

  public Component.Apex.OutputText getPreview () {
    return FormAPI.getPreview(form); //Case #2193
  }

  /**
   * getFDF - fdf string compiler
   * @return OutputText component for render in page
   */
  public Component.Apex.OutputText getFDF() {

    // Process variable list fees map    
    form = FormAPI.processFeeVariables(form, deal);

    return FormAPI.getFDF(form); 
  }

  public String base64Decode(String s) {
    return FormAPI.base64Decode(s); 
  }

  public dealer__Form__c lookupForm(Id formId) {
    return [SELECT Id, OwnerId, IsDeleted, Name, dealer__Active__c, dealer__Revision_Date__c, dealer__Sequence__c, dealer__Library__c, dealer__Page_Name__c, dealer__Proofed_by__c, dealer__Form_ID__c, dealer__Print_Type__c, dealer__Impact_Code__c, dealer__FDF_Code__c FROM dealer__Form__c
      Where Id=:formId
      and IsDeleted = false
      limit 1];
  }

  @AuraEnabled
  public static Form__c getForm(Id formId){
    return [SELECT Id, OwnerId, IsDeleted, Name, dealer__Active__c, dealer__Revision_Date__c, dealer__Sequence__c, dealer__Library__c, dealer__Page_Name__c, dealer__Proofed_by__c, dealer__Form_ID__c, dealer__Print_Type__c, dealer__Impact_Code__c, dealer__FDF_Code__c, DocumentContentId__c FROM dealer__Form__c
      Where Id=:formId
      and IsDeleted = false
      limit 1];
  }

  /**
   * lookupAppraisal
   * @param         appraisalId record Id of the Appraisal you would like to view
   * @return        [returns a database query of the selected appraisal]
   */
  public dealer__Appraisal__c lookupAppraisal(Id AprId) {
    return FormAPI.lookupAppraisal(AprId);
  }

  /**
   * lookupDeal
   * @param  dealId record Id of the deal you would like to view
   * @return        [returns a database query of the selected deal]
   */
  public dealer__Deal__c lookupDeal(Id dealId) {
    return FormAPI.lookupDeal(dealId); //Case #2193
  }
  
  /**
   * lookupTradeIns
   * 
   */
  public List<dealer__Trade_In__c> lookupTradeIns(Id dealId) {
        return FormAPI.lookupTradeIns(dealId); //Case #2193
  }  

  public List<dealer__Form__c> getForms() {
    return [Select Id, Name, dealer__Form_ID__c, dealer__Active__c, dealer__Library__c, dealer__Print_Type__c, dealer__Proofed_by__c, 
          dealer__Revision_Date__c, dealer__Sequence__c, CreatedDate, CreatedById
        from dealer__Form__c
        where dealer__Print_Type__c = 'Impact'
        Order By dealer__Sequence__c ASC
        limit 5000];
  }

  public PageReference compileFormSource() {
      update form;
      return null;
  }

  public PageReference setDealId() {
    System.debug(sup);
    System.debug(sup.dealer__Car_Deal__c);

    if(sup!=null && sup.dealer__Car_Deal__c !=  null) {
      System.debug(sup);
      
      deal = lookupDeal(sup.dealer__Car_Deal__c);
      System.debug(deal);

      deal_Id = deal.Id;
    } 

    return null;
  }

  public Account getBuyer() {
    return FormAPI.getBuyer(deal); //Case #2193
  }

  public Account getCoBuyer() {
    return FormAPI.getCoBuyer(this.deal); //Case #2193
  }

  public Boolean getisPersonAccount() {
    return FormAPI.getisPersonAccount(this.deal); //Case #2193
  }

  public dealer__Trade_In__c gettradeIn1() {
    return tradeIn1;
  }
  public dealer__Trade_In__c gettradeIn2() {
    return tradeIn2;
  }
  public dealer__Trade_In__c gettradeIn3() {
    return tradeIn3;
  }

  public List<dealer__Deal_Tax__c> retreiveTaxList() {
    return FormAPI.retreiveTaxList(deal); //Case #2193
  }

  public List<dealer__Discount_Rebate__c> retreiveDiscountList() {
    return FormAPI.retreiveDiscountList(deal); //Case #2193
  }

  public List<dealer__After_Market__c> retreiveAftermarketList() {
    return FormAPI.retreiveAftermarketList(deal); //Case #2193
  }

  public List<dealer__Service_Contract__c> retreiveServiceContractList() {
    return FormAPI.retreiveServiceContractList(deal); //Case #2193
  }

  public class cDeal {
    public String Id {get;set;}
    public String name {get;set;}
    public String buyerName {get;set;}

    public cDeal(dealer__Deal__c d){
      Id = d.Id;
      name = d.name;
      if(d.dealer__Buyer_First_Name__c != null && d.dealer__Buyer_Last_Name__c != null) {
        buyerName = d.dealer__Buyer_First_Name__c + ' ' + d.dealer__Buyer_Last_Name__c;
      }
    }
  }

}