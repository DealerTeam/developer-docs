---
layout: default
---
# EvalExpressionTest

`ISTEST`
## Methods
### `private static void testAndTokenizer()`

`ISTEST`
### `private static void testAndRPN()`

`ISTEST`
### `private static void testAndEval()`

`ISTEST`
### `private static void testOrEval()`

`ISTEST`
### `private static void testCompare()`

`ISTEST`
### `private static void testCompareCombined()`

`ISTEST`
### `private static void testMixed()`

`ISTEST`
### `private static void testNot()`

`ISTEST`
### `private static void testConstants()`

`ISTEST`
### `private static void testIf()`

`ISTEST`
### `private static void testStringCompare()`

`ISTEST`
### `private static void testStringConcat()`

`ISTEST`
### `private static void testStringMixed()`

`ISTEST`
### `private static void testVariableIsCaseInsensitive()`

`ISTEST`
### `private static void testFunctionCaseInsensitive()`

`ISTEST`
### `private static void testCustomOperator()`

`ISTEST`
### `private static void testCustomFunction()`

`ISTEST`
### `private static void testCustomFunctionVariableParameters()`

`ISTEST`
### `private static void testUnary()`

`ISTEST`
### `private static void testInvalidExpressions1()`

`ISTEST`
### `private static void testInvalidExpressions2()`

`ISTEST`
### `private static void testInvalidExpressions3()`

`ISTEST`
### `private static void testInvalidExpressions4()`

`ISTEST`
### `private static void testInvalidExpressions5()`

`ISTEST`
### `private static void testWrongBrackets1()`

`ISTEST`
### `private static void testWrongBrackets2()`

`ISTEST`
### `private static void testInvalidString()`

`ISTEST`
### `private static void testBrackets()`

`ISTEST`
### `private static void testUnknown1()`

`ISTEST`
### `private static void testUnknown2()`

`ISTEST`
### `private static void testSimple()`

`ISTEST`
### `private static void testPow()`

`ISTEST`
### `private static void testSqrt()`

`ISTEST`
### `private static void testFunctions()`

`ISTEST`
### `private static void testExpectedParameterNumbers()`

`ISTEST`
### `private static void testVariableParameterNumbers()`

`ISTEST`
### `private static void testExtremeFunctionNesting()`

`ISTEST`
### `private static void testTrigonometry()`

`ISTEST`
### `private static void testAsin()`

`ISTEST`
### `private static void testAcos()`

`ISTEST`
### `private static void testAtan()`

`ISTEST`
### `private static void testLog10()`

`ISTEST`
### `private static void testMinMaxAbs()`

`ISTEST`
### `private static void testRounding()`

`ISTEST`
### `private static void testMathContext()`

`ISTEST`
### `private static void testIsNumber()`

`ISTEST`
### `private static void testDeclaredOperators()`

`ISTEST`
### `private static void testDeclaredVariables()`

`ISTEST`
### `private static void testDeclaredFunctionGetter()`

`ISTEST`
### `private static void testNestedVars()`
### `private static void testReplacements()`
### `private static void testRPNSimple()`

`ISTEST`
### `private static void testRPNFunctions()`

`ISTEST`
### `private static void testSciSimple()`

`ISTEST`
### `private static void testSciNegative()`

`ISTEST`
### `private static void testSciPositive()`

`ISTEST`
### `private static void testSciCombined()`

`ISTEST`
### `private static void testSciError1()`

`ISTEST`
### `private static void testSciError2()`

`ISTEST`
### `private static void testUnknownFunction()`

`ISTEST`
### `private static void testUndefinedVariable()`

`ISTEST`
### `private static void testTokenizerNumbers()`

`ISTEST`
### `private static void testTokenizerExtraSpaces()`

`ISTEST`
### `private static void testTokenizerNextThrows()`

`ISTEST`
### `private static void testTokenizer1()`

`ISTEST`
### `private static void testTokenizer2()`

`ISTEST`
### `private static void testTokenizer3()`

`ISTEST`
### `private static void testTokenizer4()`

`ISTEST`
### `private static void testTokenizer5()`

`ISTEST`
### `private static void testTokenizer6()`

`ISTEST`
### `private static void testTokenizer7()`

`ISTEST`
### `private static void testTokenizer8()`

`ISTEST`
### `private static void testTokenizerStrings()`

`ISTEST`
### `private static void testTokenizerStringConcat()`

`ISTEST`
### `private static void testTokenizerFunction1()`

`ISTEST`
### `private static void testTokenizerFunction2()`

`ISTEST`
### `private static void testTokenizerFunction3()`

`ISTEST`
### `private static void testTokenizerFunction4()`

`ISTEST`
### `private static void testTokenizerFunction5()`

`ISTEST`
### `private static void testVarArgsSimple()`

`ISTEST`
### `private static void testVarArgsNested()`

`ISTEST`
### `private static void testVarArgsZero()`

`ISTEST`
### `private static void testVarArgsError()`

`ISTEST`
### `private static void testVarArgsCustomFunction1()`

`ISTEST`
### `private static void testVarArgsCustomFunction2()`

`ISTEST`
### `private static void testVars()`

`ISTEST`
### `private static void testReferencedVars()`

`ISTEST`
### `private static void testInvalidVariableType()`

`ISTEST`
### `private static void testSubstitution()`

`ISTEST`
### `private static void testNullSubstitution()`

`ISTEST`
### `private static void testWith()`

`ISTEST`
### `private static void testNames()`

`ISTEST`
### `private static void testQuadraticFormula()`

`ISTEST`
### `private static void testEqualAndHashCode()`

`ISTEST`
### `private static void testNotEqualAndHashCode1()`

`ISTEST`
### `private static void testNotEqualAndHashCode2()`

`ISTEST`
### `private static void testMismatchedParens1()`

`ISTEST`
### `private static void testMismatchedParens2()`

`ISTEST`
### `private static void testFunctionError()`

`ISTEST`
---
## Classes
### SumFunction

**Inheritance**

SumFunction

#### Constructors
##### `public SumFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, EvalExpression mc)`
---

### BitRightOperator

**Inheritance**

BitRightOperator

#### Constructors
##### `public BitRightOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, EvalExpression mc)`
---

### AvgFunction

**Inheritance**

AvgFunction

#### Constructors
##### `public AvgFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, EvalExpression mc)`
---

### NullOperator

**Inheritance**

NullOperator

#### Constructors
##### `public NullOperator(String oper, Integer precedence, Associability assoc)`
---
#### Methods
##### `public override Object apply(Object v1, Object v2, EvalExpression mc)`
---

### NullFunction

**Inheritance**

NullFunction

#### Constructors
##### `public NullFunction(String name, Integer numParams)`
---
#### Methods
##### `public override Object apply(List&lt;Object&gt; parameters, EvalExpression mc)`
---

---
