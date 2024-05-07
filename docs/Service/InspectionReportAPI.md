---
layout: default
---
# InspectionReportAPI



**Group** Service

## Methods
### `public static List<Inspection_Report_Lines__c> instantiateLines(Id reportId)`
### `public static List<Inspection_Report_Lines__c> instantiateLines(Id reportId, String newTemplateName)`
### `public static InspectionTemplate getInspectionTemplate(String DeveloperName)`
### `private static InspectionTemplate instantiateWrapper(Inspection_Template__mdt template, Map<Id,InspectionTemplateGroup__mdt> InspectionTemplateGroupMap, Map<Id,Inspection_Group__mdt> InspectionGroupMap, Map<Id,InspectionGroupItem__mdt> InspectionGroupItemMap, Map<Id,Inspection_Item__mdt> InspectionItemMap)`
---
## Classes
### InspectionTemplate
#### Constructors
##### `public InspectionTemplate(Inspection_Template__mdt header, List&lt;InspectionTemplateGroup&gt; inspectionTemplateGroups)`
---
#### Fields

##### `public Header` → `Inspection_Template__mdt`


##### `public InspectionTemplateGroups` → `List&lt;inspectionTemplateGroup&gt;`


---

### InspectionTemplateGroup
#### Constructors
##### `public InspectionTemplateGroup(InspectionTemplateGroup__mdt header, List&lt;InspectionGroup&gt; inspectionGroups)`
---
#### Fields

##### `public Header` → `InspectionTemplateGroup__mdt`


##### `public InspectionGroups` → `List&lt;InspectionGroup&gt;`


---

### InspectionGroup
#### Constructors
##### `public InspectionGroup(Inspection_Group__mdt header, List&lt;GroupItem&gt; groupItems)`
---
#### Fields

##### `public Header` → `Inspection_Group__mdt`


##### `public GroupItems` → `List&lt;GroupItem&gt;`


---

### GroupItem
#### Constructors
##### `public GroupItem(InspectionGroupItem__mdt header, List&lt;Item&gt; items)`
---
#### Fields

##### `public Header` → `InspectionGroupItem__mdt`


##### `public Items` → `List&lt;Item&gt;`


---

### Item
#### Constructors
##### `public Item(Inspection_Item__mdt header)`
---
#### Fields

##### `public Header` → `Inspection_Item__mdt`


---

---
