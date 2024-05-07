---
layout: default
---
# VitalApplicationMetrics

Core telemetry data collection class


**Group** Core //TODO Add Test Coverage!!

## Methods
### `public static void activeUserCount()`

Vital telemetry data on active users within the last 7 days.  This value is reported to the LMO


**Method** activeUserCount

### `public static void logException(String exceptionObject)`

`FUTURE`

logException receives a json serialized object and makes a callout to external logging

#### Parameters

|Param|Description|
|---|---|
|`exception`|serialized telemetry wrapper|

---
## Classes
### TelemetryWrapper

Wrapper to be used by methods calling the logException method to provide the expected serialized object

#### Fields

##### `public message` → `string`


##### `public application` → `string`


##### `public severity` → `string`


---

---
