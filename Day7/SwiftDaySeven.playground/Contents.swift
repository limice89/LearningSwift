import UIKit

/***
 闭包二
 闭包作为函数内的传参,自身也可以有传参
 ***/
func travel(action: (String) -> Void){
    print("I'm getting ready to go")
    action("London")
    print("I'm arrived")
}
//调用travel函数
travel{(place: String) in
    print("I'm going to \(place) in my car")
}
travel { (place) in
    print("I'm going to \(place) in my car")
}
/***
 闭包作为函数内的传参,也可以有返回值
 ***/

func travels(action: (String) -> String){
    print("I'm ready")
    let message = action("Home")
    print(message)
    print("Done")
}
travels { (place: String) -> String in
    return "Where are your \(place)"
}
/***
 简洁写法
 Swift知道闭包内传参是字符串 所以可以移除String
 ***/
travels { (place) -> String in
    return "Let's go \(place)"
}
travels { place -> String in
    return "Let's go \(place)"
}
//Swift知道闭包内返回值是String,也可以移除返回类型String
travels { place in
    return "Let's go \(place)"
}
//因为闭包只有一行代码必须是返回值的代码，所以Swift也允许我们删除return关键字：
travels { place in
    "Let's go \(place)"
}
//Swift有一个简短的语法，可以让语句更短,我们可以让Swift为闭包的参数提供自动名称，而不是使用 place in,它们以美元符号命名，从0开始计数
travels {
    "Let's go \($0)"
}
/***
 使用多个参数的闭包为传参的函数
 ***/
func journey(action: (String, Int) -> String){
    print("I'm getting ready to go")
    let message = action("Zhengzhou", 80)
    print(message)
    print("I'm arrived")
}
journey {
    "I'm going to \($0) at \($1) miles per hour"
}
/***
 闭包为函数的返回值
 闭包不仅可以作为函数的传参,也可以是函数的返回值
 语法可能有点困惑,因为包含两个-> 第一个->是函数的返回值第二个->是闭包的返回值
 ***/
//传参为空,返回是一个闭包,返回闭包的传参是一个字符串,闭包返回值是空
func outing() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}
//函数调用
let result = outing()  //result是一个闭包,相当于一个函数
result("London")
//从技术上来说虽然能从outing() 调用返回值,是可行的,但是并不推荐这么使用
let result1 = outing()("London")

/***
 闭包捕获值
 闭包可以捕获包裹它的上下文所定义的常量和变量
 ***/
//(1)全局函数:
var number = 0
var add = {
    number += 1
    print(number)
}
add()      //1
add()      //2
add()      //3
print(number)       //3
//(2) 函数嵌套函数

func makeIncrementer(from start: Int, amount: Int) -> () -> Int{
    var number = start
    return {
        number += amount
        return number
    }
}

let incrementer = makeIncrementer(from: 0, amount: 1)
incrementer()       //1
incrementer()       //2
incrementer()       //3
//函数makeIncrementer返回的是一个没有参数返回整数的函数(闭包)，所以，常量incrementer其实就是一个函数。每次调用incrementer()都会执行闭包里面的操作，而闭包的上下文就是makeIncrementer函数。从这也可以看出来，函数既能当返回值，也可以做参数

//（3）swift中closure(闭包)和Object-C中block的区别
//block
/***
NSInteger number = 1;
NSMutableString *str = [NSMutableString stringWithString: @"hello"];
void(^block)() = ^{
    NSLog(@"%@--%ld", str, number);
};
[str appendString: @" world!"];
number = 5;
block();    //hello world!--1

//closure
var str = "hello"
var number = 1
let block = {
    print(str + "--" + " \(number)")
}
str.append(" world!")
number = 5
block()    //hello world!--5
 ***/
//一句话来说，block内部会对值类型做一份复制，并不指向之前的值的内存地址，而对于对象类型则会指向对象当前的内存地址，所以修改number时，block里的number数值不变，而修改字符串时，block里的字符串则改变了；closure则默认给外部访问的变量加上了__block修饰词的block。

/***
 闭包总结:
 1.你可以把闭包赋值给一个变量,之后在使用
 2.闭包可以接受参数和返回值,相当于一个函数
 3.你可以将闭包作为参数传给一个函数,闭包可以有自己的参数和返回值
 4.如果你的函数最后一个参数是闭包,你可以使用尾随闭包,使代码更简洁
 5.Swift自动提供简写参数名称，从0 开始计数 使用$0..$n
 6.如果在闭包内使用外部值,闭包可以捕获到并引用
 ***/


