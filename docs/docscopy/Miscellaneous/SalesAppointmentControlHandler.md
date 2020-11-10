---
layout: default
---
# SalesAppointmentControlHandler class

 		Handler for SalesAppointmentControl trigger

---
## Methods
### `handleAfterInsert(List<dealer__Sales_Appointment__c> salesApptList)` → `void`

 Creates related event on after Insert context

#### Parameters
|Param|Description|
|-----|-----------|
|`dealer__Sales_Appointment__c` |  list |

### `handleAfterUpdate(List<dealer__Sales_Appointment__c> salesApptList)` → `void`

 on after Update context

#### Parameters
|Param|Description|
|-----|-----------|
|`dealer__Sales_Appointment__c` |  list |

### `handleBeforeDateTime(List<dealer__Sales_Appointment__c> salesApptList)` → `void`

 Populate Date and Time fields with DateTime value on before context

#### Parameters
|Param|Description|
|-----|-----------|
|`dealer__Sales_Appointment__c` |  list |

### `handleBeforeDelete(List<dealer__Sales_Appointment__c> oldSalesApptList)` → `void`

 	Deletes related Event records on before delete context

#### Parameters
|Param|Description|
|-----|-----------|
|`dealer__Sales_Appointment__c` |  old list |

---
