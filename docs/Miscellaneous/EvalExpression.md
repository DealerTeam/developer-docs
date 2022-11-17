# EvalExpression

`APIVERSION: 45`

`STATUS: ACTIVE`

**Implemented types**

[IExpression](IExpression)

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
## Fields

### `MAX_INTEGER` → `Decimal`


### `MIN_INTEGER` → `Decimal`


### `ONE` → `Decimal`


### `ZERO` → `Decimal`


### `mc` → `MathContext`


### `variables` → `Map<String,Object>`


---
## Methods
### `eval()`

Evaluates the expression.

#### Return

**Type**

Decimal

**Description**

the result of the expression.

### `evalBool()`
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

### `static addOperator(Operator operator)`

Adds to the list of supported operators

#### Parameters

|Param|Description|
|---|---|
|`operator`|The operator to add|

#### Return

**Type**

Operator

**Description**

the previous operator with that name, or `null` if there was none

### `static addUnaryOperator(UnaryOperator operator)`

Adds to the list of supported unary operators

#### Parameters

|Param|Description|
|---|---|
|`operator`|The operator to add|

#### Return

**Type**

UnaryOperator

**Description**

the previous operator with that name, or `null` if there was none

### `static addFunction(Function function)`

Adds to the list of supported functions

#### Parameters

|Param|Description|
|---|---|
|`function`|The function to add|

#### Return

**Type**

Function

**Description**

the previous operator with that name, or `null` if there was none

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

### `getExpressionTokenizer()`

Get an iterator for this expression, allows iterating over an expression token by token.

#### Return

**Type**

Iterator&lt;Token&gt;

**Description**

a new iterator instance for this expression.

### `toRPN()`

Get a string representation of the RPN (Reverse Polish Notation) for this expression.

#### Return

**Type**

String

**Description**

a string with the RPN representation for this expression.

### `static isNumber(String st)`

Is the string a number?

#### Parameters

|Param|Description|
|---|---|
|`st`|the string|

#### Return

**Type**

Boolean

**Description**

true if the input string is a number

### `getDeclaredVariables()`

Exposing declared variables in the expression

#### Return

**Type**

Set&lt;String&gt;

**Description**

declared variables

### `getReferencedVariables()`

Returns a set of variable names referenced in the expression string

### `getDeclaredOperators()`

Exposing declared operators in the expression

#### Return

**Type**

Set&lt;String&gt;

**Description**

declared operators

### `getDeclaredFunctions()`

Exposing declared functions

#### Return

**Type**

Set&lt;String&gt;

**Description**

declared functions

### `equals(Object obj)`
### `hashCode()`
---
## Enums
### Associability

### TokenType

---
## Classes
### AbsFunction

**Inheritance**

AbsFunction

#### Constructors
##### `AbsFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### AcosFunction

**Inheritance**

AcosFunction

#### Constructors
##### `AcosFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### AddOperator

**Inheritance**

AddOperator

#### Constructors
##### `AddOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### AndOperator

**Inheritance**

AndOperator

#### Constructors
##### `AndOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### AsinFunction

**Inheritance**

AsinFunction

#### Constructors
##### `AsinFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### AtanFunction

**Inheritance**

AtanFunction

#### Constructors
##### `AtanFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### BaseOperator

Base definition of a supported operator

#### Methods
##### `getOper()`
---

### CeilingFunction

**Inheritance**

CeilingFunction

#### Constructors
##### `CeilingFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### CosFunction

**Inheritance**

CosFunction

#### Constructors
##### `CosFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### CoshFunction

**Inheritance**

CoshFunction

#### Constructors
##### `CoshFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### DegFunction

**Inheritance**

DegFunction

#### Constructors
##### `DegFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### DivideOperator

**Inheritance**

DivideOperator

#### Constructors
##### `DivideOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### EqualOperator

**Inheritance**

EqualOperator

#### Constructors
##### `EqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### ExpressionException

Expression evaluator exceptions


**Inheritance**

ExpressionException


### FloorFunction

**Inheritance**

FloorFunction

#### Constructors
##### `FloorFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### Function
#### Constructors
##### `Function(String name, Integer numParams)`
###### Parameters

|Param|Description|
|---|---|
|`name`|name of the function|
|`numParams`|number of parameters for this function; `-1` denotes a variable number of parameters|


**Method** Creates a new function with given name and parameter count

---
#### Methods
##### `getName()`
##### `getNumParams()`
##### `numParamsVaries()`
##### `apply(List&lt;Object&gt; parameters, MathContext mc)`

Implementation for this function.

###### Parameters

|Param|Description|
|---|---|
|`parameters`|passed by evaluator as a List of Object values|

###### Return

**Type**

Object

**Description**

a new Object value as a computing result

---

### GreaterEqualOperator

**Inheritance**

GreaterEqualOperator

#### Constructors
##### `GreaterEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### GreaterOperator

**Inheritance**

GreaterOperator

#### Constructors
##### `GreaterOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### IfFunction

**Inheritance**

IfFunction

#### Constructors
##### `IfFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### IllegalArgumentException

**Inheritance**

IllegalArgumentException


### IllegalStateException

**Inheritance**

IllegalStateException


### LessEqualOperator

**Inheritance**

LessEqualOperator

#### Constructors
##### `LessEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### LessOperator

**Inheritance**

LessOperator

#### Constructors
##### `LessOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### Log10Function

**Inheritance**

Log10Function

#### Constructors
##### `Log10Function(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### LogFunction

**Inheritance**

LogFunction

#### Constructors
##### `LogFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### MathContext
#### Constructors
##### `MathContext(Integer precision, RoundingMode roundingMode)`
---
#### Fields

##### `precision` → `Integer`


##### `roundingMode` → `RoundingMode`


---

### MaxFunction

**Inheritance**

MaxFunction

#### Constructors
##### `MaxFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### MinFunction

**Inheritance**

MinFunction

#### Constructors
##### `MinFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### ModOperator

**Inheritance**

ModOperator

#### Constructors
##### `ModOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### MultiplyOperator

**Inheritance**

MultiplyOperator

#### Constructors
##### `MultiplyOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### NegativeOperator

**Inheritance**

NegativeOperator

#### Constructors
##### `NegativeOperator(String oper)`
---
#### Methods
##### `override apply(Object v)`
---

### NotEqualOperator

**Inheritance**

NotEqualOperator

#### Constructors
##### `NotEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### NotFunction

**Inheritance**

NotFunction

#### Constructors
##### `NotFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### Operator

Abstract definition of a supported operator. An operator is defined by its name (pattern), precedence, and if it is left or right associative.


**Inheritance**

Operator

#### Constructors
##### `Operator(String oper, Integer precedence, Associability assoc)`

Creates a new operator.

###### Parameters

|Param|Description|
|---|---|
|`oper`|operator name (pattern)|
|`precedence`|operator precedence|
|`assoc`|true if the operator is left associative, else false|

---
#### Methods
##### `getPrecedence()`
##### `isLeftAssoc()`
##### `apply(Object v1, Object v2, MathContext mc)`

Implementation for this operator

###### Parameters

|Param|Description|
|---|---|
|`v1`|operand 1|
|`v2`|operand 2|

###### Return

**Type**

Object

**Description**

result of the operation

---

### OrOperator

**Inheritance**

OrOperator

#### Constructors
##### `OrOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### PositiveOperator

**Inheritance**

PositiveOperator

#### Constructors
##### `PositiveOperator(String oper)`
---
#### Methods
##### `override apply(Object v)`
---

### PowOperator

**Inheritance**

PowOperator

#### Constructors
##### `PowOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### RadFunction

**Inheritance**

RadFunction

#### Constructors
##### `RadFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### RandomFunction

**Inheritance**

RandomFunction

#### Constructors
##### `RandomFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### RoundFunction

**Inheritance**

RoundFunction

#### Constructors
##### `RoundFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### SinFunction

**Inheritance**

SinFunction

#### Constructors
##### `SinFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### SinhFunction

**Inheritance**

SinhFunction

#### Constructors
##### `SinhFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### SqrtFunction

**Inheritance**

SqrtFunction

#### Constructors
##### `SqrtFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### SubtractOperator

**Inheritance**

SubtractOperator

#### Constructors
##### `SubtractOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `override apply(Object v1, Object v2, MathContext mc)`
---

### TanFunction

**Inheritance**

TanFunction

#### Constructors
##### `TanFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### TanhFunction

**Inheritance**

TanhFunction

#### Constructors
##### `TanhFunction(String name, Integer numParams)`
---
#### Methods
##### `override apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### Token
#### Constructors
##### `Token(TokenType type, String text)`
---
#### Fields

##### `text` → `String`


##### `type` → `TokenType`


---

### Tokenizer

**Implemented types**

[Iterator&lt;Token&gt;](Iterator&lt;Token&gt;)

#### Constructors
##### `Tokenizer(String input, EvalExpression expr)`

Creates a new tokenizer for an expression.

###### Parameters

|Param|Description|
|---|---|
|`input`|expression string|

---
#### Methods
##### `hasNext()`
##### `next()`
##### `getPos()`

Get the actual character position in the string.

###### Return

**Type**

Integer

**Description**

the actual character position.

---

### UnaryOperator

**Inheritance**

UnaryOperator

#### Constructors
##### `UnaryOperator(String oper)`

Creates a new operator.

###### Parameters

|Param|Description|
|---|---|
|`oper`|operator name (pattern)|

---
#### Methods
##### `apply(Object v)`

Implementation for this unary operator

###### Parameters

|Param|Description|
|---|---|
|`v`|operand|

###### Return

**Type**

Object

**Description**

result of the operation

---

---
