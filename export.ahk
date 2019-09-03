Class biga {

	__New() {
        this.info_Array
        this.caseSensitive := false
        this.limit := -1
	}
    
    concat(param_array,param_values*) {
        if (!IsObject(l_array)) {
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

    clone(param_array,Objs := 0) {
        if (!Objs) {
            Objs := {}
        }
        Obj := param_array.Clone()
        Objs[&param_array] := Obj ; Save this new array
        For Key, Val in Obj
        {
            if (IsObject(Val)) ; If it is a subarray
                Obj[Key] := Objs[&Val] ; If we already know of a refrence to this array
                ? Objs[&Val] ; Then point it to the new array
                : this.clone(Val,Objs) ; Otherwise, clone this sub-array
        }
        return Obj
    }
    
    difference(para_array, para_excludevalues) {

    }


    join(param_collection,param_sepatator := ",") {
        if (!IsObject(param_collection)) {
            return false
        }
        l_Array := ""
        loop, % param_collection.MaxIndex() {
            if (A_Index == param_collection.MaxIndex()) {
                return % l_Array param_collection[A_Index]
            }
            l_Array := param_collection[A_Index] param_sepatator l_Array
        }
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
        global
        if (!IsObject(param_collection)) {
            return false
        }
        dummy_Array := []
        this.info_Array := []
        Loop, % param_collection.MaxIndex() {
            printedelement := this.internal_MD5(this.objPrint(param_collection[A_Index]))
            if (this.indexOf(dummy_Array,printedelement) == -1) {
                dummy_Array.push(printedelement)
                this.info_Array.push(param_collection[A_Index])
            }
        }
        return this.info_Array
    }


    filter(para_collection,para_func) {
        this.info_Array := []
        Loop, % para_collection.MaxIndex() {
            if (para_func is string) {
                if (para_collection[A_Index][para_func]) {
                    this.info_Array.push(para_collection[A_Index])
                }
            }
            if (IsFunc(para_func)) {
                if (%para_func%(para_collection[A_Index])) {
                    this.info_Array.push(para_collection[A_Index])
                }
            }
            ; if (para_func.Count() > 0) {
            ;     for Key, Value in para_func {
            ;         msgbox, % Key
            ;         msgbox, % Value
            ;         if (para_collection[A_Index][para_func]) {
            ;             this.info_Array.push(para_collection[A_Index])
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
            if (param_iteratee is string) {
                if (param_collection[A_Index][param_iteratee]) {
                    return % param_collection[A_Index]
                }
            }
            if (IsFunc(param_iteratee)) {
                if (%param_iteratee%(param_collection[A_Index])) {
                    return % param_collection[A_Index]
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
            if (this.startsWith(param_value,"/") && this.startsWith(param_value,"/"),StrLen(param_collection)) {
                param_value := SubStr(param_value, 2 , StrLen(param_value) - 2)
                return % RegExMatch(param_collection, param_value, RE, param_fromIndex)
            }
            ; Normal string search
            stringFoundVar := InStr(param_collection, param_value, this.caseSensitive, param_fromIndex)
            if (stringFoundVar == 0) {
                return false
            } else {
                return true
            }
        }
    }


    map(param_collection,param_iteratee) {
        l_Array := []
        Loop, % param_collection.MaxIndex() {
            if (IsFunc(param_iteratee)) {
                    l_Array.push(%param_iteratee%(param_collection[A_Index]))
            }
            if (param_iteratee is string) {
                l_Array.push(param_collection[A_Index][param_iteratee])
            }
        }
        return % l_Array
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
        return % this.info_Array
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
        return % output
    }


    startCase(para_string) {
        StringUpper, para_string, para_string, T
        return % para_string
    }
    startsWith(para_string, para_needle, para_fromIndex := 1) {
        l_startString := SubStr(para_string, para_fromIndex, StrLen(para_needle))
        ; check if substring matches
        if (this.caseSensitive ? (l_startString == para_needle) : (l_startString = para_needle)) {
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


    truncate(param_string, param_options := "") {
        if (param_options.separator && this.includes(param_string, param_options.separator)) {
            param_string := StrSplit(param_string, param_options.separator)[1]
        }
        if (param_options.length > 0 && param_string.length > param_options.length) {
            param_string := SubStr(param_string, 1 , param_options.length)
        }
        return % param_string
    }


    ; /--\--/--\--/--\--/--\--/--\
    ; Internal functions
    ; \--/--\--/--\--/--\--/--\--/

    indexOf(param_array,param_searchTerm)	{
        for index, value in param_array {
            if (this.caseSensitive ? (value == param_searchTerm) : (value = param_searchTerm)) {
                return index
            }
        }
        return -1
    }



    printObj(param_obj) {
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
        for Key, Val in param_obj
        {
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
}
