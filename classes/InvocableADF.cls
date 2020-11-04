global class InvocableADF {
    @InvocableMethod(label='Process ADF' description='Invocable method for sending ADF lead')

    global static void InvocableRouter(List<InputParams> inputs){
        String transactionType = inputs[0].trans;

        String email = inputs[0].recipientEmail;
        Sales_Up__c sup = inputs[0].salesUp;

        ADFAPI.outputXML(sup, email);
    }

    global class InputParams {
        @InvocableVariable(label='Transaction Type' description='Inbound or Outbound' required=true)
        global String trans;

        @InvocableVariable(label='Recipient Email Address' description='Where the email will be sent' required=true)
        global String recipientEmail;

        @InvocableVariable(label='Sales Up' description='The sales up record to be used' required=true)
        global Sales_Up__c salesUp;
    }
}