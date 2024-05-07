---
layout: default
---
# MetadataServicePatcher

See the README file for instructions on how to use this class should
should you want to generate your own MetadataService.cls instead of using the one supplied

## Fields

### `private API_VERSION` → `String`


### `private METADATA_TYPES` → `Map<String,String>`


### `private METADATA_BASE_TYPES` → `Set<String>`


---
## Methods
### `public static void patch()`
### `private static void addCopyright(List<String> lines)`
---
## Classes
### PatchException

**Inheritance**

PatchException


### LineReader

Utility class to iterate over lines in Apex source code


**Implemented types**

[Iterator&lt;string&gt;](Iterator&lt;string&gt;)
, 
[Iterable&lt;string&gt;](Iterable&lt;string&gt;)

#### Constructors
##### `public LineReader(String textData)`
---
#### Fields

##### `private LF` → `String`


##### `private textData` → `String`


---
#### Methods
##### `public Boolean hasNext()`
##### `public String next()`
##### `public Iterator&lt;String&gt; Iterator()`
---

---
