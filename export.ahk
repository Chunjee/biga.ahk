Class biga {

	__New() {
        this.info_Array
        this.caseSensitive := false
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
