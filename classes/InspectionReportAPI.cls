public class InspectionReportAPI {

    public static List<Inspection_Report_Lines__c> instantiateLines(Id reportId){
        Try{
            Inspection_Report__c inspectionReport = [SELECT Id, TemplateName__c FROM Inspection_Report__c WHERE Id =: reportId];
            if(inspectionReport.TemplateName__c != null){
                return instantiateLines(inspectionReport.Id, inspectionReport.TemplateName__c);
            }
            return new List<Inspection_Report_Lines__c>();
        } catch (QueryException e){
            throw new QueryException(e.getMessage());
        }
    }

    /* Instantiates Line items for inspection reports */
    public static List<Inspection_Report_Lines__c> instantiateLines(Id reportId, String newTemplateName){
        System.assert(reportId!=null,'Missing required field to create Inspection Report Lines: Inspection Report Id');

        Inspection_Report__c inspectionReport = [SELECT Id, TemplateName__c FROM Inspection_Report__c WHERE Id=: reportId];
        
        // Prevent this method from continuing if template name is not present 
        if(newTemplateName == null){
            return new List<Inspection_Report_Lines__c>();
        } 

        inspectionReport.TemplateName__c = newTemplateName;
        InspectionTemplate Template = getInspectionTemplate(inspectionReport.TemplateName__c);
        
        if(Template != null){
            List<Inspection_Report_Lines__c> irLines = new List<Inspection_Report_Lines__c>();
            Map<String, List<InspectionReportLineMetric__c> > irLineMetricMap = new Map<String, List<InspectionReportLineMetric__c> >(); //Line dev name + Line ( for id mapping after insert.)

            for(InspectionTemplateGroup templateGroup: Template.InspectionTemplateGroups){
                for(InspectionGroup inspectionGroup: templateGroup.InspectionGroups){
                    for(GroupItem groupItem: inspectionGroup.GroupItems){
                        for(Item item: groupItem.Items){
                            irLines.add(new Inspection_Report_Lines__c(
                                    Inspection_Report__c = inspectionReport.Id,
                                    InspectionItem__c = item.Header.DeveloperName,
                                    Label__c = item.Header.Description__c,
                                    Type__c = item.Header.Type__c,
                                    Sequence__c = item.Header.Sequence__c,
                                    EnableSimpleView__c = item.Header.EnableSimpleView__c,
                                    Description__c = item.Header.Description__c));
                                    // Checkbox_Cluster__r.Checkbox_1__r.Score__C,Checkbox_Cluster__r.Checkbox_1__r.Header__c,
                            
                            List<InspectionReportLineMetric__c> lineMetricList = new List<InspectionReportLineMetric__c>();
                            
                            //Single Checkbox
                            if(item.Header.Type__c == 'Single Checkbox' && item.Header.Checkbox__c != null){
                                LineMetricList.add(new InspectionReportLineMetric__c(
                                                        Type__c = item.Header.Metric__r.Type__c, // Only checkbox for now, we need to redo this for dynamic types , next iteration.
                                                        Label__c = item.Header.Description__c,
                                                        Color__c = item.Header.Checkbox__r.Color__c,
                                                        ColorCode__c = item.Header.Checkbox__r.ColorCode__c,
                                                        // Score__c = Integer.valueOf(item.Header.Checkbox_Cluster__r.Checkbox_1__r.Score__C), /// need to think on how this will be scored...
                                                        Checked__c = false)); 
                            }

                            //Checkbox Cluster(radio) / Multi Select(ckbx grp)
                            if(item.Header.Type__c == 'Checkbox Cluster' || item.Header.Type__c == 'Multi-Select' && item.Header.Checkbox_Cluster__c != null){
                                    if(item.Header.Checkbox_Cluster__r.Checkbox_1__r != null){
                                        lineMetricList.add(new InspectionReportLineMetric__c(
                                                                Type__c = item.Header.Metric__r.Type__c, // Only checkbox for now, we need to redo this for dynamic types , next iteration.
                                                                Label__c = item.Header.Checkbox_Cluster__r.Checkbox_1__r.Header__c,
                                                                Color__c = item.Header.Checkbox_Cluster__r.Checkbox_1__r.Color__c,
                                                                ColorCode__c = item.Header.Checkbox_Cluster__r.Checkbox_1__r.ColorCode__c,
                                                                Score__c = Integer.valueOf(item.Header.Checkbox_Cluster__r.Checkbox_1__r.Score__C),
                                                                Checked__c = false)); 
                                    }
                                    if(item.Header.Checkbox_Cluster__r.Checkbox_2__r != null){
                                        lineMetricList.add(new InspectionReportLineMetric__c(
                                                                Type__c = item.Header.Metric__r.Type__c, // Only checkbox for now, we need to redo this for dynamic types , next iteration.
                                                                Label__c = item.Header.Checkbox_Cluster__r.Checkbox_2__r.Header__c,
                                                                Color__c = item.Header.Checkbox_Cluster__r.Checkbox_2__r.Color__c,
                                                                ColorCode__c = item.Header.Checkbox_Cluster__r.Checkbox_2__r.ColorCode__c,
                                                                Score__c = Integer.valueOf(item.Header.Checkbox_Cluster__r.Checkbox_2__r.Score__C),
                                                                Checked__c = false)); 
                                    }
                                    if(item.Header.Checkbox_Cluster__r.Checkbox_3__r != null){
                                        lineMetricList.add(new InspectionReportLineMetric__c(
                                                                Type__c = item.Header.Metric__r.Type__c, // Only checkbox for now, we need to redo this for dynamic types , next iteration.
                                                                Label__c = item.Header.Checkbox_Cluster__r.Checkbox_3__r.Header__c,
                                                                Color__c = item.Header.Checkbox_Cluster__r.Checkbox_3__r.Color__c,
                                                                ColorCode__c = item.Header.Checkbox_Cluster__r.Checkbox_3__r.ColorCode__c,
                                                                Score__c = Integer.valueOf(item.Header.Checkbox_Cluster__r.Checkbox_3__r.Score__C),
                                                                Checked__c = false)); 
                                    }
                                    if(item.Header.Checkbox_Cluster__r.Checkbox_4__r != null){
                                        lineMetricList.add(new InspectionReportLineMetric__c(
                                                                Type__c = item.Header.Metric__r.Type__c, // Only checkbox for now, we need to redo this for dynamic types , next iteration.
                                                                Label__c = item.Header.Checkbox_Cluster__r.Checkbox_4__r.Header__c,
                                                                Color__c = item.Header.Checkbox_Cluster__r.Checkbox_4__r.Color__c,
                                                                ColorCode__c = item.Header.Checkbox_Cluster__r.Checkbox_4__r.ColorCode__c,
                                                                Score__c = Integer.valueOf(item.Header.Checkbox_Cluster__r.Checkbox_4__r.Score__C),
                                                                Checked__c = false)); 
                                    }
                            }

                            //Percentage Slider (Number slider next iteration)
                            if(item.Header.Type__c == 'Slider' && item.Header.Metric__r.Type__c == 'Percentage'){
                                lineMetricList.add(new InspectionReportLineMetric__c(
                                                        Type__c  = item.Header.Metric__r.Type__c,
                                                        Label__c = item.Header.Description__c
                                ));
                            }
                               if(item.Header.Type__c == 'Numeric Input'){
                                lineMetricList.add(new InspectionReportLineMetric__c(
                                                        Type__c  = item.Header.Metric__r.Type__c,
                                                        Label__c = item.Header.Description__c
                                ));
                            }


                            if(lineMetricList.size() > 0 ){
                                irLineMetricMap.put(item.Header.DeveloperName, lineMetricList);
                            }
                        
                        }
                    }
                }
            }
            if(irLines.size() > 0){
                insert irLines;
                
                //Insert Inspection Report Line Metric list
                List<InspectionReportLineMetric__c> lineMetricInsert = new List<InspectionReportLineMetric__c>();
                if(irLineMetricMap.size()>0){
                    for(Inspection_Report_Lines__c line : irLines){
                        if(irLineMetricMap.get(line.InspectionItem__c) != null){
                            for(InspectionReportLineMetric__c lm : irLineMetricMap.get(line.InspectionItem__c)){
                                lm.Line__c = line.Id;
                                lineMetricInsert.add(lm);
                            }
                        }
                    }
                    insert lineMetricInsert;
                }
                return irLines;
            }
        }
        return new List<Inspection_Report_Lines__c>();
    }

    /* Retrieves a pre-defined template from Inspection_Template__mdt */
    public static InspectionTemplate getInspectionTemplate(String DeveloperName){
        
        System.assert(DeveloperName != null,'DeveloperName is required to acquire an Inspection Template');

        //Step 1: Get Template Container
        Inspection_Template__mdt template = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName FROM Inspection_Template__mdt WHERE DeveloperName =:DeveloperName];

        //Step 2: Get Map of of applicable template groups
        Map<Id, InspectionTemplateGroup__mdt> InspectionTemplateGroupMap = new Map<Id, InspectionTemplateGroup__mdt>();
        for(InspectionTemplateGroup__mdt itg: [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label,
                                                 QualifiedApiName, Inspection_Template__c 
                                                 FROM InspectionTemplateGroup__mdt WHERE Inspection_Template__c =: template.Id]){
            InspectionTemplateGroupMap.put(itg.Id, itg);
        }

        //Step 3: Get Map of applicable Inspection Group
        Map<Id, Inspection_Group__mdt> InspectionGroupMap = new Map<Id, Inspection_Group__mdt>();
        for(Inspection_Group__mdt ig: [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName,
                                       Description__c, Name__c, InspectionTemplateGroup__c 
                                       FROM Inspection_Group__mdt WHERE InspectionTemplateGroup__c IN: InspectionTemplateGroupMap.Keyset()]){
            InspectionGroupMap.put(ig.Id, ig);
        }

        //Step 4: get Map of applicable group Items
        Map<Id, InspectionGroupItem__mdt> InspectionGroupItemMap = new Map<Id, InspectionGroupItem__mdt>();
        for(InspectionGroupItem__mdt igi: [SELECT DeveloperName, Id, Label, Language, MasterLabel, NamespacePrefix, QualifiedApiName,
                                             Inspection_Group__c 
                                             FROM InspectionGroupItem__mdt WHERE Inspection_Group__c IN: InspectionGroupMap.Keyset()]){
            InspectionGroupItemMap.put(igi.Id, igi);
        }
        //Step 5: get Map of applicable Inspection Items
        Map<Id, Inspection_Item__mdt> InspectionItemMap = new Map<Id, Inspection_Item__mdt>();
        for(Inspection_Item__mdt ii: [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName, 
                                        Checkbox_Cluster__c, Checkbox__c, Description__c, Metric__c,
                                        Metric__r.Type__c, Metric__r.Chart__c, Metric__r.Description__c, Type__c,
                                        Checkbox__r.Header__c, Sequence__c, EnableSimpleView__c,
                                        Checkbox__r.Color__c, Checkbox__r.ColorCode__c,
                                        Checkbox_Cluster__r.Checkbox_1__r.Score__C,Checkbox_Cluster__r.Checkbox_1__r.Header__c,
                                        Checkbox_Cluster__r.Checkbox_1__r.Color__c,Checkbox_Cluster__r.Checkbox_1__r.ColorCode__c,
                                        Checkbox_Cluster__r.Checkbox_2__r.Score__C,Checkbox_Cluster__r.Checkbox_2__r.Header__c,
                                        Checkbox_Cluster__r.Checkbox_2__r.Color__c,Checkbox_Cluster__r.Checkbox_2__r.ColorCode__c,
                                        Checkbox_Cluster__r.Checkbox_3__r.Score__C,Checkbox_Cluster__r.Checkbox_3__r.Header__c,
                                        Checkbox_Cluster__r.Checkbox_3__r.Color__c,Checkbox_Cluster__r.Checkbox_3__r.ColorCode__c,
                                        Checkbox_Cluster__r.Checkbox_4__r.Score__C,Checkbox_Cluster__r.Checkbox_4__r.Header__c,
                                        Checkbox_Cluster__r.Checkbox_4__r.Color__c,Checkbox_Cluster__r.Checkbox_4__r.ColorCode__c,
                                        InspectionGroupItem__c
                                        FROM Inspection_Item__mdt WHERE InspectionGroupItem__c IN: InspectionGroupItemMap.Keyset()]){
            InspectionItemMap.put(ii.Id, ii);
        }

        return instantiateWrapper(template, InspectionTemplateGroupMap, InspectionGroupMap, InspectionGroupItemMap, InspectionItemMap);
    }

    /** Private Helper Methods **/
    private static InspectionTemplate instantiateWrapper(Inspection_Template__mdt template,  
                                                         Map<Id, InspectionTemplateGroup__mdt> InspectionTemplateGroupMap,    
                                                         Map<Id, Inspection_Group__mdt> InspectionGroupMap, 
                                                         Map<Id, InspectionGroupItem__mdt> InspectionGroupItemMap,  
                                                         Map<Id, Inspection_Item__mdt> InspectionItemMap ){
        
        // Build map to associate Inspection Group Item to a list of Items
        Map<id, List<Item> > GroupItemMap = new Map<id, List<Item> >();//Group Item Id, List<Item>
        for(Inspection_Item__mdt ii : InspectionItemMap.values()){
            if(GroupItemMap.get(ii.InspectionGroupItem__c) == null){
                //New List<Item> for this group item
                GroupItemMap.put(ii.InspectionGroupItem__c, new List<Item>{new Item(ii)});
            } else if (groupItemMap.get(ii.InspectionGroupItem__c) != null){
                List<Item> items = groupItemMap.get(ii.InspectionGroupItem__c);
                items.add(new Item(ii));
                GroupItemMap.put(ii.InspectionGroupItem__c, items);
            }
        }

        // Build map to associate Inspection Group to a list of GroupItems
        Map<Id,List<GroupItem> > GroupMap = new Map<Id,List<GroupItem>>(); //Inspection Group Id, List<GroupItem>
        for(Id gId : GroupItemMap.Keyset()){
            InspectionGroupItem__mdt thisGroupItem = InspectionGroupItemMap.get(gId);
            List<Item> items = GroupItemMap.get(gId);
            if(GroupMap.get(thisGroupItem.Inspection_Group__c) == null){
                GroupMap.put(thisGroupItem.Inspection_Group__c, new List<GroupItem>{new GroupItem(thisGroupItem, items)});
            } else {
                List<GroupItem> existingGroupItems = GroupMap.get(thisGroupItem.Inspection_Group__c);
                existingGroupItems.add(new GroupItem(thisGroupItem, items));
                GroupMap.put(thisGroupItem.Inspection_Group__c,existingGroupItems);
            }
        }

        // Build map to associate Inspection template Group to a list of InspectionGroup
        Map<Id,List<InspectionGroup> > TemplateGroupMap = new Map<Id, List<InspectionGroup> >();//Inspection Template Group Id, List<InspectionGroup>
        for(Id igId : GroupMap.Keyset()){
            Inspection_Group__mdt thisInspectionGroup = InspectionGroupMap.get(igId);
            List<GroupItem> groupItems = GroupMap.get(igId);
            if(TemplateGroupMap.get(thisInspectionGroup.InspectionTemplateGroup__c) == null){
                TemplateGroupMap.put(thisInspectionGroup.InspectionTemplateGroup__c, new List<InspectionGroup>{new InspectionGroup(thisInspectionGroup, groupItems)});
            }else{
                List<InspectionGroup> existingInspectionGroups = TemplateGroupMap.get(thisInspectionGroup.InspectionTemplateGroup__c);
                existingInspectionGroups.add(new InspectionGroup(thisInspectionGroup, groupItems));
                TemplateGroupMap.put(thisInspectionGroup.InspectionTemplateGroup__c, existingInspectionGroups);
            }
        }

        //Finally Build InspectionTemplate Group List
        List<InSpectionTemplateGroup> InspectionTemplateGroup = new List<InspectionTemplateGroup>();
        for(Id itgId : TemplateGroupMap.Keyset()){
            InspectionTemplateGroup__mdt thisTemplateGroup = InspectionTemplateGroupMap.get(itgId);
            List<InspectionGroup> InspectionGroups = TemplateGroupMap.get(itgId);
            InspectionTemplateGroup.add(new InspectionTemplateGroup(thisTemplateGroup, InspectionGroups));
        }

        return new InspectionTemplate(template,InspectionTemplateGroup);
    }

    /** Wrapper Classes **/
    public class InspectionTemplate{
        public Inspection_Template__mdt Header;
        public List<inspectionTemplateGroup> InspectionTemplateGroups;
        
        public InspectionTemplate(Inspection_Template__mdt header, List<InspectionTemplateGroup> inspectionTemplateGroups){
            this.Header = header;
            this.InspectionTemplateGroups = inspectionTemplateGroups;
        }
    }

    public class InspectionTemplateGroup{
        public InspectionTemplateGroup__mdt Header;
        public List<InspectionGroup> InspectionGroups;
        
        public InspectionTemplateGroup(InspectionTemplateGroup__mdt header, List<InspectionGroup> inspectionGroups){
            this.Header = header;
            this.InspectionGroups = inspectionGroups;
        }
    }

    public class InspectionGroup{
        public Inspection_Group__mdt Header;
        public List<GroupItem> GroupItems;
        
        public InspectionGroup(Inspection_Group__mdt header, List<GroupItem> groupItems){
            this.Header = header;
            this.GroupItems = groupItems;
        }
    }

    public class GroupItem{
        public InspectionGroupItem__mdt Header;
        public List<Item> Items;
        
        public GroupItem(InspectionGroupItem__mdt header, List<Item> items){
            this.Header = header;
            this.Items = items;
        }
    }

    public class Item{
        public Inspection_Item__mdt Header;
        public Item(Inspection_Item__mdt header){
           this.Header = header;
        }
    }
}