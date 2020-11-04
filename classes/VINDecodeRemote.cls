/**
**Date              |Developer             |Work
**2016-07-11         Sneha                  T-00854
*
**Date              |Developer             |Case
**2016-07-11         Sneha                  C-00002224
* To decode VIN when common data is null, and take basic data from the array of styles.
* 
**/


global with sharing class VINDecodeRemote {

    global VINDecodeRemote() {}

    global String getdecodeResults() {
        String vin = ApexPages.currentPage().getParameters().get('vin');
        String callback = ApexPages.currentPage().getParameters().get('callback');
        if(vin=='' || vin ==null) {
            return '{ Error : \'VIN required as a page parameter\'}';
        }

        if(callback == '' || callback ==null) {
            return '{ Error : \'callback required as a page parameter\'}';
        }

        // Do the VIN Decode
        return callback+'('+JSON.serializePretty(decodedVin(vin))+')';
    }

    // Setup Vin Decoder remote Action.
    @RemoteAction
    global static Map<String,Object> decodedVin(String vin){

        List<String> trims = new List<String>();
        Map<String,Object> v = new Map<String,Object>();

        v.put('dealer__VIN__c', vin );

        if( String.valueOf( v.get('dealer__VIN__c') ).length()==17 ) {
            VINDecoder vd = new VINDecoder();
            
            vd.DecodeVIN( String.valueOf( v.get('dealer__VIN__c') ) );
            VINDecoderDataObject.DecodeData ddat = vd.decodeData;


            if(vd.decodeError!='') {
                throw new VINDECODE_Exception('Unable to decode VIN, Error: `'+vd.decodeError+'`');                            
            }
            //Null check for common data
            if(ddat!=null && ddat.common_data != null) {
                v.put('dealer__Year__c', ddat.common_data.year);
                v.put('dealer__Make__c', ddat.common_data.make);
                v.put('dealer__Carline__c', ddat.common_data.model);
            } 
            //Null check basic data in styles
            else if(ddat!=null && ddat.styles != null && ddat.styles[0] != null && ddat.styles[0].basic_data !=null){
                v.put('dealer__Year__c', ddat.styles[0].basic_data.year);
                v.put('dealer__Make__c', ddat.styles[0].basic_data.make);
                v.put('dealer__Carline__c', ddat.styles[0].basic_data.model);
            }

            for(VINDecoderDataObject.Style style : ddat.styles) {
                trims.add(style.basic_data.trim);
            }
            v.put('dealer__Trim_Level__c', trims );
        } else {
            throw new VINDECODE_Exception('VIN must be 17 characters');
        }
        return v;
    }   

    global class VINDECODE_Exception extends Exception {}
}