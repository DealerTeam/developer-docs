# EvalStack

`APIVERSION: 45`

`STATUS: ACTIVE`

**Implemented types**

[IStack](IStack)

## Constructors
### `EvalStack(List<Object> stack)`

Creates a pre-populated stack

#### Parameters

|Param|Description|
|---|---|
|`stack`|starting elements|

### `EvalStack()`

Creates an empty Stack.

---
## Methods
### `push(Object item)`
### `pop()`
### `peek()`
### `size()`
### `empty()`
### `search(Object o)`
---
## Classes
### EmptyStackException

**Inheritance**

EmptyStackException


---
## Interfaces
### IStack
#### Methods
##### `push(Object item)`

Pushes an item onto the top of this stack

###### Parameters

|Param|Description|
|---|---|
|`item`|the item to be pushed onto this stack|

###### Return

**Type**

Object

**Description**

the item

##### `pop()`

Removes the object at the top of this stack and returns that object as the value of this function

###### Return

**Type**

Object

**Description**

The object at the top of this stack

###### Throws

|Exception|Description|
|---|---|
|`EmptyStackException`|if this stack is empty.|

##### `peek()`

Looks at the object at the top of this stack without removing it from the stack

###### Return

**Type**

Object

**Description**

the object at the top of this stack

###### Throws

|Exception|Description|
|---|---|
|`EmptyStackException`|if this stack is empty|

##### `size()`

Returns the number of components in this stack

###### Return

**Type**

Integer

**Description**

the number of components in this stack

##### `empty()`

Tests if this stack is empty

###### Return

**Type**

Boolean

**Description**

`true` if and only if this stack contains no items; `false` otherwise.

##### `search(Object o)`

Returns the 1-based position where an object is on this stack. If the object `o` occurs as an item in this stack, this method returns the distance from the top of the stack of the occurrence nearest the top of the stack; the topmost item on the stack is considered to be at distance `1`. The `equals` method is used to compare `o` to the items in this stack.

###### Parameters

|Param|Description|
|---|---|
|`o`|the desired object.|

###### Return

**Type**

Integer

**Description**

the 1-based position from the top of the stack where          the object is located; the return value `-1` indicates          that the object is not on the stack.

---

