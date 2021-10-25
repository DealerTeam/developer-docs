# EvalExpression class

 Port - Apex EvalEx - Apex Expression Evaluator An Apex port of EvalEx @ https://github.com/uklimaschewski/EvalEx /** Port - RT_Expression - Apex Expression Eval https://github.com/jdcrensh/apex-evalex /** EvalExpression is an eval engine ported to support DealerTeam Sage Integration Functions Modifications List

---
## Constructors
### `EvalExpression(String expression)`

 All defined operators with name and implementation /** All defined operators with name and implementation /** All defined functions with name and implementation /** Token types that are case-insensitive /** Default constants /** The MathContext to use for calculations /** The original infix expression /** Cached access to the RPN notation of this expression, ensures only one calculation of the RPN per expression instance. If no cached instance exists, a new one will be created and put to the cache.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression. E.g. `&apos;2.4*sin(3)/(2-4)&apos;` or `&apos;sin(y)&gt;0 &amp; max(z, 3)&gt;3&apos;` |

### `EvalExpression(String expression, Map<String, Object> variables)`

 Creates a new expression instance from an expression string with the given variables.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression. E.g. `&apos;2.4*sin(3)/(2-4)&apos;` or `&apos;sin(y)&gt;0 &amp; max(z, 3)&gt;3&apos;` |
|`variables` |  a mapping of variables |

### `EvalExpression(String expression, MathContext mc)`

 Creates a new expression instance from an expression string with a default MathContext.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression. E.g. `&apos;2.4*sin(3)/(2-4)&apos;` or `&apos;sin(y)&gt;0 &amp; max(z, 3)&gt;3&apos;` |
|`mc` |  an instance of MathContext |

### `EvalExpression(String expression, Map<String, Object> variables, MathContext mc)`

 Creates a new expression instance from an expression string with the given variables and a default MathContext.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression, eg: `2.4*sin(3)/(2-4)` or `sin(y)&gt;0 &amp;&amp; max(z, 3)&gt;3` |
|`variables` |  a mapping of variables |
|`mc` |  an instance of MathContext |

---
## Methods
### `eval()` → `Decimal`

 Implementation of the Shunting Yard algorithm to transform an infix expression to a RPN expression.

#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the input expression in infx. |

#### Return

**Type**

Decimal

**Description**

the result of the expression.

### `matching(Map<String, Object> fieldValues)` → `EvalExpression`

 Matches a value from the passed value set for variables replacement.

#### Parameters
|Param|Description|
|-----|-----------|
|`sObject` |  populated fields |

#### Return

**Type**

EvalExpression

**Description**

the matched expression for chaining

### `setPrecision(Integer precision)` → `EvalExpression`

 Sets the precision for expression evaluation

#### Parameters
|Param|Description|
|-----|-----------|
|`precision` |  the new precision |

#### Return

**Type**

EvalExpression

**Description**

the expression, allows to chain methods

### `setRoundingMode(RoundingMode roundingMode)` → `EvalExpression`

 Sets the rounding mode for expression evaluation

#### Parameters
|Param|Description|
|-----|-----------|
|`rounding` |  the new rounding mode |

#### Return

**Type**

EvalExpression

**Description**

the expression, allows to chain methods

### `setVariable(String variable, Object value)` → `EvalExpression`

 Adds to the list of supported operators

#### Parameters
|Param|Description|
|-----|-----------|
|`operator` |  The operator to add |
|`operator` |  The operator to add |
|`function` |  The function to add |
|`variable` |  the variable to set |
|`value` |  the variable value |

#### Return

**Type**

EvalExpression

**Description**

the expression for chaining

### `with(String variable, Object value)` → `EvalExpression`

 Sets a variable value.

#### Parameters
|Param|Description|
|-----|-----------|
|`variable` |  The variable to set |
|`value` |  The variable value |

#### Return

**Type**

EvalExpression

**Description**

the expression for chaining

---
## Inner Classes

### EvalExpression.MathContext class

 Get an iterator for this expression, allows iterating over an expression token by token. @return a new iterator instance for this expression. /** Check that the expression have enough numbers and variables to fit the requirements of the operators and functions, also check for only 1 result stored at the end of the evaluation. /** Get a string representation of the RPN (Reverse Polish Notation) for this expression. @return a string with the RPN representation for this expression. /** Is the string a number? @param st the string @return true if the input string is a number /** Converts an angle measured in degrees to an approximately equivalent angle measured in radians. The conversion from degrees to radians is generally inexact. @param angdeg an angle, in degrees @return measurement of the angle `angdeg` in radians. /** Converts an angle measured in radians to an approximately equivalent angle measured in degrees. The conversion from radians to degrees is generally inexact; users should not expect `cos(toRadians(90.0))` to exactly equal `0.0`. @param angrad an angle, in radians @return the measurement of the angle `angrad` in degrees. /** Returns the string of a character at `ind` in `str` /** Round a Decimal given a MathContext /** Get value as zero in case of null @param d Decimal that may be null @return d if not null, zero otherwise /** Safely inserts an element at the beginning of a potentially empty list /** Exposing declared variables in the expression @return declared variables /** Returns a set of variable names referenced in the expression string /** Exposing declared operators in the expression @return declared operators /** Exposing declared functions @return declared functions /** Abstract definition of a supported expression function. A function is defined by a name, the number of parameters and the actual processing implementation. /** Name of this function. /** Number of parameters expected for this function. `-1` denotes a variable number of parameters. /** Creates a new function with given name and parameter count @param name name of the function @param numParams number of parameters for this function; `-1` denotes a variable number of parameters /** Implementation for this function. @param parameters passed by evaluator as a List of Object values @return a new Object value as a computing result /** Base definition of a supported operator /** This operators name (pattern). /** Abstract definition of a supported operator. An operator is defined by its name (pattern), precedence, and if it is left or right associative. /** Operators precedence. /** Operator is left associative. /** Creates a new operator. @param oper operator name (pattern) @param precedence operator precedence @param assoc true if the operator is left associative, else false /** Implementation for this operator @param v1 operand 1 @param v2 operand 2 @return result of the operation /** Abstract definition of a supported unary operator /** Creates a new operator. @param oper operator name (pattern) /** Implementation for this unary operator @param v operand @return result of the operation /** Expression tokenizer that allows to iterate over a String expression token by token. Blank characters will be skipped. /** Actual position in expression string. /** The original input expression. /** The previous token or `null` if none. /** Creates a new tokenizer for an expression. @param input expression string /** Peek at the next character, without advancing the iterator. @return the next character or character 0, if at end of string. /** Get the actual character position in the string. @return the actual character position. /** Expression assoc /** MathContext container

---
#### Constructors
##### `MathContext(Integer precision, RoundingMode roundingMode)`
---
#### Properties

##### `precision` → `Integer`

##### `roundingMode` → `RoundingMode`

---
