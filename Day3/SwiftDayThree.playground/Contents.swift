import UIKit

/***
 操作符 + - * / % (加减乘除 取余)
 只能操作同类型的
 ***/


let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = 13 % secondScore

//+号同时支持字符串合并
let fakes = "Fakers gonna "
let action = fakes + "fake"
//+号也支持数组合并
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

/***
 赋值运算 =  +=  -=  *=  /=  %= ....
 ***/

var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

/***
 比较运算符 == != > < >= <=
 ***/
let firstHeight = 57
let secondHeight = 23

firstHeight == secondHeight
firstHeight != secondHeight
firstHeight >= secondHeight
firstHeight <= secondHeight

//比较运算符也可用在字符串比较
let firstStr = "Taylor"
let seconfStr = "Swift"
firstStr <= seconfStr

/***
 条件判断语句
 有了比较运算符,我们可以使用if判断状态
 ***/
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
}

if firstCard + secondCard == 21 {
    print("Backjack!")
} else {
    print("Refular cards")
}

if firstCard + secondCard == 2 {
    print("Aces - lucky!")
}else if firstCard + secondCard == 21{
    print("Backjack!")
}else{
    print("Regular cards")
}

/***
 混合条件判断语句
 包含多个条件判断语句执行
 && 逻辑 与  两侧都为true n则为true 有一项为flase 则为flase
 || 逻辑 或  两侧有一项为true 则为true
 ! 逻辑 非   布尔值取反   !(A&&B)
 ***/

let age1 = 12
let age2 = 21
if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}
//使用, 等同于 &&
if age1 > 18 , age2 > 18 {
    print("Both are over 18")
}
if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}
if !(age1 > 18) {
    print("Isn't over 18")
}

/***
 三元操作符
 condition ? X : Y 如果 condition 为 true ,值为X,否则为Y
 ***/

let firstNumber = 11
let secondNumber = 10
print(firstNumber == secondNumber ? "Numbers are the same" : "Numbers are different")
//上面三元操作符等同于: if...else
if firstNumber == secondNumber {
    print("Numbers are the same")
} else {
    print("Numbers are different")
}

/***
 switch语句
 switch 语句允许测试一个变量等于多个值时的情况。 Swift 语言中只要匹配到 case 语句，则整个 switch 语句执行完成。
 **注意 case 语句中如果没有使用 fallthrough 语句，则在执行当前的 case 语句后，switch 会终止，控制流将跳转到 switch 语句后的下一行。
 如果使用了fallthrough 语句，则会继续执行之后的 case 或 default 语句，不论条件是否满足都会执行
 ***/
let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

/***
 区间运算符  ...  ..<
 1..<5 包含 1,2,3,4  1...5 包含 1,2,3,4,5
 ***/
let number = 85
switch number {
case 0..<50:
    print("Less than 50")
case 50..<85:
    print("Greater than or equal to 50 and less than 85")
default:
    print("Greater than or equal to 85")
}

/***
 总结:
 1.swift 基本操作符 + - * / % 加减乘除取余
 2.赋值运算 = 赋值 += 想加再赋值 -= 相减再赋值 *= 相乘再赋值 /= 相除再赋值 %= 求余后再赋值
 3.比较运算 == 相等 >= 大于等于 <= 小于等于 < 小于 > 大于 != 不等于
 4.可以使用if，else和else if来根据条件的结果运行代码
 5.三元操作符 检查真假 运行代码块, 可读性差,建议少使用
 6.一个值的不同状态可以使用switch语句,使代码更清晰
 7.使用..< 和...制定范围取值
 ***/




















