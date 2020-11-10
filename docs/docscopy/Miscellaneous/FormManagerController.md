---
layout: default
---
# FormManagerController class

Service Layer controller for Aura and LWC components.  Used within the Form Manager UX.

---
## Methods
### `addForms(String recordId, List<String> formIds)` → `Boolean`

 addForms description

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |
|`formIds` |   formIds description |

### `allForms(String recordId)` → `List<Form__c>`

 allForms description

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |

### `applicableForms(String recordId)` → `List<Form__c>`

 applicableForms description

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |

### `formData(String recordId)` → `FormWrapper`

 formData description

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |

### `getForms(Id locId)` → `FMFormWrapper`

 getForms description

#### Parameters
|Param|Description|
|-----|-----------|
|`locId` |  locId description |

### `getTabUrl()` → `String`

 getTabUrl description

### `printForms(String recordId, List<String> formIds)` → `PrintResult`

 printForms description

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |
|`formIds` |   formIds description |

### `removeForm(String recordId, String formId)` → `Boolean`

 removeForm description

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |
|`formId` |    formId description |

### `selectedForms(String recordId)` → `List<Form__c>`

 selectedForms description

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |

---
## Inner Classes

### FormManagerController.FMFormWrapper class

Nested wrapper class

---
#### Constructors
##### `FMFormWrapper(List<Form__c> availableFormsT, List<FormRef__c> selectedFormRefsT)`

List of form reference of selected forms /** FMFormWrapper description
###### Parameters
|Param|Description|
|-----|-----------|
|`availableFormsT` |    availableFormsT description |
|`selectedFormRefsT` |  selectedFormRefsT description |

---
### FormManagerController.FormWrapper class

This wrapper class organizes the form data for column based layout usage.

---
#### Constructors
##### `FormWrapper(List<Form__c> availableForms, List<Form__c> applicableForms, List<Form__c> selectedForms)`

 FormWrapper description
###### Parameters
|Param|Description|
|-----|-----------|
|`availableForms` |   availableForms description |
|`applicableForms` |  applicableForms description |
|`selectedForms` |    selectedForms description |

---
### FormManagerController.PrintResult class

@description

---
#### Constructors
##### `PrintResult(String result, List<String> formsToAdd)`

 PrintResult description
###### Parameters
|Param|Description|
|-----|-----------|
|`result` |      result description |
|`formsToAdd` |  formsToAdd description |

---
#### Properties

##### `formsToAdd` → `List<String>`

List of forms to be added to the print request

##### `result` → `String`

result contains the print request result

---
