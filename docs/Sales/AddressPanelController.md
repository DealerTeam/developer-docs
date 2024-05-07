---
layout: default
---
# AddressPanelController

Controls whether the Address Panel is displayed and saves new input to the contact record.


**Group** Sales

## Constructors
### `public AddressPanelController()`

Don't show Address Panel for existing Contact

---
## Properties

### `public currentContact` → `Contact`


currentContact

### `public newContact` → `Contact`


newContact

### `public showPanel` → `Boolean`


showPanel

---
## Methods
### `public PageReference openPanel()`

openPanel Show Address Panel on new Contact

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|

### `public PageReference save()`

Save Street,City,State,Zip,Country for contact

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|

### `public PageReference cancel()`
---
