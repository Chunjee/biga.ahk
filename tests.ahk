#Include export.ahk
#Include ..\unit-testing.ahk\export.ahk
#Include ..\arraygui.ahk\export.ahk
#NoTrayIcon

SetBatchLines, -1

A := new biga()
assert := new unittesting()


;; Test reverse()
assert.test(A.reverse(["a","b","c"]), ["c","b","a"])
assert.test(A.reverse([{"foo":"bar"},"b","c"]), ["c","b",{"foo":"bar"}])
assert.test(A.reverse([[1,2,3],"b","c"]), ["c","b",[1,2,3]])

;; Test filter()
FilterFn(para_interatee) {
    if (para_interatee > .5) {
        return para_interatee
    }
    return false
}
assert.test(A.filter([.3,.4,.6],Func("FilterFn")), [.6])
assert.test(A.filter([1,-10,0],Func("FilterFn")), [1])

;; Test includes()
assert.test(A.includes([1,2,3],3), true)
assert.test(A.includes("InStr","Str"), true)
assert.test(A.includes("InStr","Other"), false)


;; Display test results in GUI
assert.fullreport()

ExitApp
