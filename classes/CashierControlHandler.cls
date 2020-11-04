public with sharing class CashierControlHandler {


    public static void setDealCashierTotals(List<Cashering__c> triggerNew)
	{
        
        Map<Id, Deal__c> dealMap = new Map<Id, Deal__c>();
        for(Cashering__c c : triggerNew){
            if(c.Deal__c != null){
                if(dealMap.get(c.Deal__c) == null){
                    dealMap.put(c.Deal__c, new Deal__c(Id=c.Deal__c));
                }
            }
        }

		AggregateResult[] aggregateResults = 
		[
			SELECT  Deposit__c,Deal__c,
					SUM(Amount__c)   amount
			FROM Cashering__c 
			WHERE Deal__c IN:dealMap.values()
			GROUP BY Deposit__c,Deal__c
        ];

        Map<Id, CashierTotal> cashTotalMap = new Map<Id, CashierTotal>();
		for(AggregateResult ar : aggregateResults){
            
            Boolean isDeposit =(Boolean)ar.get('dealer__Deposit__c');
            Id dealId = (Id)ar.get('dealer__Deal__c');
            Decimal amount = (Decimal)ar.get('amount') != null ? (Decimal)ar.get('amount') : 0;
            Decimal deposit = isDeposit ? amount : 0;
            
            if(cashTotalMap.get(dealId) == null){
                cashTotalMap.put(dealId, new CashierTotal(amount, deposit));
            } else {
                cashTotalMap.get(dealId).total += amount;
                cashTotalMap.get(dealId).deposit +=  deposit;
            }
        }

        List<Deal__c> dealsToUpdate = new List<Deal__c>();
        for(String dId : dealMap.keySet()){
            CashierTotal cash = cashTotalMap.get(dId);
            
            if(cash == null){
                dealsToUpdate.add(new Deal__c(Id=dId, TotalCashiering__c=0, Deposit__c = 0));
            } else {
                dealsToUpdate.add(new Deal__c(Id = dId, TotalCashiering__c=cash.total,  Deposit__c = cash.deposit));
            }

        }

        if(dealsToUpdate.size()>0){
            upsert dealsToUpdate;
        }
    }

    public class CashierTotal
    {
        public Decimal total;
        public Decimal deposit;

        public CashierTotal(Decimal total, Decimal deposit){
            this.total =   total   != null ? total   : 0;
            this.deposit = deposit != null ? deposit : 0;
        }
    }

    public static void locationDefaults(List<Cashering__c> triggerNew){
        Set<Id> recordIds = new Set<Id>();
		Map<Id, Dealer_Location__c> locationIds = new Map<Id, Dealer_Location__c>();
		for(Cashering__c c : triggerNew) {
			if(c.Location__c==null || c.Company_Number__c==null) {
				if(c.Service_Repair_Order__c!=null)
					recordIds.add(c.Service_Repair_Order__c);

				if(c.Rental_Agreement__c!=null)
					recordIds.add(c.Rental_Agreement__c);

				if(c.Parts_Invoice__c!=null)
					recordIds.add(c.Parts_Invoice__c);

				if(c.Deal__c!=null) 
					recordIds.add(c.Deal__c);
			}
		}

		// Query records and position the ID
		if(!recordIds.isEmpty()) {
			for(Service_Repair_Order__c sro : [SELECT Id, Company__c, Company__r.Company_Number__c FROM Service_Repair_Order__c WHERE Id IN:recordIds]) {
				locationIds.put(sro.Id, new Dealer_Location__c(Id=sro.Company__c, Company_Number__c=sro.Company__r.Company_Number__c));
			}

			for(Rental_Agreements__c ra : [SELECT Id, Location__c, Location__r.Company_Number__c FROM Rental_Agreements__c WHERE Id IN:recordIds]) {
				locationIds.put(ra.Id, new Dealer_Location__c(Id=ra.Location__c, Company_Number__c=ra.Location__r.Company_Number__c));
			}

			for(Parts_Invoice__c pi : [SELECT Id, Location__c, Location__r.Company_Number__c FROM Parts_Invoice__c WHERE Id IN:recordIds]) {
				locationIds.put(pi.Id, new Dealer_Location__c(Id=pi.Location__c, Company_Number__c=pi.Location__r.Company_Number__c));
			}

			for(Deal__c deal : [SELECT Store_Location__c, Store_Location__r.Company_Number__c FROM Deal__c WHERE Id IN:recordIds]) {
				locationIds.put(deal.Id, new Dealer_Location__c(Id=deal.Store_Location__c, Company_Number__c=deal.Store_Location__r.Company_Number__c));
			}
		}

		// Set Values based on specified record
		for(Cashering__c c : triggerNew) {
			if(c.Location__c==null || c.Company_Number__c==null) {
				if(c.Service_Repair_Order__c!=null && locationIds.get(c.Service_Repair_Order__c)!=null) {
					c.Location__c=locationIds.get(c.Service_Repair_Order__c).Id;
					c.Company_Number__c=locationIds.get(c.Service_Repair_Order__c).Company_Number__c;
				}
				if(c.Rental_Agreement__c!=null && locationIds.get(c.Rental_Agreement__c)!=null) {
					c.Location__c=locationIds.get(c.Rental_Agreement__c).Id;
					c.Company_Number__c=locationIds.get(c.Rental_Agreement__c).Company_Number__c;
				}
				if(c.Parts_Invoice__c!=null && locationIds.get(c.Parts_Invoice__c)!=null) {
					c.Location__c=locationIds.get(c.Parts_Invoice__c).Id;
					c.Company_Number__c=locationIds.get(c.Parts_Invoice__c).Company_Number__c;
				}	
				if(c.Deal__c!=null && locationIds.get(c.Deal__c)!=null) {
					c.Location__c=locationIds.get(c.Deal__c).Id;
					c.Company_Number__c=locationIds.get(c.Deal__c).Company_Number__c;
				}											
			}
		}
    }

    public static void sroRentalTotals(List<Cashering__c> triggerNew){

		// List Cashier Ids
		Set<Id> cashIds = new Set<Id>();
		Set<Id> RaIds = new Set<Id>();

		// Lists of Records to Update (Only contains records that have changed values)
		List<dealer__Rental_Agreements__c> rentals_to_update = new List<dealer__Rental_Agreements__c>();
		List<dealer__Service_Repair_Order__c> repair_orders_to_update = new List<dealer__Service_Repair_Order__c>();

		// In not deleting get the new stuff

        // Update SRO ID list
        for(dealer__Cashering__c c : triggerNew) {
            // Build List if Chacier has SRO field
            if(c.dealer__Service_Repair_Order__c != null) {
                cashIds.add( c.dealer__Service_Repair_Order__c );
            }

            if(c.dealer__Rental_Agreement__c != null) {
                RaIds.add(c.dealer__Rental_Agreement__c);
            }
        }

		// Collect a List of related SROs and also the associated cashier objects.
		// Collect a list of the Rental Agreements and total into the Rental Agreement

		List<dealer__Service_Repair_Order__c> sros = new List<dealer__Service_Repair_Order__c>([SELECT Id, Deposit__c, dealer__Payments_Total__c, (SELECT Id, Amount__c, Deposit__c FROM Cashiering__r ) FROM dealer__Service_Repair_Order__c WHERE Id IN:cashIds LIMIT 200]);
		List<dealer__Rental_Agreements__c> ra = new List<dealer__Rental_Agreements__c>([Select Id, dealer__Total_Payments__c, (Select Id, Amount__c From RentalCashierEntry__r) FROM dealer__Rental_Agreements__c where Id IN:RaIds LIMIT 200]);

		/* Set the deposit on the Repair Order Object */
		if(sros.size()>0) {
			for(dealer__Service_Repair_Order__c ro : sros) {

				// Setup Empty Deposit
				Decimal newDeposit = 0;
				Decimal totalPayments = 0;

				// Loop through associated Cachiering Entries and total them.
				if(!ro.Cashiering__r.isEmpty()){
					for(dealer__Cashering__c c : ro.Cashiering__r) {
						totalPayments += c.Amount__c;					
						if(c.Deposit__c == true) {
							newDeposit += c.Amount__c;					
						}
					}
				}

				if(ro.Deposit__c != newDeposit || ro.dealer__Payments_Total__c != totalPayments) {
					ro.Deposit__c = newDeposit;
					ro.dealer__Payments_Total__c = totalPayments;
					repair_orders_to_update.add(ro);
				}
			}
			if(!repair_orders_to_update.isEmpty()) {
				update repair_orders_to_update;
			}
		}

		/* Set the Amount of Payments */
		if(ra.size()>0) {
			for(dealer__Rental_Agreements__c r : ra) {
				Decimal payment_total = 0;

				if(!r.RentalCashierEntry__r.isEmpty()) {
					for(dealer__Cashering__c c : r.RentalCashierEntry__r) {
						payment_total+=c.Amount__c;
					}
				}

				if(r.dealer__Total_Payments__c != payment_total) {
					r.dealer__Total_Payments__c=payment_total;
					rentals_to_update.add(r);
				}
			}

			if(!rentals_to_update.isEmpty()) {
				update rentals_to_update;
			}
		}
    }
    
}