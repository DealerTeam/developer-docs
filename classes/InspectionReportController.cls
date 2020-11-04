public with sharing class InspectionReportController {

    @AuraEnabled(cacheable=true)
    public static List<Result> getInspectionTemplateGroups(){
        //Get Inspection Templates
        List<Result> AvailableTemplates = new List<Result>();
        for(Inspection_Template__mdt template : [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName FROM Inspection_Template__mdt LIMIT 20]){
            AvailableTemplates.add(new Result(template.Label, template.DeveloperName));
        }
        return AvailableTemplates;
    }

    @AuraEnabled
    public static string createAndApplyTemplate(String templateName, String serviceVehicleId, String locationId, String vehicleId, String acctId){
        Savepoint sp = Database.setSavePoint();
        try{
            Inspection_Report__c ir = new Inspection_Report__c();
            if(!String.isBlank(templateName)){
                ir.TemplateName__c = templateName;
            }
            if( !String.isBlank(serviceVehicleId)){
                ir.Service_Vehicle__c = serviceVehicleId;
            }
            if(!String.isBlank(locationId)){
                ir.Store_Location__c = locationId;
            }
            if(!String.isBlank(vehicleId)){
                ir.dealer__Inventoried_Vehicle__c = vehicleId;
            }
            if(!String.isBlank(acctId)){
                ir.dealer__Vehicle_Owner__c = acctId;
            }
            insert ir;
            // Deprecated Logic; Moved to domain layer on create
            // applyTemplate(ir.Id, templateName);
            return ir.Id;
        } catch(DMLException e){
            Database.rollback(sp);
            throw new AuraHandledException('DML Exception thrown while inspection report: '+e.getMessage());
        } catch(Exception e){
            Database.rollback(sp);
            throw new AuraHandledException('Unexpected error while inspection report: '+e.getMessage());
        }
    }

    @AuraEnabled
    public static String applyTemplate(String recordId, String TemplateName){
        Id objId = (Id)recordId;
        String sobjectType = objId.getSObjectType().getDescribe().getName();
        if(sobjectType == 'dealer__Appraisal__c'){
            //create inspection report for appraisals.
            Appraisal__c thisAppraisal = [SELECT Id, Service_Vehicle__c, Store_Location__c,
                                          Inventory_Vehicle__c,Vehicle_Owner__c
                                          FROM Appraisal__c WHERE Id =:recordId];

            Savepoint sp = Database.setSavePoint();

            try{
                Inspection_Report__c ir = new Inspection_Report__c();

                ir.Appraisal__c = thisAppraisal.Id;
                if(!String.isBlank(templateName)){
                    ir.TemplateName__c = templateName;
                }
                if( !String.isBlank(thisAppraisal.Service_Vehicle__c)){
                    ir.Service_Vehicle__c = thisAppraisal.Service_Vehicle__c;
                }
                if(!String.isBlank(thisAppraisal.Store_location__c)){
                    ir.Store_Location__c = thisAppraisal.Store_location__c;
                }
                if(!String.isBlank(thisAppraisal.Inventory_Vehicle__c)){
                    ir.dealer__Inventoried_Vehicle__c = thisAppraisal.Inventory_Vehicle__c;
                }
                if(!String.isBlank(thisAppraisal.Vehicle_Owner__c)){
                    ir.dealer__Vehicle_Owner__c = thisAppraisal.Vehicle_Owner__c;
                }
                insert ir;
                // Deprecated Logic; Moved to domain layer on create
                // applyTemplate(ir.Id, templateName);
                return ir.Id;
            } catch(DMLException e){
                Database.rollback(sp);
                throw new AuraHandledException('DML Exception thrown while inspection report: '+e.getMessage());
            } catch(Exception e){
                Database.rollback(sp);
                throw new AuraHandledException('Unexpected error while inspection report: '+e.getMessage());
            }
        }
        return '';
    }
    
    @AuraEnabled
    public static string updateLine(String lineId, String notes, String estCost, String field){
        Inspection_Report_Lines__c line = new Inspection_Report_Lines__c(Id=lineId);
        if(field=='notes'){
            line.Notes__c = notes;
        } else if( field == 'estCost'){
            line.Repair_Estimate__c = Decimal.valueOf(estCost);
        }
        update line;
        return JSON.serializePretty(line);
    }
    @AuraEnabled
    public static string updateMetricGroup(String recordId, String lineId, List<String> checkedMetrics){
        Set<String> metricSet = new Set<String>();
        for(String s : checkedMetrics){
            metricSet.add(s);
        }
        Boolean lineComplete = false;
        List<InspectionReportLineMetric__c> metrics = new List<InspectionReportLineMetric__c>();
        for(InspectionReportLineMetric__c m : [SELECT Id, Checked__c, Line__c FROM InspectionReportLineMetric__c WHERE Line__c =: lineId ]){
            if(metricSet.contains(m.Id)){
                m.checked__c = true;
                lineComplete = true;
            } else{
                m.checked__c = false;
            }
            metrics.add(m);
        }
        if(metrics.size() > 0) update metrics;
        if(lineComplete == true){
            Inspection_Report_Lines__c line = [SELECT Id FROM Inspection_Report_Lines__c WHERE Id =: lineId];
            line.Complete__c = true;
            update line;
        }
        return getLineItems(recordId);
    }

    @AuraEnabled
    public static string updateMetric(String recordId, String metricId, String lineId, String value ){
        system.assert(recordId != null,'Record Id is needed to update Inspection Report Metric Line');
        system.assert(metricId != null,'Metric Id is needed to update Inspection Report Metric Line');
        system.assert(lineId != null,'Inspection Report Line Id is needed to update Inspection Report Metric Line');
        InspectionReportLineMetric__c metric = [SELECT Id, Type__c, Checked__c FROM InspectionReportLineMetric__c WHERE Id =: metricId];
        Inspection_Report_Lines__c line = [SELECT Id, Complete__c FROM Inspection_Report_Lines__c WHERE Id =: lineId];
        
        if(metric.Type__c == 'Percentage' ){
            metric.Percent__c = Decimal.valueOf(value); 
        }
        if(metric.Type__c == 'Decimal'){
            metric.Number__c = Decimal.valueOf(value);
        }
        if(value == 'true' || value == 'false'){
            metric.Checked__c = Boolean.valueOf(value);
        } else {
            if(value != null)
                metric.Checked__c = true;
        }

        update metric;

        line.Complete__c = metric.Checked__c;
        update line;
        return getLineItems(recordId);
    }

    @AuraEnabled
    public static string updateRadioMetric(String recordId, String metricId, String lineId, String value ){
        system.assert(recordId != null,'Record Id is needed to update Inspection Report Metric Line');
        system.assert(metricId != null,'Metric Id is needed to update Inspection Report Metric Line');
        system.assert(lineId != null,'Inspection Report Line Id is needed to update Inspection Report Metric Line');
        Boolean lineComplete = false;
        InspectionReportLineMetric__c thisMetric = [SELECT Id, Line__c FROM InspectionReportLineMetric__c WHERE Id=:metricId];
        List<InspectionReportLineMetric__c> metricsToUpdate = new List<InspectionReportLineMetric__c>();
        for(InspectionReportLineMetric__c m :[SELECT Id, Line__c, Type__c FROM InspectionReportLineMetric__c WHERE Line__c =: thisMetric.Line__c]){
            m.Checked__c = m.Id == metricId ? true : false;
            lineComplete = m.Checked__c == true ? true : lineComplete;
            metricsToUpdate.add(m);
        }
        update metricsToUpdate;
        if(lineComplete == true){
            Inspection_Report_Lines__c line = [SELECT Id FROM Inspection_Report_Lines__c WHERE Id =: lineId];
            line.Complete__c = true;
            update line;
        }
        return getLineItems(recordId);
    }
    @AuraEnabled(cacheable=true)
    public static string dealerLocation(String userId){
        String division = [select Id, Division FROM USER WHERE Id=: userId].Division;
        Dealer_Location__c location = new Dealer_Location__c();
        if(division != null){
            try{
                return [SELECT Id, Name FROM Dealer_Location__c WHERE Company_Number__c=: division].Id;
            } catch(QueryException e){}
        }
        return '';
    }

    @AuraEnabled
    public static string relatedSV(String vehId){
        try{
            return [SELECT Id, Service_Vehicle__c FROM Vehicle_Inventory__c WHERE Id=:vehId].Service_Vehicle__c;
        }
        catch(QueryException e){}
        return '';
    }

    /** Inspection Template Results **/
    @AuraEnabled(cacheable=true)
    public static Result getSelectedTemplate(String recordId){
        Inspection_report__c thisReport = [SELECT Id, TemplateName__c FROM Inspection_report__c WHERE Id=: recordId];
        Result selectedTemplate;
        if(thisReport.TemplateName__c != null){
            Inspection_Template__mdt template = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName FROM Inspection_Template__mdt WHERE DeveloperName =: thisReport.TemplateName__c];
            selectedTemplate = new Result(template.Label, template.DeveloperName);
        }
        return selectedTemplate;
    }
    public class Result {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;

        public Result(String l, string v){
                label=l;
                value=v;
        }
    }

    /** Line Items **/
    @AuraEnabled
    public static string getSingleLine(String lineId){
        try{
            Boolean complete = false;
            Inspection_Report_Lines__c thisLine = [SELECT Id, Name, Label__c,Description__c, Result__c, Type__c,
                                                Notes__c, Repair_Estimate__c, OpCode__c, OpCode__r.Name,
                                                InspectionItem__c, Inspection_Report__c, Technician__c, Technician__r.Name, EnableSimpleView__c
                                                FROM Inspection_Report_Lines__c WHERE Id =: lineId];
            List<InspectionReportLineMetric__c> lineMetrics = new List<InspectionReportLineMetric__c>();
            for(InspectionReportLineMetric__c line : [SELECT Id, Line__c, Line__r.InspectionItem__c, Checked__c, Label__c, Score__c, Color__c, ColorCode__c, Number__c, Percent__c, Type__c FROM InspectionReportLineMetric__c WHERE Line__c =: lineId]){
                lineMetrics.add(line);
                if(line.checked__c){
                    complete = true;
                }
            }
            return JSON.serializePretty(new Line(thisLine,lineMetrics,complete));
        } catch (QueryException e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static String getLineItems(String recordId){
        Id objId = (Id)recordId;
        String sobjectType = objId.getSObjectType().getDescribe().getName();
        

        Map<String, Line> lineMDTMap = new Map<String, Line>();
        Set<Id> lineSet = new Set<Id>();

        if(sobjectType == 'dealer__Appraisal__c'){
           
            //acquire inspection report by appraisal Id 
            Inspection_report__c ir = [SELECT Id FROM Inspection_Report__c WHERE Appraisal__c =: recordId];

            for(Inspection_Report_Lines__c line : [SELECT Id, Name, Label__c,Description__c, Type__c, Sequence__c, 
                                                Notes__c, Score__c, Repair_Estimate__c, OpCode__c, OpCode__r.Name,
                                                InspectionItem__c, Inspection_Report__c,Result__c, Technician__c, Technician__r.Name, EnableSimpleView__c
                                                FROM Inspection_Report_Lines__c WHERE Inspection_Report__c =: ir.Id ORDER BY Sequence__c ASC] ){
                if(line.InspectionItem__c != null){
                    lineSet.add(line.Id);
                    lineMDTMap.put(line.InspectionItem__c,new Line(line, new List<InspectionReportLineMetric__c>(), false));
                }                                                   
            }
        } else if(sobjectType =='dealer__Inspection_Report__c') {
            for(Inspection_Report_Lines__c line : [SELECT Id, Name, Label__c,Description__c, Type__c, Sequence__c, 
                                                Notes__c, Score__c, Repair_Estimate__c, OpCode__c, OpCode__r.Name,
                                                InspectionItem__c, Inspection_Report__c,Result__c, Technician__c, Technician__r.Name, EnableSimpleView__c
                                                FROM Inspection_Report_Lines__c WHERE Inspection_Report__c =: recordId ORDER BY Sequence__c ASC] ){
                if(line.InspectionItem__c != null){
                    lineSet.add(line.Id);
                    lineMDTMap.put(line.InspectionItem__c,new Line(line, new List<InspectionReportLineMetric__c>(), false));
                }                                                   
            }
        }

        //Get all the metrics for the above lines.
        for(InspectionReportLineMetric__c metric : [SELECT Id, Line__c, Line__r.InspectionItem__c, Checked__c, Label__c, Score__c, Color__c, ColorCode__c, Number__c, Percent__c, Type__c FROM InspectionReportLineMetric__c WHERE Line__c IN: lineSet ]){
            if(lineMDTMap.get(metric.Line__r.InspectionItem__c) != null){
                //Metrics will either be an empty list or have items in it at this point.
                Line existingLine = lineMDTMap.get(metric.Line__r.InspectionItem__c);
                List<InspectionReportLineMetric__c> existingMetrics = lineMDTMap.get(metric.Line__r.InspectionItem__c).Metrics;
                existingMetrics.add(metric);
                lineMDTMap.put(metric.Line__r.InspectionItem__c, new Line(existingLine.Header, existingMetrics, false));
            }
        }

        //Get all the lines for this inspection report and group them by groupnames
        Map<String, List<Line> > lineGroupMap = new Map<String, List<Line> >();
        Map<String, Integer> seqMap = new Map<String, Integer>();
        for(Inspection_Item__mdt mdt : [SELECT DeveloperName, InspectionGroupItem__r.label, Sequence__c, InspectionGroupItem__r.Sequence__c FROM Inspection_Item__mdt WHERE DeveloperName IN: lineMDTMap.Keyset() ORDER BY Sequence__c ASC NULLS LAST]){
            if(mdt.InspectionGroupItem__r.Label != null){
                if(lineGroupMap.get(mdt.inspectionGroupItem__r.Label ) == null){
                    lineGroupMap.put(mdt.inspectionGroupItem__r.Label, new List<Line>{lineMDTMap.get(mdt.DeveloperName)});
                } else {
                    List<Line> existingLines = lineGroupMap.get(mdt.inspectionGroupItem__r.Label);
                    existingLines.add(lineMDTMap.get(mdt.DeveloperName));
                    lineGroupMap.put(mdt.inspectionGroupItem__r.Label, existingLines);
                }
                seqMap.put(mdt.InspectionGroupItem__r.label, (Integer)mdt.InspectionGroupItem__r.Sequence__c);
            }
        }

        List<LineGroup> lineGroups = new List<LineGroup>();
        for(String g : lineGroupMap.Keyset()){
            List<Line> lineList = lineGroupMap.get(g);
            Integer seq = null;
            if(lineList.size() > 0){
                seq = seqMap.get(g);
            }
            Integer linesRemaining = 0;
            for(Line line : lineList){
                for(InspectionReportLineMetric__c metric : line.Metrics){
                    if(metric.Checked__c){
                        line.complete = true;
                    } 
                }
                // if(!line.complete) linesRemaining ++;
                linesRemaining = !line.complete ? linesRemaining + 1 : linesRemaining + 0;
            }

            lineGroups.add(new LineGroup(g, linesRemaining, seq, lineList));
        }
        lineGroups.sort();
        
        return JSON.serializePretty(lineGroups);
    }


    public class LineGroup implements Comparable{
        String  GroupName;
        Integer Remaining;
        Integer Sequence;
        List<Line> Lines;
        public LineGroup(String groupName, Integer remaining, Integer sequence, List<Line> lines){
            this.Remaining = remaining;
            this.Sequence = sequence;
            this.GroupName = groupName;
            this.Lines = lines;
        }
        public LineGroup(String groupName, Integer remaining, List<Line> lines){
            this.Remaining = remaining;
            this.GroupName = groupName;
            this.Lines = lines;
        }
        public Integer compareTo(Object obj){
            LineGroup lg = (LineGroup)(obj);

            if(this.Sequence == null){
                return 1;
            }
            if(this.sequence > lg.sequence){
                return 1;
            }
            if(this.sequence == lg.sequence){
                return 0;
            }
            else {
                return -1;
            }
        }
    }
    public class Line{
        Inspection_Report_Lines__c Header;
        Boolean complete;
        List<InspectionReportLineMetric__c> Metrics;
        public Line(Inspection_Report_Lines__c header, List<InspectionReportLineMetric__c> metrics, Boolean complete){
            this.header= header;
            this.Metrics=metrics;
            this.Complete = complete;
        }
    }
}