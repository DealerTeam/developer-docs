---
layout: default
---
# EvalStack class

 The `Stack` class represents a last-in-first-out (LIFO) stack of objects. When a stack is first created, it contains no items. The usual `push` and `pop` operations are provided, as well as a method to `peek` at the top item on the stack, a method to test for whether the stack is `empty`, and a method to `search` the stack for an item and discover how far it is from the top.

---
## Constructors
### `EvalStack(List<Object> stack)`

 Creates a pre-populated stack
#### Parameters
|Param|Description|
|-----|-----------|
|`stack` |   starting elements |

### `EvalStack()`

 Creates an empty Stack.
---
## Methods
### `empty()` → `Boolean`
### `peek()` → `Object`
### `pop()` → `Object`
### `push(Object item)` → `Object`
### `search(Object o)` → `Integer`
### `size()` → `Integer`
---
## Inner Classes

### EvalStack.EmptyStackException class
---
### EvalStack.IStack interface
---
#### Methods
##### `empty()` → `Boolean`

 Tests if this stack is empty

##### `peek()` → `Object`

 Looks at the object at the top of this stack without removing it from the stack

##### `pop()` → `Object`

 Removes the object at the top of this stack and returns that object as the value of this function

##### `push(Object item)` → `Object`

 Pushes an item onto the top of this stack

###### Parameters
|Param|Description|
|-----|-----------|
|`item` |   the item to be pushed onto this stack |

##### `search(Object o)` → `Integer`

 Returns the 1-based position where an object is on this stack. If the object `o` occurs as an item in this stack, this method returns the distance from the top of the stack of the occurrence nearest the top of the stack; the topmost item on the stack is considered to be at distance `1`. The `equals` method is used to compare `o` to the items in this stack.

###### Parameters
|Param|Description|
|-----|-----------|
|`o` |   the desired object. |

##### `size()` → `Integer`

 Returns the number of components in this stack

---
