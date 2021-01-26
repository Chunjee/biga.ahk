biga.ahk
=================

Long-form README and documentation: https://biga-ahk.github.io/biga.ahk

A modern immutable utility library for AutoHotKey. Takes out the hassle of working with arrays, numbers, objects, strings, etc.

Mirrors functionality and method names of [Lodash](https://lodash.com/)

:warning: **alpha - may have defects prior to v1.0.0** :warning:

------------------


## Installation

In a terminal or command line navigated to your project folder:

```bash
npm install biga.ahk
```
You may also review or copy the library from [./export.ahk on GitHub](https://raw.githubusercontent.com/biga-ahk/biga.ahk/master/export.ahk); #Incude as you would normally when manually downloading.


In your code only export.ahk needs to be included:

```autohotkey
#Include %A_ScriptDir%\node_modules
#Include biga.ahk\export.ahk

A := new biga()
msgbox, % A.join(A.concat(["a"],["b", "c"]))
; => "a,b,c"
```

AutoHotkey v1.1.05 or higher is required


## Usage

Initiate an instance of the class and use as needed

```autohotkey
A := new biga()
wordsArray := A.words("This could be real real useful")
; => ["This", "could", "be", "real", "real", "useful"]
uniqWords := A.uniq(wordsArray)
msgbox, % A.size(uniqWords)
; => 6
msgbox, % A.join(uniqWords, " ")
; => "This could be real useful"
```

Longer realworld examples available at https://github.com/biga-ahk/biga.ahk/tree/master/examples


## Documentation

All methods documented at https://biga-ahk.github.io/biga.ahk


## Contributing

Please make pull requests to source found at https://github.com/biga-ahk/biga.ahk
