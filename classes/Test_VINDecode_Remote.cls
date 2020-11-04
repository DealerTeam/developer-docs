@isTest(seeAllData=true)
private class Test_VINDecode_Remote {
	static testmethod void testVINDecodeRemote() {
		Map<String, Object> results = VINDecodeRemote.decodedVin('3FADP4BJ1FM146543');
	}
}