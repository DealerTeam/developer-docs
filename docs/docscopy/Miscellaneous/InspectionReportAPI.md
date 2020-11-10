---
layout: default
---
# InspectionReportAPI class
---
## Methods
### `getInspectionTemplate(String DeveloperName)` → `InspectionTemplate`
### `instantiateLines(Id reportId)` → `List<Inspection_Report_Lines__c>`
### `instantiateLines(Id reportId, String newTemplateName)` → `List<Inspection_Report_Lines__c>`
---
## Inner Classes

### InspectionReportAPI.GroupItem class
---
#### Constructors
##### `GroupItem(InspectionGroupItem__mdt header, List<Item> items)`
---
#### Properties

##### `Header` → `InspectionGroupItem__mdt`

##### `Items` → `List<Item>`

---
### InspectionReportAPI.InspectionGroup class
---
#### Constructors
##### `InspectionGroup(Inspection_Group__mdt header, List<GroupItem> groupItems)`
---
#### Properties

##### `GroupItems` → `List<GroupItem>`

##### `Header` → `Inspection_Group__mdt`

---
### InspectionReportAPI.InspectionTemplate class

Private Helper Methods * /** Wrapper Classes *

---
#### Constructors
##### `InspectionTemplate(Inspection_Template__mdt header, List<InspectionTemplateGroup> inspectionTemplateGroups)`
---
#### Properties

##### `Header` → `Inspection_Template__mdt`

##### `InspectionTemplateGroups` → `List<inspectionTemplateGroup>`

---
### InspectionReportAPI.InspectionTemplateGroup class
---
#### Constructors
##### `InspectionTemplateGroup(InspectionTemplateGroup__mdt header, List<InspectionGroup> inspectionGroups)`
---
#### Properties

##### `Header` → `InspectionTemplateGroup__mdt`

##### `InspectionGroups` → `List<InspectionGroup>`

---
### InspectionReportAPI.Item class
---
#### Constructors
##### `Item(Inspection_Item__mdt header)`
---
#### Properties

##### `Header` → `Inspection_Item__mdt`

---
