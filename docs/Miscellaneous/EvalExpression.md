# EvalExpression

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `EvalExpression(String expression)`

Creates a new expression instance from an expression string.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'`|

### `EvalExpression(String expression, Map<String,Object> variables)`

Creates a new expression instance from an expression string with the given variables.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'`|
|`variables`|a mapping of variables|

### `EvalExpression(String expression, MathContext mc)`

Creates a new expression instance from an expression string with a default MathContext.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'`|
|`mc`|an instance of MathContext|

### `EvalExpression(String expression, Map<String,Object> variables, MathContext mc)`

Creates a new expression instance from an expression string with the given variables and a default MathContext.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression, eg: `2.4*sin(3)/(2-4)` or `sin(y)>0 && max(z, 3)>3`|
|`variables`|a mapping of variables|
|`mc`|an instance of MathContext|

---
## Methods
### `eval()`

Evaluates the expression.

#### Return

**Type**

Decimal

**Description**

the result of the expression.

### `setPrecision(Integer precision)`

Sets the precision for expression evaluation

#### Parameters

|Param|Description|
|---|---|
|`precision`|the new precision|

#### Return

**Type**

EvalExpression

**Description**

the expression, allows to chain methods

### `setRoundingMode(RoundingMode roundingMode)`

Sets the rounding mode for expression evaluation

#### Parameters

|Param|Description|
|---|---|
|`rounding`|the new rounding mode|

#### Return

**Type**

EvalExpression

**Description**

the expression, allows to chain methods

### `setVariable(String variable, Object value)`

Sets a variable value.

#### Parameters

|Param|Description|
|---|---|
|`variable`|the variable to set|
|`value`|the variable value|

#### Return

**Type**

EvalExpression

**Description**

the expression for chaining

### `with(String variable, Object value)`

Sets a variable value.

#### Parameters

|Param|Description|
|---|---|
|`variable`|The variable to set|
|`value`|The variable value|

#### Return

**Type**

EvalExpression

**Description**

the expression for chaining

### `matching(Map<String,Object> fieldValues)`

Matches a value from the passed value set for variables replacement.

#### Parameters

|Param|Description|
|---|---|
|`sObject`|populated fields|

#### Return

**Type**

EvalExpression

**Description**

the matched expression for chaining

---
## Classes
### MathContext
#### Constructors
##### `MathContext(Integer precision, RoundingMode roundingMode)`
---
#### Fields

##### `precision` → `Integer`


##### `roundingMode` → `RoundingMode`


---

---
