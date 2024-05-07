---
layout: default
---
# EvalExpression

**Implemented types**

[IExpression](IExpression)

## Constructors
### `global EvalExpression(String expression)`

Creates a new expression instance from an expression string.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'`|

### `global EvalExpression(String expression, Map<String,Object> variables)`

Creates a new expression instance from an expression string with the given variables.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'`|
|`variables`|a mapping of variables|

### `global EvalExpression(String expression, MathContext mc)`

Creates a new expression instance from an expression string with a default MathContext.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'`|
|`mc`|an instance of MathContext|

### `global EvalExpression(String expression, Map<String,Object> variables, MathContext mc)`

Creates a new expression instance from an expression string with the given variables and a default MathContext.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the expression, eg: `2.4*sin(3)/(2-4)` or `sin(y)>0 && max(z, 3)>3`|
|`variables`|a mapping of variables|
|`mc`|an instance of MathContext|

---
## Fields

### `public ZERO` → `Decimal`


### `public ONE` → `Decimal`


### `public MAX_INTEGER` → `Decimal`


### `public MIN_INTEGER` → `Decimal`


### `private operators` → `Map<String,Operator>`


### `private unaryOperators` → `Map<String,UnaryOperator>`


### `private functions` → `Map<String,Function>`


### `private caseInsensitiveTokens` → `Set<TokenType>`


### `private constants` → `Map<String,Object>`


### `public mc` → `MathContext`


### `private expression` → `String`


### `public variables` → `Map<String,Object>`


### `private stringVarCount` → `Integer`


---
## Properties

### `private rpn` → `List<Token>`


---
## Methods
### `private List<Token> shuntingYard(String expression)`

Implementation of the Shunting Yard algorithm to transform an infix expression to a RPN expression.

#### Parameters

|Param|Description|
|---|---|
|`expression`|the input expression in infx.|

#### Returns

|Type|Description|
|---|---|
|`List<Token>`|an RPN representation of the expression, with each token as a list member.|

### `private static Boolean isHigherPriority(Operator o1, Operator o2)`
### `private static Token peekToken(EvalStack stack)`
### `private static Token popToken(EvalStack stack)`
### `private static TokenType peekTokenType(EvalStack stack)`
### `global Decimal eval()`

Evaluates the expression.

#### Returns

|Type|Description|
|---|---|
|`Decimal`|the result of the expression.|

### `public Boolean evalBool()`
### `global EvalExpression setPrecision(Integer precision)`

Sets the precision for expression evaluation

#### Parameters

|Param|Description|
|---|---|
|`precision`|the new precision|

#### Returns

|Type|Description|
|---|---|
|`EvalExpression`|the expression, allows to chain methods|

### `global EvalExpression setRoundingMode(RoundingMode roundingMode)`

Sets the rounding mode for expression evaluation

#### Parameters

|Param|Description|
|---|---|
|`rounding`|the new rounding mode|

#### Returns

|Type|Description|
|---|---|
|`EvalExpression`|the expression, allows to chain methods|

### `public static Operator addOperator(Operator operator)`

Adds to the list of supported operators

#### Parameters

|Param|Description|
|---|---|
|`operator`|The operator to add|

#### Returns

|Type|Description|
|---|---|
|`Operator`|the previous operator with that name, or `null` if there was none|

### `public static UnaryOperator addUnaryOperator(UnaryOperator operator)`

Adds to the list of supported unary operators

#### Parameters

|Param|Description|
|---|---|
|`operator`|The operator to add|

#### Returns

|Type|Description|
|---|---|
|`UnaryOperator`|the previous operator with that name, or `null` if there was none|

### `public static Function addFunction(Function function)`

Adds to the list of supported functions

#### Parameters

|Param|Description|
|---|---|
|`function`|The function to add|

#### Returns

|Type|Description|
|---|---|
|`Function`|the previous operator with that name, or `null` if there was none|

### `global EvalExpression setVariable(String variable, Object value)`

Sets a variable value.

#### Parameters

|Param|Description|
|---|---|
|`variable`|the variable to set|
|`value`|the variable value|

#### Returns

|Type|Description|
|---|---|
|`EvalExpression`|the expression for chaining|

### `global EvalExpression with(String variable, Object value)`

Sets a variable value.

#### Parameters

|Param|Description|
|---|---|
|`variable`|The variable to set|
|`value`|The variable value|

#### Returns

|Type|Description|
|---|---|
|`EvalExpression`|the expression for chaining|

### `global EvalExpression matching(Map<String,Object> fieldValues)`

Matches a value from the passed value set for variables replacement.

#### Parameters

|Param|Description|
|---|---|
|`sObject`|populated fields|

#### Returns

|Type|Description|
|---|---|
|`EvalExpression`|the matched expression for chaining|

### `private boolean isValidVariable(Object value)`
### `private void validateVariable(Object value)`
### `public Iterator<Token> getExpressionTokenizer()`

Get an iterator for this expression, allows iterating over an expression token by token.

#### Returns

|Type|Description|
|---|---|
|`Iterator<Token>`|a new iterator instance for this expression.|

### `private void validate(List<Token> rpn)`

Check that the expression have enough numbers and variables to fit the requirements of the operators and functions, also check for only 1 result stored at the end of the evaluation.

### `public String toRPN()`

Get a string representation of the RPN (Reverse Polish Notation) for this expression.

#### Returns

|Type|Description|
|---|---|
|`String`|a string with the RPN representation for this expression.|

### `public static Boolean isNumber(String st)`

Is the string a number?

#### Parameters

|Param|Description|
|---|---|
|`st`|the string|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|true if the input string is a number|

### `private static Boolean isNumeric(Object o)`
### `private static Decimal toRadians(Decimal angdeg)`

Converts an angle measured in degrees to an approximately equivalent angle measured in radians. The conversion from degrees to radians is generally inexact.

#### Parameters

|Param|Description|
|---|---|
|`angdeg`|an angle, in degrees|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|measurement of the angle `angdeg` in radians.|

### `private static Decimal toDegrees(Decimal angrad)`

Converts an angle measured in radians to an approximately equivalent angle measured in degrees. The conversion from radians to degrees is generally inexact; users should not expect `cos(toRadians(90.0))` to exactly equal `0.0`

#### Parameters

|Param|Description|
|---|---|
|`angrad`|an angle, in radians|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|the measurement of the angle `angrad` in degrees.|

### `private static String charAt(String str, Integer ind)`

Returns the string of a character at `ind` in `str`

### `private static Decimal round(Decimal d, MathContext mc)`

Round a Decimal given a MathContext

### `private static Decimal nullValue(Decimal d)`

Get value as zero in case of null

#### Parameters

|Param|Description|
|---|---|
|`d`|Decimal that may be null|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|d if not null, zero otherwise|

### `private static void unshift(List<Object> l, Object d)`

Safely inserts an element at the beginning of a potentially empty list

### `public Set<String> getDeclaredVariables()`

Exposing declared variables in the expression

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|declared variables|

### `public Set<String> getReferencedVariables()`

Returns a set of variable names referenced in the expression string

### `public Set<String> getDeclaredOperators()`

Exposing declared operators in the expression

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|declared operators|

### `public Set<String> getDeclaredFunctions()`

Exposing declared functions

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|declared functions|

### `public Boolean equals(Object obj)`
### `public Integer hashCode()`
### `private static String stringVariable(Integer i)`
---
## Enums
### TokenType

### Associability

---
## Classes
### Function
#### Constructors
##### `public Function(String name, Integer numParams)`
###### Parameters

|Param|Description|
|---|---|
|`name`|name of the function|
|`numParams`|number of parameters for this function; `-1` denotes a variable number of parameters|


**Method** Creates a new function with given name and parameter count

---
#### Methods
##### `public String getName()`
##### `public Integer getNumParams()`
##### `public Boolean numParamsVaries()`
##### `public Object apply(List&lt;Object&gt; parameters, MathContext mc)`

Implementation for this function.

###### Parameters

|Param|Description|
|---|---|
|`parameters`|passed by evaluator as a List of Object values|

###### Returns

|Type|Description|
|---|---|
|`Object`|a new Object value as a computing result|

---

### BaseOperator

Base definition of a supported operator

#### Methods
##### `public String getOper()`
---

### Operator

Abstract definition of a supported operator. An operator is defined by its name (pattern), precedence, and if it is left or right associative.


**Inheritance**

Operator

#### Constructors
##### `public Operator(String oper, Integer precedence, Associability assoc)`

Creates a new operator.

###### Parameters

|Param|Description|
|---|---|
|`oper`|operator name (pattern)|
|`precedence`|operator precedence|
|`assoc`|true if the operator is left associative, else false|

---
#### Methods
##### `public Integer getPrecedence()`
##### `public Boolean isLeftAssoc()`
##### `public Object apply(Object v1, Object v2, MathContext mc)`

Implementation for this operator

###### Parameters

|Param|Description|
|---|---|
|`v1`|operand 1|
|`v2`|operand 2|

###### Returns

|Type|Description|
|---|---|
|`Object`|result of the operation|

---

### UnaryOperator

**Inheritance**

UnaryOperator

#### Constructors
##### `public UnaryOperator(String oper)`

Creates a new operator.

###### Parameters

|Param|Description|
|---|---|
|`oper`|operator name (pattern)|

---
#### Methods
##### `public Object apply(Object v)`

Implementation for this unary operator

###### Parameters

|Param|Description|
|---|---|
|`v`|operand|

###### Returns

|Type|Description|
|---|---|
|`Object`|result of the operation|

---

### Token
#### Constructors
##### `public Token(TokenType type, String text)`
---
#### Fields

##### `public type` → `TokenType`


##### `public text` → `String`


---

### Tokenizer

**Implemented types**

[Iterator&lt;Token&gt;](Iterator&lt;Token&gt;)

#### Constructors
##### `public Tokenizer(String input, EvalExpression expr)`

Creates a new tokenizer for an expression.

###### Parameters

|Param|Description|
|---|---|
|`input`|expression string|

---
#### Fields

##### `private expr` → `EvalExpression`


##### `private pos` → `Integer`


##### `private input` → `String`


##### `private previousToken` → `Token`


---
#### Methods
##### `public Boolean hasNext()`
##### `private String peekNextChar()`

Peek at the next character, without advancing the iterator.

###### Returns

|Type|Description|
|---|---|
|`String`|the next character or character 0, if at end of string.|

##### `public Token next()`
##### `public Integer getPos()`

Get the actual character position in the string.

###### Returns

|Type|Description|
|---|---|
|`Integer`|the actual character position.|

---

### MathContext
#### Constructors
##### `global MathContext(Integer precision, RoundingMode roundingMode)`
---
#### Fields

##### `global precision` → `Integer`


##### `global roundingMode` → `RoundingMode`


---

### AddOperator

**Inheritance**

AddOperator

#### Constructors
##### `public AddOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### SubtractOperator

**Inheritance**

SubtractOperator

#### Constructors
##### `public SubtractOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### MultiplyOperator

**Inheritance**

MultiplyOperator

#### Constructors
##### `public MultiplyOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### DivideOperator

**Inheritance**

DivideOperator

#### Constructors
##### `public DivideOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### ModOperator

**Inheritance**

ModOperator

#### Constructors
##### `public ModOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### PowOperator

**Inheritance**

PowOperator

#### Constructors
##### `public PowOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### AndOperator

**Inheritance**

AndOperator

#### Constructors
##### `public AndOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### OrOperator

**Inheritance**

OrOperator

#### Constructors
##### `public OrOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### GreaterOperator

**Inheritance**

GreaterOperator

#### Constructors
##### `public GreaterOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### GreaterEqualOperator

**Inheritance**

GreaterEqualOperator

#### Constructors
##### `public GreaterEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### LessOperator

**Inheritance**

LessOperator

#### Constructors
##### `public LessOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### LessEqualOperator

**Inheritance**

LessEqualOperator

#### Constructors
##### `public LessEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### EqualOperator

**Inheritance**

EqualOperator

#### Constructors
##### `public EqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### NotEqualOperator

**Inheritance**

NotEqualOperator

#### Constructors
##### `public NotEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, MathContext mc)`
---

### PositiveOperator

**Inheritance**

PositiveOperator

#### Constructors
##### `public PositiveOperator(String oper)`
---
#### Methods
##### `public override Object apply(Object v)`
---

### NegativeOperator

**Inheritance**

NegativeOperator

#### Constructors
##### `public NegativeOperator(String oper)`
---
#### Methods
##### `public override Object apply(Object v)`
---

### NotFunction

**Inheritance**

NotFunction

#### Constructors
##### `public NotFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### IfFunction

**Inheritance**

IfFunction

#### Constructors
##### `public IfFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### RandomFunction

**Inheritance**

RandomFunction

#### Constructors
##### `public RandomFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### SinFunction

**Inheritance**

SinFunction

#### Constructors
##### `public SinFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### CosFunction

**Inheritance**

CosFunction

#### Constructors
##### `public CosFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### TanFunction

**Inheritance**

TanFunction

#### Constructors
##### `public TanFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### AsinFunction

**Inheritance**

AsinFunction

#### Constructors
##### `public AsinFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### AcosFunction

**Inheritance**

AcosFunction

#### Constructors
##### `public AcosFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### AtanFunction

**Inheritance**

AtanFunction

#### Constructors
##### `public AtanFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### SinhFunction

**Inheritance**

SinhFunction

#### Constructors
##### `public SinhFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### CoshFunction

**Inheritance**

CoshFunction

#### Constructors
##### `public CoshFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### TanhFunction

**Inheritance**

TanhFunction

#### Constructors
##### `public TanhFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### RadFunction

**Inheritance**

RadFunction

#### Constructors
##### `public RadFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### DegFunction

**Inheritance**

DegFunction

#### Constructors
##### `public DegFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### MaxFunction

**Inheritance**

MaxFunction

#### Constructors
##### `public MaxFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### MinFunction

**Inheritance**

MinFunction

#### Constructors
##### `public MinFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### AbsFunction

**Inheritance**

AbsFunction

#### Constructors
##### `public AbsFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### LogFunction

**Inheritance**

LogFunction

#### Constructors
##### `public LogFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### Log10Function

**Inheritance**

Log10Function

#### Constructors
##### `public Log10Function(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### RoundFunction

**Inheritance**

RoundFunction

#### Constructors
##### `public RoundFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### FloorFunction

**Inheritance**

FloorFunction

#### Constructors
##### `public FloorFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### CeilingFunction

**Inheritance**

CeilingFunction

#### Constructors
##### `public CeilingFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### SqrtFunction

**Inheritance**

SqrtFunction

#### Constructors
##### `public SqrtFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, MathContext mc)`
---

### ExpressionException

Expression evaluator exceptions


**Inheritance**

ExpressionException


### IllegalStateException

**Inheritance**

IllegalStateException


### IllegalArgumentException

**Inheritance**

IllegalArgumentException


---
## Interfaces
### IExpression
#### Methods
##### `private Decimal eval()`
##### `private Boolean evalBool()`
##### `private String toRPN()`
##### `private EvalExpression setPrecision(Integer precision)`
##### `private EvalExpression setRoundingMode(RoundingMode roundingMode)`
##### `private EvalExpression setVariable(String variable, Object value)`
##### `private EvalExpression with(String variable, Object value)`
##### `private EvalExpression matching(Map&lt;String,Object&gt; fieldValues)`
##### `private Iterator&lt;Token&gt; getExpressionTokenizer()`
##### `private Set&lt;String&gt; getDeclaredVariables()`
##### `private Set&lt;String&gt; getDeclaredOperators()`
##### `private Set&lt;String&gt; getDeclaredFunctions()`
---

