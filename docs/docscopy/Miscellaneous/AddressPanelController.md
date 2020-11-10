---
layout: default
---
# AddressPanelController class

Controls whether the Address Panel is displayed and saves new input to the contact record.

---
## Constructors
### `AddressPanelController()`

Don't show Address Panel for existing Contact
---
## Properties

### `currentContact` → `Contact`

@description

### `newContact` → `Contact`

@description

### `showPanel` → `Boolean`

@description

---
## Methods
### `cancel()` → `PageReference`
### `openPanel()` → `PageReference`

Show Address Panel on new Contact

### `save()` → `PageReference`

Save Street,City,State,Zip,Country for contact

---
