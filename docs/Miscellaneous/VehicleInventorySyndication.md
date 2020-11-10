---
layout: default
---
# VehicleInventorySyndication class

 	VehicleInventorySyndication - prepate uploadable inventory file for distribution

---
## Constructors
### `VehicleInventorySyndication()`
---
## Properties

### `primaryPublicationEndpoint` → `String`

---
## Methods
### `JSONFeed()` → `String`

 	JSONFeed 	Prpare written JSON file for Syndication

### `XMLFeed()` → `String`

 	XMLFeed 	Prepare written XML file for Syndication

### `publishFeed()` → `void`

 	PublishFeed 	Post the data object to the signified endpoint

### `vehicleList()` → `List<dealer__Vehicle_Inventory__c>`

 	vehicleList 	Retrieve all INSTOCK vehicles from the Database

---
