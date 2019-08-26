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
        global
        if (!IsObject(para_collection)) {
            return false
        }
        this.info_Array := []
        Loop, % para_collection.MaxIndex() {
            if (%para_func%(para_collection[A_Index])) {
                this.info_Array.push(para_collection[A_Index])
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
                if (para_fromIndex > A_Index) {
                    if (para_collection[A_Index] == para_value) {
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

    merge(para_) {

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
