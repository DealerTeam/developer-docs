---
layout: default
---
# PartsInventoryControlHandler class

 Date            |Developer            |Work# Notes -- 2016-9-20        |David Ray          |Case # 2073 DR1 - Parts Inventroy should inherit the status of its master - 9-22 - Force to include pack QTY from master. 2016-11-25       |Gaurav Agrawal       |W-000321 Implemented Trigger Framework 2016-11-25       |Abhishek Goel       |W-000776 To prevent creating multiple part with same location on a single Part Master /** PartsInventoryControlHandler - Domain Layer Logic @test PartPhysicalDomainLayer.testPartsInventoryControlHandler

---
## Methods
### `PartsInventoryControlMethod(List<dealer__Parts_Inventory__c> PartsList, Boolean isInsert)` → `void`
### `PartsToPartMasterLocationValidation(List<dealer__Parts_Inventory__c> PartsList, Boolean isInsert)` → `void`
---
## Inner Classes

### PartsInventoryControlHandler.MyException class
---
