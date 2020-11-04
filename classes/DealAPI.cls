/**
*	DealAPI provides service layer logic for processing requests related to the Deal Records
*
*/
global class DealAPI
{
	/**
	* Creates a Deal Record
	* @param dealData DealAPI.deal
	* @return Deal__c
	*/
	global static Deal__c create(deal dealData)
	{

		// Parent container 
		Deal__c deal = new Deal__c();

		// Transaction Control
		SavePoint sp = Database.setSavePoint();

		// Assembly records 
		deal = dealData.dealHeader;

		if(deal.Deal_Date__c == null){
			deal.Deal_Date__c = date.today();
		}

		if(dealData.buyer!=null && dealData.buyer.Id==null) {
			try {
				insert dealData.buyer;
				deal.Buyer__c=dealData.buyer.Id;
			} Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}

		if(dealData.cobuyer!=null && dealData.cobuyer.Id==null) {
			try {
				insert dealData.cobuyer;
				deal.Co_Buyer__c=dealData.cobuyer.Id;
			} Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}	

		

		if(dealData.salesup!=null && dealData.salesup.Id==null) {
			System.assert(deal.Buyer__c!=null, 'Deal Buyer (Account Lookup) must reference a valid account when creating a SalesUp record within the DealAPI.create() method. ');
			try {
				SalesUp supInstance = new SalesUp();
        		SalesUp.SalesUpWrapper salesUp = new SalesUp.SalesUpWrapper(new Account(Id=deal.Buyer__c), new Contact(), null, null, null, dealData.salesup, true);
		        deal.Sales_Lead__c = supInstance.create(salesUp).Id;

			} Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}
		// Specify the Next Deal#
		Integer dealNumber 	= 	Utility.nextDealNumber();
		deal.Deal_ID__c		=	String.valueOf(dealNumber);
		deal.Name 			=	String.valueOf(dealNumber); 

		//Vehicle / Conversion Default Taxable from location
        if(deal.Store_Location__c != null){
            Dealer_Location__c loc = [SELECT VehicleTaxDefault__c, TaxConversion__c FROM Dealer_Location__c WHERE Id =: deal.Store_Location__c];
			deal.IsVehicleTax__c = loc.VehicleTaxDefault__c;
            deal.isConvertionTax__c = loc.TaxConversion__c;
		}

		dealData.dealHeader = deal;
		Tax_Zones__c [] availableZones = TaxAPI.getAvailableTaxZonesDeal('', dealData);

		if(availableZones.size() == 1){
			system.debug('One Tax Zone Was Returned - Add To deal Automatically and apply it');
			deal.Tax_Zone__c = availableZones[0].Id;
		}
		
		try {
			insert deal;
			dealData.dealHeader = deal;
		} Catch(DmlException e) {
			Database.rollback(sp);
			throw new DealAPIException(e.getMessage());
		} Catch(Exception e) {
			Database.rollback(sp);
			throw new DealAPIException(e.getMessage());
		}
		
		// List Data Creation
		// Aftermarket record creation
		List<After_Market__c> afterMarketInsert = new List<After_Market__c>();
		for(After_Market__c a : dealData.afterMarketItems) {
			a.Car_Deal__c = deal.Id;
			afterMarketInsert.add(a);
		}

		// Service Contract record creation
		List<Service_Contract__c> serviceContractInsert = new List<Service_Contract__c>();
		for(Service_Contract__c s : dealData.serviceContractItems) {
			s.Car_Deal__c = deal.Id;
			serviceContractInsert.add(s);
		}

		// Deal Forms insertion
		List<Deal_Form__c> forms = new List<Deal_Form__c>();
		for(Deal_Form__c f : dealData.dealForms) {
			f.Deal__c=deal.Id;
			forms.add(f);
		}

		// TradeIn recoreds
		List<Trade_In__c> trades = new List<Trade_In__c>();
		for(Trade_In__c t : dealData.tradeIns) {
			t.Car_Deal__c = deal.Id;
			trades.add(t);
		}

		// Fee records 
		List<Sales_Fee__c> fees = new List<Sales_Fee__c>();
		for(Sales_Fee__c f : dealData.dealFees) {
			f.Car_Deal__c = deal.Id;
			fees.add(f);
		}

		// DiscountRebate records
		List<Discount_Rebate__c> rebates = new List<Discount_Rebate__c>();
		for(Discount_Rebate__c r : dealData.rebates) {
			r.Deal__c = deal.Id;
			rebates.add(r);
		}

		// Cashiering Records
		List<Cashering__c> cashEntries = new List<Cashering__c>();
		for(Cashering__c c : dealData.cashierItems) {
			c.Deal__c = deal.Id;
			cashEntries.add(c);
		}


		// Data Markup Execute
		try {

			insert afterMarketInsert;
			insert serviceContractInsert;
			insert forms;
			insert trades;
			insert fees;
			insert rebates;
			insert cashEntries;

			deal = DealCalculations.setDealTotals(deal);
			update deal;

		} Catch(Exception e) {
			Database.rollback(sp);
			throw new DealAPIException(e.getMessage());
		}

		// Referential Data, this data needs to be available to the record header
		return deal;
	}

	public static Deal__c createFromSalesUp(deal dealData){
		// Parent container 
		Deal__c deal = new Deal__c();

		// Transaction Control
		SavePoint sp = Database.setSavePoint();

		// Assembly records 
		deal = dealData.dealHeader;

		if (dealData.salesup != null && dealData.salesup.Id != null){
			dealData = generateFromSalesUp(dealData);
			deal = dealData.dealHeader;
			// Specify the Next Deal#
			Integer dealNumber 	= 	Utility.nextDealNumber();
			deal.Deal_ID__c		=	String.valueOf(dealNumber);
			deal.Name 			=	String.valueOf(dealNumber); 
			
			if(deal.Store_Location__c != null){
				Dealer_Location__c loc = [SELECT VehicleTaxDefault__c, TaxConversion__c FROM Dealer_Location__c WHERE Id =: deal.Store_Location__c];
				deal.IsVehicleTax__c = loc.VehicleTaxDefault__c;
				deal.isConvertionTax__c = loc.TaxConversion__c;
			}

			if(deal.Deal_Date__c == null){
				deal.Deal_Date__c = date.today();
			}

			try {
				insert deal;

				if(dealData.salesup.ConversionPartsKit__c != null){
					createAfterMarketItems(dealData.salesup.ConversionPartsKit__c, deal);
				}

				saveTradesData(dealData);

				Deal__c dealRecord = (Deal__c)Utility.queryAllFields('dealer__Deal__c', deal.Id);
				dealData.dealHeader = deal;
				Tax_Zones__c [] availableZones = TaxAPI.getAvailableTaxZonesDeal('', dealData);
		
				if(availableZones.size() == 1){
					system.debug('One Tax Zone Was Returned - Add To deal Automatically and apply it');
					deal.Tax_Zone__c = availableZones[0].Id;
				}

				deal = DealCalculations.setDealTotals(deal);
				update deal;
				// TaxAPI.calculateTaxes(dealRecord);
				// TaxAPI.applyTaxZone(dealRecord, new Tax_Zones__c(Id=dealRecord.Tax_Zone__c));

			} Catch(DmlException e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			} Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
			//After Market Items for insert
		}
		return deal;
	}

	public static Deal generateFromSalesUp(Deal dealData){
			System.assert(dealData.salesup != null && dealData.salesUp.Id != null, 'A valid Sales Up record is required to create a Deal from a Sales Up.');

			/* Select the SalesUp and Related Data */
			Sales_Up__c sup = [SELECT Id, Buyer_Contact__c, Co_Buyer_Contact__c, Customer_Account__c, 
			Co_Buyer__c, Desired_Stock_Num__c, Salesperson_1__c, Salesperson_2__c, 
			Desk_Manager_User__c, F_I_Manager__c,
			Trade_Comments__c, Trade_Make__c, Trade_Mileage__c, Trade_Model__c,
			Trade_VIN__c, Trade_Year__c, Service_Vehicle__c, Store_Location__c, 
			RecordType.DeveloperName, ConversionPartsKit__c,
				(Select Id, Name, Appraisal__c, Interior_Color__c, Make__c, Model__c, New_Used_Other__c, 
				Service_Vehicle__c, Trim_Level__c, VIN__c, Year__c,
				Service_Vehicle__r.Stock_Number__c, Service_Vehicle__r.Last_Odometer__c, 
				Appraisal__r.Appraised_Value__c, Appraisal__r.ACV_Actual_Cash_Value__c, 
				Sales_Up__r.Customer_Account__r.Name, 
				Sales_Up__r.Customer_Account__c, 
				Appraisal__r.Appraisal_Date__c
				FROM Appraisal_Vehicles__r 
				Order By CreatedDate DESC)
			FROM Sales_Up__c 
			WHERE Id=:dealData.salesup.Id
			LIMIT 1];	


			Deal__c deal = new Deal__c();
	
			// Check to see if a service vehicle is present on the Sup.  If present on the SUP populate the Service Vehicle on the Deal
			if(sup.Service_Vehicle__c!=null && sup.RecordType.DeveloperName == 'Equipment_Only') {
				Service_Vehicle__c svcVehicle = [SELECT Id, Name, Carline__c, VIN__c, Stock_Number__c, 
				Make__c, Conversion__c, Vehicle_Type__c, Ext_Color__c, 
				Int_Color__c, Body_Type__c, Body_Style__c, Year__c,
				Trim_Level__c, Last_Odometer__c 
				FROM Service_Vehicle__c
				WHERE Id=:sup.Service_Vehicle__c LIMIT 1];
	
				deal.Service_Vehicle__c =   svcVehicle.Id;
				deal.VIN__c     =   svcVehicle.VIN__c;
				deal.Year__c    =   svcVehicle.Year__c;
				deal.Make__c    =   svcVehicle.Make__c;
				deal.Model__c   =   svcVehicle.Carline__c;
				deal.Trim_Level__c = svcVehicle.Trim_Level__c;
				deal.Mileage__c =   svcVehicle.Last_Odometer__c;
				deal.Exterior_Color__c  =   svcVehicle.Ext_Color__c;
				deal.Interior_Color__c  =   svcVehicle.Int_Color__c;
				deal.Deal_Type__c = 'Equipment Only'; 
			}
			else if(sup.Service_Vehicle__c==null && sup.RecordType.DeveloperName == 'Equipment_Only') {
	
				deal.Deal_Type__c = 'Equipment Only'; 
			}
	
			deal.Deal_Date__c = Date.today();
			deal.Sales_Lead__c = sup.Id;
	
			// Assign the Location Record
			Dealer_Location__c location = new Dealer_Location__c();
			if(sup.Store_Location__c!=null){
	
				deal.Store_Location__c = sup.Store_Location__c; 
				
				//?
				location = [SELECT Id ,Default_Days_to_First_Payment__c, Default_Rate__c, Default_Term__c, Postal_Code__c,Tax_Delivery_Address__c FROM Dealer_Location__c WHERE Id =:deal.Store_Location__c LIMIT 1];
	
				} else {
	
					User u  = [Select Id, Division from User where Id =:UserInfo.getUserId() limit 1];     
	
					if(u.Division==null) {
						throw new DealAPIException('User MUST have Division set.');
					}
	
					location = [Select Id ,Default_Days_to_First_Payment__c, Default_Rate__c, Default_Term__c, Postal_Code__c,Tax_Delivery_Address__c from Dealer_Location__c where Company_Number__c =:u.Division limit 1];
					deal.Store_Location__c = location.Id;
				} 
	
			// Get Defaults from the Location Record
			if(location!=null) {
				deal.Days_to_First__c = location.Default_Days_to_First_Payment__c;
				if(location.Default_Rate__c != null) {
					deal.Rate__c = location.Default_Rate__c;            
				}
				deal.Term__c = location.Default_Term__c;
			}
			deal.Payments_Per_Year__c = 12;
			deal.Salesperson_1__c = sup.Salesperson_1__c;
			deal.Salesperson_2__c = sup.Salesperson_2__c;
			deal.Desk_Manager__c  = sup.Desk_Manager_User__c;
			deal.F_I_Manager__c   = sup.F_I_Manager__c;
			deal.Service_Vehicle__c = sup.Service_Vehicle__c;

			// if(sup.Appraisal_Vehicles__r.size() > 0){  // W-000901
			// 	appraisalVehList = sup.Appraisal_Vehicles__r;
			// }

			if(sup.Desired_Stock_Num__c!=null) { 
				populateVehicle( deal, sup.Desired_Stock_Num__c ); //1
			}

			if(sup.Customer_Account__c != null) {
				populateBuyerData(deal, sup.Customer_Account__c); //2
				} else if(sup.Buyer_Contact__c!=null) {
				// Get Account Id from Contact.
				Contact buyer = [Select Id, AccountId from Contact where Id=:sup.Buyer_Contact__c limit 1];
				populateBuyerData(deal, buyer.AccountId); //3
			}
	
	
			if(sup.Co_Buyer__c != null) {
				populateCoBuyerData(deal, sup.Co_Buyer__c);  //4
				} else if(sup.Co_Buyer_Contact__c!=null) {
	
					Contact cobuyer = [Select Id, AccountId from Contact where Id=:sup.Co_Buyer_Contact__c limit 1];
					populateCoBuyerData(deal, cobuyer.AccountId); //5
				}
	
			// Setting Other default Fields
			deal.Pickup_or_Delivery__c = 'Pickup';
	
			if(deal.Deal_Type__c==null) {
				deal.Deal_Type__c = 'Chassis / Conversion';
			}
		dealData.salesup = sup;
		dealData.dealHeader = deal;

		return dealData;
	}

	public static void populateVehicle(Deal__c deal, Id vehId){
		Vehicle_Inventory__c v = [SELECT Year__c, Vehicle_Type__c, Vehicle_Size__c, Trim_Level__c,
        Vehicle_Cost__c, VIN__c, Stock_Number__c, Status_Code__c, 
        Sale_Date__c, Retail_Price__c, Reserve_Price__c, New_Tires__c, 
        NUO__c, Model__c, Model_Code__c, Mileage__c, 
        Memo_Two__c, Memo_One__c, Make__c, Location__c, 
        License__c, License_Exp__c, Inventory_Date__c, 
        In_Stock__c, Holdback__c, Days_in_Stock__c, Coded_Cost__c, 
        Body_Type__c, Keyless_Entry_Code__c, Demo_Indicator__c, 
        Ignition_Key_Code__c, MSRP__c, Pack__c, 
        Exterior_Color__c, Title_Type__c, Fuel_Type__c, Work_in_Process__c,
        Invoice_Price__c,Conversion__c,Conversion_Cost__c,Conversion_Description__c,Conv_Model__c
        FROM Vehicle_Inventory__c 
        WHERE Id = :vehId
        AND IsDeleted=false 
        LIMIT 1];

        deal.Vehicle__c = v.Id;
        deal.Stock_Number__c = v.Stock_Number__c;
        deal.Year__c = v.Year__c;
        deal.Make__c = v.Make__c;
        deal.Model__c = v.Model__c;
        deal.VIN__c = v.VIN__c;
        deal.NUO__c = v.NUO__c;
        deal.Mileage__c = v.Mileage__c;
        deal.Ext_Color__c = v.Exterior_Color__c;
        deal.Trim_Level__c = v.Trim_Level__c;
        // deal.Licence__c = v.License__c;
        // deal.License_Expiration__c = v.License_Exp__c;

        deal.List_Price__c = v.MSRP__c;
        deal.Sale_Cost__c = v.Vehicle_Cost__c;        
        deal.Sale_Price__c = v.Retail_Price__c;
        
        deal.Vehicle_Price__c = v.Retail_Price__c;
        deal.Vehicle_Cost__c = v.Vehicle_Cost__c;
	}

	public static void populateBuyerData(Deal__c deal, Id acctId){
		if(acctId!=null) {
			deal.Buyer__c=acctId;
			List<Account> listAccount =[select id, Phone,FirstName, LastName,IsPersonAccount,PersonMobilePhone,PersonHomePhone, PersonEmail , BillingCountry, 
						Tax_ID__c,Billing_Email__c, //SU1
						Drivers_License_Expiration_Date__pc, Drivers_License_Number__pc,Drivers_License_State__pc,   //SU1
						BillingStreet, BillingCity, BillingState, BillingPostalCode, PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode,
						ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode                  
						 from Account where id=:acctId limit 1];

						if(listAccount[0].PersonHomePhone != null) {
							deal.Buyer_Home_Phone__c = listAccount[0].PersonHomePhone; 
							} else {
								deal.Buyer_Home_Phone__c = listAccount[0].Phone; 
							}
							deal.Buyer_Mobile_Phone__c=listAccount[0].PersonMobilePhone; 
							deal.Buyer_Email__c=listAccount[0].PersonEmail ; 

			// SU1 begins
			if(listAccount[0].Drivers_License_Number__pc != null) {
				deal.Buyer_Drivers_License__c = listAccount[0].Drivers_License_Number__pc; 
			}
			
			if(listAccount[0].Drivers_License_Expiration_Date__pc != null) {
				deal.Buyer_Drivers_License_Exp_Date__c = listAccount[0].Drivers_License_Expiration_Date__pc; 
				}else{
					deal.Buyer_Drivers_License_Exp_Date__c = null;
				}
			// SU1 ends
			if(listAccount[0].IsPersonAccount){
				deal.Buyer_First_Name__c = listAccount[0].FirstName;
				deal.Buyer_Last_Name__c =  listAccount[0].LastName;
			}
			
			if( listAccount[0].BillingStreet != null ) {

				//deal.Buyer_County__c=listAccount[0].BillingCountry ; // Country VS County - BillingCounty Doesnt exist
				deal.Buyer_Address__c=listAccount[0].BillingStreet ; 
				deal.Buyer_City__c=listAccount[0].BillingCity ; 
				deal.Buyer_State__c=listAccount[0].BillingState ;
				deal.Buyer_Postal_Code__c=listAccount[0].BillingPostalCode ;

			} else if (listAccount[0].PersonMailingStreet != null) {
				deal.Buyer_Address__c=listAccount[0].PersonMailingStreet ; 
				deal.Buyer_City__c=listAccount[0].PersonMailingCity ; 
				deal.Buyer_State__c=listAccount[0].PersonMailingState ;
				deal.Buyer_Postal_Code__c=listAccount[0].PersonMailingPostalCode ;
				
			}else if(listAccount[0].ShippingStreet != null){
				deal.Buyer_Address__c=listAccount[0].ShippingStreet ; 
				deal.Buyer_City__c=listAccount[0].ShippingCity ; 
				deal.Buyer_State__c=listAccount[0].ShippingState ;
				deal.Buyer_Postal_Code__c=listAccount[0].ShippingPostalCode ;

			}
		}
	}

	public static void populateCoBuyerData(Deal__c deal, Id acctId){
		if(acctId!=null) {
			deal.Co_Buyer__c=acctId;
			List<Account> listAccount =[select id, Phone, PersonHomePhone, PersonMobilePhone, PersonEmail ,BillingCountry, 
					Tax_ID__c,Billing_Email__c,  //SU1
					Drivers_License_Expiration_Date__pc, Drivers_License_Number__pc,Drivers_License_State__pc, //SU1
					BillingStreet, BillingCity, BillingState, BillingPostalCode,PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode from Account where id=:acctId limit 1];

		if(listAccount[0].PersonHomePhone != null) {
			deal.Co_Buyer_Home_Phone__c = listAccount[0].PersonHomePhone; 
			} else {
				deal.Co_Buyer_Home_Phone__c = listAccount[0].Phone; 
			}
		
		deal.Co_Buyer_Mobile_Phone__c=listAccount[0].PersonMobilePhone ; 
		deal.Co_Buyer_Email__c=listAccount[0].PersonEmail ; 
		
		if(listAccount[0].Drivers_License_Number__pc != null) {
			deal.Co_Buyer_Drivers_License_Number__c = listAccount[0].Drivers_License_Number__pc; 
		}
		
		if(listAccount[0].Drivers_License_Expiration_Date__pc != null) {
			deal.Co_Buyer_Drivers_License_Exp_Date__c = listAccount[0].Drivers_License_Expiration_Date__pc; 
			}else{
				deal.Co_Buyer_Drivers_License_Exp_Date__c = null;
			}

			if( listAccount[0].BillingStreet != null ) {

			deal.Co_Buyer_Address__c=listAccount[0].BillingStreet ; 
			deal.Co_Buyer_City__c=listAccount[0].BillingCity ; 
			deal.Co_Buyer_State__c=listAccount[0].BillingState ;
			deal.Co_Buyer_Postal_Code__c=listAccount[0].BillingPostalCode ;   

			} else if (listAccount[0].PersonMailingStreet != null) {
				deal.Co_Buyer_Address__c=listAccount[0].PersonMailingStreet ; 
				deal.Co_Buyer_City__c=listAccount[0].PersonMailingCity ; 
				deal.Co_Buyer_State__c=listAccount[0].PersonMailingState ;
				deal.Co_Buyer_Postal_Code__c=listAccount[0].PersonMailingPostalCode ;   
			}
		}
	}

	public static void saveTradesData(Deal dealData){
		Deal__c deal = dealData.dealHeader;
		Sales_up__c sup = dealData.salesup;
		List<Appraisal_Vehicle__c> appraisalVehList = dealData.salesUp.Appraisal_Vehicles__r != null ? dealData.salesUp.Appraisal_Vehicles__r : new List<Appraisal_Vehicle__c>();

		List<Trade_In__c> listTradeIn = new List<Trade_In__c>();
        Integer i=1;

        if(deal.Deal_Type__c == 'Equipment Only') {
            return;
        }
        Set<Id> appraisalIdSet = new Set<Id>();
        for(Appraisal_Vehicle__c av : appraisalVehList){
            if(av.Appraisal__c != null && !appraisalIdSet.contains(av.Appraisal__c))
                appraisalIdSet.add(av.Appraisal__c);
        }
        Map<Id,LoanPayoff__c> loanPayoffMap = new Map<Id,LoanPayoff__c>();//appraisal Id , Loan Payoff  

        for(LoanPayoff__c lp : [SELECT Id, Appraisal__c, PayoffAmount__c FROM LoanPayoff__c WHERE Appraisal__c  IN: appraisalIdSet]){
            if(loanPayoffMap.get(lp.Appraisal__c) == null)
                loanPayoffMap.put(lp.Appraisal__c, lp);
        }


        for(Appraisal_Vehicle__c objApp: appraisalVehList){
            Trade_In__c trade = new Trade_In__c();
            string tradeName = '('+deal.Name+')';
            if(objApp.Year__c!=null){
                tradeName+=' '+objApp.Year__c;
            }
            if(objApp.Make__c!=null){
                tradeName+=' '+objApp.Make__c;
            }
            if(objApp.Model__c!=null){
                tradeName+=' '+objApp.Model__c;
            }

            trade.Name = tradeName;                    
            trade.Car_Deal__c                =   deal.id;            
            trade.Position__c                =   i;
            trade.Service_Vehicle__c         =   objApp.Service_Vehicle__c;
            trade.Appraisal_Vehicle__c       =   objApp.id;


            //ww-2080 Revisit Below line to use new LoanPayof__c object
            trade.Pay_Off_Amount__c          =   loanPayoffMap.get(objApp.appraisal__c) == null || loanPayoffMap.get(objApp.appraisal__c).PayoffAmount__c == null ? 0 : loanPayoffMap.get(objApp.Appraisal__c).PayOffAmount__c;   
            // trade.Pay_Off_Amount__c          =   (objApp.Appraisal__r.Loan_Payoff_Amount__c)==null ? 0 :objApp.Appraisal__r.Loan_Payoff_Amount__c;
            trade.Trade_Allowance__c         =   (objApp.Appraisal__r.Appraised_Value__c) == null ? 0 : objApp.Appraisal__r.Appraised_Value__c;
            trade.Pay_Off_Expiration_Date__c =   objApp.Appraisal__r.Appraisal_Date__c;             
            trade.ACV__c                     =   (objApp.Appraisal__r.ACV_Actual_Cash_Value__c) == null ? 0 :objApp.Appraisal__r.ACV_Actual_Cash_Value__c;
            trade.VIN__c                     =   objApp.VIN__c;
            trade.Stock_Number__c            =   objApp.Service_Vehicle__r.Stock_Number__c;
            trade.Odometer_at_Trade_In__c    =   objApp.Service_Vehicle__r.Last_Odometer__c;
            trade.Lost_Trade__c              =   false;
            trade.Year__c                    =   objApp.Year__c;
            trade.Make__c                    =   objApp.Make__c;
            trade.Model__c                   =   objApp.Model__c;
            trade.Trim_Level__c              =   objApp.Trim_Level__c;
            trade.Net__c                     =   trade.Trade_Allowance__c - trade.Pay_Off_Amount__c;
            trade.Pay_Off_Account__c         =   objApp.Sales_Up__r.Customer_Account__c;                            
            
            listTradeIn.add(trade);         
        }
        
        if(listTradeIn.size()>0){
			insert listTradeIn;
			if(sup.Id != null){
				updateAppraisal( deal, listTradeIn);
			}
		}
	}

	public static void updateAppraisal(Deal__c deal, List<Trade_In__c> TradeList){
        List<Appraisal__c> appraisals = new List<Appraisal__c>();

        for(Appraisal__c ap : [SELECT Id, Deal__c, Trade_In__c, Service_Vehicle__r.VIN__c, Sales_Up__c From Appraisal__c where Sales_Up__c =: deal.Sales_Lead__c ]){
            
        for(Trade_In__c t : TradeList){
            if(t.VIN__c == ap.Service_Vehicle__r.VIN__c){
                ap.Trade_In__c = t.Id;
            }
        }
        appraisals.add(new Appraisal__c(
            Id = ap.id,
            Deal__c = deal.Id,
            Trade_In__c = ap.Trade_In__c
            ));
        }  
        if(appraisals.size()>0){
        // try {
            upsert appraisals;
            // }catch(Exception e){
            //     Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'While updating appraisals: '+ e.getMessage()));
            // }
        }
    }

	/**
	* Clones a Deal Record
	* @param Id dealId
	* @return Deal__c
	*/
	public static String cloneDeal(Id dealId)
	{
		SavePoint sp = Database.setSavePoint();
		List < dealer__Deal__c > deals = dealApi.getDealRecord(dealId);

		Deal__c objClonedDeal = (deals[0]).clone(false, true, false, false);
		objClonedDeal.Deal_ID__c = String.valueOf(dealer.Utility.nextDealNumber());
		objClonedDeal.Name = objClonedDeal.Deal_ID__c;
		
		
		try {
			insert objClonedDeal;
		}Catch(Exception e) {
			Database.rollback(sp);
			throw new DealAPIException(e.getMessage());
		}

		// Get Discounts & Rebates
		List<Discount_Rebate__c> discList = new List<Discount_Rebate__c>();
		for(Discount_Rebate__c disc : [SELECT Id, Name, RecordTypeId, Amount__c, Deal__c, Desc__c, Gross__c, Taxable__c, Type__c FROM Discount_Rebate__c WHERE Deal__c =: deals[0].Id]){
			Discount_Rebate__c newDisc = new Discount_Rebate__c();
			newDisc = disc;
			newDisc.Id = null;
			newDisc.Deal__c = objClonedDeal.Id;
			discList.add(newDisc);
		}
		// Insert psuedo-cloned discounts & rebates
		if(discList.size() > 0){
			try{
				insert discList;
			}Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}

		// Get Equipment
        List <After_Market__c> am = new List <After_Market__c>();
        for (After_Market__c a: [SELECT Car_Deal__c, Company_Number__c, Cost__c, Description__c,
                Labor_Sale__c, List_Price__c, Parts_Kit__c, Parts_Sale__c, Labor_Hourly_Sale__c, Labor_Hourly_Cost__c, 
                Sale_Price__c, Vendor__c, Tax_Rate__c, Misc_Tax_Code__c, Discount__c,
                Product_Tax_Code__c, Gross__c, Parts_Kit__r.Item_Count__c, Labor_Hours__c, Taxable__c,
                Labor_Cost__c, Labor_Gross__c, Part_Cost__c, Parts_Gross__c,
                Sales_Tax__c, GrossDistribution__c, Part__c, MFG__c, Part_Unit_Price__c, Part_Unit_Cost__c,
                Category__c, Hours__c, Kit_Notes__c, 
                Order__c, Printable__c, Quantity__c, Sub_Category__c,
                Type__c, Id, Name
                FROM After_Market__c
                WHERE Car_Deal__c =: deals[0].Id
            ]) {
            After_Market__c anew = new After_Market__c();
            anew = a;
            anew.Id = null;
            anew.Car_Deal__c = objClonedDeal.Id;
            am.add(a);

		}

		// Insert equipment
		if (!am.isEmpty()) {
			try {
				insert am;
			}Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}

		// Get Trade Records
        List < dealer__Trade_In__c > tradeRecordsToAdd = new List < dealer__Trade_In__c > ();
        for (dealer__Trade_In__c ti: [SELECT dealer__Car_Deal__c, dealer__ACV__c, dealer__Appraisal_Date__c, dealer__Appraisal_Vehicle__c, dealer__Appraised_By__c, dealer__Black_Book_Retail__c,
                dealer__Black_Book_Wholesale__c, dealer__Inventory_Vehicle__c, dealer__K_B_B_Retail__c, dealer__K_B_B_Wholesale_Value__c, dealer__Lost_Trade__c,
                dealer__Make__c, dealer__Model__c, dealer__NADA_Retail__c, dealer__NADA_Wholesale__c, dealer__Net__c, dealer__Odometer_at_Trade_In__c,
                dealer__Pay_Off_Account_Number__c, dealer__Pay_Off_Account__c, dealer__Pay_Off_Amount__c, dealer__Pay_Off_Expiration_Date__c, dealer__Pay_Off_To__c,
                dealer__Position__c, dealer__Profit__c, dealer__Recon__c, dealer__Service_Vehicle__c, dealer__Stock_Number__c, dealer__Trade_Allowance__c, dealer__Trim_Level__c,
                dealer__VIN__c, dealer__Year__c, Name, Id
                FROM dealer__Trade_In__c
                WHERE dealer__Car_Deal__c =: deals[0].Id
            ]) {

            dealer__Trade_In__c t = new dealer__Trade_In__c();
            t = ti;
            t.Id = null;
            t.dealer__Car_Deal__c = objClonedDeal.Id;
            tradeRecordsToAdd.add(t);

		}
		
		// Insert Trade Records
		if (!tradeRecordsToAdd.isEmpty()) {
            try {
				insert tradeRecordsToAdd;
			}Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}

		// Get Service Contracts
		List<Service_Contract__c> sericeContractList = new List<Service_Contract__c>();
		for(Service_Contract__c sc : [SELECT Id, Name, RecordTypeId, Car_Deal__c, Company_Number__c, Contract_Template__c, Cost__c, Customer_Contact__c, Customer__c, Deductable__c, Default_on_Lease_Agreements__c, Default_on_Retail_Deals__c, Description__c, Discount__c, End_Date__c, Expiration_Mileage__c, Expiration_Months__c, External_Id__c, Gross__c, Location__c, Odometer_at_Sale__c, Order__c, Plan_Code__c, Printable__c, Product_Code__c, SDRecordKey__c, Sale_Price__c, Service_Vehicle__c, Start_Date__c, Status__c, Taxable__c, Type__c, Vehicle_Inventory__c FROM Service_Contract__c WHERE Car_Deal__c =: deals[0].Id]){
			Service_Contract__c newSC = new Service_Contract__c();
            newSC = sc;
            newSC.Id = null;
            newSC.Car_Deal__c = objClonedDeal.Id;
            sericeContractList.add(newSC);
		}

		// Insert psuedo-cloned service contracts
		if(sericeContractList.size() > 0){
			try{
				insert sericeContractList;
			}Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}
		
		// Get Taxes
        List < dealer__Deal_Tax__c > taxItems = new List < dealer__Deal_Tax__c > ();
        for (dealer__Deal_Tax__c dt: [SELECT dealer__Deal_Tax_Parent__c, dealer__Deal__c, dealer__Flat_Tax__c, dealer__Tax_Percentage__c,
                dealer__Type__c, dealer__Tax_Zone__c, Name, Id
                FROM dealer__Deal_Tax__c
                WHERE dealer__Deal__c =: deals[0].Id
            ]) {

            dealer__Deal_Tax__c newTaxItem = new dealer__Deal_Tax__c();
            newTaxItem = dt;
            newTaxItem.Id = null;
            newTaxItem.dealer__Deal__c = objClonedDeal.Id;
            taxItems.add(newTaxItem);
		}
		
		// Insert Taxes
		if (!taxItems.isEmpty()) {
            try {
				insert taxItems;
			}Catch(Exception e) {
				Database.rollback(sp);
				throw new DealAPIException(e.getMessage());
			}
		}
		
		return objClonedDeal.Id;
	}

	/**
     * getDealRecord 
	 * @param Id dealId
     * @return List < dealer__Deal__c >
     * @description
     */ 
    public static List < dealer__Deal__c > getDealRecord(Id dealId) 
    {

        //Query Deal using deal id parameter
        List <dealer__Deal__c> lstDeal = [select Id, Name,
            dealer__Aftermarket_Gross__c,
            dealer__Year__c,
            dealer__Make__c,
            dealer__Model__c,
            dealer__VIN__c,
            dealer__Trim_Level__c,
            dealer__Exterior_Color__c,
            dealer__Interior_Color__c,
            dealer__Days__c,
            dealer__Buyer__c,
            dealer__Buyer_City__c,
            dealer__Buyer_Address__c,
            dealer__Buyer__r.Name,
            dealer__Buyer__r.IsPersonAccount,
            dealer__Buyer__r.dealer__Tax_ID__c,
            dealer__County__c,
            dealer__Status__c,
            dealer__Service_Vehicle__c,
            dealer__Service_Vehicle__r.Name,
            dealer__Service_Vehicle__r.dealer__Veh_Owner__c,
            dealer__Deal_ID__c,
            dealer__Vehicle__r.dealer__Ramp_Location__c,
            dealer__Broker_Home_Phone__c,
            dealer__Broker_Mobile_Phone__c,
            dealer__Broker_Email__c,
            dealer__DeliveryRepairOrder__c,
            dealer__Buyer_County__c,
            dealer__Disposition__c,
            dealer__Buyer_Email__c,
            dealer__Buyer_Postal_Code__c,
            dealer__Buyer_State__c,
            dealer__Co_Buyer__r.isPersonAccount,
            dealer__Co_Buyer__r.dealer__Tax_ID__c,
            dealer__Buyer_Mobile_Phone__c,
            dealer__Buyer_Home_Phone__c,
            dealer__Co_Buyer__c,
            dealer__Co_Buyer__r.Name,
            dealer__Co_Buyer_Address__c,
            dealer__Co_Buyer_Drivers_Lic_State__c,                              
            dealer__Vehicle_Price__c,
            dealer__Conversion_Price__c,
            dealer__Vehicle__r.dealer__Conversion__r.dealer__Product_Tax_Code__c,
            dealer__Stock_Number__c,
            dealer__Mileage__c,
            dealer__Buyer_Drivers_License__c,
            dealer__Buyer_Drivers_License_Exp_Date__c,
            dealer__Buyer_Drivers_Lic_State__c, 
            dealer__Buyer_Middle_Name__c, 
            dealer__Co_Buyer_Drivers_License_Exp_Date__c,
            dealer__Co_Buyer_Drivers_License_Number__c,
            dealer__Buyer_Social_Security_Number__c,
            dealer__Co_Buyer_Social_Security_Number__c,
            dealer__Buyer_Birthdate__c,
            dealer__Co_Buyer_Birth_Date__c,
            dealer__Co_Buyer_Middle_Name__c, 
            dealer__Co_Buyer_City__c,
            dealer__Co_Buyer_County__c,
            dealer__Co_Buyer_Email__c,
            dealer__Co_Buyer_Home_Phone__c,
            dealer__Co_Buyer_Mobile_Phone__c,
            dealer__Co_Buyer_State__c,
            dealer__Co_Buyer_Postal_Code__c,
            dealer__Delivery_Date__c,
            dealer__Business_Department__c,
            dealer__Deal_Date__c,
            dealer__Deal_Close_Date__c,
            dealer__Broker__c,
            dealer__Broker__r.Name,
            dealer__Broker_Address__c,
            dealer__Broker_City__c,
            dealer__Broker_County__c,
            dealer__Broker_Postal_Code__c,
            dealer__Broker_State__c,
            dealer__Business_Title__c,
            dealer__Business_Address__c,
            dealer__Business_Phone__c,
            dealer__Business_Contracting_Name__c,
            dealer__Business_City__c,
            dealer__Business_State__c,
            dealer__Business_Postal_Code__c,
            dealer__Business_County__c,
            dealer__Business_Email__c,
            dealer__Company_Number__c,
            dealer__DeliveryRepairOrderStatus__c,
            dealer__ClientNotes__c,
            dealer__Conversion_Manufacturer__c,
            dealer__Conversion_Model__c,
            dealer__Conversion_Description__c,
            dealer__NUO__c,
            dealer__Vehicle__c,
            dealer__Desk_Manager__c,
            dealer__Desk_Manager__r.Name,
            dealer__Sales_Lead__c,
            dealer__Sales_Lead__r.Name,
            dealer__Vehicle__r.Name,
            dealer__Vehicle__r.dealer__Stock_Number__c,
            dealer__Vehicle__r.dealer__Exterior_Color__c,
            dealer__Vehicle__r.dealer__Interior_Color__c,
            dealer__Vehicle__r.dealer__Vehicle_Type__c,
            dealer__Vehicle__r.dealer__Coded_Cost__c,
            dealer__Vehicle__r.dealer__Mileage__c,
            dealer__Vehicle__r.dealer__VIN__c,
            dealer__Vehicle__r.dealer__Trim_Level__c,
            dealer__Vehicle__r.dealer__Invoice_Price__c,
            dealer__Vehicle__r.dealer__Conversion_Cost__c,
            dealer__Vehicle__r.dealer__Status_Code__c,
            dealer__Vehicle__r.dealer__Model_Code__c,
            dealer__Vehicle__r.dealer__Work_in_Process__c,
            dealer__Vehicle__r.dealer__New_Used_Other__c,
            dealer__Vehicle__r.dealer__Year__c,
            dealer__Vehicle__r.dealer__Make__c,
            dealer__Vehicle__r.dealer__Model__c,
            dealer__Vehicle__r.dealer__Retail_Price__c,
            dealer__Vehicle__r.dealer__Purchase_Price__c,
            dealer__Vehicle__r.dealer__Days_in_Stock__c,
            dealer__Vehicle__r.dealer__Conversion_Price__c,
            dealer__Vehicle__r.RecordType.Name,
            dealer__Vehicle__r.dealer__Ramp_Operation__c,
            dealer__Vehicle__r.dealer__Ramp_Type__c,
            dealer__Vehicle__r.dealer__Conversion_Description__c,
            dealer__Vehicle__r.dealer__Conv_Model__c,
            dealer__Order__c,
            dealer__OrderNotes__c,
            dealer__DeliveryRepairOrder__r.Name,
            dealer__Finance_Institution_Account__c,
            dealer__Term__c,
            dealer__Vehicle__r.dealer__Vehicle_Cost__c,
            dealer__DeliveryRepairOrder__r.dealer__Status__c,
            dealer__Days_to_First__c,
            dealer__Payments_Per_Year__c,
            dealer__Rate__c,
            dealer__Amt_Financed__c,
            dealer__Monthly_Pymt__c,
            dealer__F_I_Manager__r.Name,
            dealer__Store_Location__c,
            dealer__Store_Location__r.Name,
            dealer__Store_Location__r.dealer__County__c,
            dealer__Store_Location__r.dealer__State__c,
            dealer__Store_Location__r.dealer__Company_Number__c,
            dealer__Store_Location__r.dealer__Default_Days_to_First_Payment__c,
            dealer__Store_Location__r.dealer__Default_Rate__c,
            dealer__Store_Location__r.dealer__Default_Term__c,
            dealer__Store_Location__r.dealer__Tax_Delivery_Address__c,
            dealer__Store_Location__r.dealer__Postal_Code__c,
            dealer__Store_Location__r.dealer__Tax_Trade__c,
            dealer__Store_Location__r.dealer__Tax_Trade_In_Used__c,
            dealer__Store_Location__r.dealer__Max_Trade_Tax_Amount__c	,
            dealer__Store_Location__r.dealer__Tax_Service_Contracts__c,
            dealer__Store_Location__r.dealer__Internal_Labor_Rate__c,
            dealer__Store_Location__r.dealer__Deal_Default_Labor_Rate__c,
            dealer__Auto_Insurance_Zip__c,
            dealer__Auto_Insurance_Company__c,
            dealer__Auto_Insurance_Agent__c,
            dealer__Auto_Insurance_Policy__c,
            dealer__Auto_Insurance_Effective_Date__c,
            dealer__Auto_Insurance_Expiration_Date__c,
            dealer__Auto_Insurance_COM_Deducatable__c,
            dealer__Auto_Insurance_COL_Deductable__c,
            dealer__Auto_Insurance_Address__c,
            dealer__Auto_Insurance_City__c,
            dealer__Auto_Insurance_State__c,
            dealer__Auto_Insurance_Contact__c,
            dealer__Auto_Insurance_Phone__c,
            dealer__Co_Buyer_Work_Phone__c,
            dealer__Salesperson_1__r.Name,
            dealer__Salesperson_2__r.Name,
            dealer__Service_Manager__r.Name,
            dealer__Delivery_City__c,
            dealer__Delivery_Phone__c,
            dealer__Delivery_State__c,
            dealer__Delivery_Postal_Code__c,
            dealer__Delivery_Mobile__c,
            dealer__Delivery_County__c,
            dealer__Delivery_Notes__c,
            dealer__Delivery_Email__c,
            dealer__Delivery_Street__c,
            dealer__Vehicle_Conversion_Gross__c,
            dealer__Vehicle_Gross__c,
            dealer__Vehicle_Cost__c,
            dealer__ConversionCost__c,
            dealer__Conversion_Discount__c,
            dealer__Vehicle_Discount__c,
            dealer__Deferred_1_Payee__c,
            dealer__Deferred_1_Payee__r.Name,
            dealer__Deferred_1_Payee__r.Id,
            dealer__Deferred_2_Payee__c,
            dealer__Deferred_2_Payee__r.Name,
            dealer__Deferred_2_Payee__r.Id,
            dealer__Deferred_3_Payee__c,
            dealer__Deferred_3_Payee__r.Name,
            dealer__Deferred_3_Payee__r.Id,
            dealer__Deferred_Date_1__c,
            dealer__Deferred_Date_2__c,
            dealer__Deferred_Date_3__c,
            dealer__Deferred_Down_1__c,
            dealer__Deferred_Down_2__c,
            dealer__Deferred_Down_3__c,
            dealer__Deferred_Note_1__c,
            dealer__Deferred_Note_2__c,
            dealer__Deferred_Note_3__c,
            dealer__GVWR__c,
            dealer__Doc_Fee__c,
            dealer__License_Fee__c,
            dealer__Registration_Title_Fee__c,
            dealer__Electronic_Filing_Fee__c,
            dealer__Tire_Fee__c,
            dealer__Smog_Cert__c,
            dealer__Posting_Template__c,
            /* Deferred Monies */
            dealer__Deposit__c,
            dealer__Down_Pymt__c,
            dealer__First_Payment_Date__c,
            dealer__Total_Additional_Equipment__c,
            dealer__Total_Service_Contracts_Premium__c,
            dealer__Buyer_First_Name__c,
            dealer__Buyer_Last_Name__c,
            dealer__Co_Buyer_First_Name__c,
            dealer__Co_Buyer_Last_Name__c,
            dealer__Sales_Tax__c,
            dealer__Equipment_Tax__c,
            dealer__Standard_Tax__c,
            dealer__Total_Tax__c,
            dealer__Tax_Zone__c,
            dealer__Tax_Zone__r.dealer__Rate__c,
            dealer__Tax_Zone__r.dealer__Postal_Code__c,
            dealer__Tax_Zone__r.dealer__Common_Name__c,
            dealer__Tax_Rate__c,
            dealer__isVehicleTax__c,
            dealer__isConvertionTax__c,
            dealer__Deal_Type__c,
            dealer__Rebate__c,
            dealer__Pickup_or_Delivery__c,
            dealer__Conversion_Gross_Percent__c,
            dealer__GAP_Gross_Percent__c,
            dealer__GAP_Gross__c,
            dealer__GAP_Cost__c,
            dealer__Maintenance_Gross_Percent__c,
            dealer__Maintenance_Cost__c,
            dealer__Maintenance_Gross__c,
            dealer__Other_Cost__c,
            dealer__Other_Gross__c,
            dealer__Other_Gross_Percent__c,
            dealer__Svc_Contracts_Gross_Percent__c,
            dealer__Vehicle_Gross_Percent__c,
            dealer__Warranty_Cost__c,
            dealer__Ext_Warr_Gross__c,
            dealer__Warranty_Gross_Percent__c,
            dealer__Total_Service_Contracts_Gross__c,
            dealer__Total_Service_Contracts_Cost__c,
            dealer__Total_Gross_Percent__c,
            dealer__Total_Deferred_Down__c,
            dealer__Total_Additional_Equipment_Cost__c,
            dealer__Total_Additional_Equipment_Gross__c,                               
            dealer__Total_Taxable_Equipment__c,
            dealer__Standard_Taxable__c,                              
            dealer__Trade_Net__c,
            dealer__Due_Upon_Delivery__c,
           	dealer__Total_Additional_Equipment_Gross_Percent__c,
			dealer__Out_the_Door__c,
            dealer__PricingStrategy__c,
            dealer__PricingStrategy__r.Name,
            dealer__PricingStrategy__r.dealer__Method__c
            FROM dealer__Deal__c WHERE id =: dealId
        ];

        // If certain defaults are not set, provide the defaults.
        List < dealer__Dealer_Location__c > locations = new List < dealer__Dealer_Location__c > ();
        if (lstDeal[0].dealer__Term__c == null ||
            lstDeal[0].dealer__Days__c == null ||
            lstDeal[0].dealer__Rate__c == null
        ) {
            // Lookup the defaults
            locations = [SELECT Id, dealer__Default_Days_to_First_Payment__c,
                dealer__Default_Rate__c, dealer__Default_Term__c,
                dealer__Default_Deal_Status__c
                FROM dealer__Dealer_Location__c
                WHERE Id =: lstDeal[0].dealer__Store_Location__c
                LIMIT 1
            ];

            // Set the defaults.
            lstDeal[0].dealer__Term__c = locations[0].dealer__Default_Term__c;
            lstDeal[0].dealer__Days__c = locations[0].dealer__Default_Days_to_First_Payment__c;
            lstDeal[0].dealer__Rate__c = locations[0].dealer__Default_Rate__c;

            //Vehicle Retail Price/Di
        }
        lstDeal[0].Vehicle_Price__c = lstDeal[0].Vehicle_Price__c == null ? 0 : lstDeal[0].Vehicle_Price__c;

        return lstDeal;
    }

	/**
	* This routine will close deals and mark associated records as closed/won
	* @param deals List<Deal__c>
	* @return Void
	*/
	global static void closeDeals(List<Deal__c> deals)
	{

		if(deals.isEmpty())
			return;

		// Transaction Control
		SavePoint sp = Database.setSavePoint();

		// Instantiate the vehicle API
		VehicleInventoryAPI vapi = new VehicleInventoryAPI();

		// Get the associated trade records and other deal data
		Set<Id> dealIds = new Set<Id>();
		Set<Id> salesUpIds = new Set<Id>();
		List<Trade_In__c> trades = new List<Trade_In__c>();
		
		for(Deal__c d : deals) {

			if(!dealIds.contains(d.Id))
				dealIds.add(d.Id);

			if(!salesUpIds.contains(d.Sales_Lead__c))
				salesUpIds.add(d.Sales_Lead__c);
		}
		trades = [SELECT Id FROM Trade_In__c WHERE Car_Deal__c IN:dealIds];
		// Process the Inventory from Trade-Records
		try {
			if(!trades.isEmpty()) {
				vapi.createInventoryFromTrades(trades);
			}
		} Catch(Exception e) {
			Database.rollback(sp);
			throw new DealAPIException(e.getMessage());
		}

		// Process the Mark As Sold Inventory and Service Vehicles
		try {
			
			// Only get Vehicle Sales
			List<Deal__c> dealsWithVehicles = new List<Deal__c>();
			for(Deal__c d : deals) {
				if(d.Vehicle__c!=null)
					dealsWithVehicles.add(d);
			}
			vapi.markSold(dealsWithVehicles);

		} Catch(Exception e) {
			Database.rollback(sp);
			throw new DealAPIException(e.getMessage());
		}

		// Process the SalesUp Data
		Map<Id, Sales_Up__c> ups = new Map<Id, Sales_Up__c>([SELECT Id FROM Sales_Up__c WHERE Id IN:salesUpIds]);
		for(Deal__c d : deals) {
			if(d.Sales_Lead__c!=null && ups.get(d.Sales_Lead__c) != null) {
				Sales_Up__c tUp = ups.get(d.Sales_Lead__c);
				tUp.Car_Deal__c=d.Id;
				tUp.Sale_Date__c=d.Deal_Date__c;
				tUp.Sold__c=true;
				ups.put(tUp.Id, tUp);
			}
		}

		try {
			if(!ups.isEmpty()) {
				update ups.values();
			}
		} Catch(Exception e) {
			Database.rollback(sp);
			throw new DealAPIException(e.getMessage());
		}
	}

	/**
	* Processes the closure of a Deal Record
	* @param deals List<Deal__c>
	* @return Void
	*/
	@InvocableMethod(label='Close Deal Processor' description='Process the closure of a Deal Record.')
	global static void closeDealProcess(List<Deal__c> deals)
	{
		try {
			DealAPI.closeDeals(deals);
		} Catch(Exception e) {
			throw new DealAPIException(e.getMessage());
		}
	} 	

	/**
	*Creates After Market items on the deal from a conversion on the sales up
	* @param pkId Id
	* @param deal Deal__c
	* @return Void
	*/
	global static void createAfterMarketItems(Id pkId, Deal__c deal)
	{
			
		List<dealer__After_Market__c> records = new List<dealer__After_Market__c>();
		dealer__Parts_Kit__c partsKit = [SELECT Id, Name, RateType__c, dealer__Total_Cost__c, dealer__Kit_Price__c, dealer__Description__c, 
			dealer__Labor_Hourly_Cost__c, dealer__Labor_Hourly_Sale__c, dealer__Labor_Sale__c, dealer__Labor_Cost__c, dealer__Kit_Hours__c 
			FROM dealer__Parts_Kit__c WHERE Id =: pkId];
		After_Market__c [] existingPartKits = [SELECT Id, Parts_Kit__c, Car_Deal__c FROM After_Market__c WHERE Parts_Kit__c =:pkId AND Car_Deal__c =: deal.Id ];
		if(existingPartKits.size() > 0){
			throw new DealAPIException('Parts Kit already exists on current Deal');
		}
		
		List < dealer__Parts_Kit_Item__c > pkis = [SELECT Id, Name, IsDeleted, dealer__Parts_Kit__c, dealer__Quantity__c,
			dealer__Parts_Kit__r.Name, dealer__Extended_Cost__c, dealer__Parts_Kit__r.dealer__Item_Count__c, Parts_Kit__r.RateType__c,
			dealer__Extended_List__c, dealer__List__c, dealer__Cost__c, dealer__Part_Description__c, dealer__Part_Name__c, dealer__Part__c,
			dealer__Product_Tax_Code__c, dealer__Parts_Master__c, dealer__Miscellaneous_Charge_Code__c, dealer__Miscellaneous_Charge_Code__r.Taxable__c, dealer__Sale_Price__c,
			dealer__Miscellaneous_Charge_Code__r.Name, RateType__c FROM dealer__Parts_Kit_Item__c WHERE dealer__Parts_Kit__c =: partsKit.Id];

		// Associate Local Parts Inventory Record with Line Items
		Set < Id > masterSet = new Set < Id > ();
		for (dealer__Parts_Kit_Item__c pitem: pkis) {
			if (!masterSet.contains(pitem.dealer__Parts_Master__c)) {
				masterSet.add(pitem.dealer__Parts_Master__c);
			}
		}
		Map < Id, dealer__Parts_Inventory__c > partsInv = new Map < Id, dealer__Parts_Inventory__c > ();
		for (dealer__Parts_Inventory__c pi: [SELECT Id, Name, dealer__Parts_Master__c FROM dealer__Parts_Inventory__c WHERE dealer__Parts_Master__c IN: masterSet and dealer__Location__c =: deal.dealer__Store_Location__c]) {
			if (partsInv.get(pi.dealer__Parts_Master__c) == null) {
				partsInv.put(pi.dealer__Parts_Master__c, pi);
			}
		}

		// Identify parts not in set.
		Set < Id > masterswithoutpart = new Set < Id > ();
		for (Id ids: masterSet) {
			if (partsInv.get(ids) == null && !masterswithoutpart.contains(ids)) {
				masterswithoutpart.add(ids);
			}
		}

		List < dealer__Parts_Inventory__c > newParts = new List < dealer__Parts_Inventory__c > ();
		List<Parts_Master__c> masterList = [SELECT dealer__Applications__c, dealer__Core_Required__c,
				dealer__Core_Value__c, dealer__Cost__c, dealer__Height__c,
				dealer__Jobber_Price__c, dealer__Labor_Time__c, dealer__Length__c,
				dealer__MAP__c, dealer__MFG_Comments__c, dealer__Manufacturer__c,
				dealer__Pack_QTY__c, dealer__Part_Description__c,
				dealer__Part_No_Display__c, dealer__Part_No__c,
				dealer__Price_Tape_Date__c, dealer__Raw_Part_Number__c,
				dealer__Retail_Price__c, dealer__Return_Code__c, dealer__UPC__c,
				dealer__Warranty_Price__c, dealer__Weight__c, dealer__Width__c,
				dealer__Catalog_Image__c, Id, Name, RateType__c
				FROM dealer__Parts_Master__c
				WHERE Id IN: masterswithoutpart
			];
		try{
			partsInv.putAll(partAPI.createInventoryFromMaster(masterList, deal.dealer__Store_Location__c));
		} catch(DmlException e) {
				if (e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')) {
					System.debug('Inside the Custom Validation Handler');
					throw new DealAPIException(e.getDmlMessage(0));
				} else {
					System.debug('Exception without FIELD_CUSTOM_VALIDATION_EXCEPTION');
					throw new DealAPIException(e.getMessage());
				}
			}

		if (pkis.size() > 0) {
			Dealer_Location__c locObj = [SELECT Id, dealer__Tax_Parts__c, dealer__Tax_Misc__c, dealer__Tax_Service__c FROM Dealer_Location__c WHERE Id =: deal.dealer__Store_Location__c ];
			// Add header
			records.add(new dealer__After_Market__c(
				// Properties from Part Kit Item
				Name = partsKit.Name,
				dealer__Parts_Kit__c = partsKit.Id,
				dealer__Description__c = partsKit.dealer__Description__c,
				// Properties from Parent Part kit
				RateType__c = partsKit.RateType__c != null ? partskit.RateType__c : 'General',
				dealer__Car_Deal__c = deal.Id,
				dealer__Printable__c = true,
				dealer__Kit_Notes__c = 'Created from Kit',
				dealer__Part_Cost__c = 0,
				dealer__Parts_Sale__c = 0,
				dealer__Part_Unit_Price__c = 0,
				dealer__Part_Unit_Cost__c = 0,
				dealer__Cost__c = partsKit.dealer__Total_Cost__c,
				dealer__List_Price__c = partsKit.dealer__Kit_Price__c,
				dealer__Type__c = 'Part Kit'
			));

			// Obtain the Parts Matrix
			List<dealer__PriceMatrix__mdt> matrix = [SELECT Id, dealer__HighCost__c, dealer__LowCost__c, dealer__Multiplier__c, dealer__PaymentMethod__c, dealer__Location_Object__c, dealer__Location_Name__c FROM dealer__PriceMatrix__mdt WHERE dealer__PaymentMethod__c = 'I'];                                               


			// Iterate all Kit Items
			for (dealer__Parts_Kit_Item__c pki: pkis) {
				// Translate this prt kit itme.
				String rateType = (pki.RateType__c != null) ? pki.RateType__c : (pki.Parts_Kit__r.RateType__c != null ? pki.Parts_Kit__r.RateType__c : '');
				if (pki.dealer__Parts_Master__c != null) {

					// 
					Decimal pkItemCost = pki.dealer__Cost__c;

					// Process the Matrix and Apply the Parts
					for(dealer__PriceMatrix__mdt mtx : matrix) {
						if(pkItemCost >= mtx.dealer__LowCost__c && pkItemCost <= mtx.dealer__HighCost__c) {
							pkItemCost = (pkItemCost * (mtx.dealer__Multiplier__c / 100)) + pkItemCost;
						}
					}


					records.add(new dealer__After_Market__c(
						// Properties from Part Kit Item
						Name = pki.dealer__Part_Name__c,
						dealer__Part__c = (partsInv.get(pki.dealer__Parts_Master__c) != null) ? partsInv.get(pki.dealer__Parts_Master__c).Id : null,
						dealer__Parts_Kit__c = pki.dealer__Parts_Kit__c,
						dealer__Description__c = pki.dealer__Part_Description__c,
						dealer__Quantity__c = pki.dealer__Quantity__c,
						dealer__Product_Tax_Code__c = pki.dealer__Product_Tax_Code__c,
						RateType__c = rateType,
						// Properties from Parent Part kit
						dealer__Car_Deal__c = deal.Id,
						dealer__Printable__c = true,
						dealer__Kit_Notes__c = 'Created from Kit',
						dealer__Part_Cost__c = pkItemCost,
						dealer__Parts_Sale__c = pki.dealer__Extended_List__c,
						dealer__Sale_Price__c = pki.dealer__Extended_List__c,
						dealer__Cost__c = pki.dealer__Extended_Cost__c,
						dealer__List_Price__c = pki.dealer__List__c,
						dealer__Type__c = 'Part',
						dealer__Taxable__c = locObj.dealer__Tax_Parts__c
					));
				}

				// Iterate the Misc. Charges
				if (pki.dealer__Miscellaneous_Charge_Code__c != null) {
					Boolean taxMisc = false;
					if(locObj.Tax_Misc__c == 'All'){
						taxMisc = true;
					}
					if(locObj.Tax_misc__c == 'Respect Misc. Charge Code Record'){
						taxMisc = pki.Miscellaneous_Charge_Code__r.Taxable__c;
					}
					records.add(new dealer__After_Market__c(
						// Properties from Part Kit Item
						Name = pki.dealer__Miscellaneous_Charge_Code__r.Name,
						dealer__Parts_Kit__c = pki.dealer__Parts_Kit__c,
						dealer__Description__c = pki.dealer__Miscellaneous_Charge_Code__r.Name,
						dealer__Quantity__c = pki.dealer__Quantity__c,
						dealer__Product_Tax_Code__c = pki.dealer__Product_Tax_Code__c,
						dealer__Car_Deal__c = deal.Id,
						RateType__c = rateType,
						dealer__Printable__c = true,
						dealer__Kit_Notes__c = 'Created from Kit',
						dealer__Part_Cost__c = 0,
						dealer__Parts_Sale__c = 0,
						dealer__Part_Unit_Price__c = 0,
						dealer__Part_Unit_Cost__c = 0,
						dealer__Cost__c = pki.dealer__Sale_Price__c,
						dealer__List_Price__c = pki.dealer__Sale_Price__c,
						dealer__Sale_Price__c = pki.dealer__Sale_Price__c,
						dealer__Type__c = 'Misc',
						dealer__Taxable__c = taxMisc
					));
				}
			}

			// If there is labor add a labor line, labor is at the header level of the Kit
			if (partsKit.dealer__Labor_Sale__c != null && partsKit.dealer__Labor_Sale__c > 0) {
				records.add(new dealer__After_Market__c(
					// Properties from Part Kit Item
					Name = 'Labor',
					dealer__Type__c = 'Labor',
					dealer__Description__c = 'Kit Labor',
					dealer__Parts_Kit__c = partsKit.Id,
					dealer__Car_Deal__c = deal.Id,
					RateType__c = partsKit.RateType__c != null ? partsKit.RateType__c : 'Labor',
					dealer__Printable__c = true,
					dealer__Kit_Notes__c = 'Created from Kit',
					dealer__Labor_Hourly_Cost__c = partsKit.dealer__Labor_Hourly_Cost__c,
					dealer__Labor_Hourly_Sale__c = partsKit.dealer__Labor_Hourly_Sale__c,
					dealer__Labor_Sale__c = partsKit.dealer__Labor_Sale__c,
					dealer__Sale_Price__c = partsKit.dealer__Labor_Sale__c,
					dealer__Labor_Cost__c = partsKit.dealer__Labor_Cost__c,
					dealer__Labor_Hours__c = partsKit.dealer__Kit_Hours__c,
					dealer__Quantity__c = 1,
					dealer__Taxable__c = locObj.dealer__Tax_Service__c

				));
			}
		} else {
			//Create After Market for a Parts kit without Parts Kit Items
			records.add(new After_Market__c(
				// Properties from Part Kit Item
				Name = partsKit.Name,
				dealer__Parts_Kit__c = partsKit.Id,
				dealer__Description__c = partsKit.dealer__Description__c,
				// Properties from Parent Part kit
				dealer__Car_Deal__c = deal.Id,
				RateType__c = partsKit.RateType__c != null ? partsKit.RateType__c : 'Part',
				dealer__Printable__c = true,
				dealer__Kit_Notes__c = 'Created from Kit',
				dealer__Part_Cost__c = 0,
				dealer__Parts_Sale__c = 0,
				dealer__Part_Unit_Price__c = 0,
				dealer__Part_Unit_Cost__c = 0,
				dealer__Cost__c = partsKit.dealer__Total_Cost__c,
				dealer__List_Price__c = partsKit.dealer__Kit_Price__c,
				dealer__Type__c = 'Part Kit'
			));
		}

		if(records.size() > 0){
			try {
				insert records;
			}
			Catch(DmlException e) {
				if (e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')) {
					System.debug('Error creating after market items.');
					throw new DealAPIException(e.getDmlMessage(0));
				} else {
					System.debug('Exception without FIELD_CUSTOM_VALIDATION_EXCEPTION');
					throw new DealAPIException(e.getMessage());
				}
			}
		}
	}

	/**
	* Retrieves Data relavent to a deal. Used mostly for deal forms.
	* @param dealId Id
	* @return DealAPI.Deal
	*/
	global static Deal dealData(Id dealId)
	{
		System.assert(dealId != null ,'Deal Id is required to get Deal Data.');

		DealAPI.deal deal = new DealAPI.deal();

		//First get deal header.
		deal.dealHeader = (Deal__c)Utility.queryAllFields('dealer__Deal__c', dealId);

		if(deal.dealHeader.Sales_Lead__c != null)
			deal.salesup = (Sales_Up__c)Utility.queryAllFields('dealer__Sales_Up__c', deal.dealHeader.Sales_Lead__c);

		if(deal.dealHeader.Buyer__c != null)
			deal.buyer = (Account)Utility.queryAllFields('Account', deal.dealHeader.Buyer__c);

		if(deal.dealHeader.Co_Buyer__c != null)
			deal.cobuyer = (Account)Utility.queryAllFields('Account', deal.dealHeader.Co_Buyer__c);

		if(deal.dealHeader.Store_Location__c != null)//might not be the right object field name
			deal.location = (Dealer_Location__c)Utility.queryAllFields('dealer__Dealer_Location__c', deal.dealHeader.Store_Location__c);

		if(deal.dealHeader.dealer__Service_Vehicle__c != null)
			deal.servicevehicle = (dealer__Service_Vehicle__c)Utility.queryAllFields('dealer__Service_Vehicle__c', deal.dealHeader.dealer__Service_Vehicle__c);
			
		if(deal.dealHeader.dealer__Vehicle__c != null)
			deal.vehicle = (dealer__Vehicle_Inventory__c)Utility.queryAllFields('dealer__Vehicle_Inventory__c', deal.dealHeader.dealer__Vehicle__c);
			

		//After Market Data
		List<String> amIds = new List<String>();
		for(After_Market__c am : [SELECT Id from After_Market__c WHERE Car_Deal__c =: dealId ]){
			amIds.add(am.Id);
		}
		if(amIds.size() >0 )
			deal.afterMarketItems = (List<After_Market__c>)Utility.queryAllFields('dealer__After_Market__c',amIds);
		
		// Service Contract Data
		List<String> scIds = new List<String>();
		for(Service_Contract__c sc : [SELECT Id FROM Service_Contract__c WHERE Car_Deal__c =: dealId ]){
			scIds.add(sc.Id);
		}
        if(scIds.size() >0 ){
            deal.serviceContractItems = (List<Service_Contract__c>)Utility.queryAllFields('dealer__Service_Contract__c',scIds);
            deal.serviceContractTotal = getServiceContractTotal(deal.serviceContractItems);
        }

		//Deal Form Data
		List<String> formIds = new List<String>();
		for(Deal_Form__c df : [SELECT Id FROM Deal_Form__c WHERE Deal__c =: dealId]){
			formIds.add(df.Id);
		}
		if(formIds.size() >0 )
			deal.dealForms = (List<Deal_Form__c>)Utility.queryAllFields('dealer__Deal_Form__c',formIds);

		// Trade In Data
		List<String> tiIds = new List<String>();
		for(Trade_In__c ti : [SELECT Id From Trade_In__c WHERE Car_Deal__c =: dealId ]){
			tiIds.add(ti.Id);
		}

		if(tiIds.size() >0 ){
            deal.tradeIns = (List<Trade_In__c>)Utility.queryAllFields('dealer__Trade_In__c',tiIds);
            deal.TotalAllowance = getTotalAllowance(deal.tradeIns);
            deal.TotalTradeGross = getTotalTradeGross(deal.tradeIns);
        }

		// Deal Fee Data
		List<String> feeIds = new List<String>();
		For(Sales_Fee__c sf : [SELECT Id From Sales_Fee__c WHERE Car_Deal__c =: dealId]){
			feeIds.add(sf.Id);
		}
		if(feeIds.size() >0 )
			deal.dealFees = (List<Sales_Fee__c>)Utility.queryAllFields('dealer__Sales_Fee__c',feeIds);


		// populate discounts and rebates data
		List<String> rdIds = new List<String>();
		for(Discount_Rebate__c r : [SELECT Id FROM Discount_Rebate__c WHERE Deal__c =: dealId]){
			rdIds.add(r.Id);
		}
		if(rdIds.size() >0 )
			deal.rebates = (List<Discount_Rebate__c>)Utility.queryAllFields('dealer__Discount_Rebate__c',rdIds);

		// populate casheiering data
		List<String> cIds = new List<String>();
		for(Cashering__c c : [SELECT Id FROM Cashering__c WHERE Deal__c =: dealId]){
			cIds.add(c.Id);
		}

		if(cIds.size() >0 )
		
			deal.cashierItems = (List<Cashering__c>)Utility.queryAllFields('dealer__Cashering__c',cIds);
		deal.logoURL = getLogo(dealId, deal.location.Id);
	
		// populate taxable fees
		deal.taxableFees = getTaxableFees(dealId, deal.dealFees, true);
		
		// populate nontaxable fees
		deal.nontaxablefees = getTaxableFees(dealId, deal.dealFees, false);
		
		// populate trade tax credit
		deal.TradeTaxCredit = calcTradeTaxCredit(dealId);
		
		// populate vehicle retail price
		deal.VehRetail = getVehRetail(dealId);
		
		// populate payors
		deal.Payor1 = getPayor1(dealId);
		deal.Payor2 = getPayor2(dealId);
		deal.Payor3 = getPayor3(dealId);
		
		//Taxable Equipment
		List<String> eTaxIds = new List<String>();
		for(After_Market__c et : [SELECT Id from After_Market__c WHERE Car_Deal__c =: dealId AND Type__c != 'Part Kit' AND Taxable__c = true]){
			eTaxIds.add(et.Id);
		}
		if(eTaxIds.size() >0 ){
			deal.equipmentTaxable = (List<After_Market__c>)Utility.queryAllFields('dealer__After_Market__c',eTaxIds);
			system.debug('Taxable Equipment: ' + deal.equipmentTaxable);
		}
		
		//Non Taxable Equipment
		List<String> eNonTaxIds = new List<String>();
		for(After_Market__c net : [SELECT Id from After_Market__c WHERE Car_Deal__c =: dealId AND Type__c != 'Part Kit' AND Taxable__c = false]){
			eNonTaxIds.add(net.Id);
		}
		if(eNonTaxIds.size() >0 )
			deal.equipmentNonTaxable = (List<After_Market__c>)Utility.queryAllFields('dealer__After_Market__c',eNonTaxIds);

		return deal;
	}

	/**
	* Creates Fees to be defaulted on a deal
	* @param deals List<Deal__c>
	* @return Void 
	*/
	global static void createDefaultFees(List<Deal__c> deals)
	{
		try{
			DealControlHandler handler = new DealControlHandler();
			handler.deleteDealFees(deals);
			handler.createDefaultFees(deals);
		}catch(Exception e){
			throw new DealAPIException(e.getMessage());
		}
	}

	/**
	* Saves and calculates deal
	* Assumes all fields on Deal__c were queried prior to entry.
	* @param deal Deal__c
	* @return Deal__c
	*/
	public static Deal__c saveDeal(Deal__c deal)
	{
		System.assert(Deal.Id != null, 'Deal Id required to update Deal');
		
		/** Set Deal Totals */
		DealCalculations.setDealTotals(deal);
		applyDiscounts(deal);

		if(deal.Service_Vehicle__c == null && deal.Vehicle__c != null){
			Service_Vehicle__c [] svInv = [SELECT Id FROM Service_Vehicle__c WHERE Sales_Inventory__c =: deal.Vehicle__c];
			if(svInv.size() > 0)
				deal.Service_Vehicle__c = svInv[0].Id;
		}

		update Deal;
		return Deal;
	}

	/**
	* Retrieves Deal's Dealer Location information 
	* @param dealId Id
	* @return Dealer_Location__c
	*/
	public static Dealer_Location__c dealLocation(Id dealId)
	{
		System.assert(dealId != null, 'A valid deal Id is required to acquire the location.');
		Deal__c deal = [SELECT Store_Location__c FROM Deal__c WHERE Id =: dealId];
		return deal.Store_Location__c != null ? (Dealer_Location__c)Utility.queryAllFields('dealer__Dealer_Location__c', deal.Store_Location__c) : new Dealer_Location__c();
	}

	/**
	* Acquires Fee Records on a Deal
	* @param dealId Id
	* @return List<Sales_fee__c>
	*/
	public static List<Sales_Fee__c> getDealFees(Id dealId)
	{
		List<String> feeIds = new List<String>();
		For(Sales_Fee__c sf : [SELECT Id From Sales_Fee__c WHERE Car_Deal__c =: dealId]){
			feeIds.add(sf.Id);
		}
		if(feeIds.size() >0 ){
			return (List<Sales_Fee__c>)Utility.queryAllFields('dealer__Sales_Fee__c',feeIds);
		}
		return new List<Sales_Fee__c>();
	}
	
	/**
	* Get Discounts Records on a Deal
	* @param dealId Id
	* @return List<Discount_Rebate__c>
	*/
	public static List<Discount_Rebate__c> getDealDiscounts(Id dealId)
	{
		Discount_Rebate__c [] discounts = [SELECT Id, Name, Type__c, Deal__c, Desc__c, Amount__c FROM Discount_Rebate__c WHERE Deal__c =: dealId  AND Type__c != 'MFR Rebate'];
		return discounts;
	}

	/**
	* Get Rebate Records on a Deal
	* @param dealId Id
	* @return List<Discount_Rebate__c>
	*/
	public static List<Discount_Rebate__c> getDealRebates(Id dealId)
	{
		Discount_Rebate__c [] discounts = [SELECT Id, Name, Type__c, Taxable__c, AppliesTo__c, Deal__c, Desc__c, Amount__c FROM Discount_Rebate__c WHERE Deal__c =: dealId  AND Type__c = 'MFR Rebate'];
		return discounts;
	}

	/**
	* Returns discount templates for available for Deals
	* @return List<Discount_Rebate__c>
	*/
	public static List<Discount_Rebate__c> getDiscountTemplates()
	{
        Discount_Rebate__c [] discs = [SELECT Id, Desc__c, Type__c, Amount__c, AppliesTo__c, Gross__c, Taxable__c, Name FROM Discount_Rebate__c Where recordType.Name = 'Template'];
		return discs;
	}

	/**
	* Applies Discount logic to a deal
	* @param deal Deal__c
	* @return Deal__c
	*/
	public static void applyDiscounts(Deal__c deal)
	{

		//Preflight validation
		System.assert(deal.Id != null, 'Deal Id is needed to apply after market discounts to a deal.');
		
		//Map of existing Discounts for this deal - Only one discount of a certain type will exist.
		Map<String, Discount_Rebate__c> oldDiscountTypeMap = new Map<String,Discount_Rebate__c>();
		for(Discount_Rebate__c discount : [SELECT Id, Name, Type__c, Deal__c, Amount__c FROM Discount_Rebate__c WHERE Deal__c =: deal.Id AND Type__c != 'MFR Rebate']){
			oldDiscountTypeMap.put(discount.Type__c, discount);
		}

		//create a map of Type / Decimal value
		Map<String, Decimal> newTypeMap = new Map<String,Decimal>();
		
		//Deal Discount Logic
		Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('dealer__Deal__c').getDescribe().fields.getMap();
		
		//Vehicle Discount
		String VDT = fieldMap.get('dealer__Vehicle__c').getDescribe().getLabel();	
		newTypeMap.put(VDT, deal.Vehicle_Discount__c != null ? deal.Vehicle_Discount__c : 0);
		
		// Conversion Discount 
		// String CDT = fieldMap.get('dealer__Conversion_Discount__c').getDescribe().getLabel(); 	
		newTypeMap.put('Conversion', deal.Conversion_Discount__c != null ? deal.Conversion_Discount__c : 0);

		//After Market Discount Logic
		for(After_Market__c am : [SELECT Id, Type__c, Discount__c FROM After_Market__c WHERE Car_Deal__c =: deal.Id]){
			Decimal discount = am.Discount__c == null ? 0 : am.Discount__c;
			if(newTypeMap.get(am.Type__c) == null){
				newTypeMap.put(am.Type__c, discount);
			} else {
				Decimal existingDiscount = newTypeMap.get(am.Type__c);
				newTypeMap.remove(am.Type__c);
				newTypeMap.put(am.Type__c,existingDiscount+discount);
			}
		}

		//Service Contract Discount Logic
		for(Service_Contract__c ct : [SELECT Id, Type__c, Discount__c FROM Service_Contract__c WHERE Car_Deal__c =: deal.Id]){
			String type = ct.Type__c != null ? ct.Type__c : 'Service Contract'; // if Type is populated apply discount to the type of contract else set to generic type.
			Decimal discount = ct.Discount__c == null ? 0 : ct.Discount__c;
			if(newTypeMap.get(type) == null){
				newTypeMap.put(type, discount);
			} else {
				Decimal existingDiscount = newTypeMap.get(type);
				newTypeMap.remove(type);
				newTypeMap.put(type,existingDiscount+discount);
			}
		}

		//Fee Discount Logic
		for(Sales_Fee__c fee : [SELECT Id, Discount__c FROM Sales_Fee__c WHERE Car_Deal__c =: deal.Id]){
			String type ='Fee'; // if Type is populated apply discount to the type of contract else set to generic type.
			Decimal discount = fee.Discount__c == null ? 0 : fee.Discount__c;
			if(newTypeMap.get(type) == null){
				newTypeMap.put(type, discount);
			} else {
				Decimal existingDiscount = newTypeMap.get(type);
				newTypeMap.remove(type);
				newTypeMap.put(type,existingDiscount+discount);
			}
		}

		//delete necessary items
		List<Discount_Rebate__c> deleteList = new List<Discount_Rebate__c>();
		for(String type: oldDiscountTypeMap.Keyset()){
			//delete
			if(newTypeMap.get(type) == null || newTypeMap.get(type) == 0){
				deleteList.add(oldDiscountTypeMap.get(type));
			}
		}

		//create / update necessary items
		List<Discount_Rebate__c> upsertList = new List<Discount_Rebate__c>();
		for(String type : newTypeMap.Keyset()){
			if(oldDiscountTypeMap.get(type) == null && newTypeMap.get(type) > 0){
				upsertList.add(new Discount_Rebate__c(Name=type,Deal__c=deal.Id,Type__c=type,Amount__c=newTypeMap.get(type)));
			} else if(oldDiscountTypeMap.get(type) != null && newTypeMap.get(type) > 0) {
				Discount_Rebate__c updateDiscount = oldDiscountTypeMap.get(type);
				updateDiscount.Amount__c = newTypeMap.get(type);
				upsertList.add(updateDiscount);
			}
		}

		delete deleteList;
		upsert upsertList;
	}

	/** 
	* Queries all Trades related to a Deal
	* @param dealId Id
	* @return List<Trade_In__c>
	*/ 
	public static List<Trade_In__c> getTradeIns(Id dealId)
	{
		List<String> tradeIds = new List<String>();
		For(Trade_In__c trade : [SELECT Id FROM Trade_In__c WHERE Car_Deal__c =: dealId]){
			tradeIds.add(trade.Id);
		}
		if(tradeIds.size() >0 ){
			return (List<Trade_In__c>)Utility.queryAllFields('dealer__Trade_In__c',tradeIds);
		}
		return new List<Trade_In__c>();
	}
	
	/**
	* Acquires all header-level data for a Deal
	* @param Id dealId
	* @return Deal__c
	*/
	public static Deal__c dealHeader(Id dealId)
	{
		return (Deal__c)Utility.queryAllFields('dealer__Deal__c', dealId);
	}

	/** MOVE TO PARTAPI
	* Creates an Aftermarket record from a part 
	* @param dealId Id
	* @param partData DealAPI.partData
	* @return Void
	*/
	public static void createPartAfterMarket(Id dealId, PartAddition partData)
	{
		/* 1: Determine if part exists. Create localized inventory if necessary */
		Deal__c thisDeal = (Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId);
		System.assert(partData.PartsMasterId != null, 'Parts Master Id is required to add Parts to a Deal.');
		System.assert(thisDeal.Store_Location__c != null, 'Store Location is required to add Localized Parts Inventory to a Deal.');
		
		After_Market__c newPartAM = new After_Market__c(
			Car_Deal__c    = thisDeal.Id,
			Quantity__c    = partData.Quantity,
			Description__c = partData.Description,
			Sale_Price__c  = partData.SalePrice,
			RateType__c    = partData.RateType != null ? partData.RateType : 'Part',
			Cost__c  = partData.Cost,
			Type__c		   = 'Part',
			Taxable__c = partData.Taxable != null ? partData.Taxable : true,
			Printable__c = partData.Printable != null ? partData.Printable : true
		);
		
		Parts_Inventory__c[] existingPart = [SELECT Id, Name, Description__c, Parts_Master__c, Parts_Master__r.dealer__Product_Tax_Code__c
											 FROM Parts_Inventory__c
											 WHERE Parts_Master__c =:  partData.PartsMasterId AND Location__c =: thisDeal.Store_Location__c ];
		
		Boolean partExists = existingPart.size() > 0 ? true : false;

		if(!partExists){ //Part does not exist Create Local Inventory
			
			Map<Id, Parts_Inventory__c> newPartMap = PartAPI.createInventoryFromMaster(new List<Parts_Master__c>{new Parts_Master__c(Id=partData.PartsMasterId)}, thisDeal.Store_Location__c);
			Parts_Inventory__c          newPart = newPartMap.get(partData.PartsMasterId);
			System.debug(JSON.serializePretty(newPart));
			Parts_Master__c             pMaster = [SELECT Id, Product_Tax_Code__c FROM Parts_Master__c WHERE Id=: partData.PartsMasterId];
			
			newPartAM.Product_Tax_Code__c = pMaster.Product_Tax_Code__c;
			newPartAM.Part__c = newPart.Id;
			newpartAM.Name = [SELECT Name FROM Parts_Inventory__c WHERE Id =: newPartAM.Part__c].Name;


		}else{ // Part exists
			
			newPartAM.Product_Tax_Code__c = existingPart[0].Parts_Master__c != null && existingPart[0].Parts_Master__r.Product_Tax_Code__c != null ? existingPart[0].Parts_Master__r.Product_Tax_Code__c : null;
			newPartAM.Part__c = existingPart[0].Id;
			newPartAM.Name = existingPart[0].Name;

		}

		insert newPartAM;
		dealAPI.applyDiscounts(thisDeal);
	}

	/**
	* Adds Forms to a Deal
	*@param dealId Id
	*@param formIds List<String>
	*@return Void
	*/
	public static void addDealForms(Id dealId, List<String> formIds)
	{
        try{
            Deal__c deal = [SELECT Id, Deal_Id__c FROM Deal__c where Id=: dealId];
            
            Map<Id,Form__c> formMap = new Map<Id,Form__c>();
            for(Form__c form : [SELECT Id, Name FROM Form__c where Id IN: formIds]){
                formMap.put(form.Id, form);
            }
            
            List<Deal_Form__c> newDealForms = new List<Deal_Form__c>();
            for(Form__c form : formMap.values()){
                newDealForms.add(new Deal_Form__c(Name = deal.Deal_Id__c+'-'+form.Name, Deal__c = dealId, Form__c = form.Id));
            }
            
            if(newDealForms.size() > 0){
                insert newDealForms;
            }
        }catch(QueryException e){
            throw new QueryException(e.getMessage());
        }catch(DMLException e){
            throw new DMLException(e.getMessage());
        }
    }
    
    /**
	* Removes a Form from a Deal
	* @param dealId Id
	* @param formId Id
	* @return Void
	*/
	public static void removeDealForm(Id dealId, Id formId)
	{
        try{
            List<Deal_Form__c> dealForms = new List<Deal_Form__c>();
            for(Deal_Form__c df : [Select Id FROM Deal_Form__c WHERE Form__c =: formId AND Deal__c =: dealId] ){
                dealForms.add(df);
            }
            if(dealForms.size() > 0){
                delete dealForms;
            } else {
                //if we tried to remove an applicable form, add it to the deselected list of forms
                Map<Id, Form__c> formMap = new Map<id, Form__c>();
                for(Form__c form : applicableForms(dealId)){
                    formMap.put(form.Id, form);
                }
                if(formMap.get(formId) != null){
                    System.assert(Schema.sObjectType.dealer__FormRef__c.fields.dealer__Deselected__c.isUpdateable(),'You do not have the required permissions to remove this Form Reference from this deal. Please see your administrator.');
                    Deal__c deal = [SELECT Id, Store_Location__c From Deal__c WHERE Id =: dealId];
                    Form__c form = [SELECT Name, Id, Page_Name__c FROM Form__c WHERE Id=:formId];
                    insert new FormRef__c(Form__c=form.Id,
                                          Location__c=deal.Store_Location__c,
                                          Deselected__c=deal.Id);
                }
            }
        }catch(QueryException e){
            throw new QueryException(e.getMessage());
        }catch(DMLException e){
            throw new DMLException(e.getMessage());
        }
	}

	/**
	* Acquires forms available to a Deal
	* @param  dealId Id
	* @return List<Form__c>
	*/
	public static List<Form__c> availableForms(String dealId)
	{

		/** Disclude forms that both exist on Deal and Applicable Forms */
        set <Id> rForms = new set <Id> ();
        for(Deal_Form__c df : [SELECT Id, Form__c FROM Deal_Form__c WHERE Form__r.Print_Type__c IN ('Laser','FDF') AND Deal__c =: dealId]){
            rForms.add(df.Form__c);
        }
        for(Form__c f : applicableForms(dealId)){
            rForms.add(f.Id);
        }
        
        List<Form__c> forms = new List<Form__c>();
        //Will need to determine which forms are alread on this record
        for(Form__c f : [SELECT Id, Name, dealer__Print_Type__c, dealer__DocumentContentId__c, dealer__Page_Name__c, dealer__Flatten__c 
                         FROM Form__c
                         WHERE Print_Type__c IN ('Laser','FDF') AND Active__C = true
                         AND Id NOT IN: rForms
                         Order BY Sequence__c ASC, Name ASC ]){
                             forms.add(f);
                         }
        return forms;
	}
	
    /**
	* this selects sarg
	* @param dealId String
	* @return List<Form__c>
	*/
	public static List<Form__c> selectedForms(String dealId)
	{
        List<Form__c> forms = new List<Form__c>();
        
        for(Deal_Form__c df : [SELECT Id, Name,Form__r.Id, Form__r.Name, Form__c,Deal__c,Form__r.Print_Type__c,
                               Form__r.DocumentContentId__c, Form__r.Description__c, Form__r.Page_Name__c 
                               FROM Deal_Form__c WHERE Deal__c =: dealId]){
                                   forms.add(df.Form__r);
                               }
        return forms;
    }
	
	/**
	* Retrieves forms Applicable to a deal
	* @param  dealId String
	* @return List<Form__c>
	*/
	public static List<Form__c> applicableForms(String dealId)
	{
        Deal__c thisDeal = (Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId);
        String query = formRefQuery(thisDeal, 'FDF');
        
        List<Form__c> availableForms = new List<Form__c>();
        for(FormRef__c fr : Database.query(query)){
            if(fr.Form__r.Active__c){
                if(fr.Applicable__c == NULL || fr.Applicable__c == 'True'){
                    availableForms.add(fr.Form__r);
                } else {
                    //If there is a formula on the applicable field we need to evaluate it
                    Decimal eval = new EvalExpression(fr.Applicable__c).matching(thisDeal.getpopulatedfieldsasmap()).eval();
                    // '0' = False, '1' = True
                    if(eval == 1){
                        availableForms.add(fr.Form__r);
                    }
                }    
            }
        }
        return availableForms;
    }

	/**
	* Retrieves Cash Transaction Items on a Deal
	* @param  dealId String
	* @return List<Cashering__c>       
	*/
	public static List<Cashering__c> cashTransactions(String dealId)
	{
		Cashering__c [] cashTransactions = [
			SELECT Id, Customer__c, Deal__c, Credit_Card_Authorization_Code__c, 
			Customer__r.Name, Payment_Method__c, Deposit__c, Amount__c,
            Rental_Agreement__r.Balance_Due__c, Rental_Agreement__r.TotalEstimatedCharges__c
            FROM Cashering__c 
			WHERE Deal__c =: dealId ORDER BY CreatedDate DESC
		];
		return cashTransactions;
	}

	/**
	* Builds query for Deal-Applicable form references
	* @param  deal Deal__c
	* @param  printType FDF, Laser
	* @return String
	*/ 
	public static String formRefQuery(Deal__c deal, String printType)
	{
        List < String > removeItems = new List < String > ();
        for (dealer__Deal_Form__c dealF: [SELECT id, Form__c FROM Deal_Form__c where Deal__c =: deal.Id]) {
            removeItems.add(dealF.Form__c);
        }
        for(FormRef__c formRef: [SELECT Id, Deselected__c, Form__c FROM FormRef__c WHERE Deselected__c =: deal.Id]){
            removeItems.add(formRef.Form__c);
        }
        
        //Query Form_Ref__c for forms that exist in this location
        String query = 'SELECT Location__c, Deselected__c, Applicable__c, Form__c, '
            +'Form__r.Name, Form__r.Page_Name__c,Form__r.Flatten__c,'
            +'Form__r.dealer__Print_Type__c, Form__r.Active__c, Form__r.DocumentContentId__c '
            +'FROM FormRef__c WHERE Location__c = \''+deal.Store_Location__c+'\'  AND Form__r.Active__c = True AND Deselected__c = null';
        // 
        if(removeItems.size() > 0){
            String removeString = '(';
            for(integer i = 0; i < removeItems.size(); i++){
                if(i != removeItems.size() - 1){
                    removeString += ' \''+removeItems[i]+'\', ';
                } else {
                    removeString += ' \''+removeItems[i]+'\' )';
                }
            }
            query+= ' AND Form__c NOT IN '+removeString;
        }
        
        if(printType == 'Impact'){
            query+= ' AND Form__r.Print_Type__c = \'Impact\'';
        } else {
            query+=' AND (Form__r.Print_Type__c = \'Laser\' OR Form__r.Print_Type__c = \'FDF\') ';
        }
        return query;
	}

	/**
    * getServiceContractTotal 
    * @param  contracts List<Service_Contracts__c>
    * @return Decimal
    */
	private static Decimal getServiceContractTotal(List<Service_Contract__c> contracts)
	{
        Decimal contractTotal = 0;
        if(contracts != null) {
            for (Service_Contract__c sc: contracts){
                contractTotal += sc.Sale_Price__c;
            }
        } 
        return contractTotal;
    }
    
    /** REMOVE THIS
    * Retrieves Logo URL 
    * @param  dealId Id   
    * @param  locId Id
    * @return String
    */
	private static String getLogo(Id dealId, Id locId)
	{
        
        locId = [SELECT dealer__Store_Location__c FROM dealer__deal__c WHERE Id=:dealId].dealer__Store_Location__c;
        if(locId != null){
            return dealer.DealershipLocationAPI.formLogoURL(locId);
        }else{
            Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
            String imageId = doc.Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;
        }
    }
   
    /**
    * Retrieves list of Taxable Fees on a Deal
    * @param  dealId Id    
    * @param  fees List<Sales_Fee__c>
    * @return List<Sales_Fee__c
    */
	private static List<Sales_Fee__c> getTaxableFees(Id dealId, List<Sales_Fee__c> fees, Boolean taxable)
	{
        fees = [SELECT Type__c, Taxable__c, Fee_Code__c, Printable__c,
                Default_Amount_Formula_Field__c, Default_On_Deal_Formula_Field__c, Default_Formula_Field__c, 
                Fee_Name__c, Description__c, Car_Deal__c, Fee_Amount__c, Name, Id 
                FROM Sales_Fee__c WHERE Car_Deal__c =:dealId and Taxable__c = :taxable];
        return fees != null ? fees : new List<dealer__Sales_Fee__c>();
    }
    
    /**
    * Returns Total Allowance
    * @param  tradeInList List<Trade_In__c>
    * @return Decimal
    */
	private static Decimal getTotalAllowance(List<Trade_In__c> tradeInList)
	{
        
        Decimal totAllowance = 0;
        
        for(Trade_In__c t:  tradeInList ){
            totAllowance += t.Trade_Allowance__c;
        }
        return totAllowance;
    }
    
    /**
    * Returns Total Trade Gross
    * @param  tradeInList List<Trade_In__c>
    * @return Decimal
    */
	private static Decimal getTotalTradeGross(List<Trade_In__c> tradeInList)
	{
        Decimal totTradeGross = 0;
        // Allowance - payoff
        for(Trade_In__c t:  tradeInList ){
            totTradeGross += (t.Trade_Allowance__c - t.Pay_Off_Amount__c);
        }
        return totTradeGross;
    }
    
    /**
    * Returns Trade Tax Credit Amount
    * @param  dealId Id   
    * @return Decimal
    */
	private static Decimal calcTradeTaxCredit(Id dealId)
	{
        Deal__c d = new dealer__Deal__c();
        Decimal tradeTax = 0;
        if( dealId != null){
            try{
                d = [SELECT id, Order__c, NUO__c, Trade_Allowance__c,  Store_Location__r.Tax_Trade__c, 
                     Store_Location__r.Tax_Trade_In_Used__c, 
                     Store_Location__r.Max_Trade_Tax_Amount__c,
                     Vehicle__r.RecordType.Name
                     FROM Deal__c where Id =: dealId];
            }catch(QueryException e){}
            if(d != null){
                Boolean taxNew = d.Store_Location__r.Tax_Trade__c;
                Boolean taxUsed = d.Store_Location__r.Tax_Trade_In_Used__c;
                Decimal maxTradeTax = d.Store_Location__r.Max_Trade_Tax_Amount__c != null ? d.Store_Location__r.Max_Trade_Tax_Amount__c : 0;
                
                String NewOrUsed = 'New';
                if(!d.Order__c){
                    NewOrUsed= d.Vehicle__r.RecordType.Name == 'New'?'New':'Used';
                }  else if (d.Order__c){
                    newOrUsed = d.NUO__c == 'New' ? 'New' : 'Used';
                }
                
                if( (NewOrUsed == 'New' && !taxNew) || (NewOrUsed != 'New' && !taxused) ){
                    return 0;
                } 
                tradeTax = d.Trade_Allowance__c;
                if(maxTradeTax != null && maxTradeTax > 0){
                    tradeTax = tradeTax > maxTradeTax ? maxTradeTax : tradeTax;
                }
            }
        }
        return tradeTax;
    }
    
    /** MOVE LOGIC TO VEHICLE API
    * Returns Retail Vehicle Price of Vehicle
    * @param  dealId Id    
    * @return Decimal
    */
	private static Decimal getVehRetail(Id dealId)
	{
        try{
            return [SELECT Vehicle__r.Retail_Price__c FROM Deal__c WHERE Id =: dealId].Vehicle__r.Retail_Price__c;
        } catch (DMLException e){
            system.debug(e.getMessage());
            return 0;
        }
        return 0;
    }
    
    /**
    * Returns Account for Payor 1
    * @param  dealId Id    
    * @return Account
    */
	private static Account getPayor1(Id dealId)
	{
		if( dealId != null){
			try{
				Id payorId = [SELECT Deferred_1_Payee__c FROM Deal__c WHERE Id=:dealId].Deferred_1_Payee__c;
				if(payorId != null){
					return[SELECT Name,Phone, BillingStreet,BillingCity,BillingState, BillingPostalCode From Account WHERE Id =: payorId];
				}
			} catch (Exception e){
				return null;
			}
		}
		return null;
	}
    
    /**
    * getPayor2
    * @param  dealId Id   
    * @return Account
    */
	private static Account getPayor2(Id dealId)
	{
        if( dealId != null){
            try{
                Id payorId = [SELECT dealer__Deferred_2_Payee__c FROM dealer__Deal__c WHERE Id=:dealId].dealer__Deferred_2_Payee__c;
                if(payorId != null){
                    return[SELECT Name,Phone, BillingStreet,BillingCity,BillingState, BillingPostalCode From Account WHERE Id =: payorId];
                }
            } catch (Exception e){
                return null;
            }
        }
        return null;
    }
    
    /**
    * getPayor3
    * @param  dealId Id    
    * @return Account
    */
	private static Account getPayor3(Id dealId)
	{
        if( dealId != null){
            try{
                Id payorId = [SELECT dealer__Deferred_3_Payee__c FROM dealer__Deal__c WHERE Id=:dealId].dealer__Deferred_3_Payee__c;
                if(payorId != null){
                    return[SELECT Name,Phone, BillingStreet,BillingCity,BillingState, BillingPostalCode From Account WHERE Id =: payorId];
                }
            } catch (Exception e){
                return null;
            }
        }
        return null;
    }

	/**
	* Wrapper class for deal data and related records. 
	*/
	global class Deal{

		// Header Data
		global Deal__c dealHeader {get;set;}

		// Referential Data records available to create at the same time as the deal object. 
		global Sales_Up__c salesup {get;set;}
		global Account buyer {get;set;}
		global Account cobuyer {get;set;}
		global Account Payor1 {get;set;}
        global Account Payor2 {get;set;}
        global Account Payor3 {get;set;}
		global Dealer_Location__c location {get;set;}
		global Service_Vehicle__C serviceVehicle {get;set;} 
		global Vehicle_Inventory__c vehicle {get;set;}

		// List Data
		global List<After_Market__c> afterMarketItems {get;set;}
		global List<Service_Contract__c> serviceContractItems {get;set;}
		global List<Deal_Form__c> dealForms {get;set;}
		global List<Trade_In__c> tradeIns {get;set;}
		global List<Sales_Fee__c> dealFees {get;set;}
		global List<Discount_Rebate__c> rebates {get;set;}
		global List<Cashering__c> cashierItems {get;set;}
		global List<Sales_Fee__c> taxableFees {get;set;}
        global List<Sales_Fee__c> nonTaxableFees {get;set;}
        global List<After_Market__c> equipmentTaxable {get;set;}
        global List<After_Market__c> equipmentNonTaxable {get;set;}
        
        // Decimal Data
        global Decimal serviceContractTotal {get;set;}
        global Decimal TotalAllowance {get;set;}
        global Decimal TotalTradeGross {get;set;}
        global Decimal TradeTaxCredit {get;set;}
        global Decimal VehRetail {get;set;}
        
        // String Data
        global String logoURL {get;set;}

		global deal() {
			afterMarketItems 		= 	new List<After_Market__c>();
			serviceContractItems 	=	new List<Service_Contract__c>();
			dealForms 				=	new List<Deal_Form__c>();
			tradeIns  				=	new List<Trade_In__c>();
			dealFees  				=	new List<Sales_Fee__c>();
			rebates 				=	new List<Discount_Rebate__c>();
			cashierItems 			=	new List<Cashering__c>();
		}
	}

	/**
	*	Wrapper class to add a part After Market Item to Deal
	*/
	public class PartAddition{
        @AuraEnabled public String PartsMasterId {get;set;}
        @AuraEnabled public Decimal Quantity {get;set;}
        @AuraEnabled public String Description {get;set;}
        @AuraEnabled public Decimal SalePrice {get;set;}
		@AuraEnabled public Decimal Cost {get;set;}
		@AuraEnabled public String RateType {get;set;}
        @AuraEnabled public Boolean Printable {get;set;}
        @AuraEnabled public Boolean Taxable {get;set;}
    }
	
	global class DealAPIException extends Exception {}
	
}