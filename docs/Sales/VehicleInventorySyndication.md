---
layout: default
---
# VehicleInventorySyndication

VehicleInventorySyndication - prepate uploadable inventory file for distribution


**Group** Sales

## Constructors
### `public VehicleInventorySyndication()`
---
## Fields

### `public primaryPublicationEndpoint` → `String`


---
## Methods
### `public static String XMLFeed()`

XMLFeed Prepare written XML file for Syndication

### `public static String JSONFeed()`

JSONFeed Prpare written JSON file for Syndication

### `public static void publishFeed()`

PublishFeed Post the data object to the signified endpoint

### `public static List<dealer__Vehicle_Inventory__c> vehicleList()`

vehicleList Retrieve all INSTOCK vehicles from the Database

---
