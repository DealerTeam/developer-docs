# CheckRecursiveMap

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** CheckRecursiveMap

## Fields

### `MapRunOnce` → `Map<String,Boolean>`


### `MapRunTwice` → `Map<String,Integer>`


### `run` → `boolean`


---
## Methods
### `static RunOnce(string triggerName)`
#### Parameters

|Param|Description|
|---|---|
|`triggerName`||

#### Return

**Type**

boolean

**Description**

boolean


**Method** RunOnce

### `static RunTwice(string triggerName)`

Allows for recursion prevention on triggers that must run twice. Example is SRO that calculates charges based on a Roll-Up summary fields, which occurs after triggers fire

#### Parameters

|Param|Description|
|---|---|
|`triggerName`||

#### Return

**Type**

boolean

**Description**

boolean


**Method** RunTwice

---
