#Include export.ahk
#Include lib\unit-testing.ahk\export.ahk
#Include lib\util-array.ahk\export.ahk
#Include lib\util-misc.ahk\export.ahk
#Include lib\json.ahk\export.ahk
#NoTrayIcon
#SingleInstance, force

SetBatchLines, -1

A := new biga()
assert := new unittesting()


;globally used test array and vars
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]


; Star timer
Start := A_TickCount
QPC(1)

; =========================================================================================================
; TESTS
; =========================================================================================================

assert.label("filter()")
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

assert.label("filter() shorthands")
    ;property shorthand
assert.test(A.filter(users,"active"), [{"user":"barney", "age":36, "active":true}])
;     ;matches shorthand
; assert.test(A.filter(users,{"age": 36,"active":true}), {"user":"barney", "age":36, "active":true})
;     ;matchesProperty shorthand
; assert.test(A.filter(users,["active",true]), {"user":"barney", "age":36, "active":true})

; assert.test(A.filter([.3,.4,.6],Func("FilterFn2")), [.6])


;; Test map
assert.label("map()")
assert.test(A.map([4,8],Func("fn_square")), [16,64])
fn_square(para_number) {
    return para_number * para_number
}
    ; property shorthand
assert.test(A.map(users,"user"), ["barney","fred"])


;; Test merge
assert.label("merge()")
object := { "a": [{ "b": 2 }, { "d": 4 }] }
other := { "a": [{ "c": 3 }, { "e": 5 }] }
expected := { "a": [{ "b": 2, "c": 3 }, { "d": 4, "e": 5 }] }
assert.test(A.merge(object ,other),expected) ;FAILS CURRENTLY


;;Test mergeWith
assert.label("mergeWith()")
object := { "a": [1], "b": [2] }
other := { "a": [3], "b": [4] }


;; Test includes()
assert.label("includes()")
assert.true(A.includes([1,2,3],3))
assert.true(A.includes("InStr","Str"))
assert.false(A.includes("InStr","Other"))

;; Test reverse()
assert.label("reverse()")
assert.test(A.reverse(["a","b","c"]), ["c","b","a"])
assert.test(A.reverse([{"foo":"bar"},"b","c"]), ["c","b",{"foo":"bar"}])
assert.test(A.reverse([[1,2,3],"b","c"]), ["c","b",[1,2,3]])


;; Test find()
assert.label("find()")
users2 := [{ "user": "barney", "age": 36, "active": true }, { "user": "fred", "age": 40, "active": false }, { "user": "pebbles", "age": 1, "active": true } ]
barney := { "user": "barney", "age": 36, "active": true }
pebbles := { "user": "pebbles", "age": 1, "active": true }

assert.test(A.find(users2,"active"), barney)
assert.test(A.find(users2,"active",2), pebbles) ;fromindex argument
assert.test(A.find(users2,Func("fn_filter1")), barney)



;; Test isMatch()
assert.label("isMatch()")
object := { "a": 1, "b": 2, "c": 3 }
assert.true(A.isMatch(object,{"b": 2}))
assert.true(A.isMatch(object,{"b": 2, "c": 3}))

assert.false(A.isMatch(object,{"b": 1}))
assert.false(A.isMatch(object,{"b": 2, "z": 99}))



;; Display test results in GUI
speed := QPC(0)
; msgBox % speed
; msgbox, % A_TickCount - Start
assert.fullreport()

ExitApp



QPC(R := 0)
{
    static P := 0, F := 0, Q := DllCall("QueryPerformanceFrequency", "Int64P", F)
    return ! DllCall("QueryPerformanceCounter", "Int64P", Q) + (R ? (P := Q) / F : (Q - P) / F) 
}
