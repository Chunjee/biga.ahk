<div align="center">
	<a href="https://github.com/biga-ahk/biga.ahk">
		<img src="https://raw.githubusercontent.com/biga-ahk/biga.ahk/8cc466ae8a2764a9cd6f32a99d92f71276fbeee7/header.svg"/>
	</a>
	<br>
	<br>
	<a href="https://npmjs.com/package/biga.ahk">
		<img src="https://img.shields.io/npm/dm/biga.ahk?style=for-the-badge">
	</a>
	<a href="https://biga-ahk.github.io/biga.ahk">
		<img src="https://img.shields.io/badge/full-documentation-blue?style=for-the-badge">
	</a>
	<img src="https://img.shields.io/npm/l/string-similarity.ahk?color=tan&style=for-the-badge">
	<h3>
		A modern immutable utility library for AutoHotkey. Takes out the hassle of working with arrays, objects, strings, etc.<br>
	</h3>
</div>

Long-form README and documentation: https://biga-ahk.github.io/biga.ahk

Mirrors functionality and method names of [Lodash](https://lodash.com/)

:warning: **alpha - may have defects prior to v1.0.0** :warning:

------------------


## Installation

In a terminal or command line navigated to your project folder:

```bash
npm install biga.ahk
```

In your code only export.ahk needs to be included:

```autohotkey
#Include %A_ScriptDir%\node_modules
#Include biga.ahk\export.ahk

A := new biga()
msgbox, % A.join(A.concat(["a"], ["b", "c"]))
; => "a,b,c"
```

You may also review or copy the library from [./export.ahk on GitHub](https://raw.githubusercontent.com/biga-ahk/biga.ahk/master/export.ahk); #Incude as you would normally when manually downloading.

AutoHotkey v1.1.05 or better is required


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
