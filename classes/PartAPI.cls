/**
 * PartAPI - Service layer encapsulation for interaction with Parts
 * 
 */
global with sharing class PartAPI {

    /**
     * createInventoryFromMaster provides an api interface and single point of entry for creating inventory from parts master records in a specific location.
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
     */
    global static Map < Id, Parts_Inventory__c > createInventoryFromMaster(List < Parts_Master__c > masterItems, Id location) {


        // Setup maps for storing data
        Map < Id, Parts_Inventory__c > invMap = new Map < Id, Parts_Inventory__c > ();
        Set < Id > masterIds = new Set < Id > ();
        for (Parts_Master__c pm: masterItems) {
            masterIds.add(pm.Id);
        }
        List < Parts_Inventory__c > partsToCreate = new List < Parts_Inventory__c > ();
        Map < Id, Parts_Inventory__c > existingInventory = new Map < Id, Parts_Inventory__c > ();
        Map < Id, Parts_Master__c > masterDetails = new Map < Id, Parts_Master__c > ([SELECT Id, Name, Part_No__c, Part_Description__c, Manufacturer__c, Cost__c, Retail_Price__c, Pack_QTY__c, Core_Required__c, Jobber_Price__c, Core_Value__c, MAP__c FROM Parts_Master__c WHERE Id IN: masterItems]);

        // 1) check the list to see what parts we need to create
        for (Parts_Inventory__c pi: [SELECT Id, Parts_Master__c, On_Hand__c, On_Order__c FROM Parts_Inventory__c WHERE Parts_Master__c IN: masterIds AND Location__c =: location]) {
            existingInventory.put(pi.Parts_Master__c, pi);
            invMap.put(pi.Parts_Master__c, pi);
        }

        // 2) for parts that need to be created, create based on master
        for (Parts_Master__c pm: masterItems) {
            if (existingInventory.get(pm.Id) == NULL) {
                partsToCreate.add(new dealer__Parts_Inventory__c(
                    Parts_Master__c = pm.Id,
                    Location__c = location,
                    Part_No__c = masterDetails.get(pm.Id).Part_No__c,
                    Description__c = masterDetails.get(pm.Id).Part_Description__c,
                    MFG__c = masterDetails.get(pm.Id).Manufacturer__c,
                    Cost__c = masterDetails.get(pm.Id).Cost__c,
                    List__c = masterDetails.get(pm.Id).Retail_Price__c,
                    Pack_QTY__c = masterDetails.get(pm.Id).Pack_QTY__c,
                    CoreRequired__c = masterDetails.get(pm.Id).Core_Required__c,
                    Jobber__c = masterDetails.get(pm.Id).Jobber_Price__c,
                    Core__c = masterDetails.get(pm.Id).Core_Value__c,
                    MAP__c = masterDetails.get(pm.Id).MAP__c
                ));
            }
        }

        try {
            if (!partsToCreate.isEmpty()) {
                insert partsToCreate;

                for (Parts_Inventory__c p: partsToCreate) {
                    invMap.put(p.Parts_Master__c, p);
                }
            }
        }

        Catch(DmlException e) {
            throw new PartAPIException(e.getMessage());
        }
        Catch(Exception e) {
            throw new PartAPIException(e.getMessage());
        }


        return invMap;
    }

    /** */
    global static List < Parts_Inventory__c > readInventory(Id location) {
        return queryPartInventory(location, null, null, null);
    }

    global static List < Parts_Inventory__c > readInventory(List < Id > locationIds) {
        return queryPartInventory(null, locationIds, null, null);
    }

    global static List < Parts_Inventory__c > readInventory(Parts_Inventory__c part) {
        return queryPartInventory(null, null, part.Id, null);
    }

    global static List < Parts_Inventory__c > readInventory(List < Id > locationIds, String manufacturer) {
        return queryPartInventory(null, locationIds, null, manufacturer);
    }

    /*
     * Queries the database for parts filtered by params
     * @function - queryPartInventory
     * @param {Id} location - location of parts to filter query
     * @param {List<Id>} locationIds - multiple locations to filter
     * @param {Id} part - part id to filter
     * @param {String} manufacturer - part manufacturer to filter
     * @returns {List<Parts_Inventory__c>} - list of parts matching returned by filtered query
     * @test PartPhysicalInventoryServiceLayer.testPartAPI
     */
    Private static List < Parts_Inventory__c > queryPartInventory(Id location, List < Id > locationIds, Id part, String manufacturer) {
        String query = 'SELECT  Name, MFG__c, Part_Number__c, Part_No__c, Description__c, Cost__c, Bin__c,Last_Sale_Date__c, Status__c, On_Hand__C, On_Order__c, On_Special_Order__c, On_Back_Order__c, Entry_Date__c, Sale_Metrics__r.CY_April__c, Sale_Metrics__r.CY_August__c, Sale_Metrics__r.CY_December__c, Sale_Metrics__r.CY_February__c, Sale_Metrics__r.CY_January__c, Sale_Metrics__r.CY_July__c, Sale_Metrics__r.CY_June__c, Sale_Metrics__r.CY_March__c, Sale_Metrics__r.CY_May__c, Sale_Metrics__r.CY_November__c, Sale_Metrics__r.CY_October__c, Sale_Metrics__r.CY_September__c, Sale_Metrics__r.PY_April__c, Sale_Metrics__r.PY_August__c, Sale_Metrics__r.PY_December__c, Sale_Metrics__r.PY_February__c, Sale_Metrics__r.PY_January__c, Sale_Metrics__r.PY_July__c, Sale_Metrics__r.PY_June__c, Sale_Metrics__r.PY_March__c, Sale_Metrics__r.PY_May__c, Sale_Metrics__r.PY_November__c, Sale_Metrics__r.PY_October__c, Sale_Metrics__r.PY_September__c, Sale_Metrics__r.Last_30__c, Sale_Metrics__r.Last_60__c, Sale_Metrics__r.Last_90__c, Sale_Metrics__r.Last_120__c FROM Parts_Inventory__c WHERE';
        String filter = '';
        List < String > locationList = new List < String > ();

        if (locationIds != null) {
            for (Id l: locationIds) {
                locationList.add('\'' + String.valueOf(l) + '\'');
            }
        }

        if (location != null && locationIds == null && part == null && manufacturer == null) {
            filter = ' Location__c = \'' + String.valueOf(location) + '\'';
        }
        if (locationIds != null && location == null && part == null && manufacturer == null) {
            filter = ' Location__c IN ' + locationList + ' ';
        }
        if (part != null && location == null && locationIds == null && manufacturer == null) {
            filter = ' Id = \'' + String.valueOf(part) + '\'';
        }
        if (locationIds != null && manufacturer != null && part == null && location == null) {
            filter = ' MFG__c = \'' + manufacturer + '\' AND Location__c IN ' + locationList + ' ';
        }

        query = query + filter;
        if (filter != null) {
            return Database.Query(query);
        }
        return null;
    }
    /**
     *
     *  Matrix - Determines the matrix value based on the requested part being sold.  
     */
    global static Decimal matrix(String paymentMethod, Parts_Inventory__c part) {
        // If the part has a static price, return the static price, else find appropriate matrix entry
        if (part.Static_Price__c != null && part.Static_Price__c != 0 && paymentMethod == 'C') {
            return part.Static_Price__c;
        }

        Decimal listPrice = PartAPI.matrixSearch(paymentMethod, part.Cost__c);

        if (listPrice != null) {
            return listPrice;
        }

        return part.List__c;
    }

    global static Decimal matrix(String paymentMethod, Parts_Master__c master) {
        System.assert(paymentMethod != null, 'Payment method must be supplied to have a Matrix Applied.');
        System.assert(master.Cost__c != null, 'Part Master can not have a Matrix applied, Cost is not set on the master record.');
        Decimal listPrice = PartAPI.matrixSearch(paymentMethod, master.Cost__c);
        if (listPrice != null) {
            return listPrice;
        }

        return master.Retail_Price__c;
    }
    /**
     *  matrixSearch - perform record processing sub function for the primary global method
     */
    private static Decimal matrixSearch(String pm, Decimal cost) {
        System.assert(cost != null, 'Cost parameter must be set and not equal to null');
        PriceMatrix__mdt[] matrix = [SELECT Multiplier__c FROM PriceMatrix__mdt WHERE LowCost__c <=: cost AND HighCost__c >=: cost LIMIT 1];
        if (!matrix.isEmpty()) {
            Decimal mcost = ((matrix[0].Multiplier__c / 100) * cost) + cost;
            return mcost.setScale(2, System.RoundingMode.HALF_UP);
        }
        return null;
    }

    /**
     *  matrixSearch - perform record processing sub function for the primary global method
     * @function - saleMetricHandler
     * @param {Map<Id, Parts_Inventory__c>} - parts to process
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable 
     */
    global static Void saleMetricHandler(Map < Id, Parts_Inventory__c > partInventoryMap) {

        Map < Id, Part_Sale_Metric__c > PartMetricMap = new Map < Id, Part_Sale_Metric__c > (); //partId,saleMetric
        Set < Id > partIdSet = new Set < Id > ();
        Map < Id, Id > metricPartMap = new Map < Id, Id > (); //Metric Id ,Part Id

        partIdSet = partInventoryMap.keySet();
        //loop partInventoryMap for metric Id's
        for (Parts_Inventory__c part: partInventoryMap.values()) {
            if (part.Sale_Metrics__c != null) {
                metricPartMap.put(part.Sale_Metrics__c, part.Id);
            }
        }

        //existing part_sale_Metrics for parts
        for (Part_Sale_Metric__c psm: [SELECT Id, CY_April__c, CY_August__c, CY_December__c, CY_February__c, CY_January__c, CY_July__c, CY_June__c, CY_March__c, CY_May__c, CY_November__c, CY_October__c, CY_September__c, PY_April__c, PY_August__c, PY_December__c, PY_February__c, PY_January__c, PY_July__c, PY_June__c, PY_March__c, PY_May__c, PY_November__c, PY_October__c, PY_September__c, Last_30__c, Last_60__c, Last_90__c, Last_120__c FROM Part_Sale_Metric__c WHERE Id In: metricPartMap.keySet()]) {
            if (!PartMetricMap.containsKey(psm.id)) {
                //need to get the part Id here.
                PartMetricMap.put(metricPartMap.get(psm.Id), cleanMetric(psm));
            }

        }

        //Executes if a metric does NOT exist for a part yet.
        for (Id partId: partIdSet) {
            if (PartMetricMap.containsKey(partId) == false) {
                PartMetricMap.put(partId, cleanMetric(new Part_Sale_Metric__c( /*Part__c = partId*/ )));
            }
        }

        //aggregate result based on the partIdSet
        AggregateResult[] groupedPartResults = [
            SELECT Part__c, Calendar_Year(Sale_Date__c) year, Calendar_Month(Sale_Date__c) month, SUM(Quantity_Sold__c) soldSum
            FROM Parts_Invoice_Line__c
            WHERE(Part__c IN: partIdSet)
            GROUP BY Part__c, Calendar_Year(Sale_Date__c), Calendar_Month(Sale_Date__c)
        ];

        Map < Id, Map < Integer, Integer > > partSaleHistoryMap = new Map < Id, Map < Integer, Integer > > ();

        for (AggregateResult ar: groupedPartResults) {

            Part_Sale_Metric__c thisMetric = new Part_sale_metric__c();
            Map < Integer, Integer > unitSumMap = new Map < Integer, Integer > ();

            Date saleDate;
            if (ar.get('year') != null && ar.get('month') != null) {
                saleDate = date.newInstance((Integer) ar.get('year'), (Integer) ar.get('month'), 15 );
            } else saleDate = date.NewInstance(2000, 1, 1);

            Integer qtySold = Integer.valueOf((Decimal) ar.get('soldSum'));
            Id partId = (Id) ar.get('dealer__Part__c');

            //If this part already exists we need to get that data so we can append new values correctly.
            if (partSaleHistoryMap.containsKey(partId)) {
                unitSumMap = partSaleHistoryMap.get(partId);
            }
            unitSumMap.put(getSaleMonth(saleDate), qtySold);
            unitSumMap.put((isLast30(saleDate) ? 30 : 0), (unitSumMap.get(30) == null ? 0 : unitSumMap.get(30)) + qtySold);
            unitSumMap.put((isLast60(saleDate) ? 60 : 0), (unitSumMap.get(60) == null ? 0 : unitSumMap.get(60)) + qtySold);
            unitSumMap.put((isLast90(saleDate) ? 90 : 0), (unitSumMap.get(90) == null ? 0 : unitSumMap.get(90)) + qtySold);
            unitSumMap.put((isLast120(saleDate) ? 120 : 0), (unitSumMap.get(120) == null ? 0 : unitSumMap.get(120)) + qtySold);
            partSaleHistoryMap.put(partId, unitSumMap);

            thisMetric = cleanMetric(partId, partSaleHistoryMap);
            //thisMetric.Part__c = partId;

            //if metric for this part exists we need to update the fields not insert new
            if (PartMetricMap.get(partId).Id != null) {
                thisMetric.Id = PartMetricMap.get(partId).Id;
            }
            PartMetricMap.put(partId, thisMetric);
        }

        try {
            upsert PartMetricMap.values();
            List < Parts_Inventory__c > partUpdateList = new List < Parts_Inventory__c > ();
            for (Id partId: partIdSet) {
                partUpdateList.add(new Parts_Inventory__c(Id = partId, Sale_Metrics__c = PartMetricMap.get(partId).Id));
            }
            upsert partUpdateList;
            updatePartLastSaleDate(partIdSet);
        } catch (DmlException e) {
            throw new PartAPIException(e.getMessage());
        }
    }

    public static List < Cashering__c > cashTransactions(String invoiceId) {
        return [SELECT Id, Customer__c, Credit_Card_Authorization_Code__c, Customer__r.Name, Payment_Method__c, Deposit__c, Amount__c,
            Rental_Agreement__r.Balance_Due__c, Rental_Agreement__r.TotalEstimatedCharges__c
            FROM Cashering__c WHERE Parts_Invoice__c =: invoiceId ORDER BY CreatedDate DESC
        ];
    }

    /**
     * Updates the last_sale_date__c field with the current sale date
     * @function - updatePartLastSaleDate
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
     */
    private static void updatePartLastSaleDate(Set<Id> partIdSet){
        if(partIdSet != null){
            Map<Id, Parts_Invoice_Line__c> newPartMap = new Map<Id, Parts_Invoice_Line__c>();
            for(Parts_Invoice_Line__c line : [SELECT Id, Sale_Date__c, Part__c FROM Parts_Invoice_Line__c WHERE Part__c in: partIdSet ORDER BY Sale_Date__c DESC]){
                //Since the soql above is ordered Sale_Date__c Descending, if there are multiple lines for a part, only the latest sales date will be populated in Map.
                if(newPartMap.get(line.Part__c) == null){
                    newPartMap.put(line.Part__c, line);
                }
            }
            List<Parts_Inventory__c> updatedParts = new List<Parts_Inventory__c>();
            for(Id partId : newPartMap.keySet()){
                DateTime d = newPartMap.get(partId).Sale_Date__c;
                updatedParts.add(new Parts_Inventory__c(
                    Id = partId,
                    Last_Sale_Date__c = Date.NewInstance(d.year(),d.month(), d.day())
                    ));
            }
            try{
                if(updatedParts.size() > 0)
                update updatedParts;
            } catch(DmlException e){
                throw new DmlException(e.getMessage());
            }
        }
    }
    /**
    * Instantiate all fields on Part_Sale_Metric__c - retaining existing values and Setting null values to 0.
    * @param {Part_Sale_Metric__c} - metric to be reset to 0 
    * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
    */
    private static Part_Sale_Metric__c cleanMetric(Part_Sale_Metric__c partMetric) {

        //Current Year: 
        partMetric.CY_January__c    = partMetric.CY_January__c   != null ? partMetric.CY_January__c   : 0;
        partMetric.CY_February__c   = partMetric.CY_February__c  != null ? partMetric.CY_February__c  : 0;
        partMetric.CY_March__c      = partMetric.CY_March__c     != null ? partMetric.CY_March__c     : 0;
        partMetric.CY_April__c      = partMetric.CY_April__c     != null ? partMetric.CY_April__c     : 0;
        partMetric.CY_May__c        = partMetric.CY_May__c       != null ? partMetric.CY_May__c       : 0;
        partMetric.CY_June__c       = partMetric.CY_June__c      != null ? partMetric.CY_June__c      : 0;
        partMetric.CY_July__c       = partMetric.CY_July__c      != null ? partMetric.CY_July__c      : 0;
        partMetric.CY_August__c     = partMetric.CY_August__c    != null ? partMetric.CY_August__c    : 0;
        partMetric.CY_September__c  = partMetric.CY_September__c != null ? partMetric.CY_September__c : 0;
        partMetric.CY_October__c    = partMetric.CY_October__c   != null ? partMetric.CY_October__c   : 0;
        partMetric.CY_November__c   = partMetric.CY_November__c  != null ? partMetric.CY_November__c  : 0;
        partMetric.CY_December__c   = partMetric.CY_December__c  != null ? partMetric.CY_December__c  : 0;
        //Previous Year:
        partMetric.PY_January__c    = partMetric.PY_January__c   != null ? partMetric.PY_January__c   : 0;
        partMetric.PY_February__c   = partMetric.PY_February__c  != null ? partMetric.PY_February__c  : 0;
        partMetric.PY_March__c      = partMetric.PY_March__c     != null ? partMetric.PY_March__c     : 0;
        partMetric.PY_April__c      = partMetric.PY_April__c     != null ? partMetric.PY_April__c     : 0;
        partMetric.PY_May__c        = partMetric.PY_May__c       != null ? partMetric.PY_May__c       : 0;
        partMetric.PY_June__c       = partMetric.PY_June__c      != null ? partMetric.PY_June__c      : 0;
        partMetric.PY_July__c       = partMetric.PY_July__c      != null ? partMetric.PY_July__c      : 0;
        partMetric.PY_August__c     = partMetric.PY_August__c    != null ? partMetric.PY_August__c    : 0;
        partMetric.PY_September__c  = partMetric.PY_September__c != null ? partMetric.PY_September__c : 0;
        partMetric.PY_October__c    = partMetric.PY_October__c   != null ? partMetric.PY_October__c   : 0;
        partMetric.PY_November__c   = partMetric.PY_November__c  != null ? partMetric.PY_November__c  : 0;
        partMetric.PY_December__c   = partMetric.PY_December__c  != null ? partMetric.PY_December__c  : 0;
        //Days 30, 60, 90, 120
        partMetric.Last_30__c = partMetric.Last_30__c != null ? partMetric.Last_30__c : 0;
        partMetric.Last_60__c = partMetric.Last_60__c != null ? partMetric.Last_60__c : 0;
        partMetric.Last_90__c = partMetric.Last_90__c != null ? partMetric.Last_90__c : 0;
        partMetric.Last_120__c = partMetric.Last_120__c != null ? partMetric.Last_120__c : 0;

        return partMetric;
    }

    /**
    * Sets all changed fields to new values
    * @param {ID} - part to be updated in metric
    * @param {Map<Id, Map<Integer, Integer>>} - Map of sale data to update metric
    * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
    */
    private static Part_Sale_Metric__c cleanMetric(Id partId, Map < Id, Map < Integer, Integer > > unitSaleTotalMap) {

        Part_Sale_Metric__c partMetric = new Part_Sale_Metric__c();
        //Current Year:
        partMetric.CY_January__c   = unitSaleTotalMap.get(partId).get(1)  != null ? unitSaleTotalMap.get(partId).get(1)  : 0;
        partMetric.CY_February__c  = unitSaleTotalMap.get(partId).get(2)  != null ? unitSaleTotalMap.get(partId).get(2)  : 0;
        partMetric.CY_March__c     = unitSaleTotalMap.get(partId).get(3)  != null ? unitSaleTotalMap.get(partId).get(3)  : 0;
        partMetric.CY_April__c     = unitSaleTotalMap.get(partId).get(4)  != null ? unitSaleTotalMap.get(partId).get(4)  : 0;
        partMetric.CY_May__c       = unitSaleTotalMap.get(partId).get(5)  != null ? unitSaleTotalMap.get(partId).get(5)  : 0;
        partMetric.CY_June__c      = unitSaleTotalMap.get(partId).get(6)  != null ? unitSaleTotalMap.get(partId).get(6)  : 0;
        partMetric.CY_July__c      = unitSaleTotalMap.get(partId).get(7)  != null ? unitSaleTotalMap.get(partId).get(7)  : 0;
        partMetric.CY_August__c    = unitSaleTotalMap.get(partId).get(8)  != null ? unitSaleTotalMap.get(partId).get(8)  : 0;
        partMetric.CY_September__c = unitSaleTotalMap.get(partId).get(9)  != null ? unitSaleTotalMap.get(partId).get(9)  : 0;
        partMetric.CY_October__c   = unitSaleTotalMap.get(partId).get(10) != null ? unitSaleTotalMap.get(partId).get(10) : 0;
        partMetric.CY_November__c  = unitSaleTotalMap.get(partId).get(11) != null ? unitSaleTotalMap.get(partId).get(11) : 0;
        partMetric.CY_December__c  = unitSaleTotalMap.get(partId).get(12) != null ? unitSaleTotalMap.get(partId).get(12) : 0;
         //Previous Year:
        partMetric.PY_January__c   = unitSaleTotalMap.get(partId).get(-1)  != null ? unitSaleTotalMap.get(partId).get(-1)  : 0;
        partMetric.PY_February__c  = unitSaleTotalMap.get(partId).get(-2)  != null ? unitSaleTotalMap.get(partId).get(-2)  : 0;
        partMetric.PY_March__c     = unitSaleTotalMap.get(partId).get(-3)  != null ? unitSaleTotalMap.get(partId).get(-3)  : 0;
        partMetric.PY_April__c     = unitSaleTotalMap.get(partId).get(-4)  != null ? unitSaleTotalMap.get(partId).get(-4)  : 0;
        partMetric.PY_May__c       = unitSaleTotalMap.get(partId).get(-5)  != null ? unitSaleTotalMap.get(partId).get(-5)  : 0;
        partMetric.PY_June__c      = unitSaleTotalMap.get(partId).get(-6)  != null ? unitSaleTotalMap.get(partId).get(-6)  : 0;
        partMetric.PY_July__c      = unitSaleTotalMap.get(partId).get(-7)  != null ? unitSaleTotalMap.get(partId).get(-7)  : 0;
        partMetric.PY_August__c    = unitSaleTotalMap.get(partId).get(-8)  != null ? unitSaleTotalMap.get(partId).get(-8)  : 0;
        partMetric.PY_September__c = unitSaleTotalMap.get(partId).get(-9)  != null ? unitSaleTotalMap.get(partId).get(-9)  : 0;
        partMetric.PY_October__c   = unitSaleTotalMap.get(partId).get(-10) != null ? unitSaleTotalMap.get(partId).get(-10) : 0;
        partMetric.PY_November__c  = unitSaleTotalMap.get(partId).get(-11) != null ? unitSaleTotalMap.get(partId).get(-11) : 0;
        partMetric.PY_December__c  = unitSaleTotalMap.get(partId).get(-12) != null ? unitSaleTotalMap.get(partId).get(-12) : 0;
        //Days 30, 60, 90, 120
        partMetric.Last_30__c = unitSaleTotalMap.get(partId).get(30) != null ? unitSaleTotalMap.get(partId).get(30)    : 0;
        partMetric.Last_60__c = unitSaleTotalMap.get(partId).get(60) != null ? unitSaleTotalMap.get(partId).get(60)    : 0;
        partMetric.Last_90__c = unitSaleTotalMap.get(partId).get(90) != null ? unitSaleTotalMap.get(partId).get(90)    : 0;
        partMetric.Last_120__c = unitSaleTotalMap.get(partId).get(120) != null ? unitSaleTotalMap.get(partId).get(120) : 0;

        return partMetric;
    }

    /**
     * Handles finding the month of the part sale
     * @param {DateTime} - date to be processed
     * @returns {Integer} - Numeric value of month
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
     */
    private static Integer getSaleMonth(DateTime partSaleDate) {
        DateTime today = system.Now();
        Integer offset = UserInfo.getTimezone().getOffset(today);
        partSaleDate = partSaleDate.addSeconds(-offset / 500);
        if (partSaleDate.year() == today.year()) {
            return partSaleDate.month();

        } else if (partSaleDate.year() == today.year() - 1) {
            return -partSaleDate.month();
        } else {
            return 0;
        }
    }

    /**
     * Checks if part was sold in last 30 days
     * @param {DateTime} - date to be processed
     * @returns {Boolean} - True if sale was made in last 30 days
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
     */
    private static Boolean isLast30(DateTime partSaleDate) {
        DateTime today = System.Now();
        DateTime last30 = today.addDays(-30);
        return (partSaleDate >= last30 && partSaleDate <= today) ? true : false;
    }

    /**
     * Checks if part was sold in last 60 days
     * @param {DateTime} - date to be processed
     * @returns {Boolean} - True if sale was made in last 60 days
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
     */
    private static Boolean isLast60(DateTime partSaleDate) {
        DateTime today = System.Now();
        DateTime last60 = today.addDays(-60);
        return (partSaleDate >= last60 && partSaleDate <= today) ? true : false;
    }

    /**
     * Checks if part was sold in last 90 days
     * @param {DateTime} - date to be processed
     * @returns {Boolean} - True if sale was made in last 90 days
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
     */
    private static Boolean isLast90(DateTime partSaleDate) {
        DateTime today = System.Now();
        DateTime last90 = today.addDays(-90);
        return (partSaleDate >= last90 && partSaleDate <= today) ? true : false;
    }

    /**
     * Checks if part was sold in last 120 days
     * @param {DateTime} - date to be processed
     * @returns {Boolean} - True if sale was made in last 120 days
     * @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable
     */
    private static Boolean isLast120(DateTime partSaleDate) {
        DateTime today = System.Now();
        DateTime last120 = today.addDays(-120);
        return (partSaleDate >= last120 && partSaleDate <= today) ? true : false;
    }

    /**
     *  subLedgerDML
     *  @note Abstraction of the DML operations for subledger data manipulation.
     *        This routine will ensure that all subledger activity is controlled by 
     *        a single routine respecting feature enablement. 
     */
    public static void subLedgerDML(List<Parts_Ledger__c> subLedgerRecords, String DMLoperation)
    {
        String invControl = PartInventoryControl.inventoryControlMethod();
        Boolean isEnabled = Utility.isDMSFeatureEnabled('PartSubLedger') ;

        if(!isEnabled || invControl == 'External'){
            return;
        }

        try {
            switch on DMLoperation {
               when 'INSERT' {
                   insert subLedgerRecords;
               }
               when 'UPDATE' {
                   update subLedgerRecords;
               }
               when 'UPSERT' {
                   upsert subLedgerRecords;
               }
               when 'DELETE' {
                   delete subLedgerRecords;
               }
               when else {
                   throw new PartAPIException('Invalid DML Operation request');
               }
            }
        } Catch(Exception e) {
            throw new PartAPIException(e.getMessage());
        }
    }

    public static Parts_Kit__c getPartsKit(Id pkId){
        return (Parts_Kit__c)Utility.queryAllFields('dealer__Parts_Kit__c', pkId);
    }
    
    /**
    * updateLedger handles DML when changes to on hand are requested
    * @param  partHistory   List<Part_Inventory_History__c> list of history records with quantity and cost info
    * @param  partsToUpdate List<Parts_Inventory__c> affected parts to change on hand quantities
    * @param  emailLedger   Boolean if true this will attempt to send a GL email
     */
    public static void updateLedger(List<Part_Inventory_History__c> partHistory, List<Parts_Inventory__c> partsToUpdate,Boolean emailLedger)
    {

        SavePoint sp = Database.setSavePoint();

        Set<Id> partIds = new Set<Id>();
        Set<Id> glParts = new Set<Id>();
        Decimal glValue = 0;
        String reason = partHistory[0].Event_Notes__c;
        List<Parts_Ledger__c> pLedger = new List<Parts_Ledger__c>();
        List<Parts_Ledger__c> pLedgerUpdate = new List<Parts_Ledger__c>();
        List<Part_Inventory_History__c> historyUpdate = new List<Part_Inventory_History__c>();
        List<Part_Inventory_History__c> historyReductions = new List<Part_Inventory_History__c>();
        Integer maxReduction = 0;
        //Iterating through list we will create any positive ledgers and collect Ids and difference for reductions
        for(Part_Inventory_History__c h : partHistory){
            if(h.Quantity_Adjustment__c > 0){
                Decimal costAdjustment = 0;
                for(Integer i = 0; i <  h.Quantity_Adjustment__c; i++){
                    pLedger.add(new dealer__Parts_Ledger__c(
                                    Part__c = h.Part__c,
                                    Entry_Date__c = Date.today(),
                                    Quantity__c = 1,
                                    Item_Value__c = h.Cost__c,
                                    Reason_for_Change__c = h.Event_Notes__c,
                                    Transaction_Note__c = 'Manual On Hand Adjustment;'
                                )
                    );
                    costAdjustment += h.Cost__c;
                }
                h.Cost__c = costAdjustment;
                
                historyUpdate.add(h);
            }
            if(h.Quantity_Adjustment__c < 0){
                //Get the largest reduction - negative number will be converted to positive prior to SOQL
                maxReduction = h.Quantity_Adjustment__c < maxReduction ? (Integer)h.Quantity_Adjustment__c : maxReduction;
                partIds.add(h.Part__c);
                historyReductions.add(h);
            }
        }

        maxReduction = maxReduction * -1;
        //Currently only supports FIFO - Need to Implement LIFO
        if(partIds.size() > 0){
            Map<Id, Parts_Inventory__c> parts = new Map<Id, Parts_Inventory__c>([SELECT Id, (SELECT Id, Item_Value__c, Transaction_Note__c, Reason_for_Change__c FROM Parts_Ledgers__r WHERE Quantity__c = 1 ORDER BY CreatedDate ASC LIMIT :maxReduction) FROM Parts_Inventory__c WHERE Id =: partIds]);

            for(Part_Inventory_History__c h : historyReductions){
                Decimal adjustmentValue = 0;
                if(parts.get(h.Part__c) != null && parts.get(h.Part__c).Parts_Ledgers__r != null){
                    for(Integer i = 0; i > h.Quantity_Adjustment__c; i--){
                        if(parts.get(h.Part__c).Parts_Ledgers__r.size() > (i*-1)){
                            Parts_Ledger__c pl = parts.get(h.Part__c).Parts_Ledgers__r[i*-1];
                            //Handle updating transaction note
                            if(pl.Transaction_Note__c!=null) { 
                                pl.Transaction_Note__c =  (pl.Transaction_Note__c.right(1)!=';') ? pl.Transaction_Note__c +';Manual On Hand Adjustment;' : pl.Transaction_Note__c +'Manual On Hand Adjustment;';
                            }
                            else{ 
                                pl.Transaction_Note__c='Manual On Hand Adjustment;'; 
                            }
                            adjustmentValue -= pl.dealer__Item_Value__c; // Updated to recognize decrease
                            pl.dealer__Reason_for_Change__c=h.Event_Notes__c;
                            pl.dealer__Quantity__c = 0;
                            pLedgerUpdate.add(pl);
                        }
                    }
                }
                h.Cost__c = adjustmentValue;
                historyUpdate.add(h);
            }

        }

        pLedgerUpdate.addAll(pLedger);

        try {
            if(historyUpdate.size() > 0){
                for(Part_Inventory_History__c h : historyUpdate){
                    glValue += h.Cost__c;
                }
                insert historyUpdate;
            }
        } Catch(Exception e){
            database.rollback(sp);        
            throw new PartAPIException('Error create Part Inventory History records: ' + e.getMessage());
        }
        try{
            if(partsToUpdate.size() > 0){
                for(Parts_Inventory__c p : partsToUpdate){
                    glParts.add(p.Id);
                }
                update partsToUpdate;
            }
        } Catch(Exception e) {
            database.rollback(sp);        
            throw new PartAPIException('Error create Part Inventory History records: ' + e.getMessage());
        }
        try{
            if(pLedgerUpdate.size() > 0){
                upsert pLedgerUpdate;
            }
        } Catch(Exception e){
            database.rollback(sp);        
            throw new PartAPIException('Error updating Part Ledgers: ' + e.getMessage());
        }
        try{
            if(emailLedger == true){
                sendNotifications(glParts, glValue, reason);
            }
        } Catch(Exception e){
            database.rollback(sp);
            throw new PartAPIException(e.getMessage());
        }
        

    }

    /**
    * sendNotifications handles sending email with updated GL info
    * @param  records Set<Id> the part_inventory__c ids that were updated
    * @param  adjustmentValue Decimal total value of the transaction
     */
    private static void sendNotifications(Set<Id> records, Decimal adjustmentValue, String reasonForChange)
    { 
        // Get Custom Setting for Purchase Order Events (Fixed Ops Hierarchy Setting)
        dealer__FixedOperationsSettings__c fops = dealer__FixedOperationsSettings__c.getOrgDefaults();         
        if(fops.dealer__PurchaseOrderPartsReceiptAddress__c!=null) {
            // Check Validity of email handle
            if(!Utility.emailValid(fops.dealer__PurchaseOrderPartsReceiptAddress__c)) {
                throw new PartAPIException('Error: Third Party Accounting Integration Email Handle Invalid ('+fops.dealer__PurchaseOrderPartsReceiptAddress__c+')');
            }
            String action;
            String recordString = '';
            if(records.size() == 1){
                List<Id> idList = new List<Id>();
                idList.addAll(records);
                recordString = string.valueOf(idList[0]);
                action = 'parts_quantity_adjustment';
            }
            else{
                for(Id record : records){
                    String rId;
                    if(recordString.length() == 0){
                        recordString = record;
                    }
                    else{
                        rId = ',' + record;
                        recordString = recordString + rId;
                    }

                }
                // recordString = string.valueOf(records);
                recordString = recordString.replace('{', '');
                recordString = recordString.replace('}', '');
                action = 'parts_bulk_quantity_adjustment';
            }
            // Prepare Message
            String message = '{ "recordId" : "'+recordString+'", "comments" : " ' + reasonForChange + '", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "' + action + '", "partsReceiptValue" : "' + adjustmentValue + '" }';
            system.debug(message);
            try {

                Cashier.emailAsyncHandler(message); 
            } catch(Exception e) {
                throw new PartAPIException('Error: Unable to post inventory adjustment to the Third Party General Ledger');                
            }
            
        } 
    }

    global class PartAPIException extends Exception {}
}