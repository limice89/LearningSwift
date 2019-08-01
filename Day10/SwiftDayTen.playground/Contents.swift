import UIKit

/***
 类
 类和结构体对比
 
 Swift 中类和结构体有很多共同点。共同处在于：
 
 定义属性用于存储值
 定义方法用于提供功能
 定义附属脚本用于访问值
 定义构造器用于生成初始化值
 通过扩展以增加默认实现的功能
 符合协议以对某类提供标准功能
 
 与结构体相比，类还有如下的附加功能：
 
 继承允许一个类继承另一个类的特征
 类型转换允许在运行时检查和解释一个类实例的类型
 析构器允许一个类实例释放任何其所被分配的资源
 引用计数允许对一个类的多次引用

 ***创建类***
 //如果类中有属性,你必须创建自己的构造器
 ***/

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

/***
 类继承 (子类)
 类可以从原始类继承属性的方法
 子类可以有自己的构造器
 ***/

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

/***
 方法重写(覆盖)
 重写是子类的方法覆盖父类的方法，要求方法名和参数都相同
 因为子类会继承父类的方法，而重写就是将从父类继承过来的方法重新定义一次，重新填写方法中的代码
 ***/

class Person: NSObject {
    var name: String
    var age: Int
    
    //构造函数
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        //必须在 super.init()之前 初始化对象
        super.init()
    }
}
//通过重写方法为其添加"lesson"属性

class Student: Person {
    var lesson: String
    //重写
    
    //-parameters:
    // -name: 姓名
    // -age: 年龄
    override init(name: String, age: Int) {
        lesson = "Python" //必须放在super.init()之前
        super.init(name: name, age: age)
    }
}
let s = Student(name: "Jerry", age: 18)
print(s.lesson)

//通过重载方法为w其添加 'lesson' 属性

class Students: Person {
    var lesson: String
    
    //重载
    
    //-parameters
    // -name: 姓名
    // -age: 年龄
    // -lesson: 课程
    init(name: String, age: Int, lesson: String) {
        self.lesson = lesson
        super.init(name: name, age: age)
    }
}

let s1 = Students(name: "Tom", age: 16, lesson: "Math")
print(s1.lesson)

//通过重载,可以快速为方法添加新的属性,属性可以通过外部传入
//重写,只能在方法内部设置属性,外部无法直观看到类的参数列表

/***
 final关键字
 final关键字在大多数的编程语言中都存在，表示不允许对其修饰的内容进行继承或者重新操作。Swift中，final关键字可以在class、func和var前修饰。
 ***/

final class Cat {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
}

/***
 拷贝
 当你拷贝一个结构体时,初始的和拷贝后的是不同的,改变一个不会引起另一个的变化
 当你拷贝一个类是,初始的和拷贝后的是同一个,改变一个另一个也发生改变
 ***/

struct Singer {
    var name = "Johon"
}
var singer = Singer()
print(singer.name)        //Johon
var singerCopy = singer
singerCopy.name = "Mock"
print(singer.name)       //Johon

class Entertainer {
    var name = "Johon"
    
}
var entertainer = Entertainer()
print(entertainer.name)   //Johon
var entertainerCopy = entertainer
entertainerCopy.name = "Mock"
print(entertainer.name)    //Mock

/***
 析构器 deinit
 析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字deinit来标识，类似于构造器用init来标识。
 析构器在实例释放之前被自动调用，析构器是不允许被主动调用的。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用
 ***/

class Alien {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    func printGreeting() -> Void {
        print("Hello, I'm \(name)")
    }
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Alien()
    person.printGreeting()
}
//John Doe is alive!
//Hello, I'm John Doe
//John Doe is no more!
//John Doe is alive!
//Hello, I'm John Doe
//John Doe is no more!
//John Doe is alive!
//Hello, I'm John Doe
//John Doe is no more!

/***
 Mutability 可变性
 如果有一个静态结构体内有一个变量,变量的值不可改变
 如果一个静态类有一个属性变量,变量的值可以改变
 ***/

class Dancer {
    var name = "Lily"
    
}
let lily = Dancer()
lily.name = "Lucy"
print(lily.name)
//如果不想改变属性的值,类中属性使用常量
//class Dancer {
//    let name = "Lily"
//
//}

/***
 类总结:
 1.类和结构i体类似，因为它们都可以让您使用属性和方法创建自己的类型。
 2.一个类可以从另一个类继承，它获得父类的所有属性和方法。类层次结构是很常见的 - 一个基于另一个的类，它本身基于另一个。
 3. 您可以使用final关键字标记一个类，这会阻止其他类继承它。
 4.方法重写允许子类使用新实现方法替换其父类中的方法。
 5.当两个变量指向同一个类实例时，它们都指向同一块内存 - 更改一个,另一个也会改变
 6.类可以有一个deinitializer，它是在类的一个实例被销毁时运行的代码
 7.类不像结构体那样强制执行常量 - 如果将属性声明为变量，则无论如何创建类实例，都可以更改它。
 ***/

