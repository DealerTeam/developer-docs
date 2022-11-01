# autoCompleteController

`APIVERSION: 45`

`STATUS: ACTIVE`

**Class** autoCompleteController

## Methods

### `static findSObjects(string obj, string qry, string addFields, string resultFields)`

`REMOTEACTION`

execute dynamic SOQL using user supplied input for filter and return criteria\</summary>

#### Parameters

| Param          | Description                                                          |
| -------------- | -------------------------------------------------------------------- |
| `obj`          | >Object to query                                                     |
| `qry`          | >User spuulied input we are searching for                            |
| `addFields`    | >additional fields to query against, in the form field, field, field |
| `resultFields` | >fields to be returned by SOQL                                       |

**Method** findSObjects

### `static searchSObjects(string obj, string qry, string addFields, string resultFields, string locationOnly, string additionalFilter)`

`REMOTEACTION`

#### Parameters

| Param              | Description |
| ------------------ | ----------- |
| `obj`              |             |
| `qry`              |             |
| `addFields`        |             |
| `resultFields`     |             |
| `locationOnly`     |             |
| `additionalFilter` |             |

**Method** searchSObjects

***

## Classes

### IllegalArgumentException

***
