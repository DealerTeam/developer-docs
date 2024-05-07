---
layout: default
---
# DMSSyncBulkLoadBatch

**Implemented types**

[Database.Batchable&lt;String&gt;](Database.Batchable&lt;String&gt;)

## Constructors
### `global DMSSyncBulkLoadBatch(List<String> csvData, String fileType)`
---
## Fields

### `private dataHeader` → `List<String>`


### `private dataRows` → `List<String>`


### `private businessType` → `String`


### `private personType` → `String`


### `private dataType` → `String`


---
## Methods
### `public Iterable<String> start(Database BC)`
### `public void execute(Database info, List<String> strings)`
### `public void finish(Database info)`
---
