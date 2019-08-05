import UIKit

/***
 Swift复习 第一天
 ***/

/*****变量和常量*****/

//变量可修改值
var product = "Melon"
product = "waterMelon"

//var product = "apple"        //报错,重复定义

//常量 不可修改值

let goods = "computer"
//goods = "TV"     //报错,不可改变值


/****数据类型****/

//var name
//name = "Tom"     //没有指定类型报错

//创建一个变量 给一个默认的值字符串或其他类型.  或者给定一个数据类型 表示此变量可以存储string 类型的值
// ？表示声明的时候不赋值 否则的话必须赋值

var name: String?
name = "Tom"
//注意: 为了写法规范name和:之间没有空格

//*字符串String是一系列字符的集合
//*Int Swift 提供了8，16，32和64位的有符号和无符号整数类型 //除非你需要特定长度的整数，一般来说使用Int就够了 32位和64位平台最大长度不同
//*浮点数：Float、Double  *** Double 表示64位浮点数。当你需要存储很大或者很高精度的浮点数时请使用此类型。
//                      *** Float 表示32位浮点数。精度要求不高的话可以使用此类型
//*Bool   基本的布尔（Boolean）类  只有true false
var age: Int?
age = 18

var latitude: Double?
latitude = 36.166667

var longitude: Float?
longitude = -86.783333                //-86.78333  最后一位丢失,精度不够

longitude = -186.783333              //-186.7833
longitude = -1286.783333             //-1286.783
longitude = -12386.783333            //-12386.78
longitude = -123486.783333           //-123486.8
longitude = -1234586.783333          //-1234587

latitude = -186.783333              //-186.783333
latitude = -1286.783333             //-1286.783333
latitude = -12386.783333            //-12386.783333
latitude = -123486.783333           //-123486.783333
latitude = -1234586.783333          //-1234586.783333

latitude = 123456789.123456789        //123456789.12345679       //超过精度范围

var isLate: Bool?
isLate = true


/****运算符****/
//+加 -减 *乘 /除 %取余 =赋值
var a = 10
a = a + 1         //11
a = a - 1         //10
a = a * a         //100

//+= 相加赋值   -= 相减并赋值  *= 相乘并赋值 /= 相除并赋值  %= 取余并赋值
var b = 10
b += 10         //20
b -= 10         //10
b /= 2          //5
b %= 2          //1

//比较运算符
//== 等于   != 不等于  > 大于  < 小于  >= 大于等于  <= 小于等于

var c = 1.1
var d = 2.2
var e = c + d
e > 3         //true
e >= 3        //true
e > 4         //false
e < 4         //true
//== 也可以用在字符串中
var name1 = "Jhon"
name1 == "Jhon"          //true
name1 != "Jhon"          //false

var isBlack = true
isBlack                   // true
!isBlack                  // false


/****字符串插入值****/
var name2 =  "Tim"
print("Your name is \(name2)")         //Your name is Tim
//也可以使用加号+ 合并一个字符串
print("Your name is " + name2)        //Your name is Tim

//如果要把Int 或者 Double 类型混合成一个字符串中 使用+ 号就不行了, 所以一般都使用\()来转化

var age2 = 25
var latitude2 = 36.18273

"Your name is \(name2), your age is \(age2), and your latitude is \(latitude2)"

/****数组****/
//数组使用有序列表存储同一类型的多个值
//创建数组
var someArray = [String]()                                     //[]
var someArray1 = [String](repeating: "ad", count: 2)           //["ad","ad"]
var someArray2 = [Int](repeating: 0, count: 3)                 //[0, 0, 0]
var someArray3: [Int] = [10, 20, 30]                           //[10, 20, 30]

//访问数组元素
var Arrayitem1 = someArray1[0]                             //"ad"
//修改数组   数组是常量不可修改
someArray2.append(20)
someArray2 += [40]
print(someArray2)                  //[0, 0, 0, 20, 40]
//合并数组
var someArray4 = someArray2 + someArray3
print(someArray4)                 //[0, 0, 0, 20, 40, 10, 20, 30]
//也可以创建任意类型的数组

var songs:[Any] = ["Shake", "Belong", "December", 4]
type(of: songs)             //Array<Any>.Type


/****字典****/
//字典用来存储无序的相同类型数据的集合,字典会强制检测元素的类型，如果类型不同则会报错
//Swift 字典每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。
//和数组中的数据项不同，字典中的数据项并没有具体顺序

//创建字典
var someDict = [Int: String]()
var someDict1: [Int: String] = [1: "One", 2: "Two", 3: "Three"]

//访问字典
var dictItem1 = someDict1[2]              //"Two"

//修改字典  字典是常量不可修改
someDict1[2] = "New Two"
someDict1.updateValue("New One", forKey: 1)
print(someDict1)                //[1: "New One", 2: "New Two", 3: "Three"]
someDict1[4] = "Four"
print(someDict1)               //[4: "Four", 3: "Three", 2: "New Two", 1: "New One"]
someDict1.removeValue(forKey: 4)
print(someDict1)               //[2: "New Two", 3: "Three", 1: "New One"]

/****条件语句****/
//if 语句
//一个 if 语句 由一个布尔表达式后跟一个或多个语句组成

var number: Int = 10
if number < 20 {
    print("\(number) less than twenty")             //10 less than twenty
}

//if...else 语句
//一个 if 语句 后可跟一个可选的 else 语句，else 语句在布尔表达式为 false 时执行

if number < 0 {
    print("\(number) 小于0")
} else {
  print("\(number) 大于0")                       //10 大于0
}

//if...else if...else 语句
//if 语句后可以有 0 个或 1 个 else，但是如果 有 else if 语句，else 语句需要在 else if 语句之后。
//if 语句后可以有 0 个或多个 else if 语句，else if 语句必须在 else 语句出现之前。
//一旦 else 语句执行成功，其他的 else if 或 else 语句都不会执行。
if number == 20 {
    /* 如果条件为 true 执行以下语句 */
    print("varA 的值为 20");
} else if number == 50 {
    /* 如果条件为 true 执行以下语句 */
    print("varA 的值为 50");
} else {
    /* 如果以上条件都为 false 执行以下语句 */
    print("没有匹配条件");
}

//逻辑运算符
// &&  逻辑与   两侧都为true  才为true
// ||  逻辑或   两侧有一个为true 则为true
// !   逻辑非   布尔值取反

/****循环****/
//for-in循环
for i in 1...10 {
    print("\(i) × 10 is \(i * 10)")
}
var str = "Taking"
for _ in 1..<5 {
    str += " back"
}
for i in someArray2 {
    print(i)
}
for i in 0..<someArray2.count {
    print(someArray2[i])
}
for (key, value) in someDict1 {
    print("字典 key : \(key) -- 字典(key, value) 对 \(value)")
}
//字典 key : 3 -- 字典(key, value) 对 Three
//字典 key : 2 -- 字典(key, value) 对 New Two
//字典 key : 1 -- 字典(key, value) 对 New One

//嵌套循环

var people = ["players", "haters", "heart-breakers", "fakers"]
var action = ["play", "hate", "break", "fake"]

for i in 0..<people.count {
    var str = "\(people[i]) gonna"
    for _ in 1...5 {
        str += " \(action[i])"
    }
    print(str)
}
//players gonna play play play play play
//haters gonna hate hate hate hate hate
//heart-breakers gonna break break break break break
//fakers gonna fake fake fake fake fake

//while 循环
var counter = 2
while true {
    print("counter is now \(counter)")
    counter += 1
    if counter == 10 {
        break
    }
}
//break 终止循环  continue 跳过当前循环,继续下一个


//repeat...while 循环
//repeat...while 循环不像 for 和 while 循环在循环体开始执行前先判断条件语句，而是在循环执行结束时判断条件是否符合
var index = 15

repeat{
    print( "index 的值为 \(index)")
    index = index + 1
}while index < 20

repeat{
    print("Hello")           //打印一次Hello
}while false


/****swith case 语句****/
//switch 语句允许测试一个变量等于多个值时的情况。 Swift 语言中只要匹配到 case 语句，则整个 switch 语句执行完成。
var index1 = 10

switch index1 {
case 100  :
    print( "index 的值为 100")
case 10,15  :
    print( "index 的值为 10 或 15")
case 5  :
    print( "index 的值为 5")
default :
    print( "默认 case")
}

//一般在 switch 语句中不使用 fallthrough 语句。
//这里我们需要注意 case 语句中如果没有使用 fallthrough 语句，则在执行当前的 case 语句后，switch 会终止，控制流将跳转到 switch 语句后的下一行。
//如果使用了fallthrough 语句，则会继续执行之后的 case 或 default 语句，不论条件是否满足都会执行。
var studioAlbums = 3
switch studioAlbums {
case 0...1:
    print("You're just starting out")
case 2...3:
    print("You're rising star")
    fallthrough
case 4...5:
    print("You're world famous")
default:
    print("Have you done something new? ")
}
//You're rising star
//You're world famous
