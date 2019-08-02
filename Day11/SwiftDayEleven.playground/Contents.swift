import UIKit

/***
 协议,扩展
 协议是定义一些规范(属性、功能方法)，然后由类、结构体或者枚举遵循并实现这些规范，这一过程被称为遵循了协议
 属性要求：
 1.协议可以定义实例属性和类型属性(使用static);
 2.协议不指定属性是存储属性还是计算型属性，只指定属性名称和类型以及读写性;
 3.协议指定属性的读取类型，使用的get和set，中间不能使用逗号；
 4.协议总是使用var关键字来声明变量属性;
 5.不能给协议属性设置默认值，因为默认值被看做是一种实现;
 方法要求：
 1.协议可以定义实例方法和类方法(使用static);
 2.协议定义函数时不能添加函数的实现，同时，传入的参数也不能使用默认参数；
 3.如果协议定义的实例方法会改变实例本身，需要在定义的方法名前使用mutating；这使得结构体和枚举能够遵循此协议并满足此方法要求
 ***/
protocol Identifiable {
    var id: String { get set }
    
}
//创建一个结构体遵循这个协议
struct User: Identifiable {
    var id: String
    
}

func displayID(thing: Identifiable){
    print("My ID is \(thing.id)")
}

/***
 协议继承
 一个协议可以继承自另一个继承,一个继承可以同时继承多个协议
 ***/

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
//创建一个Employee协议继承 Payable NeedsTraining HasVacation 协议
protocol Employee: Payable, NeedsTraining, HasVacation {}

/***
 扩展
 扩展就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情况下扩展类型的能力(即逆向建模)
 扩展可以向类型添加新功能，但不能覆盖现有功能。
 
 扩展功能：
 1、添加计算型实例属性和计算型类型属性。
 2、定义实例方法和类型方法
 3、提供新便利构造器和便利析构器
 4、定义下标
 5、定义和使用新的嵌套类型
 6、使一个已有类型符合某个协议
 ***/

//给Int类型添加一个扩展方法 squared() 返回当前数的平方
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

//扩展不允许增加存储属性,所以你必须使用计算型属性 添加一个isEven计算属性,返回Bool,判断数字是否是偶数
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
}

/***
 协议扩展
 协议允许您描述应该具有哪些方法，但不提供内部代码。扩展允许您在方法中提供代码，但只影响一种数据类型 - 您无法同时将方法添加到许多数据类型中
 协议扩展解决了这两个问题：它们就像常规扩展一样，除了扩展特定类型，如Int，你扩展整个协议，以便所有符合类型的类型得到你的更改。
 ***/
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

//数组和集合都遵循一个Collection协议 所以可以对这个协议扩展增加一个 summarize() 打印集合

extension Collection {
    func summarize() {
        print("There are \(count) of us :")
        
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

/////
protocol Entity {
    var name: String {get set}
    static func uid() -> String
}

extension Entity {
    static func uid() -> String {
        return UUID().uuidString
    }
}

struct Order: Entity {
    var name: String
    let uid: String = Order.uid()
}
let order = Order(name: "My Order")
print(order.uid)
/***
 面向协议编程
 POP就是通过协议扩展，协议继承和协议组合的方式来设计需要编写的代码
 ***/

protocol Identifiables {
    var id: String { set get }
    
    func identify()
}

extension Identifiables {
    func identify() {
        print("My ID is \(id) ")
    }
}
//现在创建一个类型遵循 Identifiables .它会自动获得identify()方法

class Users: NSObject, Identifiables {
    var id: String
    init(id:String) {
        self.id = id
        super.init()
    }
}
let user = Users(id: "890")
user.identify()

/***
 协议和扩展总结:
 1.协议描述了符合类型必须具有的方法和属性，但不提供这些方法的实现
 2.协议可以继承自其它类,类似类
 3.扩展允许你向特定的类型中添加方法和计算属性
 4.协议扩展允许你向协议中添加方法的计算属性
 5. 面向协议的编程是将应用程序体系结构设计为一系列协议，然后使用协议扩展来提供默认方法实现的实践
 ***/

