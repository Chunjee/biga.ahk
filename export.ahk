Class biga {

	__New() {
        this.info_Array
        this.caseSensitive := false
        this.limit := -1

        this.matchesObj
	}

	concat(param_array,param_values*) {
	    if (!IsObject(param_array)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    l_array := this.clone(param_array)
	    for i, obj in param_values
	    {
	        if (!IsObject(obj)) {
	            ; push on any plain values
	            l_array.push(obj)
	        } else {
	            loop, % obj.MaxIndex() {
	                l_array.push(obj[A_Index])
	            }
	        }
	    }
	    return l_array
	}
	difference(param_array, param_values*) {
	    if (!IsObject(param_array)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    l_array := this.clone(param_array)

	    for i, obj in param_values
	    {
	        Loop, % obj.MaxIndex() {
	            if (this.indexOf(l_array,obj[A_Index]) != -1) {
	                l_array.RemoveAt(A_Index)
	            }
	        }
	    }
	    return l_array
	}
	findIndex(param_array,param_value,fromIndex := 1) {
	    if (IsObject(param_value)) {
	        vSearchingobjects := true
	        param_value := this.printObj(param_value)
	    }
	    for Index, Value in param_array {
	        if (Index < fromIndex) {
	            continue
	        }
	        if (vSearchingobjects) {
	            Value := this.printObj(Value)
	        }
	        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
	            return %Index%
	        }
	    }
	    return -1
	}
	indexOf(param_array,param_value,fromIndex := 1) {
	    for Index, Value in param_array {
	        if (Index < fromIndex) {
	            continue
	        }
	        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
	            return Index
	        }
	    }
	    return -1
	}
	join(param_array,param_sepatator := ",") {
	    if (!IsObject(param_array)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    l_array := this.clone(param_array)
	    loop, % l_array.Count() {
	        if (A_Index == 1) {
	            l_string := "" l_array[A_Index]
	            continue
	        }
	        l_string := l_string param_sepatator l_array[A_Index]
	    }
	    return l_string
	}
	lastIndexOf(param_array,param_value,param_fromIndex := 0) {
	    if (param_fromIndex == 0) {
	        param_fromIndex := param_array.Count()
	    }
	    for Index, Value in param_array {
	        Index -= 1
	        vNegativeIndex := param_array.Count() - Index
	        if (vNegativeIndex > param_fromIndex) { ;skip search if 
	            continue
	        }
	        if (this.caseSensitive ? (param_array[vNegativeIndex] == param_value) : (param_array[vNegativeIndex] = param_value)) {
	            return vNegativeIndex
	        }
	    }
	    return -1
	}
	reverse(param_collection) {
	    if (!IsObject(param_collection)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    this.info_Array := []
	    while (param_collection.MaxIndex() != "") {
	        this.info_Array.push(param_collection.pop())
	    }
	    return % this.info_Array
	}
	uniq(param_collection) {
	    if (!IsObject(param_collection)) {
	        return false
	    }
	    dummy_Array := []
	    this.info_Array := []
	    Loop, % param_collection.MaxIndex() {
	        printedelement := this.internal_MD5(this.printObj(param_collection[A_Index]))
	        if (this.indexOf(dummy_Array,printedelement) == -1) {
	            dummy_Array.push(printedelement)
	            this.info_Array.push(param_collection[A_Index])
	        }
	    }
	    return this.info_Array
	}
	filter(param_collection,param_func) {
	    this.info_Array := []
	    Loop, % param_collection.MaxIndex() {
	        if (param_func is string) {
	            if (param_collection[A_Index][param_func]) {
	                this.info_Array.push(param_collection[A_Index])
	            }
	        }
	        if (IsFunc(param_func)) {
	            if (%param_func%(param_collection[A_Index])) {
	                this.info_Array.push(param_collection[A_Index])
	            }
	        }
	        ; if (param_func.Count() > 0) {
	        ;     for Key, Value in param_func {
	        ;         msgbox, % Key
	        ;         msgbox, % Value
	        ;         if (param_collection[A_Index][param_func]) {
	        ;             this.info_Array.push(param_collection[A_Index])
	        ;         }
	        ;     }
	        ; }
	    }
	    return this.info_Array
	}
	find(param_collection,param_iteratee,param_fromindex := 1) {
	    Loop, % param_collection.MaxIndex() {
	        if (param_fromindex > A_Index) {
	            continue
	        }
	        ; A.property handling
	        if (param_iteratee is string) {
	            if (param_collection[A_Index][param_iteratee]) {
	                return param_collection[A_Index]
	            }
	        }
	        if (IsFunc(param_iteratee)) {
	            if (%param_iteratee%(param_collection[A_Index])) {
	                return param_collection[A_Index]
	            }
	        }
	        if (param_iteratee.Count() > 0) {
	            ; for Key, Value in param_func {
	            ;     msgbox, % Key
	            ;     msgbox, % Value
	            ;     if (param_collection[A_Index][param_func]) {
	            ;         return % this.info_Array.push(param_collection[A_Index])
	            ;     }
	            ; }
	        }
	    }
	}
	includes(param_collection,param_value,param_fromIndex := 1) {
	    if (IsObject(param_collection)) {
	        loop, % param_collection.MaxIndex() {
	            if (param_fromIndex > A_Index) {
	                continue
	            }
	            if (param_collection[A_Index] = param_value) {
	                return true
	            }
	        }
	        return false
	    } else {
	        ; RegEx
	        if (RegEx_value := this.internal_JSRegEx(param_value)) {
	            return % RegExMatch(param_collection, RegEx_value, RE, param_fromIndex)
	        }
	        ; Normal string search
	        if (InStr(param_collection, param_value, this.caseSensitive, param_fromIndex)) {
	            return true
	        } else {
	            return false
	        }
	    }
	}
	map(param_collection,param_iteratee) {
	    if (!IsObject(param_collection)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    l_array := []
	    ; check what kind of param_iteratee being worked with
	    if (IsFunc(param_iteratee)) {
	        BoundFunc := param_iteratee.Bind(this)
	    } else {
	        BoundFunc := false
	    }

	    ; run against every value in the collection
	    for Key, Value in param_collection {
	        if (!BoundFunc) { ; is property/string
	            vReturn := param_collection[A_Index][param_iteratee]
	            l_array.push(vReturn)
	            continue
	        }
	        vReturn := BoundFunc.Call(Value)
	        if (vReturn) {
	            l_array.push(vReturn)
	        } else {
	            l_array.push(param_iteratee.Call(Value))
	        }
	    }
	    return l_array
	}
	matches(param_source) {
	    if (!IsObject(param_source)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }

	    ; this.matchesObj := this.cloneDeep(param_source)
	    ; for Key, Value in param_source {
	    ;     BoundFunc := this.internal_matches.Bind(Value)
	    ;     if (BoundFunc.Call()) {
	    ;         l_array.push(BoundFunc.Call())
	    ;     } else {
	    ;         l_array.push(param_iteratee.Call(Value))
	    ;     }
	    ; }
	    ; return Func(this.matchesObj)
	    ; BoundFunc := Func.Bind(Param1, Param2, ...)
	}

	internal_matches(input1) {

	}
	sample(param_collection) {
	    return this.sampleSize(param_collection)
	}
	sampleSize(param_collection,param_SampleSize := 1) {
	    if (!IsObject(param_collection)) {
	        return false
	    }
	    if (param_SampleSize > param_collection.MaxIndex()) {
	        return % param_collection
	    }

	    this.info_Array := []
	    l_dummyArray := []
	    loop, %param_SampleSize%
	    {
	        Random, randomNum, 1, param_collection.MaxIndex()
	        while (this.indexOf(l_dummyArray,randomNum) != -1) {
	            l_dummyArray.push(randomNum)
	            Random, randomNum, 1, param_collection.MaxIndex()
	        }
	        this.info_Array.push(param_collection[randomNum])
	        param_collection.RemoveAt(randomNum)
	    }
	    return this.info_Array
	}
	shuffle(param_collection) {
	    if (!IsObject(param_collection)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    l_shuffledArray := []
	    loop, % param_collection.MaxIndex() {
	        Random, randomvar, 1, param_collection.MaxIndex()
	        l_shuffledArray.push(param_collection.RemoveAt(randomvar))
	    }
	    return l_shuffledArray
	}
	size(param_collection) {

	    if (param_collection.MaxIndex() > 0) {
	        return % param_collection.MaxIndex()
	    }

	    if (param_collection.Count() > 0) {
	        return % param_collection.Count()
	    }

	    return % StrLen(param_collection)
	}
	sort(param_collection, param_iteratees := "name") {
	    l_array := this.cloneDeep(param_collection)
	    Order := 1

	    for index2, obj2 in l_array {           
	        for index, obj in l_array {
	            if (lastIndex = index)
	                break
	            if !(A_Index = 1) && ((Order = 1) ? (l_array[prevIndex][param_iteratees] > l_array[index][param_iteratees]) : (l_array[prevIndex][param_iteratees] < l_array[index][param_iteratees])) {    
	               tmp := l_array[index][param_iteratees] 
	               l_array[index][param_iteratees] := l_array[prevIndex][param_iteratees]
	               l_array[prevIndex][param_iteratees] := tmp  
	            }         
	            prevIndex := index
	        }     
	        lastIndex := prevIndex
	    }

	    ; remove any blank items if ahk array was made poorly
	    if (l_array.Count() != param_collection.MaxIndex() || StrLen(this.printObj(l_array[1])) < 2 || StrLen(this.printObj(l_array[l_array.MaxIndex()])) < 2) {
	        loop, % l_array.MaxIndex() {
	            if (StrLen(this.printObj(l_array[A_Index])) < 2) {
	                l_array.RemoveAt(A_Index)
	            }
	        }
	    }
	    return l_array
	}
	sortBy(param_collection, param_iteratees) {
	    l_array := this.cloneDeep(param_collection)
	    Order := 1

	    if (IsObject(param_iteratees)) {
	        ; sort the collection however many times is requested by the shorthand identity
	        for Key, Value in param_iteratees {
	            l_array := this.sort(l_array, Value)
	        }
	    }

	    ; if (IsFunc(param_iteratees)) {
	    ;     temp_array := []
	    ;     for Key, Value in param_collection {
	    ;         temp_array.push(param_iteratees.__Call(param_collection[key]))
	    ;     }
	    ;     l_array := this.cloneDeep(temp_array)
	    ;     temp_array := [] ; free memory
	    ; }

	    return l_array
	}
	; /--\--/--\--/--\--/--\--/--\
	; Internal functions
	; \--/--\--/--\--/--\--/--\--/

	printObj(param_obj) {
	    if (!IsObject(param_obj)) {
	        return param_obj
	    }
	    if this.internal_IsCircle(param_obj) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    for Key, Value in param_obj {
	        if Key is not Number 
	        {
	            Output .= """" . Key . """:"
	        } else {
	            Output .= Key . ":"
	        }
	        if (IsObject(Value)) {
	            Output .= "[" . this.printObj(Value) . "]"
	        } else if (Value is not number) {
	            Output .= """" . Value . """"
	        }
	        else {
	            Output .= Value
	        }
	        Output .= ", "
	    }
	    StringTrimRight, OutPut, OutPut, 2
	    Return OutPut
	}

	internal_IsCircle(param_obj, param_objs=0) {
	    if (!param_objs) {
	        param_objs := {}
	    }
	    for Key, Val in param_obj {
	        if (IsObject(Val)&&(param_objs[&Val]||this.internal_IsCircle(Val,(param_objs,param_objs[&Val]:=1)))) {
	            return true
	        }
	    }
	    return false
	}

	internal_MD5(param_string, case := 0) {
	    static MD5_DIGEST_LENGTH := 16
	    hModule := DllCall("LoadLibrary", "Str", "advapi32.dll", "Ptr")
	    , VarSetCapacity(MD5_CTX, 104, 0), DllCall("advapi32\MD5Init", "Ptr", &MD5_CTX)
	    , DllCall("advapi32\MD5Update", "Ptr", &MD5_CTX, "AStr", param_string, "UInt", StrLen(param_string))
	    , DllCall("advapi32\MD5Final", "Ptr", &MD5_CTX)
	    loop % MD5_DIGEST_LENGTH
	        o .= Format("{:02" (case ? "X" : "x") "}", NumGet(MD5_CTX, 87 + A_Index, "UChar"))
	    return o, DllCall("FreeLibrary", "Ptr", hModule)
	}

	internal_JSRegEx(param_string) {
	    if (this.startsWith(param_string,"/") && this.startsWith(param_string,"/"),StrLen(param_string)) {
	        return % SubStr(param_string, 2 , StrLen(param_string) - 2)
	    }
	    return false
	}
	clone(param_value) {
	    if (IsObject(param_value)) {
	        return param_value.Clone()
	    } else {
	        return param_value
	    }
	}
	cloneDeep(param_array,Objs := 0) {
	    if (!Objs) {
	        Objs := {}
	    }
	    Obj := param_array.Clone()
	    Objs[&param_array] := Obj ; Save this new array
	    For Key, Val in Obj {
	        if (IsObject(Val)) ; If it is a subarray
	            Obj[Key] := Objs[&Val] ; If we already know of a refrence to this array
	            ? Objs[&Val] ; Then point it to the new array
	            : this.clone(Val,Objs) ; Otherwise, clone this sub-array
	    }
	    return Obj
	}
	isEqual(param_value, param_other) {
	    if (IsObject(param_value)) {
	        param_value := this.printObj(param_value)
	        param_other := this.printObj(param_other)
	    }

	    if (this.caseSensitive ? (param_value == param_other) : (param_value = param_other)) {
	        return true
	    }
	    return false
	}
	isMatch(param_obj,param_iteratee) {
	    for Key, Value in param_iteratee {
	        if (param_obj[key] == Value) {
	            continue
	        } else {
	            return false
	        }
	    }
	    return true
	}
	isUndefined(param_value) {
	    if (!param_value || param_value == "") {
	        return true
	    }
	    return false
	}
	merge(param_collections*) {
	    result := param_collections[1]
	    for i, obj in param_collections {
	        if(A_Index = 1) {
	            Continue 
	        }
	        result := this.internal_Merge(result, obj)
	    }
	    return result
	}

	internal_Merge(param_collection1, param_collection2) {
	    if(!IsObject(param_collection1) && !IsObject(param_collection2)) {
	        ; if only one OR the other exist, display them together. 
	        if(param_collection1 = "" || param_collection2 = "") {
	            return param_collection2 param_collection1
	        }
	        ; return only one if they are the same
	        if (param_collection1 = param_collection2)
	            return param_collection1
	        ; otherwise, return them together as an object. 
	        return [param_collection1, param_collection2]
	    }

	    ; initialize an associative array
	    combined := {}

	    for key, val in param_collection1 {
	        combined[key] := this.internal_Merge(val, param_collection2[key])
	    }
	    for key, val in param_collection2 {
	        if(!combined.HasKey(key)) {
	            combined[key] := val
	        }
	    }
	    return combined
	}
	replace(param_string := "",param_needle := "",param_replacement := "") {
	    l_string := param_string
	    ; RegEx
	    if (l_needle := this.internal_JSRegEx(param_needle)) {
	        return % RegExReplace(param_string, l_needle, param_replacement, , this.limit)
	    }
	    output := StrReplace(l_string, param_needle, param_replacement, , this.limit)
	    return output
	}
	split(param_string := "",param_separator := ",", param_limit := 0) {
	    if (IsObject(param_string)) {
	        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
	    }
	    ; regex
	    if (this.internal_JSRegEx(param_separator)) {
	        param_string := this.replace(param_string,param_separator,",")
	        param_separator := ","
	    }

	    oSplitArray := StrSplit(param_string, param_separator)
	    if (!param_limit) {
	        return oSplitArray
	    } else {
	        oReducedArray := []
	        loop, % param_limit {
	            if (A_Index <= oSplitArray.MaxIndex()) {
	                oReducedArray.push(oSplitArray[A_Index])
	            }
	        }
	    }
	    return oReducedArray
	}
	startCase(param_string := "") {
	    l_string := this.replace(param_string,"/(\W)/"," ")
	    l_string := this.replace(l_string,"/([\_])/"," ")

	    ; add space before each capitalized character
	    RegExMatch(l_string, "O)([A-Z])", RE_Match)
	    if (RE_Match.Count()) {
	        loop, % RE_Match.Count() {
	            l_string := % SubStr(l_string,1,RE_Match.Pos(A_Index) - 1) " " SubStr(l_string,RE_Match.Pos(A_Index))
	        }
	    }
	    ; Split the string into array and Titlecase each element in the array
	    l_array := StrSplit(l_string, " ")
	    loop, % l_array.MaxIndex() {
	        x_string := l_array[A_Index]
	        StringUpper, x_string, x_string, T
	        l_array[A_Index] := x_string
	    }
	    ; join the string back together from Titlecased array elements
	    l_string := this.join(l_array," ")
	    l_string := this.trim(l_string)
	    return l_string
	}
	startsWith(param_string, param_needle, param_fromIndex := 1) {
	    l_startString := SubStr(param_string, param_fromIndex, StrLen(param_needle))
	    ; check if substring matches
	    if (this.caseSensitive ? (l_startString == param_needle) : (l_startString = param_needle)) {
	        return true
	    }
	    return false
	}
	toLower(param_string) {
	    StringLower, OutputVar, param_string
	    return % OutputVar
	}
	toUpper(param_string) {
	    StringUpper, OutputVar, param_string
	    return % OutputVar
	}
	trim(param_string,param_chars := " ") {
	    if (param_chars = " ") {
	        l_string := this.trimStart(param_string, param_chars)
	        return % this.trimEnd(l_string, param_chars)
	    } else {
	        l_string := param_string
	        l_removechars := "\" this.join(StrSplit(param_chars,""),"\")

	        ; replace starting characters
	        l_string := this.trimStart(l_string,param_chars)
	        ; replace ending characters
	        l_string := this.trimEnd(l_string,param_chars)
	        return l_string
	    }
	}
	trimEnd(param_string,param_chars := " ") {
	    if (param_chars = " ") {
	        l_string := param_string
	        return % regexreplace(l_string, "(\s+)$") ;trim ending whitespace
	    } else {
	        l_string := param_string
	        l_removechars := "\" this.join(StrSplit(param_chars,""),"\")

	        ; replace ending characters
	        l_string := this.replace(l_string,"/([" l_removechars "]+)$/","")
	        return l_string
	    }
	}
	trimStart(param_string,param_chars := " ") {
	    if (param_chars = " ") {
	        return % regexreplace(param_string, "^(\s+)") ;trim beginning whitespace
	    } else {
	        l_string := param_string
	        l_removechars := "\" this.join(StrSplit(param_chars,""),"\")

	        ; replace starting characters
	        l_string := this.replace(l_string,"/^([" l_removechars "]+)/","")
	        return l_string
	    }
	}
	truncate(param_string, param_options := "") {
	    if (!IsObject(param_options)) {
	        param_options := {}
	        param_options.length := 30
	    }
	    if (!param_options.omission) {
	        param_options.omission := "..."
	    }

	    ; check that length is even worth working on
	    if (StrLen(param_string) + StrLen(param_options.omission) < param_options.length && !param_options.separator) {
	        return param_string
	    }

	    l_array := StrSplit(param_string,"")
	    l_string := ""
	    ; cut length of the string by character count + the omission's length
	    if (param_options.length) {
	        loop, % l_array.MaxIndex() {
	            if (A_Index > param_options.length - StrLen(param_options.omission)) {
	                l_string := l_string param_options.omission
	                break
	            }
	            l_string := l_string l_array[A_Index]
	        }
	    }

	    ; separator
	    if (this.internal_JSRegEx(param_options.separator)) {
	        param_options.separator := this.internal_JSRegEx(param_options.separator)
	    }
	    if (param_options.separator) {
	        return % RegexReplace(l_string, "^(.{1," param_options.length "})" param_options.separator ".*$", "$1") param_options.omission
	        ; reversestring := this.join(this.reverse(StrSplit(l_string)),"")
	        ; param_options.reverseseparator := this.join(this.reverse(StrSplit(param_options.separator)),"")
	        ; l_match := RegExMatch(reversestring, "P)" param_options.reverseseparator, RE_Match)
	        ; ; msgbox, % "REGEX: " RE_MatchPos1 " / " RE_MatchLen1 "/" l_match "`n-" param_options.separator "-`n`n" param_string "`n" l_string
	        ; if (l_match) {
	        ;     param_options.regexmatchposition := l_match
	        ; }
	        ; if (RE_MatchPos1) {
	        ;     param_options.regexmatchposition := RE_MatchPos1
	        ; }
	        ; if (param_options.regexmatchposition) {
	        ;     l_string := SubStr(reversestring, param_options.regexmatchposition + StrLen(param_options.separator))
	        ;     return % this.join(this.reverse(StrSplit(l_string)),"") . param_options.omission
	        ; }
	    }
	    return l_string
	}
}
