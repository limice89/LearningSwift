import UIKit

/***
 复习第二天
 ***/

/****函数****/
//函数用来完成特定任务的独立的代码块。
//Swift 定义函数使用关键字 func。
//定义函数的时候，可以指定一个或多个输入参数和一个返回值类型。
func favoriteAlbum(){
    print("My favorite is football")
}
//函数调用
favoriteAlbum()

//函数带参数
func favoriteAlbum1(name: String) {
    print("My favorite is \(name)")
}
favoriteAlbum1(name: "badminton")
//函数带多个参数
func favorite2(name: String, year: Int) {
    print("\(name) was released in \(year)")
}
favorite2(name: "tennis", year: 2000)
//外部参数名和内部参数名

func countLettersInString(myString str: String) {
    //myString调用的时候使用,str在函数实现内使用
    print("The string \(str) has \(str.count) letters")
}
countLettersInString(myString: "hello")
//不使用外部参数名
func countLettersInString1(_ str: String) {
    print("The string \(str) has \(str.count) letters")
}
countLettersInString1("Hello")

//函数返回值 使用-> 后面跟函数返回值类型
func albumIsTaylor(name: String) -> Bool {
    switch name {
    case "Taylor", "Red", "1999":
        return true
    default:
        return false
    }
}

if albumIsTaylor(name: "1989") {
    print("That's true")
}else {
    print("failure")
}

/****可选类型****/
//可选（Optional）类型，用于处理值缺失的情况
var myString: String? = nil
if myString != nil {
    print(myString!)
} else {
    print("字符串为nil")
}
//强制解析
//当你确定可选类型确实包含值之后，你可以在可选的名字后面加一个感叹号（!）来获取值
//注意：
//使用!来获取一个不存在的可选值会导致运行时错误。使用!来强制解析值之前，一定要确定可选包含一个非nil的值

var myString1: String? = "Hello"
print("强制解析\(myString1!)")
//自动解析
//你可以在声明可选变量时使用感叹号（!）替换问号（?）。这样可选变量在使用时就不需要再加一个感叹号（!）来获取值，它会自动解析
var myString2:String!

myString2 = "Hello, Swift!"

if myString2 != nil {
    print(myString2)
}else{
    print("myString2 值为 nil")
}

//可选绑定
//使用可选绑定（optional binding）来判断可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量。可选绑定可以用在if和while语句中来对可选类型的值进行判断并把值赋给一个常量或者变量。
var myString3: String?
myString3 = "Hello"
if let stirng3 = myString3 {
    print("string3 is \(stirng3)")
}else{
    print("string3 is nil")
}

/****可选链****/
//可选链返回两个值：如果目标有值，调用就会成功，返回该值 如果目标为nil，调用将返回nil

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006:
        return "Tom"
    case 2007:
        return "Helen"
    case 2010:
        return "Bob"
    case 2015:
        return "David"
    default:
        return nil
    }
}
let album = albumReleased(year: 2006)
//print("The album is \(album)")  //会有⚠️

let album1 = albumReleased(year: 2008)?.uppercased()
//print(album1)    //会有⚠️

//合并空值运算符
//合并空值运算符 （a ?? b ）如果可选项 a 有值则展开，如果没有值，是 nil ，则返回默认值 b 。表达式 a 必须是一个可选类型。表达式 b 必须与 a 的储存类型相同

let album2 = albumReleased(year: 2010) ?? "unknown"
print(album2)           //Bob

/****枚举****/
//自定义的特定数据类型
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
      return "Hate"
    }
}
//这个函数接受string定义当前天气,问题是天气的种类有很多,可以定义一个枚举,列举天气的种类在函数中使用
enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus1(weather: WeatherType) -> String? {
    if weather == WeatherType.sun {
        return nil
    } else {
        return "Hate"
    }
}
getHaterStatus1(weather: WeatherType.cloud)

enum WeatherType1 {
    case sun
    case cloud
    case rain
    case wind
    case snow
}
func getHaterStatus2(weather: WeatherType1) -> String? {
    if weather == .sun {     //swift自动判断枚举类型 使用.sun 代替 WeatherType1.sun
        return nil
    } else {
      return "Hate"
    }
}
getHaterStatus2(weather: .snow)

//枚举增加相关值
enum Student{
    case Name(String)
    case Mark(Int,Int,Int)
    case Age(detial: Int)
}
var studDetails = Student.Name("Runoob")
var studMarks = Student.Mark(98,97,95)

switch studMarks {
case .Name(let stuName):
    print("名字: \(stuName)")
case .Mark(let Mark1, let Mark2, let Mark3):
    print("成绩是: \(Mark1),\(Mark2),\(Mark3)")
default:
    print("nil")
}

/****结构体****/
//结构体是构建代码所用的一种通用且灵活的构造体。
//可以为结构体定义属性（常量、变量）和添加方法，从而扩展结构体的功能。
struct Person {
    var clothes: String
    var shoes: String
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}
let tom = Person(clothes: "T-shirts", shoes: "sneakers")
let david = Person(clothes: "short shirts", shoes: "high hells")
print(tom.shoes)
print(david.clothes)
tom.describe()


/****类****/
//类与结构体有很多相似的地方 可以为类定义属性（常量、变量）和方法。
//不同的f地方
//*类需要对属性成员写自己的初始化
//*一个类可以继承另一个类,增加新的属性方法等
//*创建的类成为对象,如果复制一个对象,改变一个对象的值,另一个也跟着改变
class Persons {
    var clothes: String
    var shoes: String
    
    init(clothes: String, shoes: String) { //构造函数前没有func
        self.clothes = clothes
        self.shoes = shoes
    }
}
//类继承
class Singer {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sing() {
        print("La la la la")
    }
}

var taylor = Singer(name: "Taylor", age: 18)
taylor.name
taylor.age
taylor.sing()
//创建一个子类
class CountrySinger: Singer {
    var noiseLevel: Int     //子类新增加属性
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }
    override func sing() {     //重写父类方法
        print("Ha ha ha ha")
    }
    
}
var tim = CountrySinger(name: "Tim", age: 29, noiseLevel: 22)
tim.sing()

//swift和OC代码使用
//如果让xapple系统其它地方使用你swift类中的方法,使用@objc标记
//也可以在类之前写 @objcMembers 表示所有方法都可被OC使用


