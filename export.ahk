Class biga {

	__New() {
        this.info_Array
	}


    filter(para_collection,para_func) {
        global
        if (!IsObject(para_collection)) {
            return false
        }
        this.info_Array := []
        Loop, % para_collection.MaxIndex() {
            l_element := %para_func%(para_collection[A_Index])
            if (l_element) {
                this.info_Array.push(l_element)
            }
        }
        return this.info_Array
    }
}
