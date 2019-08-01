import UIKit

/***
 结构体.属性.方法
 Swift中有两种方式定义自己的类型,一种就是结构体,一种是类.
 结构体可以有自己的常量.变量和函数
 ***/
//创建一个有一个name属性的Sport结构体
struct Sport {
    var name: String
}
//创建并使用
var badminton = Sport(name: "badminton")
print(badminton.name)
//应为name属性为变量,所以我们也可以改变它的值
badminton.name = "Lcw badminton"

/***
 计算属性
 通过执行代码获得属性的值
 1）必须用var（2）属性的类型不可以省略 （3）如果要想修改属性的值，必须写setter方法，否则只有一个getter方法
 ***/
struct Sports {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is't an Olympic sport"
        }
    }
}
// olympicStatus 就像一个常规的字符串,只不过根据其他属性的值表现不同的值
let  chessBoxing = Sports(name: "chessBoxing", isOlympicSport: false)

print(chessBoxing.olympicStatus)

/***
 属性观察器
 属性观察器可让我们在使用属性时候，在希望一个属性发生改变时候进行某些操作
 也就是一些小的代码块，可在一个属性值即可发生改变之前 willSet 或者之后 didSet 运行。要创建一个属性观察器，可在属性后面添加大括号（类似对计算属性的做法）
 ***/
/**
struct Progress {
    var task: String
    var amount: Int
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100
 ***/
//如果要在amount属性值发生改变是打印一条消息,我们可以使用didSet属性观察器,它会在amount值发生改变时执行
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100
//也可以是用willSet在属性值改变之前执行,一般使用较少

/***
 方法
 结构体内可以有函数,这些函数可以使用结构体内的属性.这些函数称为方法,它们同样使用func定义
 ***/
struct City {
    var popular: Int
    
    func collectTaxes() -> Int {
        return popular * 1000
    }
}
//collectTaxes方法属于City结构体,说以调用的时候要用结构体City的实例调用
let london = City(popular: 9_000_000)
london.collectTaxes()

/***
 mutating 关键字
 如果结构体内是变量,但是结构体实例是常量,那么结构体内的变量不可被改变
 当你创建结构体时,你不知道创建的结构体作为变量还是常量使用.所以Swift不允许你改变属性的值,除非你有特殊需求
 当你需要在方法里改变一个属性的值, 使用 mutating 关键字
 ***/
struct Person {
    var name: String
    
    mutating func makeAnonymous(){
        name = "Anonymous"
    }
}
//因为要改变属性的值,所以j结构体实例必须是变量
var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name)

/***
 字符串的属性和方法
 ***/
let string = "Do or do not, there is no try."
//可以使用count属性获取字符串的字符总数
print(string.count)  //30
//hasPrefix() 返回Bool,根据指定的开始字符串
print(string.hasPrefix("Od")) //false
//hasPrefix() 返回Bool,根据指定的结束字符串
print(string.hasSuffix("y.")) //true
//hasPrefix() 返回字符串,并且所有字母大写
print(string.uppercased()) //DO OR DO NOT, THERE IS NO TRY.
//lowercased() 返回字符串,并且所有字母小写
print(string.lowercased()) // do or do not, there is no try.
// sorted() 字符串所有字符放到数组并排序,返回这个数组
print(string.sorted()) //[" ", " ", " ", " ", " ", " ", " ", ",", ".", "D", "d", "e", "e", "h", "i", "n", "n", "o", "o", "o", "o", "o", "r", "r", "r", "s", "t", "t", "t", "y"]
//String还有其他属性和方法,可以在Xcode中,Command+鼠标点击String查看其他属性方法

/***
 数组的属性和方法
 ***/
var names = ["Tom", "Grace", "Tony", "Tom"]
//数组中元素个数 使用count属性
print(names.count)
//向数组中添加元素使用append()
names.append("Bulan")
//你可以找到数组中元素第一个位置使用 firstIndex()
names.firstIndex(of: "Tom")
//对数组内元素进行排序
print(names.sorted())
//移除数组内的某个元素
names.remove(at: 1)
//Array还有其他属性和方法,可以在Xcode中,Command+鼠标点击Array查看其他属性方法

