---
layout: default
---
# CheckRecursiveMap class

@description

---
## Properties

### `MapRunOnce` → `Map<String,Boolean>`

@description

### `MapRunTwice` → `Map<String,Integer>`

@description

### `run` → `boolean`

@description

---
## Methods
### `RunOnce(string triggerName)` → `boolean`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `RunTwice(string triggerName)` → `boolean`

Allows for recursion prevention on triggers that must run twice. Example is SRO that calculates charges based on a Roll-Up summary fields, which occurs after triggers fire

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

---
