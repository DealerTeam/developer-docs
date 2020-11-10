---
layout: default
---
# ClaimControlHandler class

Claim Control Handler - Service Layer Application Class

---
## Methods
### `AssignClaimNumber(List<Claim__c> triggerNew)` → `void`

Utility method to Assign Claim Number depending upon the custom settings

#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |

### `BeforeHandlerforCalcultingTax(List <dealer__ClaimItem__c> ListServiceEstimateLine)` → `void`
### `ChangeClaimNumber(List<Claim__c> triggerNew, Map<Id, Claim__c> oldMap)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |
|`` | p |

### `ServiceVehicleForServiceEstimate(List<dealer__Claim__c> ServiceEstimateList)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |

### `handleRollUp(List<ClaimSubItem__c> subLines, List<ClaimSubItem__c> beforeSubLines)` → `void`

Total Values for the parent line

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |
|`` | s |

### `handleRollUp(List<ClaimItem__c> seLines)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `preflight(List<ClaimSubItem__c> subLines)` → `void`

Pre-clear values that are going to be saved to the object

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `preventEdit(List<ClaimItem__c> seLines)` → `void`

Prevent Converted Estimates from being Edited

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |
|`` | s |

### `setAccountVehicleByROReference(List<Claim__c> estimateList)` → `void`

When creating an estimate exclusively from an RO reference, the Account and Vehicle will populate

#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |

### `setClaimItemName(List<ClaimItem__c> triggerNew)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`List<ClaimItem__c>` |  trigger new context |

### `setClaimSubItemName(List<ClaimSubItem__c> triggerNew)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`List<ClaimSubItem__c>` |  trigger new context |

### `setCompanyNumber(List<Claim__c> estimateList)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |

### `setLocation(List<Claim__c> estimateList)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |

### `updateOdometer(List<Claim__c> triggerNew, Map<Id, Claim__c> triggerOldMap)` → `void`

Updates service vehicle mileage when claim is put in finalized status

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

### `updateSRO(List<Claim__c> triggerNew)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | w |

### `updateServiceLineTax(List <dealer__ClaimItem__c> ListServiceEstimateLine)` → `void`

W-001780 Ends

### `updateTaxableCalculation(List<dealer__Claim__c> SEList, Map<Id,dealer__Claim__c> ServiceEstimateOldMap)` → `void`

W-001780 Begins. Forces total tax on Service Estimate to be recalculated if Taxable flag is changed by firing triggers that calculate Service Estimate Line Tax

#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |
|`` | p |

---
## Inner Classes

### ClaimControlHandler.ClaimControlHandlerException class

@description

---
