Class biga {

	__New() {
        this.info_Array
        this.caseSensitive := false
        this.limit := -1
	}

    ; /--\--/--\--/--\--/--\--/--\
    ; Array functions
    ; \--/--\--/--\--/--\--/--\--/


    ; /--\--/--\--/--\--/--\--/--\
    ; Collection functions
    ; \--/--\--/--\--/--\--/--\--/

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

    find(para_collection,para_iteratee,para_fromindex := 1) {
        Loop, % para_collection.MaxIndex() {
            if (para_fromindex > A_Index) {
                continue
            }
            if (para_iteratee is string) {
                if (para_collection[A_Index][para_iteratee]) {
                    return % para_collection[A_Index]
                }
            }
            if (IsFunc(para_iteratee)) {
                if (%para_iteratee%(para_collection[A_Index])) {
                    return % para_collection[A_Index]
                }
            }
            if (para_iteratee.Count() > 0) {
                ; for Key, Value in para_func {
                ;     msgbox, % Key
                ;     msgbox, % Value
                ;     if (para_collection[A_Index][para_func]) {
                ;         return % this.info_Array.push(para_collection[A_Index])
                ;     }
                ; }
            }
        }
    }

    includes(para_collection,para_value,para_fromIndex := 1) {
        if (!IsObject(para_collection)) {
            stringFoundVar := InStr(para_collection, para_value, this.caseSensitive, para_fromIndex)
            if (stringFoundVar == 0) {
                return false
            } else {
                return true
            }
        } else {
            loop, % para_collection.MaxIndex() {
                if (para_fromIndex > A_Index) {
                    continue
                }
                if (para_collection[A_Index] = para_value) {
                    return true
                }
            }
            return false
        }
    }

    join(para_collection,para_sepatator := ",") {
        if (!IsObject(para_collection)) {
            return false
        }
        l_output := ""
        loop, % para_collection.MaxIndex() {
            if (A_Index == para_collection.MaxIndex()) {
                return % l_output para_collection[A_Index]
            }
            l_output := para_collection[A_Index] para_sepatator l_output
        }
    }

    map(para_collection,para_iteratee) {
        this.info_Array := []
        Loop, % para_collection.MaxIndex() {
            if (IsFunc(para_iteratee)) {
                    this.info_Array.push(%para_iteratee%(para_collection[A_Index]))
            }
            if (para_iteratee is string) {
                this.info_Array.push(para_collection[A_Index][para_iteratee])
            }
        }
        return this.info_Array
    }

    matches(para_source) {
        ; fn_array := []
        ; fn := Func("dothis")
        ; For Key, Value in para_source {

        ; }
    }

    merge(para_collections*) {
        result := para_collections[1]
        for i, obj in para_collections {
            if(A_Index = 1) {
                Continue 
            }
            result := this.internal_Merge(result, obj)
        }
        return result
    }

    mergeWith(para_collection1,para_collection2,para_func) {

    }
    

    orderBy() {

    }


    reverse(para_collection) {
        if (!IsObject(para_collection)) {
            throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
        }
        this.info_Array := []
        while (para_collection.MaxIndex() != "") {
            this.info_Array.push(para_collection.pop())
        }
        return % this.info_Array
    }


    sampleSize(para_collection,para_SampleSize) {
        if (!IsObject(para_collection)) {
            return false
        }
        if (para_SampleSize > para_collection.MaxIndex()) {
            return % para_collection
        }

        this.info_Array := []
        l_dummyArray := []
        loop, %para_SampleSize%
        {
            Random, randomNum, 1, para_collection.MaxIndex()
            while (this.indexOf(l_dummyArray,randomNum) != -1) {
                l_dummyArray.push(randomNum)
                Random, randomNum, 1, para_collection.MaxIndex()
            }
            this.info_Array.push(para_collection[randomNum])
            para_collection.RemoveAt(randomNum)
        }
        return % this.info_Array
    }


    uniq(para_collection) {
        global
        if (!IsObject(para_collection)) {
            return false
        }
        dummy_Array := []
        this.info_Array := []
        Loop, % para_collection.MaxIndex() {
            printedelement := MD5(this.objPrint(para_collection[A_Index]))
            if (this.indexOf(dummy_Array,printedelement) == -1) {
                dummy_Array.push(printedelement)
                this.info_Array.push(para_collection[A_Index])
            }
        }
        return this.info_Array
    }

    ; /--\--/--\--/--\--/--\--/--\
    ; String functions
    ; \--/--\--/--\--/--\--/--\--/

    replace(para_string := "",para_needle := "",para_replacement := "") {
        l_string := para_string
        output := StrReplace(l_string, para_needle, para_replacement, , this.limit)
        return % output
    }


    ; /--\--/--\--/--\--/--\--/--\
    ; Util functions
    ; \--/--\--/--\--/--\--/--\--/

    isMatch(para_obj,para_iteratee) {
        for Key, Value in para_iteratee {
            if (para_obj[key] == Value) {
                continue
            } else {
                return false
            }
        }
        return true
    }

    ; /--\--/--\--/--\--/--\--/--\
    ; Internal functions
    ; \--/--\--/--\--/--\--/--\--/

    indexOf(para_array,para_searchTerm)	{
        for index, value in para_array {
            if (this.caseSensitive ? (value == para_searchTerm) : (value = para_searchTerm)) {
                return index
            }
        }
        return -1
    }

    internal_Merge(para_collection1, para_collection2) {
        if(!IsObject(para_collection1) && !IsObject(para_collection2)) {

            ; if only one OR the other exist, display them together. 
            if(para_collection1 = "" || para_collection2 = "") {
                return para_collection2 para_collection1
            }
            ; if both are the same thing, return one of them only 
            if (para_collection1 = para_collection2)
                return para_collection1
            ; otherwise, return them together as an object. 
            return [para_collection1, para_collection2]
        }

        ; initialize an associative array
        combined := {}

        for key, val in para_collection1 {
            combined[key] := this.internal_Merge(val, para_collection2[key])
        }

        for key, val in para_collection2 {
            if(!combined.HasKey(key)) {
                combined[key] := val
            }
        }
        return combined
    }

    printObj(para_obj) {
        if this.internal_IsCircle(para_obj) {
            throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
        }
        for Key, Value in para_obj {
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

    internal_IsCircle(para_obj, para_objs=0) {
        if (!para_objs) {
            para_objs := {}
        }
        for Key, Val in para_obj
        {
            if (IsObject(Val)&&(para_objs[&Val]||Array_IsCircle(Val,(para_objs,para_objs[&Val]:=1)))) {
                return true
            }
        }
        return false
    }
}
