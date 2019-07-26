import UIKit

/***
 数组-Arrays
 数组包含同一类型的多个值
***/
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
/**使用索引获取数组元素 beatles[2], 如果数组越界会发生crash 例如: beatles[10]**/
//创建特定类型的数组
var intArray = [Int]()
var results = Array<Int>()
print("intArray is of type [Int] with \(intArray.count) items")

/***
 集合- Sets
 集合类似数组包含同一类型的多个值 但是有两点区别:
 1.集合内的元素是没有顺序的
 2.集合内没有重复的元素
 ***/

var fruits = Set<String>()  //空集合
let colors = Set(["red","blue","white"])

let array = ["apple", "apple", "banana"]
let set = Set(array)
print(set)   //["apple", "banana"]


/***
 元组- Tuples
 元组包含了若干个相关联变量的对象 与数组主要有三点区别:
 1.元组内的元素不能添加或删除
 2.你不能改变元组中元素的类型,它们与创建时类型相同
 3.你可以通过数字索引或命名来获取元素,但不能读取不存在的位置索引或名称
 ***/

let firstHighScore = ("Mary",9001)
print(firstHighScore.0)   //Mary

let secondHighScore = (name:"James",score:7899)
print(secondHighScore.name)  //James

var someScore = ("John", 55)

var anotherScore = someScore
anotherScore.0 = "Robert"


print(anotherScore.0)  //Outputs:  "Robert"
print(someScore.0)     //Outputs:  "John"

/***
//Arrays vs Sets vs Tuples
1.如果你需要特定的相关值集合,其中每个元素都有精确的位置或名称,使用Tuple
 let address = (house:666,street:"Wangjing",city:"Beijing")
2.如果需要一个集合内的值是唯一的,或者需要很快确定元素是否在集合内 使用Set
 let set = Set(["red","blue","black"])
3.如果需要集合内的元素可以重复,或者需要元素是有序的,使用 Array
 let scores = [68,89,90,39,100,99]
***/

/***
 字典- Dictionaries
 字典也是用来存放相同数据类型的元素的数据结构。不过字典是通过键（Key）来查找特定的值（Value），字典中存放的每一个数据项（item）都是这样的一个键值对。
 1.元组内的元素不能添加或删除
 2.你不能改变元组中元素的类型,它们与创建时类型相同
 3.你可以通过数字索引或命名来获取元素,但不能读取不存在的位置索引或名称
 ***/
var teams = [String:String]()
var teams1 = Dictionary<String,Int>()

var dict1:Dictionary<String,Int> = ["key":1]
var dict2:[String:Int] = ["key2":2,"key3":3]
let favorite = [
    "Paul":"eat",
    "Tom":"drink"
]

var dictCount = dict2.count
dict1["key4"] = 4
var value3 = dict2["key3"]
dict1.updateValue(5, forKey: "key5")
dict2["key3"] = nil

print("dictionary1 = \(dict1)")
print("dictionary2 = \(dict2)")

/***
 枚举
 枚举简单的说也是一种数据类型，只不过是这种数据类型只包含自定义的特定数据，它是一组有共同特性的数据的集合。
 ***/
enum DaysofaWeek {
    case Sunday
    case Monday
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case Saturday
}
let day = DaysofaWeek.Sunday
//相关值
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")
//原始值
//默认第一项为0
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
enum Planets: Int {
    case mercurys = 1
    case venuss
    case earths
    case marss
}






