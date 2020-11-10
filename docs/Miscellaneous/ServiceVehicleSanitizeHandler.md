---
layout: default
---
# ServiceVehicleSanitizeHandler class

Trigger level class for handling servicevehicle records

---
## Methods
### `UpdateApprisals(List<Service_Vehicle__c> triggerNew)` → `void`

Performs an update to the service vehicle related fields associated with the appraisal if vales have changed.

#### Parameters
|Param|Description|
|-----|-----------|
|`Trigger.new` |  context list of Service Vehicles |

### `UpdateVehicleConversion(Map<Id, Service_Vehicle__c> triggerNew, Map<Id, Service_Vehicle__c> oldMap)` → `void`

 UpdateVehicleConversion description

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew description |
|`oldMap` |      oldMap description |

### `populateRelatedData(List<Service_Vehicle__c> triggerNew, Map<ID, Service_Vehicle__c> triggerOldMap )` → `void`

 populateRelatedData description

#### Parameters
|Param|Description|
|-----|-----------|
|`newSV` |  Trigger.new context variable |
|`oldVehicleMap` |  oldVehicleMap description |

### `preventDelete(List<Service_Vehicle__c> triggerNew)` → `void`

 preventDelete description

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  list of Service vehicles |

### `setSystemValues(List<Service_Vehicle__c> triggerNew)` → `void`

 setSystemValues description

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew description |

---
