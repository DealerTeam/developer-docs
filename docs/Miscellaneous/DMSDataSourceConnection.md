---
layout: default
---
# DMSDataSourceConnection

**Inheritance**

DMSDataSourceConnection

## Constructors
### `public DMSDataSourceConnection(DataSource connectionInfo)`
---
## Fields

### `public connectionInfo` → `DataSource`


### `public context` → `object`


---
## Methods
### `public override List<DataSource.Table> sync()`

syncs external data

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.Table>`|return List<Datasource.Table>|

### `public override DataSource query(DataSource context)`

queries external data

#### Returns

|Type|Description|
|---|---|
|`DataSource`|return DataSource.TableResult|

### `public override List<DataSource.TableResult> search(DataSource context)`

searches external data

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.TableResult>`|return List < DataSource.TableResult >|

### `public override List<DataSource.UpsertResult> upsertRows(DataSource context)`

Upserts data

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.UpsertResult>`|return List<DataSource.UpsertResult>|

### `public override List<DataSource.DeleteResult> deleteRows(DataSource context)`

deletes data in external system.

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.DeleteResult>`|return List<DataSource.DeleteResult>|

---
