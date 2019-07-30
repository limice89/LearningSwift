import UIKit

/***
 Swift 闭包(一)
 闭包(Closures) 是自包含的功能代码块,可以在代码中使用或者用来作为参数传值
 ***/
let driving = {
    print("I'm driving in my car")
}
driving()

/***
 闭包内传参
 {(参数: 类型) in ...}
 ***/
let drivings = {(place: String) in
    print("I'm going to \(place) in my car")
}
drivings("Nanjing")

/***
 闭包返回参数
  {(参数: 类型) -> 类型 in ...}
 ***/
let drivingWithReturn = {(place: String) -> String in
    return "I'm going to \(place) by bike"
}

let message = drivingWithReturn("Home")
print(message)
/***
 闭包作为函数参数使用
 ***/
let driving1 = {
    print("I'm diving in my car")
}
// 函数的参数为 () -> 即一个不含参数没有返回值的闭包
func travel(action: () -> Void){
    print("I'm getting ready to go")
    action()
    print("I'm arrived")
}
travel(action: driving1)

/***
 尾随闭包(Trailing closure syntax)
 注意，只有最后一个参数为闭包时才可以使用尾随闭包
 尾随闭包只是闭包的一种精简方式
 ***/
//函数最后参数为闭包

func travels(action: () -> Void){
    print("I'm getting ready to go")
    action()
    print("I'm arrived")
}
//普通写法如下:
travels(action: driving1)
//尾随闭包的写法:
travels() {
    print("I'm driving in my car")
}
//由于没有其他参数,我们可以直接写成:
travels {
    print("I'm driving in my car")
}

