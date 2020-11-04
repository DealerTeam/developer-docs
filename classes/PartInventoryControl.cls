/*
	Inventory Control Class

		v.1.421 Ported to Global for external integrations
*/
global without sharing class PartInventoryControl {
	
	global PartInventoryControl() {}

	global enum Methods {LIFO,FIFO}

	/**
	 * True / False to check if the inventory method requested exists
	 *
	 * @param String 	:	The string to check if matched against the  
	 *							global enumeration of available methods
	 *
	 * @return Boolean 	:	True if method exists, false if it does not
	 * @test PartPhysicalServiceLayer.testPartInventoryControl
	 */
	global static boolean methodValid(String s) {
		Set<String> knownMethods = new Set<String>();
		for(Methods m : Methods.values()) {
			knownMethods.add(String.valueOf(m));
		}

		if(knownMethods.contains(s)) {
			return true;
		}
		return false;
	}

	/**
	 *	List of inventory history purchase events that will be
	 *		used to prepare the cost valuations
	 *
	 *	@param String 	: 	Method name for inventory cost valuation
	 *	@param Id 		:	Part Inventory record Id
	 *	@param Decimal 	:	number of items requested.  This can force span
	 *							across multiple purchase events
	 *
	 *	@return List 	:	List of inventory history events that corrospond
	 *							to the purchase events.
	 * @test PartPhysicalServiceLayer.testPartInventoryControl
	 */
	global static List<dealer__Part_Inventory_History__c> inventoryCostPremise(String method, Id inventoryId, Decimal qtyRequested) {

		if(method == null || !methodValid(method)) {
			throw new InventoryControlException('Inventory Control Method '+method+' is invalid for your organization');
		}

		List<dealer__Part_Inventory_History__c> pEvent = new List<dealer__Part_Inventory_History__c>();
		Decimal count 		= 	0;
		Boolean countMathed = 	false;

		List<dealer__Part_Inventory_History__c> pH = new List<dealer__Part_Inventory_History__c>();

		if(method == 'LIFO') {
		 	pH = [Select Id, dealer__Cost__c, dealer__Quantity_Adjustment__c, dealer__Units_Relieved__c, dealer__Value_Relieved__c, dealer__Item_Value__c
													  from dealer__Part_Inventory_History__c 
														where dealer__Part__c =:inventoryId 
														and dealer__Cost_Relieved__c = false 
														and ( dealer__Transaction_Event__c = 'Data Load' 
																or dealer__Transaction_Event__c = 'Conversion' 
																or dealer__Transaction_Event__c = 'Purchase Order Received'
																or dealer__Transaction_Event__c = 'Cost Adjustment') 
														order by CreatedDate DESC
														limit 100];
		}

		if(method == 'FIFO') {
		 	pH = [Select Id, dealer__Cost__c, dealer__Quantity_Adjustment__c, dealer__Units_Relieved__c, dealer__Value_Relieved__c, dealer__Item_Value__c
													  from dealer__Part_Inventory_History__c 
														where dealer__Part__c =:inventoryId 
														and dealer__Cost_Relieved__c = false 
														and ( dealer__Transaction_Event__c = 'Data Load' 
																or dealer__Transaction_Event__c = 'Conversion' 
																or dealer__Transaction_Event__c = 'Purchase Order Received'
																or dealer__Transaction_Event__c = 'Cost Adjustment') 
														order by CreatedDate ASC
														limit 100];
		}

		if(pH.size()>0)	 {
			for(dealer__Part_Inventory_History__c pHist : pH) {
				if(!countMathed) {
					pEvent.add(pHist);
					count += pHist.dealer__Quantity_Adjustment__c;
					if(count >= qtyRequested) {
						countMathed = true;
						return pEvent;
					}
				}
			}
		}	

		return pEvent;
	}

	/**
	 *	Get Cost Method as Defined in the Custom Setting
	 *
	 *
	 * @test PartPhysicalServiceLayer.testPartInventoryControl
	 */
	 global static String inventoryControlMethod() {
	 	dealer__FixedOperationsSettings__c fs = dealer__FixedOperationsSettings__c.getOrgDefaults();
	 	if(fs==null) {
	 		return '';
	 	} 

	 	return fs.dealer__Parts_Inventory_Control_Method__c;
	 }

	/**
	 *	Process the matched matched list to provide valid cost
	 *
	 *	@param List 	:	List of part inventory history to set cost by
	 * 	@param Decimal 	:	Number of items requested, this can impact partial lines
	 *  @returm Decimal :	Value of the list of parts by their costs
	 * @test PartPhysicalServiceLayer.testPartInventoryControl
	 */
	 global static invControl costBasis(Id partId, Decimal qtyRequested) {

	 	List<dealer__Part_Inventory_History__c> partsHistory = inventoryCostPremise(inventoryControlMethod(), partId, qtyRequested);
	 	List<dealer__Part_Inventory_History__c> partHistoryPost = new List<dealer__Part_Inventory_History__c>();

	 	Decimal returnValue = 0;
	 	Decimal qtyCount 	= 0;

	 	for(dealer__Part_Inventory_History__c p : partsHistory) {

	 		if(p.dealer__Item_Value__c==null) {
	 			throw new InventoryControlException('Item Value may not be NULL');
	 		}

	 		if(p.dealer__Quantity_Adjustment__c == null) {
	 			throw new InventoryControlException('Quanty Adjustment may not be NULL');
	 		}

	 		// Set our counters
	 		qtyCount += p.dealer__Quantity_Adjustment__c;
	 		returnValue += p.dealer__Item_Value__c;

	 		// If we have a larger number of initial purchase than qty requested, perform cost basis and exit
	 		if(p.dealer__Quantity_Adjustment__c>qtyRequested) {
	 			partHistoryPost.add(new dealer__Part_Inventory_History__c(Id=p.Id, 
	 																		dealer__Units_Relieved__c=qtyRequested, 
	 																		dealer__Value_Relieved__c=(qtyRequested*p.dealer__Item_Value__c)
	 																	)
	 			);
	 		}

	 		// If we have an equal number (one to one line match) return value
	 		if(p.dealer__Quantity_Adjustment__c==qtyRequested) {
	 			partHistoryPost.add(new dealer__Part_Inventory_History__c(Id=p.Id, dealer__Units_Relieved__c=qtyRequested, dealer__Value_Relieved__c=(qtyRequested*p.dealer__Item_Value__c), dealer__Cost_Relieved__c=true));
	 		}

	 		// If we have multiple rows of history to fill
	 		if(p.dealer__Quantity_Adjustment__c<qtyRequested) {
	 			partHistoryPost.add(new dealer__Part_Inventory_History__c(Id=p.Id, dealer__Units_Relieved__c=qtyRequested, dealer__Value_Relieved__c=(qtyRequested*p.dealer__Item_Value__c)));	 			
	 		}

	 	}

	 	return new invControl(returnValue, partHistoryPost);
	 }

	 global static invControl setTransactionEventId(invControl i, Id eId) {
	 	List<dealer__Part_Inventory_History__c> hTemp = new List<dealer__Part_Inventory_History__c>();
	 	for(dealer__Part_Inventory_History__c p : i.history) {
	 		p.dealer__EventId__c = eId;
	 		hTemp.add(p);
	 	}
	 	return new invControl(i.value, hTemp);
	 }

	 global static Boolean reversePartSale(Id eId) {
	 	
	 	if(eId==null) {
	 		throw new InventoryControlException('Error: reversePartSale requires a valid event Id');
	 	}

	 	List<dealer__Parts_Invoice_Line__c> iLine = [Select dealer__Cost__c, dealer__Quantity_Sold__c 
	 													from dealer__Parts_Invoice_Line__c where id=:eId limit 1];
	 	if(iLine.size()==0) {
	 		throw new InventoryControlException('Error: reversePartSale requires a valid sale line');
	 	}



	 	List<dealer__Part_Inventory_History__c> pList = new List<dealer__Part_Inventory_History__c>();

	 	for(dealer__Part_Inventory_History__c p : [Select Id, dealer__Cost__c, dealer__Quantity_Adjustment__c, dealer__Units_Relieved__c, dealer__Value_Relieved__c, dealer__Item_Value__c, dealer__Cost_Relieved__c, dealer__EventId__c from dealer__Part_Inventory_History__c where dealer__EventId__c =:eId and ( NOT dealer__Transaction_Event__c like 'Sold %') limit 10]) {
	 		if(p.dealer__Units_Relieved__c <= iLine[0].dealer__Quantity_Sold__c) {
	 			p.dealer__Units_Relieved__c-=iLine[0].dealer__Quantity_Sold__c;
	 			p.dealer__Value_Relieved__c-=iLine[0].dealer__Cost__c;
	 			p.dealer__Cost_Relieved__c=false;
	 			p.dealer__EventId__c=null;
	 			pList.add(p);
	 		}
	 	}

	 	if(pList.size()==0) {
	 		return false;
	 	}

	 	try {
	 		update pList;
	 		return true;
	 	} catch(DmlException e) {
	 		throw new InventoryControlException('Failed to reverse parts sale: '+e.getMessage());
	 	}
	 	return false;
	 }

	 /**
	  * Wrapper Class
	  *
	  * @test PartPhysicalServiceLayer.testPartInventoryControl
	  */
	  global class invControl {
	  	global Decimal value {get;set;}
	  	global List<dealer__Part_Inventory_History__c> history {get;set;}
	  	global invControl(Decimal invValue, List<dealer__Part_Inventory_History__c> invHistory) {
	  		value 	= 	invValue;
	  		history = 	invHistory;
	  	}
	  }

	 /**
	  *	Append the cost values, quantity adjsuted and cost releived of the associated parts list
	  *
	  *	@param List
	  *
	  */

	global class InventoryControlException extends Exception {}
}