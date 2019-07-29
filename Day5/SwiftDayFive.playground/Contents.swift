import UIKit

/***
 函数:
 函数提供重复利用代码,我们可以写一个函数,在很多地方使用
 ***/
func printHelp(){
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    print(message)
    
}
//执行函数
printHelp()
/***
 函数可以接受一个或者多个参数，这些参数被包含在函数的括号之中，以逗号分隔。
 ***/
func square(number: Int){
    print(number * number)
}
square(number: 8)

/***
 函数返回值
 函数不仅能接受参数,也能返回参数,在传参后面加->和返回的数据类型,函数内用return 返回 应得的返回值,函数执行完成
 ***/
func square1(number: Int) -> Int{
    return number * number
}

let result = square1(number: 8)
print(result)

/***
 函数参数标签:
 Swift允许我们为每个参数定义两个名字,一个用在调用函数时使用,另一个在函数内部使用,这两个名字之间用空格分隔开
 ***/
func sayHello(to name: String){
    print("Hello, \(name)!")
}
sayHello(to: "Tom")

/***
 省略函数参数标签
 我们使用print函数不需要使用任何参数名 比如print("Hello") 而不是 print(message: "Hello")
 你也可以是用_下划线作为你的外部参数名称
 ***/
func greet(_ person: String){
    print("Hello, \(person)!")
}
//调用greet()函数:
greet("Lily")
//使不使用外部参数名取决于你当前的函数名称是否表达清楚函数的意义

/***
 默认参数值
 你可以使用 = 给参数一个默认值,使用默认值后,这个参数变成了可选参数
 ***/

func greeting(_ person: String, nicely: Bool = true){
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again ...")
    }
}
//执行上面函数可以用两种方式:
greeting("Taylor")
greeting("Taylor", nicely: false)

/***
 函数-可变参数
 可变参数可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数，其数量是不确定的。
 可变参数通过在变量类型名后面加入（...）的方式来定义。
 ***/
func square2(numbers: Int...){
    for number in numbers {
        print("\(number) square is \(number * number)")
    }
}
square2(numbers: 2, 3, 4)

func vari<N>(numbers: N...){
    for i in numbers {
        print(i)
    }
}
vari(numbers: 4, 3, 5)
vari(numbers: 4.3, 5.5, 4.1)
vari(numbers: "Google", "Baidu", "Taobao")

/***
 函数-抛出异常
 函数有时候因为输入错误或者其他问题执行失败,Swift允许使用 throw 当执行错误时抛出异常
 使用enum定义抛出的异常类型,必须基于Error类型
 ***/

enum PasswordError: Error{
    case obvious
}
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
//Swift不希望在程序运行中抛出错误, 所以我们需要在可能发生错误的地方去处理异常,使用do-catch语句处理错误
//do {
//    try expression
//    statements
//} catch pattern 1 {
//    statements
//} catch pattern 2 where condition {
//    statements
//} catch {
//    statements
//}

do {
    try checkPassword("password")
    print("That password is good")
} catch {
    print("You can't use taht password")
}

/***
 inout关键字
 传递给swift函数的所有参数s都是常量,不能改变它的值, 如果需要更改,使用inout关键字,使传入参数可以在函数内部更改值,改变后,函数外的值也发生改变
 ***/
func doubleInPlace(number: inout Int){
    number *= 2
}
//首先定义一个变量integer -使用inout时不能定义常量integer,因为它的值会发生改变.使用时,在inout关键字修饰的参数前面使用&传参

var myNum = 10
doubleInPlace(number: &myNum)

print(myNum)
//交换值
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

/***
 总结:
 1.函数提供重复利用的代码
 2.函数可以接受传参,需要指定参数的类型
 3.函数可以有返回值,需要指定返回的类型,如果返回多个内容,使用元组作为返回参数
 4.你可以指定函数的内部和外部使用参数名称,也可以省略外部参数名称
 5.函数参数可以设置默认值,特定值通用时减少代码量
 6.函数的参数可以有0个或多个,swift将输入转化为数组
 7.函数可能抛出异常,可以使用do-catch处理异常错误
 8.你可以使用inout关键字来改变函数内的变量,但通常最好返回一个新的值
 ***/
