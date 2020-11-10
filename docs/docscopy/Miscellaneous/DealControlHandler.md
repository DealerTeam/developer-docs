---
layout: default
---
# DealControlHandler class

This class is exclusively for handling trigger context operations on the Deal__c object

---
## Constructors
### `DealControlHandler()`
### `DealControlHandler(List<dealer__Deal__c> triggerNew)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |

---
## Properties

### `SalesUpID` → `Map<Id,dealer__Deal__c>`

@description

### `accountIds` → `Set<Id>`

@description

### `accountsToUpdate` → `Set<Account>`

@description

### `activeUserMap` → `User>`

@description

### `companies` → `Set<String>`

@description

### `contactKey` → `Contact>`

@description

### `custAccounts` → `Account>`

@description

### `custContacts` → `Contact>`

@description

### `customerExternalReference` → `Set<String>`

@description

### `customerIds` → `Set<ID>`

@description

### `dealStatus` → `String>`

@description

### `dispositions` → `List<dealer__SalesDispositions__c>`

@description

### `dmsConfiguration` → `DMSConfig__mdt>`

@description

### `enumbers` → `Set<String>`

@description

### `relatedContacts` → `List<Contact>>`

### `vehicleExtRef` → `Set<String>`

@description

### `vehicleMap` → `Vehicle_Inventory__c>`

@description

---
## Methods
### `createDefaultFees(List < Deal__c > deals)` → `void`
### `customersToUpdateMethod( List<dealer__Deal__c> allDealer)` → `void`

Update customersToUpdateMethod - After Insert Method

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

### `dataLoadSupport(List<Deal__c> triggerNew)` → `List<Deal__c>`

Foreign key support for data loading

#### Parameters
|Param|Description|
|-----|-----------|
|`configName` |  configName description |
|`` | w |

### `deleteDealFees(List<Deal__c> deals)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `handleAccountUpdate(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 handleAccountUpdate updates buyer and co buyer fields from b2c account when buyer/cobuyer account is changed on a deal

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     trigger.New |
|`triggerOldMap` |  trigger.OldMap |

### `handleContactUpdate(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 handleAccountUpdate updates buyer and co buyer fields from b2b contact when buyer/cobuyer contact is changed on a deal

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     trigger.New |
|`triggerOldMap` |  trigger.OldMap |

### `preventDeleteEquipmentOrders(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 preventDeleteEquipmentOrders Deletes equipment inventory records of Record Type Order when removed from Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

### `salesFeesUpdateMethod(Map<Id, Deal__c> triggerNewMap, Map<Id, Deal__c> triggerOldMap)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | p |
|`` | p |

### `salesUpMethod( List<dealer__Deal__c> allDealer )` → `void`

pdate SalesUpMethod - After Method

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

### `setConversionDescription(List<Deal__c> triggerNew)` → `List<Deal__c>`
### `setDealDispositionBasedOnStatus(List<Deal__c> triggerNew)` → `List<Deal__c>`

 setDealDispositionBasedOnStatus

#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |

### `setDealGross(List<Deal__c> triggerNew)` → `void`

Runs on insert and update to calculate front and back gross based on custom metadata type record eval string

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

### `setDefaults(List<Deal__c> triggerNew)` → `void`

Set defaults in deal create based on the mapped configurations

#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |

### `sumTaxes(List<Deal__c> triggerNew)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |
|`` | w |

### `updateAccount(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 updateAccount pushes changes made to buyer/cobuyer fields to the associated account when the saveToAccount boolean is selected for either buyer or cobuyer

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     trigger.New |
|`triggerOldMap` |  trigger.OldMap |

### `updateDealerFields(List<dealer__Deal__c> allDealer)` → `void`

updateDealerFields Before Insert

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

### `updateEquipmentPricing(List<Deal__c> triggerNew)` → `void`

 populateEquipmentPricing Sets Equipment Inventory pricing fields on inserted deals with equipmentInventory__c

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew description |

### `updateEquipmentPricing(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 populateEquipmentPricing Sets Equipment Inventory pricing fields on updated deals if equipmentInventory__c was changed

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

### `updateFinanceGross(List<Deal__c> triggerNew)` → `void`

Calculates finance gross based on finance company and deal values

### `updateOpportunity(List<dealer__Deal__c> triggerNew)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |

### `updateRelatedEquipmentInventory(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 updateRelatedEquipmentInventory Update pricing on Order type EquipmentInventory__c records if pricing on deal changes

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

### `updateRelatedPricing(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |
|`` | p |

### `updateSalesTeam(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`
### `updateSchedulePricing(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`
### `updateVehicleGross(List<Deal__c> triggerNew)` → `void`

 updateVehicleGross Calculates chassis, conversion and total vehicle gross and percents

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew inserted or updated deals |

### `updateVehicleMasterInfo(List<Deal__c> triggerNew)` → `void`

 updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  inserted deals |

### `updateVehicleMasterInfo(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  updated deals |

### `updateVehiclePricing(List<Deal__c> triggerNew)` → `void`

 updateVehiclePricing updates vehicle related fields on insert

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew inserted deals |

### `updateVehiclePricing(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)` → `void`

 updateVehiclePricing updates vehicle related fields on update

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew updated deals |

### `updateVehiclePricingTotals(List<Deal__c> triggerNew)` → `void`

 updateVehiclePricingTotals updates price and cost totals on insert and update

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew inserted or updated deals |

---
## Inner Classes

### DealControlHandler.DealControlHandlerException class
---
