import UIKit

/***
复习第三天
***/

/****属性****/
//属性将值跟特定的类、结构或枚举关联。
//属性可分为存储属性和计算属性
struct Number {
    var digits: Int            //变量存储属性
    let pi = 3.1415            //常量存储属性
    var length = 300.0
    var breadth = 150.0
    //计算属性
    var middle: (Double, Double) {
        get {
            return (length / 2, breadth / 2)
        }
        set(axis) {
            length = axis.0 - (length / 2)
            breadth = axis.1 - (breadth / 2)
        }
    }
    
    
}

var num = Number(digits: 2, length: 30, breadth: 20)
print(num.middle)          //(15.0, 10.0)
num.middle = (40, 60)
print(num.length)             //25.0
print(num.breadth)            //50.0

//属性观察器
//willSet 在新的值被设置之前调用
//didSet 在新的值被设置之后调用
class Samplepgm {
    var counter: Int = 0 {
        willSet(newTotal){
            print("计数器: \(newTotal)")
        }
        didSet{
            if counter > oldValue {
                print("新增数 \(counter - oldValue)")
            }
        }
    }
    
}
let NewCounter = Samplepgm()
NewCounter.counter = 100
NewCounter.counter = 800
//计数器: 100
//新增数 100
//计数器: 800
//新增数 700

/****类型属性和方法****/

struct SomeStructure {
    var name: String = "Struct"
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnum {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 20
    }
    class var overrideableComputedTypeProperty: Int {     //改用关键字 class 来支持子类对父类的实现进行重写
        return 200
    }
}

var sampleStruct1 = SomeStructure()
var sampleStruct2 = SomeStructure()
sampleStruct1.name = "struct1"
sampleStruct2.name = "struct2"
print(SomeStructure.storedTypeProperty)

/****访问控制****/
//访问控制可以限定其它源文件或模块中的代码对你的代码的访问级别,这个特性可以让我们隐藏代码的一些实现细节，并且可以为其他人可以访问和使用的代码提供接口。
//Open 和 Public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 Open 或 Public 级别来指定框架的外部接口。Open 和 Public 的区别在后面会提到。
//Internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
//File-private 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
//Private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。

/***
 Open 只能作用于类和类的成员，它和 Public 的区别如下：
     Public 或者其它更严访问级别的类，只能在其定义的模块内部被继承。
     Public 或者其它更严访问级别的类成员，只能在其定义的模块内部的子类中重写。
     Open 的类，可以在其定义的模块中被继承，也可以在引用它的模块中被继承。
     Open 的类成员，可以在其定义的模块中子类中重写，也可以在引用它的模块中的子类重写。
 */
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

/****多态性和类型转换****/

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
    
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
    
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The castles Studios")
var fearless  = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "Itunes Live", location: "New York")

var allAlbums:[Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}
//The studio album Taylor Swift sold lots
//The studio album Speak Now sold lots
//The live album Itunes Live sold lots

for album in allAlbums {
    print(album.getPerformance())
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}
//The studio album Taylor Swift sold lots
//The castles Studios
//The studio album Speak Now sold lots
//Aimeeland Studio
//The live album Itunes Live sold lots
//New York
//for album in allAlbums {
//    let studioAlbum = album as! StudioAlbum          //报错as! 确定是同一类型
//    print(studioAlbum.studio)
//}
for album in allAlbums as? [StudioAlbum] ?? [StudioAlbum]() {
    print(album.studio)        //什么都没输出
}

let number = 5
let text = String(number)
print(text)

/****闭包****/
/*
{ (parameters) -> return type in
statements
}
 */
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
//单表达式闭包的隐式返回
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
//参数名缩写
reversedNames = names.sorted(by: { $0 > $1 } )

//尾随闭包
//将一个很长的闭包表达式作为最后一个参数传递给函数，将这个闭包替换成为尾随闭包的形式很有用。尾随闭包是一个书写在函数圆括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}
