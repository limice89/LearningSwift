import UIKit

/***
 可选类型，解包和类型转换
 可选类型,可为nil
 如果一个常量或变量，它的值可能存在，也可能不存在，那么可以定义这个值为可选类型值。
 可选类型的数据类型是确定的，值不确定。
 可以定义一个Int类型值为5,但是如果定义一个年龄属性,年龄值不知道的情况下就需要使用可选,数值可能有值可能没值nil
 ***/
var age: Int? = nil //没有持有数值 ,
//我们知道年龄后使用
age = 18

var canBeNil : Int? = 4
canBeNil = nil
//下面这样是不可以的
var cantBeNil : Int = 4
//cantBeNil = nil // can't do this

/***
 解包
 Swift中有可选型这一类型，但不能确定变量是否为空时就使用的话，编译器会直接报错,这时候需要用解包处理
 ***/
var errorCode: String? = "404"
//下面使用报错Value of optional type 'String?' must be unwrapped to a value of type
//"The errorCode is " + errorCode

//这时候就要解包。在变量后面加上一个！，意思是说对编译器说这个变量不为nil
"The errorCode is " + errorCode!  //确定不为空时使用!

var errorCode1: String? = nil
//下面报错:error: error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
//"The errorCode is " + errorCode1!     //为空时使用!报错

//进行判断
if errorCode1 != nil {
    "The errorCode is " + errorCode1!
}

//也可以对errorCode1 进行解包
if let unwrappedErrorCode1 = errorCode1 {
    "The errorCode is " + unwrappedErrorCode1
}
if let unwrappedErrorCode = errorCode {
    "The errorCode is " + unwrappedErrorCode
}

//同时对两个变量进行解包

if let errorCode = errorCode, let errorCode1 = errorCode1 {
    "The errorCode is " + errorCode + "," + "The errorCode1 is " + errorCode1
}

/***
 guard 解包
 if let... 和 guard let...else的区别：
 
 从字面意思上就可以理解，使用if let...的时候你下面所需要执行的代码是需要写在 if 的条件语句块里，而guard let...else是下面所需要执行的代码应该写在guard let...else后面: 在guard代码之后可使用解包可选类型
 ***/

func greet (_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name !")
        return
    }
    print("Hello, \(unwrapped)! ")
}


/***
 强制解包
 如果明确知道可选类型是有值的,可以使用强制解包 将一个可选类型转变成非可选类型
 ***/
let str = "5"
let num = Int(str)
//创建一个num为一个Int可选类型,因为str 可能为"Cat" 而不是数字
//尽管Swift不确定这个转换是否会成功执行,但你可以看到这个代码是安全的,所以可以使用强制解包,在Int(str)后加!

let num1 = Int(str)!
//如果str 不是数字,则会引起crash

/***
 隐式解包的可选类型
 你可以把 隐式解包可选类型 当成对每次使用的时候自动解包的可选类型。即不是每次使用的时候 在变量/常量后面加！，而是直接在定义的时候加！
 隐式解包不意味着 “这个变量不会是 nil，你可以放心使用” 这种暗示，只能说 Swift 通过这个特性给了我们一种简便但是危险的使用方式
 ***/

let score: Int! = nil


/***
 空合运算符: ??
 一个可变类型的值,如果有值,就把本身赋值给一个常量或者变量,如果为 nil,就把 ?? 右边的值赋值过去
 ***/


//loginName 表示为可选性，如果loginName 为空，则使用默认名称 Guest
var loginName: String? = nil
let userName = loginName ?? "Guest"

func username(for id: Int) ->String? {
    if id == 1 {
        return "God"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Hobby"

/***
 可选链
 可选的nil上查询，调用属性，下标和方法的过程叫作可选链。可选链接返回两个值 -
 
 如果可选项包含值，则调用相关属性，方法和下标返回值。如果可选项包含nil值，则所有相关属性，方法和下标返回nil
 a.b?.c
 ***/

class Person {
    var residence:Residence?
}
class Residence {
    var numberOfRooms = 1
    
}
let john = Person()
let roomcount = john.residence?.numberOfRooms //nil

let names = ["John", "Paul", "Ringo"]
let beatle = names.first?.uppercased()    //JOHN


/***
 异常处理中的try? try!
 * throws抛出异常, 那么就必须通过try来处理
 * try  : 标准的处理方式, 该方式必须结合do catch来处理
 * try? :告诉系统可能有错, 也可能没错, 如果发生错误, 那么返回nil, 如果没有发生错误, 会见数据包装成一个可选类型的值返回给我们这种使用方式, 相当于忽略错误
 * try! : 告诉系统一定没错, 如果发生错误, 程序会崩溃. 不推荐使用
 
 ***/

enum PassowrdError: Error {
    case obvious
}

func checkPassword(_ password: String) throws ->Bool {
    if password == "password" {
        throw PassowrdError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That password is good")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("admin")
}
try! checkPassword("123456")
print("ok")

/***
 可失败构造器
 当使用构造器创建对象时，可以向构造器传递的形参无效或在构造器中使用函数外部的资源缺失，就会造成创建对象失败，如果创建对象失败，调用任何实例方法都会崩溃，为了解决崩溃问题，使用可失败构造器，将崩溃的结构变为nil
 
 (1)init? 创建的对象可能存在nil值 所以当对象创建成功, 需要强制解析
 
 (2)init! 创建的对象相当于使用了隐式解析 ,使用隐式解析或者强制解析的前提条件 确保对象真实存在
 ***/

struct People {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

/***
 类型转换
 类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
 ***/

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
    
}
//第一个子类 Movie 封装了与电影相关的额外信息，在父类（或者说基类）的基础上增加了一个 director（导演）属性，和相应的初始化器。第二个子类 Song，在父类的基础上增加了一个 artist（艺术家）属性，和相应的初始化器：
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
    
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
    
}
//创建一个数组常量:
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//用类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    }else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")
// Media library contains 2 movies and 3 songs

//***向下转型***
/*
向下转型，用类型转换操作符(as? 或 as!)

当你不确定向下转型可以成功时，用类型转换的条件形式(as?)。条件形式的类型转换总是返回一个可选值（optional value），并且若下转是不可能的，可选值将是 nil。

只有你可以确定向下转型一定会成功时，才使用强制形式(as!)。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
*/

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', director: \(movie.director)")
    }else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}

//Any 和 AnyObject 的类型转换
/*
Swift 为不确定类型提供了两种特殊的类型别名：

Any 可以表示任何类型，包括函数类型。
AnyObject 可以表示任何类类型的实例。
*/
//Any 类型的数组 things：
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called 'Ghostbusters', dir. Ivan Reitman
// Hello, Michael

//注意
//Any类型可以表示所有类型的值，包括可选类型。Swift 会在你用Any类型来表示一个可选值的时候，给你一个警告。如果你确实想使用Any类型来承载可选值，你可以使用as操作符显式转换为Any，如下所示：
let optionalNumber: Int? = 3
things.append(optionalNumber)        // 警告
things.append(optionalNumber as Any) // 没有警告


/***
 总结:
 1.可选项让我们以清晰明确的方式表示缺少值
 2.Swift不允许没解包的情况下使用可选值, 解包使用 if let  或者 guard let
 3.你可以使用!强制解包,但如果强制解包的值是nil会发生crash
 4.隐式解包可选类型 没有对可选项进行安全检查
 5.空合运算符??如果有值,就把本身赋值给一个常量或者变量,如果为 nil,就把 ?? 右边的值赋值过去
 6.可选链接允许我们编写代码来操作可选项，但如果可选的结果为空，则忽略代码
 7.你可以使用try？将throwing函数转换为可选的返回值，或者try！如果抛出错误就崩溃
 8. 当使用构造器创建对象时，可以向构造器传递的形参无效或在构造器中使用函数外部的资源缺失，就会造成创建对象失败，使用init（）创建一个可失败构造器
 9.可以使用类型转换将一种类型的对象转换为另一种类型
 ***/
