global with sharing class VINDecoder_DataOneSoftware {
    
    /*
        Request Defenition Object for JSON VIN Decode requests
    */
    global class DecodeRequestStruct {
        global DecoderSettings decoder_settings = new DecoderSettings();
        global QueryRequests query_requests = new QueryRequests();
    }
    
    /*
        Response Defenition Object JSON data response
    */
    global class DecodeResponseStruct {
        global DecoderMessages decoder_messages = new DecoderMessages();
        global QueryResponses query_responses = new QueryResponses();
    }
    
    ////////////////////////////////////////////
    //  
    //      JSON Response Obects 
    //
    ////////////////////////////////////////////
    global class DecoderMessages {
        global String service_provider {get;set;}
        global String decoder_version {get;set;}
        global String decoder_errors {get;set;}
        global List<String> decoder_error_list {get;set;}
    }
    
    global class QueryResponses {
        global ResponseData unique_request = new ResponseData();
    }
    
    global class ResponseData {
        global String transaction_id {get;set;}
        global QueryError query_error {get;set;}
        global StyleData[] styles {get;set;}
        global CommonData common_data {get;set;}

        global ResponseData() {
            if(styles==null) {
                styles = new List<StyleData>();
            }
            if(common_data==null) {
                common_data=new CommonData();
            }
        }
    }
    
    global class QueryError {
        global String error_code {get;set;}
        global String error_message {get;set;}
    }
    
    /* Bulk of response data inlcuded in this class */
    global class CommonData {
        global BasicData basic_data {get;set;}
        global Pricing pricing {get;set;}
        global EngineList[] engines {get;set;}
        global TransmissionList[] transmissions {get;set;}
        global WarrantyList[] warranties {get;set;}
        global EPAFuelEfficiencyList[] epa_fuel_efficiency {get;set;}
        global OptionalEquipmentList[] optional_equipment {get;set;}
        global InstalledEquipmentList[] installed_equipment {get;set;}
    }
    
    global class StyleData {
        global String name {get;set;}
        global String vehicle_id {get;set;}
        global String complete {get;set;}
        global BasicData basic_data {get;set;}
        global Pricing pricing {get;set;}
        global EngineList[] engines {get;set;}
        global TransmissionList[] transmissions {get;set;}
        global WarrantyList[] warranties {get;set;}
        global EPAFuelEfficiencyList[] epa_fuel_efficiency {get;set;}
        global OptionalEquipmentList[] optional_equipment {get;set;}
        global InstalledEquipmentList[] installed_equipment {get;set;}
        global ColorData colors {get;set;}

        global StyleData() {
            if(engines==null) { engines=new List<EngineList>(); }
            if(transmissions==null) { transmissions=new List<TransmissionList>(); }
            if(warranties==null) { warranties=new List<WarrantyList>(); } 
            if(epa_fuel_efficiency==null) { epa_fuel_efficiency=new List<EPAFuelEfficiencyList>(); }
            if(optional_equipment==null) { optional_equipment=new List<OptionalEquipmentList>(); }
            if(installed_equipment==null) { installed_equipment=new List<InstalledEquipmentList>(); }
            if(colors==null) { colors=new ColorData(); }
        }
    }
    
    global class BasicData {
        global String market {get;set{market=String.valueOf(value);}}
        global Integer year {get;set;}
        global String make {get;set{make=String.valueOf(value);}}
        global String model {get;set{model=String.valueOf(value);}}
        global String trim {get;set;}
        global String vehicle_type {get;set{vehicle_type=String.valueOf(value);}}
        global String body_type {get;set;}
        global String body_subtype {get;set;}
        global Integer doors {get;set;}
        global String model_number {get;set;}
        global String package_code {get;set;}
        global String drive_type {get;set;}
        global String brake_system {get;set;}
        global String restraint_type {get;set;}
        global String country_of_manufacture {get;set;}
        global String plant {get;set;}
    }
    
    global class Pricing {
        global String msrp {get;set;}
        global String invoice_price {get;set;}
        global String destination_charge {get;set;}
        global String gas_guzzler_tax {get;set;}
    }
    
    global class EngineList {
        global String name {get;set;}
        global String brand {get;set;}
        global String engine_id {get;set;}
        global String availability {get;set;}
        global String aspiration {get;set;}
        global String block_type {get;set;}
        global String bore {get;set;}
        global String cam_type {get;set;}
        global String compression {get;set;}
        global String cylinders {get;set;}
        global String displacement {get;set;}
        global String fuel_induction {get;set;}
        global String fuel_quality {get;set;}
        global String fuel_type {get;set;}
        global String msrp {get;set;}
        global String invoice_price {get;set;}
        global String marketing_name {get;set;}
        global String max_hp {get;set;}
        global String max_hp_at {get;set;}
        global String max_payload {get;set;}
        global String max_torque {get;set;}
        global String max_torque_at {get;set;}
        global String oil_capacity {get;set;}
        global String order_code {get;set;}
        global String redline {get;set;}
        global String stroke {get;set;}
        global String valve_timing {get;set;}
        global String valves {get;set;} 
    }
    
    global class TransmissionList {
        global String name {get;set;}
        global String brand {get;set;}
        global String msrp {get;set;}
        global String transmission_id {get;set;}
        global String availability {get;set;}
        global String item_type {get;set;}
        global String detail_type {get;set;}
        global String gears {get;set;}
        global String invoice_price {get;set;}
        global String order_code {get;set;}
    }
    
    
    global class WarrantyList {
        global String name {get;set;}
        global String item_type {get;set;}
        global String months {get;set;}
        global String miles {get;set;}
    }
    
    global class EPAFuelEfficiencyList {
        global String engine_id {get;set;}
        global String transmission_id {get;set;}
        global String fuel_type {get;set;}
        global String fuel_grade {get;set;}
        global String city {get;set;}
        global String highway {get;set;}
        global String combined {get;set;}
    }
    
    global class OptionalEquipmentList {
        global String category {get;set;}
        global List<OptionalEquipmentDetails> options {get;set;}
    }
    
    global class OptionalEquipmentDetails {
        global String name {get;set;}
        global String option_id {get;set;}
        global String order_code {get;set;}
        global String installed {get;set;}
        global String install_type {get;set;}
        global String invoice_price {get;set;}
        global String msrp {get;set;}
        global String description {get;set;}
    }
    
    global class InstalledEquipmentList {
        global String category {get;set;}
        global List<InstalledEquipmentDetails> equipment {get;set;}
    }
    
    global class InstalledEquipmentDetails {
        global String name {get;set;}
        global List<String> values {
                get;
                set;
                //set{                 
                //    List<String> retVals = new List<String>();
                //    for(String s : values) {
                //        retVals.add(String.valueOf(s));
                //    }
                //    values = retVals;
                //}
        }
    }

    global class ColorData {
        global List<ExteriorColors> exterior_colors {get;set;}
        global List<InteriorColors> interior_colors {get;set;}
        global List<RoofColors> roof_colors {get;set;}

        global ColorData() {
            if(exterior_colors==null) { exterior_colors = new List<ExteriorColors>(); }
            if(interior_colors==null) { interior_colors = new List<InteriorColors>(); }
            if(roof_colors==null) { roof_colors = new List<Roofcolors>(); }
        }
    }   

    global class ExteriorColors {
        global String mfr_code {get;set;}
        global String two_tone {get;set;}
        global String generic_color_name {get;set;}
        global String mfr_color_name {get;set;}
        global RGB primary_rgb_code {get;set;}
        global RGB secondary_rgb_code {get;set;}
    }

    global class InteriorColors {
        global String mfr_code {get;set;}
        global String two_tone {get;set;}
        global String generic_color_name {get;set;}
        global String mfr_color_name {get;set;}
        global RGB primary_rgb_code {get;set;}
        global RGB secondary_rgb_code {get;set;}
    }

    global class RoofColors {
    }    

    global class RGB {
        global String r {get;set;}
        global String g {get;set;}
        global String b {get;set;}
        global String hex {get;set;}
    }
    
    ////////////////////////////////////////////
    //  
    //      JSON Request Obects 
    //
    ////////////////////////////////////////////
    global class QueryRequests {
        global RequestData unique_request = new RequestData(); 
    }
    
    global class RequestData {
        global String vin {get;set;}
        global String year {get;set;}
        global String make {get;set;}
        global String model {get;set;}
        global String trim {get;set;}
        global String model_number {get;set;}
        global String package_code {get;set;}
        global String drive_type {get;set;}
        global String vehicle_type {get;set;}
        global String body_type {get;set;}
        global String doors {get;set;}
        global String bedlength {get;set;}
        global String wheelbase {get;set;}
        global String msrp {get;set;}
        global String invoice {get;set;}
        global EngineParameters engine = new EngineParameters();
        global TransmissionParameters transmission = new TransmissionParameters();
        global String optional_equipment_codes {get;set;}
        global String installed_equipment_descriptions {get;set;}
        global IntColor interior_color = new IntColor();
        global ExtColor exterior_color = new ExtColor();
    }
    
    global class EngineParameters {
        global String description {get;set;}
        global String block_type {get;set;}
        global String cylinders {get;set;}
        global String displacement {get;set;}
        global String fuel_type {get;set;}
    }
    
    global class TransmissionParameters {
        global String description {get;set;}
        global String trans_type {get;set;}
        global String trans_speeds {get;set;}
    }
    
    global class IntColor {
        global String description {get;set;}
        global String color_code {get;set;}
    }
    
    global class ExtColor {
        global String description {get;set;}
        global String color_code {get;set;}     
    }
    
    global class DecoderSettings {
        global String display {get;set;}
        global String styles {get;set;}
        global StylePacks style_data_packs = new StylePacks();
        global String common_data {get;set;}
        global CommonPacks common_data_packs = new CommonPacks();
    }
    
    global class StylePacks {
        global String basic_data {get;set;}
        global String pricing {get;set;}
        global String engines {get;set;}
        global String transmissions {get;set;}
        global String specifications {get;set;}
        global String installed_equipment {get;set;}
        global String optional_equipment {get;set;}
        global String colors {get;set;}
        global String safety_equipment {get;set;}
        global String warranties {get;set;}
        global String fuel_efficiency {get;set;}
    }
    
    global class CommonPacks {
        global String basic_data {get;set;}
        global String pricing {get;set;}
        global String engines {get;set;}
        global String transmissions {get;set;}
        global String specifications {get;set;}
        global String installed_equipment {get;set;}
        global String optional_equipment {get;set;}
        global String colors {get;set;}
        global String safety_equipment {get;set;}
        global String warranties {get;set;}
        global String fuel_efficiency {get;set;}
    }
    
    global Map<String, String> errorCodes = new Map<String, String>{
        'AF'=>'Authentication failed.',
        'IP'=>'Your IP address cannot access the service at this time.  Please contact DealerTeam.com.',
        'SP'=>'Access denied. Service is suspended.',
        'ET'=>'Access denied. Trial ended',
        'ED'=>'Access denied. Maximum decodes has been reached for your trial.',
        'ES'=>'Access denied. Maximum number of returned styles has been reached for your trial.',
        'IN'=>'Your account is awaiting approval by our sales team.',
        'NS'=>'Access denied. Trial not started',
        'MD'=>'Access denied. Maximum number of decodes exceeded for this request.',
        'MS'=>'Access denied. Maximum number of returned styles exceeded for this request.',
        'IQ'=>'Query must be properly formatted JSON or XML',
        'RI'=>'The "styles", "common, or "data_group" data is not available for display.',
        'VD'=>'VIN-less decode does not meet the minimum field requirements: year, make, and model OR VIN-less decoding has not been enabled for your account.',
        'AT'=>'This VIN could not be decoded. It appears to be an ATV.',
        'OM'=>'This VIN could not be decoded. It appears to be an Out Of Market vehicle',
        'CA'=>'This VIN could not be decoded. It appears to be a Canadian vehicle.',
        'CH'=>'This VIN could not be decoded. It appears to be a Chassis vehicle.',
        'EU'=>'This VIN could not be decoded. It appears to be a European vehicle.',
        'FL'=>'This VIN could not be decoded. It appears to be a Fleet vehicle.',
        'GM'=>'This VIN could not be decoded. It appears to be a Grey Market vehicle.',
        'HV'=>'This VIN could not be decoded. It appears to be a Heavy-duty vehicle.',
        'IV'=>'This VIN could not be decoded. Invalid VIN, Engine Code, Plant Digit, Restraint Digit, VDS or WMI',
        'VF'=>'VIN contained invalid characters, but was able to be fixed for decoding.',
        'MD'=>'This VIN could not be decoded. It appears to be a Mid-duty vehicle.',
        'MO'=>'This VIN could not be decoded. It appears to be a Motorcycle.',
        'MM'=>'This VIN could not be decoded. It appears to be a Motorcycle that is Out Of Market.',
        'MY'=>'This VIN could not be decoded. It appears to be a Motorcycle that is out of the model year range.',
        'PR'=>'This VIN could not be decoded. It appears to be a pre-1981 vehicle.',
        'RV'=>'This VIN could not be decoded. It appears to be a Recreational vehicle.',
        'TR'=>'This VIN could not be decoded. It appears to be a Trailer.',
        'IV'=>'Invalid VIN: Failed Checksum'
    };
}