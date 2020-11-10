---
layout: default
---
# ADFAPI class
---
## Properties

### `av` → `Appraisal_Vehicle__c`

### `beforeTime` → `Date`

### `buyerAccount` → `Account`

### `buyerContact` → `Contact`

### `buyerContactId` → `Id`

### `companyNumber` → `String`

@description

### `crm` → `dealer__CRMSettings__c`

DOM.Document adfDoc = new DOM.Document();

### `curbPurchaseId` → `Id`

### `customerAddressLine1` → `String`

@description

### `customerAddressLine2` → `String`

@description

### `customerCellPhone` → `String`

@description

### `customerCity` → `String`

@description

### `customerDayPhone` → `String`

@description

### `customerEmail` → `String`

@description

### `customerEveningPhone` → `String`

@description

### `customerFirstName` → `String`

@description

### `customerFullName` → `String`

@description

### `customerLastName` → `String`

@description

### `customerState` → `String`

@description

### `customerZip` → `String`

@description

### `dv` → `Desired_Vehicle__c`

### `dvList` → `List<Desired_Vehicle__c>`

### `finance` → `String`

@description

### `fromEmail` → `String`

### `fromEmailAddress` → `String`

### `isBuyInterest` → `Boolean`

### `isSaleTradeInterest` → `Boolean`

### `lead_routing` → `dealer__IntercompanyLeadRouting__c`

Intercompany Routing Table for this Request

### `objStoreLocation` → `dealer__Dealer_Location__c`

To store associated company to take related SalesUp queue

### `payload` → `String`

 ADF XML payload used to send or read

### `providerName` → `String`

@description

### `providerService` → `String`

@description

### `readableXML` → `String`

### `standardSalesUp` → `Id`

### `stockNumber` → `String`

@description

### `storeLocation` → `String`

Added MKS 1-26-16

### `supCheck` → `List<dealer__Sales_Up__c>`

### `taskList` → `List<Task>`

### `toEmail` → `String`

### `toEmailAddress` → `String`

### `trafficLog` → `Traffic_Log__c`

### `up` → `Sales_Up__c`

---
## Methods
### `assignAccount()` → `Account`

Looks for an Account to assign and if found, updates it. If no account is found, a new account is created.

### `assignContact()` → `Contact`

Looks for Contact to assign and if found, updates it. If no contact is found, a new contact is created.

### `assignInventoryRecord()` → `dealer__Vehicle_Inventory__c`

Assigns Inventory record to Sales Up

#### Parameters
|Param|Description|
|-----|-----------|
|`subX` |  xml node with vehicle data |
|`customer` |  xml node with customer data |
|`provider` |  xml node with provider data |

### `exposeADF(DOM.Xmlnode adfDom)` → `dealer__Sales_Up__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | m |

### `getInstance()` → `ADFAPI`
### `logException(ADFException e, String methodName)` → `void`

 logException sends exceptions to external logging system

#### Parameters
|Param|Description|
|-----|-----------|
|`e` |  ADFException with message |
|`methodName` |  the method where the exception was caught |

### `outputXML(Sales_Up__c s, String email)` → `void`
### `parseADF(String XML, String toAddress, String fromAddress)` → `dealer__Sales_Up__c`

Converts XML into Sales Up and related records

#### Parameters
|Param|Description|
|-----|-----------|
|`XML` |  String of ADF payload |
|`toAddress` |    toAddress description |
|`fromAddress` |  fromAddress description |

### `readXML()` → `void`
### `sendXML(String payload, String toEmail)` → `void`

 sendXML sends an ADF xml payload to the provided email

### `setCompanyNumber(String toEmail)` → `void`

MKS 1-26-16: Added Store Location information.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | l |

### `setFromAddress(String fromEmail)` → `void`

Sets e-mail as that found within the XML

#### Parameters
|Param|Description|
|-----|-----------|
|`` | l |

### `setLocationRouting(String toEmail)` → `void`

Assigns the public property of location_routing

#### Parameters
|Param|Description|
|-----|-----------|
|`toEmail` |  [email to locate routing table from] |

---
## Inner Classes

### ADFAPI.ADFException class

@description

---
