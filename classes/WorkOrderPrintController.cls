global with sharing class WorkOrderPrintController {
       
    global ServiceVehicleAPI.sv svW {get;set;}

    global WorkOrderPrintController(ApexPages.StandardController controller) {
        Id svId = ApexPages.currentPage().getParameters().get('id');

        svW = ServiceVehicleAPI.svData(svId);
    }
}