global with sharing class VINDecoder {

    global VINDecoder() {
        getActiveSettings();
    }

    public String vinjson;
    public String result;
    public String payload;

    global String decodeError = null;
    public Map < String, Object > vinObject = null;

    global void DecodeVIN(String VIN) {
        decodeData = (VINDecoderDataObject.DecodeData) JSON.deserialize(VinDecoderAPI.DoCallout(VIN), VinDecoderDataObject.DecodeData.class);
        decodeError = decodeData.error.error_message != '' ? decodeData.error.error_message : '';
    }

    public String doVINDecodeCallout(String VIN) {
        return VinDecoderAPi.DoCallout(VIN);
    }

    public VinDecoderDataObject.Style SelectedStyle(String styleId) {
        for (VinDecoderDataObject.Style style: decodeData.styles) {
            if (style.vehicle_id == styleId) {
                return style;
            }
        }
        return new VINDecoderDataObject.Style();
    }

    // Deprecated Methods 4.7+
    @Deprecated
    global List < VINDecoder_DataOneSoftware.StyleData > modelKeys = new List < VINDecoder_DataOneSoftware.StyleData > ();
    @Deprecated
    global VINDecoder_DataOneSoftware.DecodeResponseStruct decode = new VINDecoder_DataOneSoftware.DecodeResponseStruct();
    @Deprecated
    global VINDecoder_DataOneSoftware.DecodeResponseStruct res = new VINDecoder_DataOneSoftware.DecodeResponseStruct(); // Should be transient
    
    public VINDecoderDataObject.DecodeData decodeData = new VINDecoderDataObject.DecodeData();
    private dealer__VINDecoderCS__c df = new dealer__VINDecoderCS__c();
    transient VINDecoder_DataOneSoftware.DecodeResponseStruct Tres = new VINDecoder_DataOneSoftware.DecodeResponseStruct();
    transient String Tvinjson;
    transient String Tresult;
    transient String Tpayload;
    
    public void getActiveSettings() {}  

    @Deprecated
    global VINDecoder_DataOneSoftware.StyleData StyleDat(String styleID) {
        return new VINDecoder_DataOneSoftware.StyleData();
    }

    public HttpRequest buildRequest() {
            HttpRequest req = new HttpRequest(); 
            return req;
    } 

    public HttpResponse invokeWebService(Http h, HttpRequest req) {
        HttpResponse res = h.send(req);
        return res;
    }

    public String serializeRequest(String VIN) {
        return null;
    }

    public VINDecoder_DataOneSoftware.DecodeResponseStruct deserializeResponse(String JSONResponse) { 
        return new VINDecoder_DataOneSoftware.DecodeResponseStruct();
    }
    
    public void saveVINDecodeResults(VINDecoder_DataOneSoftware.DecodeResponseStruct decodedObject, String VIN, String StockNumber) {
    }

    public String sanitizeJSON(String JSONResponse) {
        return null;
    }

    public class EquipmentItem {
    }

    global class VINDecoderException extends Exception {}
}