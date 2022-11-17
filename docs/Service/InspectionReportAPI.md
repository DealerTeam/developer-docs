# InspectionReportAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Methods
### `static instantiateLines(Id reportId)`
### `static instantiateLines(Id reportId, String newTemplateName)`
### `static getInspectionTemplate(String DeveloperName)`
---
## Classes
### GroupItem
#### Constructors
##### `GroupItem(InspectionGroupItem__mdt header, List&lt;Item&gt; items)`
---
#### Fields

##### `Header` → `InspectionGroupItem__mdt`


##### `Items` → `List&lt;Item&gt;`


---

### InspectionGroup
#### Constructors
##### `InspectionGroup(Inspection_Group__mdt header, List&lt;GroupItem&gt; groupItems)`
---
#### Fields

##### `GroupItems` → `List&lt;GroupItem&gt;`


##### `Header` → `Inspection_Group__mdt`


---

### InspectionTemplate
#### Constructors
##### `InspectionTemplate(Inspection_Template__mdt header, List&lt;InspectionTemplateGroup&gt; inspectionTemplateGroups)`
---
#### Fields

##### `Header` → `Inspection_Template__mdt`


##### `InspectionTemplateGroups` → `List&lt;inspectionTemplateGroup&gt;`


---

### InspectionTemplateGroup
#### Constructors
##### `InspectionTemplateGroup(InspectionTemplateGroup__mdt header, List&lt;InspectionGroup&gt; inspectionGroups)`
---
#### Fields

##### `Header` → `InspectionTemplateGroup__mdt`


##### `InspectionGroups` → `List&lt;InspectionGroup&gt;`


---

### Item
#### Constructors
##### `Item(Inspection_Item__mdt header)`
---
#### Fields

##### `Header` → `Inspection_Item__mdt`


---

---
