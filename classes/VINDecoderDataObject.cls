public with sharing class VINDecoderDataObject {
//serialize response from Middleware hosted on Hemi
    public class DecodeData{
        public String transaction_id {get;set;}
        public Error error {get;set;}
        public CommonData common_data {get;set;}
        public Style[] styles {get;set;}

        public DecodeData() {
            styles = styles == null ? new List<Style>() :styles;
        }
    }

    public class Error{
        public String error_code  {get;set;}
        public String error_message {get;set;}
    }

    public class CommonData{
        public String market {get;set;}
        public String year {get;set;}
        public String make {get;set;}
        public String model {get;set;}
        public String trim {get;set;}
        public String vehicle_type {get;set;}
        public String body_type {get;set;}
        public String body_subtype {get;set;}
        public String doors {get;set;}
        public String model_number {get;set;}
        public String package_code {get;set;}
        public String drive_type {get;set;}
        public String brake_system {get;set;}
        public String restraint_type {get;set;}
        public String country_of_manufacture {get;set;}
        public String plant {get;set;}
    }

    public class Style{
        public String name {get;set;}
        public String vehicle_id {get;set;}
        public String complete {get;set;}
        public CommonData basic_data {get;set;}
        public Pricing pricing {get;set;}
        public List<Engine> engines {get;set;}
        public List<Transmission> transmissions {get;set;}
        public List<InstalledEquipment> installed_equipment {get;set;}
        public List<OptionalEquipment> optional_equipment {get;set;}
        public List<FuelEfficiency> epa_fuel_efficiency {get;set;}
        // TO ADD?
        // public WarrantyList[] warranties {get;set;}
        // public EPAFuelEfficiencyList[] epa_fuel_efficiency {get;set;}
        // public OptionalEquipmentList[] optional_equipment {get;set;}
        // public InstalledEquipmentList[] installed_equipment {get;set;}
        // public ColorData colors {get;set;}
    }

    public class Pricing{
        public Decimal msrp {get;set;}
        public Decimal invoice_price {get;set;}
        public Decimal destination_charge {get;set;}
        public Decimal gas_guzzler_tax {get;set;}
    }

    public class Engine{
        public String name {get;set;}
        public String brand {get;set;}
        public String engine_id {get;set;}
        public String availability {get;set;}
        public String aspiration {get;set;}
        public String block_type {get;set;}
        public String bore {get;set;}
        public String cam_type {get;set;}
        public String compression {get;set;}
        public String cylinders {get;set;}
        public String displacement {get;set;}
        public String fuel_induction {get;set;}
        public String fuel_quality {get;set;}
        public String fuel_type {get;set;}
        public String msrp {get;set;}
        public String invoice_price {get;set;}
        public String marketing_name {get;set;}
        public String max_hp {get;set;}
        public String max_hp_at {get;set;}
        public String max_payload {get;set;}
        public String max_torque {get;set;}
        public String max_torque_at {get;set;}
        public String oil_capacity {get;set;}
        public String order_code {get;set;}
        public String redline {get;set;}
        public String stroke {get;set;}
        public String valve_timing {get;set;}
        public String valves {get;set;} 
    }

    public class Transmission{
        public String name {get;set;}
        public String brand {get;set;}
        public String msrp {get;set;}
        public String transmission_id {get;set;}
        public String availability {get;set;}
        public String type {get;set;}
        public String detail_type {get;set;}
        public String gears {get;set;}
        public String invoice_price {get;set;}
        public String order_code {get;set;}
    }

    public class InstalledEquipment {
        public String category {get;set;}
        public List<InstalledEquipmentDetails> equipment {get;set;}
    }
    
    public class InstalledEquipmentDetails {
        public String name {get;set;}
        public List<String> values {get;set;}
    }

    public class OptionalEquipment {
        public String category {get;set;}
        public List<OptionalEquipmentDetails> options {get;set;}
    }
    
    public class OptionalEquipmentDetails {
        public String name {get;set;}
        public String option_id {get;set;}
        public String order_code {get;set;}
        public String installed {get;set;}
        public String install_type {get;set;}
        public String invoice_price {get;set;}
        public String msrp {get;set;}
        public String description {get;set;}
    }

    public class ColorData {
        public List<ExteriorColors> exterior_colors {get;set;}
        public List<InteriorColors> interior_colors {get;set;}
        public List<RoofColors> roof_colors {get;set;}

        public ColorData() {
            if(exterior_colors==null) { exterior_colors = new List<ExteriorColors>(); }
            if(interior_colors==null) { interior_colors = new List<InteriorColors>(); }
            if(roof_colors==null) { roof_colors = new List<Roofcolors>(); }
        }
    }   

    public class ExteriorColors {
        public String mfr_code {get;set;}
        public String two_tone {get;set;}
        public String generic_color_name {get;set;}
        public String mfr_color_name {get;set;}
        public RGB primary_rgb_code {get;set;}
        public RGB secondary_rgb_code {get;set;}
    }

    public class InteriorColors {
        public String mfr_code {get;set;}
        public String two_tone {get;set;}
        public String generic_color_name {get;set;}
        public String mfr_color_name {get;set;}
        public RGB primary_rgb_code {get;set;}
        public RGB secondary_rgb_code {get;set;}
    }

    public class RoofColors {
    }  

    public class FuelEfficiency {
        public String engine_id {get;set;}
        public String transmission_id {get;set;}
        public String fuel_type {get;set;}
        public String fuel_grade {get;set;}
        public Decimal city {get;set;}
        public Decimal highway {get;set;}
        public Decimal combined {get;set;}
    }

    public class RGB {
        public String r {get;set;}
        public String g {get;set;}
        public String b {get;set;}
        public String hex {get;set;}
    }
}