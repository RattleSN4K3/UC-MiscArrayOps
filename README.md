ArrayOps
-----------------

A set of Array operations which let's you use a inline expression to create dynamic array from given values.
These expression can look like this: `MyArray = ! ArrayValue1 + ArrayValue2 + ArrayValue3`

This is similar to an expression like `arr = [ArrayValue1, ArrayValue2, ArrayValue3]`.

Most of the standard data types are supported.
- byte, int, float
- string, name
- Object, Actor, Class
- Interface

And also various standard structs
- Vector, Rotator, Vector2D, TwoVectors, Plane
- Color, LinearColor
- KeyValuePair

... and several more

# Integration

These operations are created in a include-able file (UnrealScript template, *.uci)
which can be included in a base file which allows to use array operations in every child class.
Or specifically include the UCI file where ever you need these array operations.

- Download the [ArrayOp.uci](ArrayOp.uci) file
- Place it into your root package folder (where `Classes` is located)
- Add the following at the end of your methods (before `defaultproperties`)  
  ```
  `include( ArrayOp.uci );
  ```

# Extending

In case you want to have array operations for custom structs, base classes or anything else,
you can support this by adding a single line to the [ArrayOp.uci](ArrayOp.uci) file:  
```
`ArrayOp(MyStruct)
```

This is a pre-processor command which will create the actual implementation on compilation.

# Usage

The following section will show various basic examples how these array ops can be used.
The important part of these expression is the custom operator `!` which takes the following value and returns
an array of the type of that value. After this single expression, the operator `+` is not the known operator. In this case,
it always takes an array on the left side and an element on the right side.

```
!ELEMENT returns an array with the the type of ELEMENT
ARR + ELEMENT adds the ELEMENT to the array ARR
```

The following expression is not doing anything and would be processed just like it would without the _Array operations_:  
`ELEMENT + ELEMENT`

In case of an int type, it would just create the sum of these values (addition). The `!` as prefix-operator is the important step
to convert an ELEMENT to an array with the type of that ELEMENT.

## Array byte

A note about byte arrays, literials (numbers) are mostly parsed as integeter (if not ending with `.f`).
Therefore the first element (for the `!` operator) has to be explicitly casted to byte in order to return
an array type of byte.

### Assignment
UnrealScript:  
```UnrealScript
local array<byte> arr;
arr = ! byte(0) + 254 + 255;
```

Result:  
```
array<byte> arr =
  [0]: 0
  [1]: 254
  [2]: 255
```

### Parse from string with assignment

UnrealScript:
```UnrealScript
local array<byte> arr;
arr /= "0,1,255" / ",";
```

Result:
```
array<byte> arr =
  [0]: 0
  [1]: 1
  [2]: 255
```


### Parse and assignment

UnrealScript:
```UnrealScript
local array<byte> arr;
arr = byte("") ~= "0,1,255" / ",";
```

Result:
```
array<byte> arr =
  [0]: 0
  [1]: 1
  [2]: 255
```

## Array int

### Assignment
UnrealScript:
```UnrealScript
local array<int> arr;
arr = ! 666 + 777 + 98;
```

Result:
```
array<int> arr =
  [0]: 666
  [1]: 777
  [2]: 98
```

### Parse from string with assignment

UnrealScript:
```UnrealScript
local array<int> arr;
arr /= "1,2,3,5,7" / ",";
```

Result:
```
array<int> arr =
  [0]: 1
  [1]: 2
  [2]: 3
  [3]: 5
  [4]: 7
```


### Parse and assignment

UnrealScript:
```UnrealScript
local array<int> arr;
arr = int("") ~= "1,2,3,5,7" / ",";
```

Result:
```
array<int> arr =
  [0]: 1
  [1]: 2
  [2]: 3
  [3]: 5
  [4]: 7
```

## Array float

### Assignment
UnrealScript:
```UnrealScript
local array<float> arr;
arr = ! 1.0f + 2.5f;
```

Result:
```
array<float> arr =
  [0]: 1.0
  [1]: 2.5
```

### Parse from string with assignment

UnrealScript:
```UnrealScript
local array<float> arr;
arr /= "1.0,2.123,3.23,5.773,-7.1234" / ",";
```

Result:
```
array<float> arr =
  [0]: 1.0
  [1]: 2.123
  [2]: 3.23
  [3]: 5.773
  [4]: -7.1234
```


### Parse and assignment

UnrealScript:
```UnrealScript
local array<float> arr;
arr = float("") ~= "1.0,2.123,3.23,5.773,-7.1234" / ",";
```

Result:
```
array<float> arr =
  [0]: 1.0
  [1]: 2.123
  [2]: 3.23
  [3]: 5.773
  [4]: -7.1234
```


## Array string

### Assignment
UnrealScript:
```UnrealScript
local array<string> arr;
arr = ! "Elem1" + "NewElem" + "LastElem";
```

Result:
```
array<string> arr =
  [0]: "Elem1"
  [1]: "NewElem"
  [2]: "LastElem"
```

### From string

UnrealScript:
```UnrealScript
local array<string> arr;
arr /= "First,2nd,AnotherOne" / ",";
```
or
```UnrealScript
local array<string> arr;
arr = "First,2nd,AnotherOne" / ",";
```

Result:
```
array<string> arr =
  [0]: "First"
  [1]: "2nd"
  [2]: "AnotherOne"
```


## Array name

### Assignment
UnrealScript:
```UnrealScript
local array<name> arr;
arr = ! 'Elem1' + 'NewName';
```

Result:
```
array<name> arr =
  [0]: 'Elem1'
  [1]: 'NewName'
```

### Parse from string with assignment

UnrealScript:
```UnrealScript
local array<name> arr;
arr /= "AName,SomeName" / ",";
```

Result:
```UnrealScript
array<name> arr =
  [0]: 'AName'
  [1]: 'SomeName'
```


### Parse and assignment

UnrealScript:
```UnrealScript
local array<name> arr;
arr = name("") ~= "AName,SomeName" / ",";
```

Result:
```
array<name> arr =
  [0]: 'AName'
  [1]: 'SomeName'
```


## Array Object

### Assignment
UnrealScript:
```UnrealScript
local array<Object> arr;
arr = ! self + Other;
```

Result:
```
array<Object> arr =
  [0]: MyActor_0
  [1]: Pawn_2
```

### Parse from string with assignment

UnrealScript:
```UnrealScript
local array<Object> arr;
arr /= "MapName.TheWorld:PersistentLevel.MyActor_0,MapName.TheWorld:PersistentLevel.Pawn_2" / ",";
```

Result:
```
array<Object> arr =
  [0]: MyActor_0
  [1]: Pawn_2
```


### Parse and assignment

UnrealScript:
```UnrealScript
local array<Object> arr;
arr = Object("") ~= "MapName.TheWorld:PersistentLevel.MyActor_0,MapName.TheWorld:PersistentLevel.Pawn_2" / ",";
```

Result:
```
array<Object> arr =
  [0]: MyActor_0
  [1]: Pawn_2
```


## Array Actor

### Assignment
UnrealScript:
```UnrealScript
local array<Actor> arr;
arr = ! self + Other;
```

Result:
```
array<Actor> arr =
  [0]: MyActor_0
  [1]: Pawn_2
```

### Parse from string with assignment

UnrealScript:
```UnrealScript
local array<Actor> arr;
arr /= "MapName.TheWorld:PersistentLevel.MyActor_0,MapName.TheWorld:PersistentLevel.Pawn_2" / ",";
```

Result:
```
array<Actor> arr =
  [0]: MyActor_0
  [1]: Pawn_2
```


### Parse and assignment

UnrealScript:
```UnrealScript
local array<Actor> arr;
arr = Actor("") ~= "MapName.TheWorld:PersistentLevel.MyActor_0,MapName.TheWorld:PersistentLevel.Pawn_2" / ",";
```

Result:
```
array<Actor> arr =
  [0]: MyActor_0
  [1]: Pawn_2
```


## Array Class

### Assignment
UnrealScript:
```UnrealScript
local array<Class> arr;
arr = ! class'Actor' + class'Info' + class'Pawn';
```

Result:
```
array<Actor> arr =
  [0]: Actor
  [1]: Info
  [2]: Pawn
```

### Parse from string with assignment

UnrealScript:
```UnrealScript
local array<Class> arr;
arr /= "Engine.GameInfo,Engine.Info" / ",";
```

Result:
```
array<Class> arr =
  [0]: GameInfo
  [1]: Info
```


### Parse and assignment

UnrealScript:
```UnrealScript
local array<Class> arr;
arr = Class("") ~= "Engine.GameInfo,Engine.Info" / ",";
```

Result:
```
array<Class> arr =
  [0]: GameInfo
  [1]: Info
```

# Testing

There is a test commandlet which lets you define and add various test runs/cases for the existing array ops or new created ones.

If you compiled the package, you need to add it as StartupPackage which forces the package to be loaded in the _command environment_.
- Open the Config\\GameEngine.ini
- Search for the section `[Engine.StartupPackages]`
- Add **`Package=MiscArrayOps`** after the section header

Now you are able to run the test cases with:
```
game.exe run TestArrayOp
```

You can check the current test output in the [Tests.txt](Tests.txt) file.

# License
Available under [the MIT license](http://opensource.org/licenses/mit-license.php).

# Author
RattleSN4K3
