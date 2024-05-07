---
layout: default
---
# EvalStack

**Implemented types**

[IStack](IStack)

## Constructors
### `public EvalStack(List<Object> stack)`

Creates a pre-populated stack

#### Parameters

|Param|Description|
|---|---|
|`stack`|starting elements|

### `public EvalStack()`

Creates an empty Stack.

---
## Fields

### `private stack` → `List<Object>`


### `private elementCount` → `Integer`


---
## Methods
### `public Object push(Object item)`
### `public Object pop()`
### `public Object peek()`
### `public Integer size()`
### `public Boolean empty()`
### `public Integer search(Object o)`
---
## Classes
### EmptyStackException

**Inheritance**

EmptyStackException


---
## Interfaces
### IStack
#### Methods
##### `public Object push(Object item)`

Pushes an item onto the top of this stack

###### Parameters

|Param|Description|
|---|---|
|`item`|the item to be pushed onto this stack|

###### Returns

|Type|Description|
|---|---|
|`Object`|the item|

##### `public Object pop()`

Removes the object at the top of this stack and returns that object as the value of this function

###### Returns

|Type|Description|
|---|---|
|`Object`|The object at the top of this stack|

###### Throws

|Exception|Description|
|---|---|
|`EmptyStackException`|if this stack is empty.|

##### `public Object peek()`

Looks at the object at the top of this stack without removing it from the stack

###### Returns

|Type|Description|
|---|---|
|`Object`|the object at the top of this stack|

###### Throws

|Exception|Description|
|---|---|
|`EmptyStackException`|if this stack is empty|

##### `public Integer size()`

Returns the number of components in this stack

###### Returns

|Type|Description|
|---|---|
|`Integer`|the number of components in this stack|

##### `public Boolean empty()`

Tests if this stack is empty

###### Returns

|Type|Description|
|---|---|
|`Boolean`|`true` if and only if this stack contains no items; `false` otherwise.|

##### `public Integer search(Object o)`

Returns the 1-based position where an object is on this stack. If the object `o` occurs as an item in this stack, this method returns the distance from the top of the stack of the occurrence nearest the top of the stack; the topmost item on the stack is considered to be at distance `1`. The `equals` method is used to compare `o` to the items in this stack.

###### Parameters

|Param|Description|
|---|---|
|`o`|the desired object.|

###### Returns

|Type|Description|
|---|---|
|`Integer`|the 1-based position from the top of the stack where          the object is located; the return value `-1` indicates          that the object is not on the stack.|

---

