public class RentalAgreementAPI {
    public static Decimal taxableSubtotal = 0.0;
    public static Map<Id,Decimal> taxableFeeMap = new Map<Id, Decimal>();

    public RentalAgreementAPI() {}
    public static List<Rental_Agreements__c> updateRentalAgreements(List<Rental_Agreements__c> rentalList){
        
        Set<Id> locIdSet = new Set<Id>();
        Set<Id> accessoryIds = new Set<Id>();
        Set<Id> dailyRateIds = new Set<Id>();
        Set<Id> raIds = new Set<Id>();
        
        for(Rental_Agreements__c ra : rentalList){
            if(ra.Location__c != null) locIdSet.add(ra.Location__c);
            if(ra.Rental_Accessories__c != null) accessoryIds.add(ra.Rental_Accessories__c);
            if(ra.Rental_Rates_Code__c != null) dailyRateIds.add(ra.Rental_Rates_Code__c);
            raIds.add(ra.Id);
        }
 
        Map<Id,Rental_Rates__c> dailyRateMap = getDailyRateMap(dailyRateIds);
        Map<Id,Decimal> locationRateMap = getLocationRateMap(locIdSet);
        Map<Id,Decimal> accessoryDailyRateMap = getAccessoryDailyRateMap(accessoryIds);
        Map<Id,Decimal> feeMap = getFeeMap(raIds);
        taxableFeeMap = getTaxableFeeMap(raIds);

        for(Rental_Agreements__c ra : rentalList){
            Decimal gracePeriodMinutes = dailyRateMap.get(ra.Rental_Rates_Code__c) != null && dailyRateMap.get(ra.Rental_Rates_code__c).GracePeriodMinutes__c != null ? dailyRateMap.get(ra.Rental_Rates_Code__c).GracePeriodMinutes__c : 0;
            Decimal dailyRate =  dailyRateMap.get(ra.Rental_Rates_Code__c) != null && dailyRateMap.get(ra.Rental_Rates_code__c).Daily_Rate__c != null ? dailyRateMap.get(ra.Rental_Rates_Code__c).Daily_Rate__c : 0;
            Integer daysRented = getDaysRented(ra,gracePeriodMinutes);
            Decimal accessoryRate = accessoryDailyRateMap.get(ra.Rental_Accessories__c) != null ? accessoryDailyRateMap.get(ra.Rental_Accessories__c) : 0;
            Decimal feesTotal = feeMap.get(ra.Id) != null ? feeMap.get(ra.Id) : 0;
            Rental_Rates__c rentalRates = dailyRateMap.get(ra.Rental_Rates_code__c) != null ? dailyRateMap.get(ra.Rental_rates_code__c) : new Rental_Rates__c();

            ra.DaysRentedCalculated__c = daysRented;
            ra.Rental_Vehicle_Total__c = daysRented * dailyRate;
            ra.Total_Mileage_Limit__c = ra.Total_Mileage_Limit__c != null ?ra.Mileage_Limit_Daily__c * daysRented : 0; 
            ra.Delivery_Fee__c        = ra.Delivery_Fee__c != null ? ra.Delivery_Fee__c : 0;
            ra.Vehicle_Licence_Fee__c = ra.Vehicle_Licence_Fee__c != null ? ra.Vehicle_Licence_Fee__c : 0;
            ra.Refueling_Fee__c       = ra.Refueling_Fee__c != null ? ra.Refueling_Fee__c : 0;
            ra.Adjustment_Charges__c  = feesTotal;
            ra.Discount__c = ra.Discount__c > 0 ? ra.Discount__c * -1 : ra.Discount__c != null ? ra.Discount__c : 0; // force negative.

            Decimal subTotal = 0.0;
            subTotal = getGrossTotal(ra, rentalRates, accessoryRate, feesTotal);
            ra.Discount_Percentage__c = subtotal > 0 ? (ra.Discount__c /subTotal) * -100 : 0;

             if(ra.Discount__c != null){
                ra.SubTotal__c = subTotal + ra.Discount__c;
            }else{
				ra.SubTotal__c = subTotal;		
    		}

            setEstimatedTax(ra,locationRateMap);
        }
        try{
            upsert rentalList;
            
        }catch(DmlException e){
     
            String errMsg = '';
            //Get All DML Messages
            for (Integer i = 0; i < e.getNumDml(); i++) {
        
                errMsg = e.getDmlMessage(i);
                String searchStr = 'FIELD_CUSTOM_VALIDATION_EXCEPTION';
    
                if(errMsg.contains(searchStr)) {
    
                    errMsg =+ errMsg.substring((errMsg.indexOfIgnoreCase(searchStr) + 1) + searchStr.length()) +  '\n';
                } else {
                    errMsg =+ e.getDmlMessage(i) +  '\n' ;
                }
            }
            
            //throw DML exception message
            throw new AuraHandledException(errMsg);
            
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        return rentalList;
    }
    public static Decimal getGrossTotal(Rental_Agreements__c ra, Rental_Rates__c rentalRate, Decimal accessoryRate, Decimal feeTotal){
        //dailyRate
        Decimal grossTotal = 0.0;
        Decimal dailyRate = rentalRate.Daily_Rate__c == null ? 0 : rentalRate.Daily_Rate__c;
        Decimal gracePeriodMinutes = rentalRate.GracePeriodMinutes__c != null ? rentalRate.GracePeriodMinutes__c : 0;
        accessoryRate = accessoryRate == null ? 0 : accessoryRate;

        Integer daysRented = getDaysRented(ra,gracePeriodMinutes);
        Integer daysFree = ra.Days_Free__c != null ? Integer.valueOf(ra.Days_Free__c) : 0;
        Decimal milesDriven = (ra.Return_Mileage__c != null && ra.Mileage_Out__c != null) ? ra.Return_Mileage__c - ra.Mileage_Out__c : 0;
       
        Decimal mileOverageCost = 0.0;
        if(ra.Mileage_Limit_Daily__c != null && ra.Excess_Miles_Fee__c !=null && milesDriven > 0){
            mileOverageCost = ((milesDriven - ra.Total_Mileage_Limit__c) * ra.Excess_Miles_Fee__c) < 0 ? 0 : ((milesDriven - ra.Total_Mileage_Limit__c) * ra.Excess_Miles_Fee__c) ;
        }

        Decimal accessoryTotal = 0.0;
        if(ra.Rental_Accessories__c != null && accessoryRate != null){
            accessoryTotal = accessoryRate * daysRented;
        }

        Decimal taxableFees = 0.0;
        if(ra.id != null){
            Set<Id> raIds = new Set<Id>();
            raIds.add(ra.Id);

            if(taxableFeeMap == null){
                taxableFeeMap = getTaxableFeeMap(raIds);
            }
            taxableFees = taxableFeeMap.get(ra.Id) != null ? taxableFeeMap.get(ra.Id) : 0.0;
        }

        Decimal adjustmentCharges = feeTotal;
        grossTotal += (daysRented - daysFree) * dailyRate;
        grossTotal += accessoryTotal;
        grossTotal += mileOverageCost;
        grossTotal += adjustmentCharges;
        grossTotal += ra.Delivery_Fee__c != null ? ra.Delivery_Fee__c : 0.0;
        grossTotal += ra.Vehicle_Licence_Fee__c != null ? ra.Vehicle_Licence_Fee__c : 0.0;
        grossTotal += ra.Refueling_Fee__c != null ? ra.Refueling_Fee__c : 0.0;

        taxableSubtotal = 0.0;
        taxableSubtotal += (daysRented - daysFree) * dailyRate;
        taxableSubtotal += accessoryTotal;
        taxableSubtotal += mileOverageCost;
        taxableSubtotal += taxableFees;
        taxableSubtotal += ra.Delivery_Fee__c != null ? ra.Delivery_Fee__c : 0.0;
        taxableSubtotal += ra.Vehicle_Licence_Fee__c != null ? ra.Vehicle_Licence_Fee__c : 0.0;
        taxableSubtotal += ra.Refueling_Fee__c != null ? ra.Refueling_Fee__c : 0.0;

        return grossTotal;
    }
    public static Decimal getGrossTotal(Rental_Agreements__c ra){
        Rental_Rates__c rentalRates = new Rental_Rates__c();
        if(ra.Rental_Rates_Code__c != null){
            rentalRates = [SELECT Id, Daily_Rate__c, GracePeriodMinutes__c FROM Rental_Rates__c WHERE Id =: ra.Rental_Rates_Code__c];
        }
        Decimal dailyRate = rentalRates.Daily_Rate__c != null ? rentalRates.Daily_Rate__c : 0;
        Decimal gracePeriodMinutes = rentalRates.GracePeriodMinutes__c != null ? rentalRates.GracePeriodMinutes__c : 0;

        Decimal locationRate = ra.Location__c != null ? [SELECT Id,Tax_Local_Rate__c FROM Dealer_Location__c WHERE Id =: ra.Location__c].Tax_Local_Rate__c : 0;
        locationRate = locationRate != null ? locationRate : 0;

        Decimal accessoryRate = ra.Rental_Accessories__c != null ? [SELECT Id, Daily_Rate__c FROM Rental_Accessories__c WHERE Id =: ra.Rental_Accessories__c].Daily_Rate__c : 0;
        accessoryRate = accessoryRate != null ? accessoryRate : 0;
        
        Decimal feeTotal = 0.0;
        if(ra.id != null){
            Set<Id> raIds = new Set<Id>();
            raIds.add(ra.Id);
            feeTotal = getFeeMap(raIds).get(ra.Id);
        }

        Decimal taxableFees = 0.0;
        if(ra.id != null){
            Set<Id> raIds = new Set<Id>();
            raIds.add(ra.Id);
            if(taxableFeeMap == null){
                taxableFeeMap = getTaxableFeeMap(raIds);
            }
            taxableFees = taxableFeeMap.get(ra.Id) != null ? taxableFeeMap.get(ra.Id) : 0.0;
        }

        Decimal grossTotal = 0.0;
        dailyRate = dailyRate == null ? 0 : dailyRate;
        accessoryRate = accessoryRate == null ? 0 : accessoryRate;

        Integer daysRented = getDaysRented(ra,gracePeriodMinutes);
        Integer daysFree = ra.Days_Free__c != null ? Integer.valueOf(ra.Days_Free__c) : 0;
        Decimal milesDriven = (ra.Return_Mileage__c != null && ra.Mileage_Out__c != null) ? ra.Return_Mileage__c - ra.Mileage_Out__c : 0;
       
        Decimal mileOverageCost = 0.0;
        if(ra.dealer__Mileage_Limit_Daily__c != null && ra.dealer__Excess_Miles_Fee__c != null && milesDriven > 0.0){
           mileOverageCost = (( milesDriven - (ra.dealer__Mileage_Limit_Daily__c * daysRented )) * ra.dealer__Excess_Miles_Fee__c) < 0 ? 0 :  (( milesDriven - (ra.dealer__Mileage_Limit_Daily__c * daysRented )) * ra.dealer__Excess_Miles_Fee__c);          
           System.debug('Mileage overages -->>'+mileOverageCost);
        }

        Decimal accessoryTotal = 0.0;
        if(ra.Rental_Accessories__c != null && accessoryRate != null){
            accessoryTotal = accessoryRate * daysRented;
        }

        Decimal adjustmentCharges = feeTotal;
        grossTotal += (daysRented - daysFree) * dailyRate;
        grossTotal += accessoryTotal;
        grossTotal += mileOverageCost;
        grossTotal += adjustmentCharges;
        grossTotal += ra.Delivery_Fee__c != null ? ra.Delivery_Fee__c : 0.0;
        grossTotal += ra.Vehicle_Licence_Fee__c != null ? ra.Vehicle_Licence_Fee__c : 0.0;
        grossTotal += ra.Refueling_Fee__c != null ? ra.Refueling_Fee__c : 0.0;

        taxableSubtotal = 0.0;
        taxableSubtotal += (daysRented - daysFree) * dailyRate;
        taxableSubtotal += accessoryTotal;
        taxableSubtotal += mileOverageCost;
        taxableSubtotal += taxableFees;
        taxableSubtotal += ra.Delivery_Fee__c != null ? ra.Delivery_Fee__c : 0.0;
        taxableSubtotal += ra.Vehicle_Licence_Fee__c != null ? ra.Vehicle_Licence_Fee__c : 0.0;
        taxableSubtotal += ra.Refueling_Fee__c != null ? ra.Refueling_Fee__c : 0.0;

        return grossTotal;
    }
    public static void setEstimatedTax(Rental_Agreements__c ra, Map<Id,Decimal>locationRateMap){
        List<DMS_Settings__c> dmsTaxSettings = new List<DMS_Settings__c>();
        dmsTaxSettings = DMS_Settings__c.getall().values();
        ra.Estimated_Tax__c = 0.0;
        if(!ra.Tax_Exempt__c){
            if(ra.Discount__c != null){
                ra.Estimated_Tax__c = taxableSubtotal + ra.Discount__c;
            }
            else{
                ra.Estimated_Tax__c = taxableSubtotal;
            }
            system.debug('------> ra.Location__c is set? ' + ra.dealer__Location__c );
            //If location is set, get tax from location settings else get tax from custom settings
            if(locationRateMap.get(ra.Location__c) != null){
                ra.Estimated_Tax__c = ra.Estimated_Tax__c * (locationRateMap.get(ra.Location__c) / 100);
            } else if (dmsTaxSettings != null && dmsTaxSettings.size()>0 && dmsTaxSettings[0].Default_Tax_Rate__c != null){
                ra.Estimated_Tax__c = ra.Estimated_Tax__c * (dmsTaxSettings[0].Default_Tax_Rate__c / 100);
            }
        }
    }
    public static Integer getDaysRented(Rental_Agreements__c ra, Decimal gracePeriodMinutes){
        Integer daysRented = 0;
        Decimal daysBetween;

        //Ensure we are using the proper date time field based on status of rental
        DateTime ReturnDateTime = ra.Agreement_Status__c == 'Open' || (ra.DateTime_Due_In__c != null && ra.Return_DateTime__c == null) ? ra.DateTime_Due_In__c : ra.Return_DateTime__c;
        DateTime DateTimeOut = ra.DateTime_Out__c;
        
        if(DateTimeOut != null){
            daysBetween = utility.daysBetweenDatetime(DateTimeOut, ReturnDateTime);
            if(utility.Modulus(daysBetween) > gracePeriodMinutes / 1440){
                daysRented = (Integer)daysBetween + 1; // Over Grace Period; Add another day.
            } else {
                daysRented = (Integer)daysBetween; // Within Grace period charge true days between
            }
        } else {
            daysRented += 1; // always charge 1 day
        }
        return daysRented;
    }
    public static Map<Id,Rental_Rates__c> getDailyRateMap(Set<Id> rateIds){
        Map<Id, Rental_Rates__c> dailyRateMap = new Map<id,Rental_Rates__c>();
        for(Rental_Rates__c rate : [SELECT Id, Daily_Rate__c, GracePeriodMinutes__c FROM Rental_Rates__c WHERE Id IN : rateIds]){
            if(rate.Daily_Rate__c!=null){
                dailyRateMap.put(rate.Id, rate);
            }
        }
        return dailyRateMap;
    }
    public static Map<Id,Decimal> getLocationRateMap(Set<Id> locIds){
        Map<Id,Decimal> locationRateMap = new Map<Id,Decimal>();
        for(Dealer_Location__c loc : [SELECT Id,Tax_Local_Rate__c,Tax_Local_Rental_Addition__c 
                                      FROM Dealer_Location__c WHERE Id IN: locIds]){
            Decimal totalTaxRate = 0;
            totalTaxRate += (loc.Tax_Local_Rate__c != null ? loc.Tax_Local_Rate__c : 0) + (loc.Tax_Local_Rental_Addition__c != null ? loc.Tax_Local_Rental_Addition__c : 0);
            locationRateMap.put(loc.Id, totalTaxRate);
        }
        return locationRateMap;
    }
    public static Map<Id,Decimal> getAccessoryDailyRateMap(Set<Id> accesoryIds){
        Map<Id,Decimal> accessoryRateMap = new Map<Id,Decimal>();
        for(Rental_Accessories__c accessory : [SELECT Id, Daily_Rate__c FROM Rental_Accessories__c WHERE Id IN : accesoryIds]){
            accessoryRateMap.put(accessory.Id, accessory.Daily_Rate__c);
        }
        return accessoryRateMap;
    }
    public static Map<Id, Decimal> getFeeMap(Set<Id> raIds){
        AggregateResult[] groupedResults = [SELECT Rental_Agreement__c, SUM(Amount__c)
                FROM Rental_Fee__c
                GROUP BY Rental_Agreement__c];
        Map<Id, Decimal> feeMap = new Map<Id,Decimal>();
        for (AggregateResult ar : groupedResults)  {
            Id raId = (Id)ar.get('dealer__Rental_Agreement__c');
            Decimal total = (Decimal)ar.get('expr0') != null ? (Decimal)ar.get('expr0') : 0;
            feeMap.put(raId, total);
        }
        for(Id r : raIds){
            if(feeMap.get(r) == null){
                feeMap.put(r,0.0);
            }
        }
        return feeMap;
    }
    public static Map<Id, Decimal> getTaxableFeeMap(Set<Id> raIds){
        AggregateResult[] groupedResults = [SELECT Rental_Agreement__c, SUM(Amount__c)
                FROM Rental_Fee__c WHERE Taxable__c = true
                GROUP BY Rental_Agreement__c];
        Map<Id, Decimal> feeMap = new Map<Id,Decimal>();
        for (AggregateResult ar : groupedResults)  {
            Id raId = (Id)ar.get('dealer__Rental_Agreement__c');
            Decimal total = (Decimal)ar.get('expr0') != null ? (Decimal)ar.get('expr0') : 0;
            feeMap.put(raId, total);
        }
        for(Id r : raIds){
            if(feeMap.get(r) == null){
                feeMap.put(r,0.0);
            }
        }
        return feeMap;
    }
    public static Integer getTimeOutMinutes(Rental_Agreements__c ra){
        Integer minutes = 0;
        if(ra.Time_Out__c != null){
            if(ra.Time_Out__c.contains('PM') && ra.Time_Out__c.substring(0,2) != '12'){
                minutes += (Integer.valueOf(ra.Time_Out__c.substring(0,2))+12) * 60;
                minutes += Integer.valueOf(ra.Time_OUT__c.substring(3,5));
            } else {
                minutes  += Integer.valueOf(ra.Time_Out__c.substring(0,2)) * 60; 
                minutes += Integer.valueOf(ra.Time_Out__c.substring(3,5));
            }
        }
        return minutes;
    }
    public static Integer getTimeInMinutes(Rental_Agreements__c ra){
        Integer minutes = 0;
        if(ra.Return_Time__c != null){
            if(ra.Return_Time__c.contains('PM') && ra.Return_Time__c.substring(0,2) != '12'){
                minutes += (Integer.valueOf(ra.Return_Time__c.substring(0,2))+12) * 60;
                minutes += Integer.valueOf(ra.Return_Time__c.substring(3,5));
            } else {
                minutes  += Integer.valueOf(ra.Return_Time__c.substring(0,2)) * 60; 
                minutes += Integer.valueOf(ra.Return_Time__c.substring(3,5));
            }
        }
        return minutes;
    }
    public static List < Cashering__c > cashTransactions(String rentalId) {
        return [SELECT Id, Customer__c, Credit_Card_Authorization_Code__c, Customer__r.Name, Payment_Method__c, Deposit__c, Amount__c,
            Rental_Agreement__r.Balance_Due__c, Rental_Agreement__r.TotalEstimatedCharges__c
            FROM Cashering__c WHERE Rental_Agreement__c =: rentalId ORDER BY CreatedDate DESC
        ];
    }
}