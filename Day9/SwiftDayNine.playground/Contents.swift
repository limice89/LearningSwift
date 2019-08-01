import UIKit

/***
 结构体二
 初始化方法:在创建结构体时提供所有属性的值
 ***/

//struct User {
//    var name: String
//}
//
//var user = User(name: "Tom")

//我们可以自己写初始化方法代替默认的

struct User {
    var name: String
    
    init() {
        name = "Grace"
        print("Creating a new user")
    }
}
//**注意:初始化方法前不要写func. 你需要确保所有属性在初始化结束之前都有值
var user = User()
user.name = "Jerry"

/***
 指向当前的实例----self
 self帮助你区分属性和参数
 ***/
struct Person {
    var name: String
    
    init(name: String) {
        print("\(name) is born")
        self.name = name; //self.name指向属性  name指向参数
    }
}

/***
 属性懒加载
 //为了性能优化,Swift允许你当属性使用时再创建
 ***/
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
//我们可以使用FamilyTree 作为一个属性在Persons 结构体内
struct Persons {
    var name: String
    var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
    
}

var ed = Persons(name: "Ed")
//但是,如果我们并不是总t需要特定人的家谱,我们可以使用 lazy 关键字修饰 familyTree属性 ,这样FamilyTree结构体只会在第一次需要时创建
//lazy var familyTree = FamilyTree()
ed.familyTree

/***
 静态属性,方法
 ***/
//我们创建的结构体都有自己的属性和方法, 你也可以共享特定的属性和方法给结构体实例,需要使用static关键字声明
struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1    //因为classSize属于结构体本身而不是结构体实例,所以使用Student.classSize
    }
    
}
let eds = Student(name: "Ed")
let taylor = Student(name: "Taylor")
print(Student.classSize)      //2

/***
 访问控制
 ***/
//open: 公开权限, 最高的权限, 可以被其他模块访问, 继承及复写。
//public: 公有访问权限，类或者类的公有属性或者公有方法可以从文件或者模块的任何地方进行访问。那么什么样才能成为一个模块呢？一个App就是一个模块，一个第三方API, 第三等方框架等都是一个完整的模块，这些模块如果要对外留有访问的属性或者方法，就应该使用public的访问权限。public的权限在Swift 3.0后无法在其他模块被复写方法/属性或被继承。
//fileprivate: 文件私有访问权限，被fileprivate修饰的类或者类的属性或方法可以在同一个物理文件中访问。如果超出该物理文件，那么有着fileprivate访问权限的类, 属性和方法就不能被访问。
//private: 私有访问权限，被private修饰的类或者类的属性或方法可以在同一个物理文件中的同一个类型(包含extension)访问。如果超出该物理文件或不属于同一类型，那么有着private访问权限的属性和方法就不能被访问。
//internal: 顾名思义，internal是内部的意思，即有着internal访问权限的属性和方法说明在模块内部可以访问，超出模块内部就不可被访问了。在Swift中默认就是internal的访问权限。

struct Product {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
}
let card = Product(id: "123") // 结构体外部可以使用id属性

struct Products {
    private var id: String // private修饰只能内部使用,结构体外面不能使用
    
    init(id: String) {
        self.id = id
    }
    func identify() -> String {
        return "My card number id is \(id)"
    }
}

/***
 结构体总结:
 你可以创建有自己属性和方法的结构体
 你可以使用存储属性或者动态计算属性值
 如果想要在方法里改变属性的值,是用mutating 修饰方法
 初始化方法是创建结构体实例,如果使用,需要给结构体所有属性一个值
 方法内使用self指向当前结构体的实例
 lazy关键字创建属性在第一次使用这个属性的时候
 使用static关键字创建静态属性和方法,所有结构体实例中使用
 访问控制限制你在内部还是外部使用属性和方法
 ***/
