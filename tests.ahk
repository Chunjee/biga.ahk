#Include export.ahk
#Include ..\unit-testing.ahk\export.ahk
#Include ..\arraygui.ahk\export.ahk
#NoTrayIcon
#SingleInstance, force

SetBatchLines, -1

A := new biga()
assert := new unittesting()


;globally used test array and vars
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]


;; Test filter()
assert.test(A.filter(users,Func("fn_filter1")), [{"user":"barney", "age":36, "active":true}])
fn_filter1(para_interatee) {
    if (para_interatee.active) { 
        return true 
    }
}

assert.test(A.filter([1,2,3,-10,1.9],Func("fn_filter2")), [2,3])
fn_filter2(para_interatee) {
    if (para_interatee >= 2) {
        return para_interatee
    }
    return false
}

    ;property shorthand
assert.test(A.filter(users,"active"), [{"user":"barney", "age":36, "active":true}])
;     ;matches shorthand
; assert.test(A.filter(users,{"age": 36,"active":true}), {"user":"barney", "age":36, "active":true})
;     ;matchesProperty shorthand
; assert.test(A.filter(users,["active",true]), {"user":"barney", "age":36, "active":true})

; assert.test(A.filter([.3,.4,.6],Func("FilterFn2")), [.6])


;; Test map
assert.test(A.map([4,8],Func("fn_square")), [16,64])
fn_square(para_number) {
    return para_number * para_number
}
    ; property shorthand
assert.test(A.map(users,"user"), ["barney","fred"])


;; Test includes()
assert.test(A.includes([1,2,3],3), true)
assert.test(A.includes("InStr","Str"), true)
assert.test(A.includes("InStr","Other"), false)

;; Test reverse()
assert.test(A.reverse(["a","b","c"]), ["c","b","a"])
assert.test(A.reverse([{"foo":"bar"},"b","c"]), ["c","b",{"foo":"bar"}])
assert.test(A.reverse([[1,2,3],"b","c"]), ["c","b",[1,2,3]])

;; Display test results in GUI
assert.fullreport()

ExitApp
