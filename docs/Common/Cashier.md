---
layout: default
---
# Cashier class

This class performs core cashiering related actions.  Cashier.cls is used throughout the invocing processes.

---
## Methods
### `emailAsyncHandler(String payload)` → `void`

Performs an outbound single email to an external handler.

#### Parameters
|Param|Description|
|-----|-----------|
|`payload` |  String containing the JSON Payload to be processed |

#### Throws
|Exception|Description|
|---------|-----------|
|`CashierException` |  Custom exception handler. |

### `getPaymentMethods()` → `List<SelectOption>`
---
