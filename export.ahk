Class biga {

	__New() {
        this.info_Array
        this.caseSensitive := false
        this.limit := -1
	}

    ; /--\--/--\--/--\--/--\--/--\
    ; Array functions
    ; \--/--\--/--\--/--\--/--\--/

    filter(para_collection,para_func) {
        this.info_Array := []
        Loop, % para_collection.MaxIndex() {
            if (IsFunc(para_func)) {
                if (%para_func%(para_collection[A_Index])) {
                    this.info_Array.push(para_collection[A_Index])
                }
            }
            if (para_func is string) {
                if (para_collection[A_Index][para_func]) {
                    this.info_Array.push(para_collection[A_Index])
                }
            }
            if (para_func.Count() > 0) {
                for Key, Value in para_func {
                    msgbox, % Key
                    msgbox, % Value
                    if (para_collection[A_Index][para_func]) {
                        this.info_Array.push(para_collection[A_Index])
                    }
                }
            }
        }
        return this.info_Array
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
                if (para_fromIndex <= A_Index) {
                    if (para_collection[A_Index] = para_value) {
                        return true
                    }
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
        fn_array := []
        fn := Func("dothis")
        For Key, Value in para_source {

        }
    }

    merge() {

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
            printedelement := MD5(Array_Print(para_collection[A_Index]))
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
}
