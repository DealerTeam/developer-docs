public with sharing class ADF {

    public inherited sharing class vehicle{
        public String interest {get;set;}
        public String status {get;set;}
        public adfId vehId {get;set;}
        public String year {get;set;}
        public String make {get;set;}
        public String model {get;set;}
        public String vin {get;set;}
        public String stock {get;set;}
        public String trim {get;set;}
        public String doors {get;set;}
        public String bodystyle {get;set;}
        public String transmission {get;set;}
        public String odometer {get;set;}
        public String odometerStatus {get;set;}
        public String odometerUnits {get;set;}
        public String condition {get;set;}
        public List<colorCombination> colors {get;set;}
        public String imageUrl {get;set;}
        public String imageW {get;set;}
        public String imageH {get;set;}
        public String imageAltText {get;set;}
        public price vPrice {get;set;}
        public String priceComments {get;set;}
        public List<option> options {get;set;}
        public String financeMethod {get;set;}
        public List<financeAmount> financeAmounts {get;set;}
        public List<balance> balances {get;set;}
        public String comments {get;set;}

        public vehicle(){

        }
    }

    public inherited sharing class customer{
        public adfContact con {get;set;}
        public adfId customerId {get;set;}
        public String timeDescription {get;set;}
        public String earliestDate {get;set;} //ISO-8601 YYYY-MM-DD format
        public String latestDate {get;set;}
        public String comments {get;set;}
        public String primary {get;set;}

        public customer(){

        }
    }

    public inherited sharing class vendor{
        public adfId vendorId {get;set;}
        public String name {get;set;}
        public String url {get;set;}
        public adfContact con {get;set;}
    }

    public inherited sharing class provider{
        public adfId providerId {get;set;}
        public adfContact providerName {get;set;} //just used for compound name, email, phone
        public String service {get;set;}
        public String url {get;set;}
        public adfContact contact {get;set;} //this is contact on the provider
    }

    public inherited sharing class adfContact{
        public String primary {get;set;}
        public String firstName {get;set;}
        public String lastName {get;set;}
        public String fullName {get;set;}
        public String type {get;set;}
        public List<phone> phones {get;set;}
        public address address {get;set;}
        public email email {get;set;}

        public adfContact(){

        }

    }

    public inherited sharing class address{
        public String street1 {get;set;}
        public String street2 {get;set;}
        public String apt {get;set;}
        public String city {get;set;}
        public String regionCode {get;set;} //State or province
        public String postalCode {get;set;}
        public String country {get;set;} //2-digit country code

        public address(){

        }
    }

    public inherited sharing class email{
        public String emailAddress {get;set;}
        public String preferred {get;set;}

        public email(){
            
        }
    }

    public inherited sharing class phone{
        public String type {get;set;}
        public String timeToCall {get;set;}
        public String preferred {get;set;} //1 or 0 
        public String phoneNumber {get;set;}
    }

    public inherited sharing class adfId{
        public Integer sequence {get;set;}
        public String source {get;set;}
        public String id {get;set;}
    }

    //Used within vehicle
    public inherited sharing class colorCombination{
        public String interiorColor {get;set;}
        public String exteriorColor {get;set;}
        public Integer preference {get;set;}
    }
    //Used within vehicle
    public inherited sharing class price{
        public String type {get;set;}
        public String currencyCode {get;set;}
        public String delta {get;set;}
        public String relativeTo {get;set;}
        public String source {get;set;}
        public String value {get;set;}

        public price(){

        }
    }
    //Used within vehicle
    public inherited sharing class option{
        public String name {get;set;}
        public String manufacturerCode {get;set;}
        public String stockNum {get;set;}
        public Integer weighting {get;set;}
        public price oPrice {get;set;}
    }
    //Used within vehicle
    public inherited sharing class financeAmount{
        public String type {get;set;}
        public String amountLimit {get;set;}
        public String currencyCode {get;set;}
        public String value {get;set;}

        public financeAmount(){

        }
    }
    //Used within vehicle
    public inherited sharing class balance{
        public String type {get;set;}
        public String currencyCode {get;set;}
        public Decimal value {get;set;}
    }

    public inherited sharing class ADFHeader{
        public List<vehicle> vehicles {get;set;}
        public List<customer> customers {get;set;}
        public vendor vendor {get;set;}
        public provider leadProvider {get;set;}
        public String toEmail {get;set;}
        public String fromEmail {get;set;}
    

        public ADFHeader() {
            List<vehicle> vehicles = new List<vehicle>();
            List<customer> customers = new List<customer>();
            vendor vendor = new vendor();
            provider leadProvider = new provider();
        }

        
    }

    public static ADFHeader createFromSUP(Sales_Up__c s){
            
            ADFHeader header = new ADFHeader();
            List<vehicle> vehicles = new List<vehicle>();
            List<customer> customers = new List<customer>();
            vendor vendor = new vendor();
            provider leadProvider = new provider();

            //Query all data needed for ADF
            Sales_Up__c sup = (Sales_Up__c)Utility.QueryAllFields('dealer__Sales_Up__c', s.Id);
            Vehicle_Inventory__c vi = sup.Desired_Stock_Num__c != null ? (Vehicle_Inventory__c)Utility.QueryAllFields('dealer__Vehicle_Inventory__c', sup.Desired_Stock_Num__c) : new Vehicle_Inventory__c();
            Dealer_Location__c loc = sup.Store_Location__c != null ? [SELECT Id, Name, Website__c FROM Dealer_Location__c WHERE Id =: sup.Store_Location__c] : new Dealer_Location__c();
            Contact con = sup.Buyer_Contact__c != null ? (Contact)Utility.QueryAllFields('Contact', sup.Buyer_Contact__c) : new Contact();

            Organization org = [SELECT Id, Name, Street, City, State, PostalCode, Country, PrimaryContact, Phone FROM Organization];

            //external id = source id

            if(vi.Id != null){
                vehicle v = new vehicle();
                v.interest = sup.Buy_or_Lease__c != null ? sup.Buy_or_Lease__c : '';
                v.status = vi.New_Used_Other__c != null ? vi.New_Used_Other__c : '';
                v.year = vi.Year__c != null ? vi.Year__c : '';
                v.make = vi.Make__c != null ? vi.Make__c : '';
                v.model = vi.Model__c != null ? vi.Model__c : '';
                v.vin = vi.Vin__c != null ? vi.Vin__c : '';
                v.stock = vi.Stock_Number__c != null ? vi.Stock_Number__c : '';
                v.trim = vi.Trim_Level__c != null ? vi.Trim_Level__c : '';
                v.doors = vi.Doors__c != null ? String.valueOf(vi.Doors__c) : '';
                v.bodystyle = vi.Body_Style__c != null ? vi.Body_Style__c : '';
                v.transmission = vi.Transmission_Shift_Type__c != null ? vi.Transmission_Shift_Type__c : '';
                v.odometer = vi.Mileage__c != null ? String.valueOf(vi.Mileage__c) : '';
                v.odometerStatus = vi.Odometer_Code__c != null ? vi.Odometer_Code__c : '';
                //v.odometerUnits
                v.condition = vi.New_Used_Other__c != null? vi.New_Used_Other__c : '';
                //v.colors
                //v.imageUrl
                //v.imageW
                //v.imageH
                //v.imageAltText
                if(vi.Coded_Cost__c != null){
                    price p = new price();
                    p.type = 'offer';
                    p.currencyCode = 'USD';
                    p.value = String.valueOf(vi.Coded_Cost__c);
                    v.vPrice = p;
                }
                //v.priceComments
                //v.options
                v.financeMethod = sup.Finance_Method__c != null ? sup.Finance_Method__c : '';
                List<financeAmount> finList = new List<financeAmount>();
                if(sup.Desired_Monthly_Payment__c != null){
                    financeAmount fin = new financeAmount();
                    fin.type = 'monthly';
                    fin.amountLimit = 'maximum';
                    fin.currencyCode = 'USD';
                    fin.value = String.valueOf(sup.Desired_Monthly_Payment__c);
                    finList.add(fin);
                }
                if(sup.Pre_qualified_Loan_Amount__c != null){
                    financeAmount fin = new financeAmount();
                    fin.type = 'total';
                    fin.amountLimit = 'maximum';
                    fin.currencyCode = 'USD';
                    fin.value = String.valueOf(sup.Pre_qualified_Loan_Amount__c);
                    finList.add(fin);
                }
                if(sup.Down_Payment__c != null){
                    financeAmount fin = new financeAmount();
                    fin.type = 'downpayment';
                    fin.amountLimit = 'maximum';
                    fin.currencyCode = 'USD';
                    fin.value = String.valueOf(sup.Down_Payment__c);
                    finList.add(fin);
                }
                v.financeAmounts = finList;
                vehicles.add(v);
            }
            customer cus = new customer();
            List<phone> phones = new List<phone>();
            if(con.Id != null){
                cus.con = new adfContact();
                cus.con.primary = '1';
                cus.con.firstName = con.firstName;
                cus.con.lastName = con.lastName;
                cus.con.type = 'individual'; //switch this to look for b2b
                if(con.Email != null){
                    email cusEmail = new email();
                    cusEmail.emailAddress = con.Email;
                    cus.con.email = cusEmail;
                }
                if(con.Phone != null){
                    phone p = new phone();
                    p.type = 'phone';
                    p.timeToCall = 'nopreference';
                    p.preferred = '1';
                    p.phoneNumber = con.Phone;
                    phones.add(p);
                }
                if(con.MobilePhone != null){
                    phone p = new phone();
                    p.type = 'cell';
                    p.timeToCall = 'nopreference';
                    p.preferred = '0';
                    p.phoneNumber = con.MobilePhone;
                    phones.add(p);
                }
                cus.con.phones = phones;
                if(con.MailingStreet != null){
                    ADF.address address = new ADF.address();
                    address.street1 = con.MailingStreet != null ? con.MailingStreet : '';
                    address.street2 = '';
                    address.city = con.MailingCity != null ? con.MailingCity : '';
                    address.regionCode = con.MailingState != null ? con.MailingState : '';
                    address.postalCode = con.MailingPostalCode != null ? con.MailingPostalCode : '';
                    address.country = con.MailingCountry != null ? con.MailingCountry : '';
                    cus.con.address = address;
                }
            }
                cus.timeDescription = sup.Timeframe__c != null ? sup.Timeframe__c : '';
                cus.comments = sup.Comments__c != null ? sup.Comments__c : '';
                customers.add(cus);
            if(loc.Id != null){
                //vendorId
                vendor.name = loc.Name;
                vendor.url = loc.Website__c != null ? loc.Website__c : '';
            }
            // leadProvider.providerId
            adfContact provCon = new adfContact();
            provCon.fullName = org.Name;
            email email = new email();
            email.emailAddress = 'help@dealerteam.com';
            provCon.email = email;

            phone provPhone = new phone();
            List<phone> provPhones = new List<phone>();
            provPhone.type = 'voice';
            provPhone.timeToCall = 'day';
            provPhone.phoneNumber = String.valueOf(org.Phone);
            provPhones.add(provPhone);
            provCon.phones = provPhones;

            address provAddress = new address();
            provAddress.street1 = org.Street;
            // provAddress.apt = '#203';
            provAddress.city = org.City;
            provAddress.regionCode = org.State;
            provAddress.postalCode = org.PostalCode;
            provAddress.country = org.Country;
            provCon.address = provAddress;

            leadProvider.providerName = provCon;
            leadProvider.service = sup.dealer__Source__c; //Now being used as the source
            leadProvider.url = 'https://www.dealerteam.com/';

            header.vehicles = vehicles;
            header.customers = customers;
            header.vendor = vendor;
            header.leadProvider = leadProvider;
            return header;

        }
}