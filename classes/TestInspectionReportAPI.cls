@isTest
public class TestInspectionReportAPI {
    
    @isTest static void testInspectionReportController(){
        
        Inspection_Report__c mpi = new Inspection_Report__c(TemplateName__c='DealerTeam_Example');
        insert mpi;
        
        List<InspectionReportController.Result> templateResults = InspectionReportController.getInspectionTemplateGroups();
        System.assert(templateResults.size() > 0,'A valid template should have been returned.');
        
        List<InspectionReportLineMetric__c> metricLines = [SELECT Id, Line__c FROM InspectionReportLineMetric__c];
        System.assert(metricLines.size() > 0,'Inspection Report Line Metrics should have been generated');
        
        InspectionReportController.Result selectedTemplate = InspectionReportController.getSelectedTemplate(mpi.Id);
        System.assert(selectedTemplate.value == 'DealerTeam_Example', 'DealerTeam_Example should have been the selected template for this Inspection Report');

        String lineGroupJSON = InspectionReportController.updateMetric(mpi.Id,metricLines[0].Id, metricLines[0].Line__c, null);
        List<InspectionReportController.LineGroup> lineGroups = (List<InspectionReportController.LineGroup>)JSON.deserialize(lineGroupJSON, List<InspectionReportController.LineGroup>.class);
        System.assert(lineGroups.size() == 4, 'Four LineGroups should have been returned for \'DealerTeam_Example\' Inspection Template');

    }
    @isTest static void testInspectionDiagramController(){
        
        Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
		insert VI;

        Service_Vehicle__c sv = [select id from Service_Vehicle__c LIMIT 1];
        Inspection_Report__c mpi = new Inspection_report__c(Service_Vehicle__c = sv.Id);
        insert mpi;
        InspectionDiagramController.getImageUrl(mpi.Id);
        InspectionDiagramController.saveUrl(mpi.Id,'google.com');

    }

    
}