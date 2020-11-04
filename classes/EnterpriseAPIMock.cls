@isTest
global class EnterpriseAPIMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request){
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"Results":[{"ETag":"9ae4def2908a088b6ee9b8a386f8bf1b","VersionId":"QF00YOxt0wuMP7fXpihqx4YAb_qCxpNA","Location":"https://sandbox-vehicle-images.s3.amazonaws.com/0eac9570-4df1-11ea-b00c-bd007b5deffc.jpeg","Key":"0eac9570-4df1-11ea-b00c-bd007b5deffc.jpeg","Bucket":"sandbox-vehicle-images","MainWidth":110,"MainHeight":83,"Mime":"image/jpeg","ThumbLocation":"https://sandbox-vehicle-images.s3.amazonaws.com/0eac9570-4df1-11ea-b00c-bd007b5deffc_thumb.jpeg","ThumbWidth":110,"ThumbHeight":83}],"Errors":["This is an error"]}');
        response.setStatusCode(200);
        return response; 
    } 
}
