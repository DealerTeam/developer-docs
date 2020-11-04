public with sharing class ServiceRepairOrder_JSONParser {
    
    
        //* Struct
    public class RORoot {
        public List<ROData> data = new List<ROData>();
        public String Advisor;
        public String Customer;
        public String Vehicle;
        public String Tag;
        public String Waiter;
        public String Mileage;
        public String Comments;
        public String PromiseDate;
        public String PromiseTime;
    }
    
    public class ROData {
        public String lId;
        public String Id;
        public String OpCode;
        public String Description;
        public String Concern;
        public String PayMethod;
        public String BookTime;
        public String Est;
        public Integer LineNumber;
    }   
    
    String jsonString = '{"data":[{"lId":"a0G80000009mnx6EAA-1","Id":"a0G80000009mnx6EAA","OpCode":"01BATTERY-TEST","Description":"Battery Load Test","Concern":"Customer request load test battery for starting and charging related issues","PayMethod":"C","BookTime":"0.8","Est":"69.95","LineNumber":1}],"Advisor":"00580000001sD9pAAE","Customer":"0018000000rBlW9","Vehicle":"a0D8000000P79cv","Tag":"","Waiter":"1","Mileage":"12500"}';
    
    
    //* Parser
    /*  Well, this normally would have been the best way to go from JSON to apex, however the deserialize bug prevents this until sprin 12 release (http://boards.developerforce.com/t5/Apex-Code-Development/Don-t-know-the-type-of-the-Apex-object-to-deserialize-in-APEX/td-p/355379/page/4)
    
    public static ServiceRepairOrder_RORoot parse(String json) {
        return (ServiceRepairOrder_RORoot) System.JSON.deserialize(json, ServiceRepairOrder_RORoot.class);
    }   
    */
    
    
    public static RORoot parse(String json) {
        
        RORoot ro = new RORoot();
        
        Boolean a = false;
        Integer i = 0;
        
        System.JSONParser p = System.JSON.createParser(json);
        
        while (p.nextToken() != null) {
            
            if (p.getCurrentToken() == JSONToken.FIELD_NAME) {
                
                if(p.getText() == 'Advisor') { p.nextToken(); ro.Advisor = p.getText(); }
                if(p.getText() == 'Customer') { p.nextToken(); ro.Customer = p.getText(); }
                if(p.getText() == 'Vehicle') { p.nextToken(); ro.Vehicle = p.getText(); }
                if(p.getText() == 'Mileage') { p.nextToken(); ro.Mileage = p.getText(); }
                if(p.getText() == 'Tag') { p.nextToken(); ro.Tag = p.getText(); }
                if(p.getText() == 'Waiter') { p.nextToken(); ro.Waiter = p.getText(); }
                if(p.getText() == 'PromiseDate') { p.nextToken(); ro.PromiseDate = p.getText(); }
                if(p.getText() == 'PromiseTime') { p.nextToken(); ro.PromiseTime = p.getText(); }
                if(p.getText() == 'Comments') { p.nextToken(); ro.Comments = p.getText(); }
                
                System.debug(' FieldText '+p.getText()+' '+p.getCurrentToken()+' ');
                
                if(ro.data.size() <= i && a == true) {
                    ro.data.add(new ROData());
                }
                
                if(p.getText() == 'lId') { p.nextToken(); ro.data[i].lId = p.getText(); }
                if(p.getText() == 'Id') { p.nextToken(); ro.data[i].Id = p.getText(); }
                if(p.getText() == 'OpCode') { p.nextToken(); ro.data[i].OpCode = p.getText(); }
                if(p.getText() == 'Description') { p.nextToken(); ro.data[i].Description = p.getText(); }
                if(p.getText() == 'Concern') { p.nextToken(); ro.data[i].Concern = p.getText(); }
                if(p.getText() == 'PayMethod') { p.nextToken(); ro.data[i].PayMethod = p.getText(); }
                if(p.getText() == 'BookTime') { p.nextToken(); ro.data[i].BookTime = p.getText(); }
                if(p.getText() == 'Est') { p.nextToken(); ro.data[i].Est = p.getText(); }
                if(p.getText() == 'LineNumber') { p.nextToken(); ro.data[i].LineNumber = p.getIntegerValue(); }
                
                                
                
                System.debug(' Contents: '+p.getText());
                
                //if(p.getText() == 'Id') { p.nextToken(); ro.data[i].Id = p.getText(); }
                    
            } 
            
            if(p.getCurrentToken() == JSONToken.START_ARRAY) {
                System.debug('Entering Array');
                a = true;
            }
            
            if(p.getCurrentToken() == JSONToken.START_OBJECT) {
                System.debug('Entering Object');
                if(a == true) {
                    //dFill.clear();
                }
            }
            
            if(p.getCurrentToken()== JSONToken.END_OBJECT) {
                System.debug('Exiting Object');
                    if(a == true) {
                        // ro.data.add(dTemp);
                    }
                i++;
            }
            
            if(p.getCurrentToken() == JSONToken.END_ARRAY) {
                System.debug('Leaving Array');
                a = false;
                // ro.data.addAll(d);
                System.debug(ro.data);
            }
        }
        
        System.debug(ro);
        return ro;
    }
}