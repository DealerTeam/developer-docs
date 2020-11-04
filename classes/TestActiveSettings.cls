@isTest
public class TestActiveSettings {
    public static testmethod void TestVINDecoderSettings() {
        try {
            VINDecoder vd = new VINDecoder();
        } catch(Exception e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('Error:  No active VIN Decoder setup.  Please contact your System Administrator') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
    }
}