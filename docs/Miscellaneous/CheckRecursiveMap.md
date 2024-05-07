---
layout: default
---
# CheckRecursiveMap



**Class** CheckRecursiveMap

## Fields

### `public run` → `boolean`


### `public MapRunOnce` → `Map<String,Boolean>`


### `public MapRunTwice` → `Map<String,Integer>`


---
## Methods
### `public static boolean RunOnce(string triggerName)`
#### Parameters

|Param|Description|
|---|---|
|`triggerName`||

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** RunOnce

### `public static boolean RunTwice(string triggerName)`

Allows for recursion prevention on triggers that must run twice. Example is SRO that calculates charges based on a Roll-Up summary fields, which occurs after triggers fire

#### Parameters

|Param|Description|
|---|---|
|`triggerName`||

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** RunTwice

---
