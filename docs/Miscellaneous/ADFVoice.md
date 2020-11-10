---
layout: default
---
# ADFVoice class

Parses ADF Voice doc to identify Customer and Sales Up

---
## Constructors
### `ADFVoice()`
---
## Properties

### `callerFirst` → `String`

@description

### `callerLast` → `String`

@description

### `companyNumber` → `String`

@description

### `phoneNumber` → `String`

@description

---
## Methods
### `alertFailedADF(String emailBody)` → `void`

Sends email alert notifying DealerTeam of ADF Voice Package Failure for an Org.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | y |

### `parseADF(String XML, String toEmail)` → `boolean`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | L |
|`` | l |

### `parseDateTime(String d)` → `DateTime`

Formats Date/Time to the following: 2013-06-04T23:41:55Z

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `setCompanyNumber(String toEmail)` → `void`

Capture local part of email for reference in routing table.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | l |

### `unpackDoc(DOM.Xmlnode nodes)` → `boolean`

Unpack XML, Set Traffic Type, Locate Customer and get Matching Sales Up

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

---
## Inner Classes

### ADFVoice.ADFException class

@description

---
