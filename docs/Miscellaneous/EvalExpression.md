---
layout: default
---
# EvalExpression class

 Copyright 2012 Udo Klimaschewski http://UdoJava.com/ http://about.me/udo.klimaschewski Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. /** Port - Apex EvalEx - Apex Expression Evaluator An Apex port of EvalEx @ https://github.com/uklimaschewski/EvalEx /** Port - RT_Expression - Apex Expression Eval https://github.com/jdcrensh/apex-evalex /** EvalExpression is an eval engine ported to support DealerTeam Sage Integration Functions Modifications List

---
## Constructors
### `EvalExpression(String expression)`

 Creates a new expression instance from an expression string.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'` |

### `EvalExpression(String expression, Map<String, Object> variables)`

 Creates a new expression instance from an expression string with the given variables.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'` |
|`variables` |  a mapping of variables |

### `EvalExpression(String expression, MathContext mc)`

 Creates a new expression instance from an expression string with a default MathContext.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression. E.g. `'2.4*sin(3)/(2-4)'` or `'sin(y)>0 & max(z, 3)>3'` |
|`mc` |  an instance of MathContext |

### `EvalExpression(String expression, Map<String, Object> variables, MathContext mc)`

 Creates a new expression instance from an expression string with the given variables and a default MathContext.
#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the expression, eg: `2.4*sin(3)/(2-4)` or `sin(y)>0 && max(z, 3)>3` |
|`variables` |  a mapping of variables |
|`mc` |  an instance of MathContext |

---
## Enums
### Associability


 Expression assoc

### TokenType

---
## Properties

### `ZERO` → `Decimal`

### `mc` → `MathContext`

 All defined operators with name and implementation /** All defined operators with name and implementation /** All defined functions with name and implementation /** Token types that are case-insensitive /** Default constants /** The MathContext to use for calculations

### `variables` → `Object>`

 The original infix expression /** Cached access to the RPN notation of this expression, ensures only one calculation of the RPN per expression instance. If no cached instance exists, a new one will be created and put to the cache. @return the cached RPN instance. /** All defined variables by name and value

---
## Methods
### `addFunction(Function function)` → `Function`

 Adds to the list of supported functions

#### Parameters
|Param|Description|
|-----|-----------|
|`function` |  The function to add |

### `addOperator(Operator operator)` → `Operator`

 Adds to the list of supported operators

#### Parameters
|Param|Description|
|-----|-----------|
|`operator` |  The operator to add |

### `addUnaryOperator(UnaryOperator operator)` → `UnaryOperator`

 Adds to the list of supported unary operators

#### Parameters
|Param|Description|
|-----|-----------|
|`operator` |  The operator to add |

### `equals(Object obj)` → `Boolean`
### `eval()` → `Decimal`

 Implementation of the Shunting Yard algorithm to transform an infix expression to a RPN expression.

#### Parameters
|Param|Description|
|-----|-----------|
|`expression` |  the input expression in infx. |

### `evalBool()` → `Boolean`
### `getDeclaredFunctions()` → `Set<String>`

 Exposing declared functions

### `getDeclaredOperators()` → `Set<String>`

 Exposing declared operators in the expression

### `getDeclaredVariables()` → `Set<String>`

 Converts an angle measured in degrees to an approximately equivalent angle measured in radians. The conversion from degrees to radians is generally inexact.

#### Parameters
|Param|Description|
|-----|-----------|
|`angdeg` |  an angle, in degrees |
|`angrad` |  an angle, in radians |
|`d` |  Decimal that may be null |

### `getExpressionTokenizer()` → `Iterator<Token>`

 Get an iterator for this expression, allows iterating over an expression token by token.

### `getReferencedVariables()` → `Set<String>`

 Returns a set of variable names referenced in the expression string

### `hashCode()` → `Integer`
### `isNumber(String st)` → `Boolean`

 Is the string a number?

#### Parameters
|Param|Description|
|-----|-----------|
|`st` |  the string |

### `matching(Map<String, Object> fieldValues)` → `EvalExpression`

 Matches a value from the passed value set for variables replacement.

#### Parameters
|Param|Description|
|-----|-----------|
|`sObject` |  populated fields |

### `setPrecision(Integer precision)` → `EvalExpression`

 Sets the precision for expression evaluation

#### Parameters
|Param|Description|
|-----|-----------|
|`precision` |  the new precision |

### `setRoundingMode(RoundingMode roundingMode)` → `EvalExpression`

 Sets the rounding mode for expression evaluation

#### Parameters
|Param|Description|
|-----|-----------|
|`rounding` |  the new rounding mode |

### `setVariable(String variable, Object value)` → `EvalExpression`

 Sets a variable value.

#### Parameters
|Param|Description|
|-----|-----------|
|`variable` |  the variable to set |
|`value` |  the variable value |

### `toRPN()` → `String`

 Check that the expression have enough numbers and variables to fit the requirements of the operators and functions, also check for only 1 result stored at the end of the evaluation. /** Thanks to Norman Ramsey: http://http://stackoverflow.com/questions/789847/postfix-notation-validation /** Get a string representation of the RPN (Reverse Polish Notation) for this expression.

### `with(String variable, Object value)` → `EvalExpression`

 Sets a variable value.

#### Parameters
|Param|Description|
|-----|-----------|
|`variable` |  The variable to set |
|`value` |  The variable value |

---
## Inner Classes

### EvalExpression.AbsFunction class
---
#### Constructors
##### `AbsFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.AcosFunction class
---
#### Constructors
##### `AcosFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.AddOperator class
---
#### Constructors
##### `AddOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.AndOperator class
---
#### Constructors
##### `AndOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.AsinFunction class
---
#### Constructors
##### `AsinFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.AtanFunction class
---
#### Constructors
##### `AtanFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.BaseOperator class

 Base definition of a supported operator

---
#### Methods
##### `getOper()` → `String`

 This operators name (pattern).

---
### EvalExpression.CeilingFunction class
---
#### Constructors
##### `CeilingFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.CosFunction class
---
#### Constructors
##### `CosFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.CoshFunction class
---
#### Constructors
##### `CoshFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.DegFunction class
---
#### Constructors
##### `DegFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.DivideOperator class
---
#### Constructors
##### `DivideOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.EqualOperator class
---
#### Constructors
##### `EqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.ExpressionException class

 Expression evaluator exceptions

---
### EvalExpression.FloorFunction class
---
#### Constructors
##### `FloorFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.Function class

 Abstract definition of a supported expression function. A function is defined by a name, the number of parameters and the actual processing implementation.

---
#### Constructors
##### `Function(String name, Integer numParams)`

 Name of this function. /** Number of parameters expected for this function. `-1` denotes a variable number of parameters. /** Creates a new function with given name and parameter count
###### Parameters
|Param|Description|
|-----|-----------|
|`name` |  name of the function |
|`numParams` |  number of parameters for this function; `-1` denotes |

---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`

 Implementation for this function.

###### Parameters
|Param|Description|
|-----|-----------|
|`parameters` |  passed by evaluator as a List of Object values |

##### `getName()` → `String`
##### `getNumParams()` → `Integer`
##### `numParamsVaries()` → `Boolean`
---
### EvalExpression.GreaterEqualOperator class
---
#### Constructors
##### `GreaterEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.GreaterOperator class
---
#### Constructors
##### `GreaterOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.IfFunction class
---
#### Constructors
##### `IfFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.IllegalArgumentException class

 IllegalArgumentException

---
### EvalExpression.IllegalStateException class

 IllegalStateException

---
### EvalExpression.LessEqualOperator class
---
#### Constructors
##### `LessEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.LessOperator class
---
#### Constructors
##### `LessOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.Log10Function class
---
#### Constructors
##### `Log10Function(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.LogFunction class
---
#### Constructors
##### `LogFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.MathContext class

 MathContext container

---
#### Constructors
##### `MathContext(Integer precision, RoundingMode roundingMode)`
---
#### Properties

##### `precision` → `Integer`

##### `roundingMode` → `RoundingMode`

---
### EvalExpression.MaxFunction class
---
#### Constructors
##### `MaxFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.MinFunction class
---
#### Constructors
##### `MinFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.ModOperator class
---
#### Constructors
##### `ModOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.MultiplyOperator class
---
#### Constructors
##### `MultiplyOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.NegativeOperator class
---
#### Constructors
##### `NegativeOperator(String oper)`
---
#### Methods
##### `apply(Object v)` → `Object`
---
### EvalExpression.NotEqualOperator class
---
#### Constructors
##### `NotEqualOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.NotFunction class
---
#### Constructors
##### `NotFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.Operator class

 Abstract definition of a supported operator. An operator is defined by its name (pattern), precedence, and if it is left or right associative.

---
#### Constructors
##### `Operator(String oper, Integer precedence, Associability assoc)`

 Operators precedence. /** Operator is left associative. /** Creates a new operator.
###### Parameters
|Param|Description|
|-----|-----------|
|`oper` |  operator name (pattern) |
|`precedence` |  operator precedence |
|`assoc` |  true if the operator is left associative, else false |

---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`

 Implementation for this operator

###### Parameters
|Param|Description|
|-----|-----------|
|`v1` |  operand 1 |
|`v2` |  operand 2 |

##### `getPrecedence()` → `Integer`
##### `isLeftAssoc()` → `Boolean`
---
### EvalExpression.OrOperator class
---
#### Constructors
##### `OrOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.PositiveOperator class
---
#### Constructors
##### `PositiveOperator(String oper)`
---
#### Methods
##### `apply(Object v)` → `Object`
---
### EvalExpression.PowOperator class
---
#### Constructors
##### `PowOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.RadFunction class
---
#### Constructors
##### `RadFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.RandomFunction class
---
#### Constructors
##### `RandomFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.RoundFunction class
---
#### Constructors
##### `RoundFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.SinFunction class
---
#### Constructors
##### `SinFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.SinhFunction class
---
#### Constructors
##### `SinhFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.SqrtFunction class
---
#### Constructors
##### `SqrtFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.SubtractOperator class
---
#### Constructors
##### `SubtractOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `apply(Object v1, Object v2, MathContext mc)` → `Object`
---
### EvalExpression.TanFunction class
---
#### Constructors
##### `TanFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.TanhFunction class
---
#### Constructors
##### `TanhFunction(String name, Integer numParams)`
---
#### Methods
##### `apply(List<Object> parameters, MathContext mc)` → `Object`
---
### EvalExpression.Token class
---
#### Constructors
##### `Token(TokenType type, String text)`
---
#### Properties

##### `text` → `String`

##### `type` → `TokenType`

---
### EvalExpression.Tokenizer class

 Expression tokenizer that allows to iterate over a String expression token by token. Blank characters will be skipped.

---
#### Constructors
##### `Tokenizer(String input, EvalExpression expr)`

 Actual position in expression string. /** The original input expression. /** The previous token or `null` if none. /** Creates a new tokenizer for an expression.
###### Parameters
|Param|Description|
|-----|-----------|
|`input` |  expression string |

---
#### Methods
##### `getPos()` → `Integer`

 Get the actual character position in the string.

##### `hasNext()` → `Boolean`
##### `next()` → `Token`

 Peek at the next character, without advancing the iterator.

---
### EvalExpression.UnaryOperator class

 Abstract definition of a supported unary operator

---
#### Constructors
##### `UnaryOperator(String oper)`

 Creates a new operator.
###### Parameters
|Param|Description|
|-----|-----------|
|`oper` |  operator name (pattern) |

---
#### Methods
##### `apply(Object v)` → `Object`

 Implementation for this unary operator

###### Parameters
|Param|Description|
|-----|-----------|
|`v` |  operand |

---
