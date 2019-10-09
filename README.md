biga.ahk
=================

A modern immutable utility library for AutoHotKey

Mirrors functionality and method names of [Lodash](https://lodash.com/)

:warning: **alpha - The API might change, and may have defects prior to v1.0.0** :warning:

------------------


## Installation

In a terminal or command line navigated to your project folder:

```bash
npm install biga.ahk
```

In your code:

```autohotkey
#Include %A_ScriptDir%\node_modules
#Include biga.ahk\export.ahk
A := new biga()
msgbox, % A.join(["a", "b", "c"], " ")
; => "a b c"
```

AutoHotkey v1.1.05 or higher is required


## Usage

Initiate an instance of the class and use as needed

```autohotkey
A := new biga()
wordsArray := A.words("This could be real real useful")
; => ["This", "could", "be", "real", "real", "useful"]
uniqWords := A.uniq(wordsArray)
msgbox, % uniqWords.Count()
; => 6
msgbox, % A.join(uniqWords, " ")
; => "This could be real useful"
```

Longer realworld examples available at https://github.com/biga-ahk/biga.ahk/tree/master/examples


## Documentation 

All working methods documented at https://biga-ahk.github.io/biga.ahk


## Contributing

Please make pull requests to src found at https://github.com/biga-ahk/biga.ahk
