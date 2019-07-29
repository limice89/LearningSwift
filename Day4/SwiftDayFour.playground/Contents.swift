import UIKit

/***
 for循环
 for-in 循环用于遍历一个集合里面的所有元素，例如由数字表示的区间、数组中的元素、字符串中的字符。
 ***/
for index in 1...5 {
    print("\(index) 乘以 5 为 : \(index * 5)")
}
for _ in 1...5 {
    print("Hello")
}
for album in ["Red", "1990", "Reputation"] {
    print("\(album) is on Apple Music")
}
/***
 while 循环
 while循环从计算单一条件开始。如果条件为true，会重复运行一系列语句，直到条件变为false。
 ***/
var index = 10
while index<=20 {
    print("index 的值为\(index)")
    index += 2
}
//无限循环
//判断条件为true, 会一直循环下去,所以需要增加一个判断条件跳出循环
var counter = 0
while true {
    print(" ")
    counter += 1
    if counter == 273 {
        break
    }
}

/***
 repeat...while 循环
 repeat...while 循环不像 for 和 while 循环在循环体开始执行前先判断条件语句，而是在循环执行结束时判断条件是否符合。
 ***/

var number = 1
repeat{
    print(number)
    number += 3
}while number <= 20

repeat{
    print("This is false")       //会执行一次
}while false

/***
跳出循环
break语句会立刻结束整个控制流的执行。
 ***/
var countDown = 10
while countDown >= 0 {
    print(countDown)
    if countDown == 4 {
        print("I'm bored, let's go now!")
        break
    }
    countDown -= 1
}
var countDown1 = 10

repeat{
    print(countDown1)
    if countDown1 == 4 {
        print("I'm bored, let's go now!")
        break
    }
    countDown1 -= 1
}while countDown1 > 0

/***
 跳出多重循环
 1.在最外层循环定义一个标签
 2.在最里层循环增加判断条件,使用break+标签 退出整个循环
 ***/
for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
    }
}
//首先定义标签:
outerLoop: for i in 1...10{
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
    }
}
//内层循环增加条件退出整个循环

outerLoop: for i in 1...10{
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

/***
 跳出当前循环,继续下面的循环
 continue语句告诉一个循环体立刻停止本次循环迭代，重新开始下次循环迭代。
 ***/
var num = 10
repeat{
    num += 2
    if num == 16 {
        //num为16 跳过
        continue
    }
    print("index is \(num)")
}while num<20

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

/***
 总结:
 1.循环重复执行代码,直到条件为假
 2.最常见的循环是for循环,循环内的每一项f分配给临时常量,如果不需要临时常量,使用下划线代替
 3.while 循环需要提供一个明确的条件执行循环,无限循环会一直执行,确保有判断条件终止无限循环
 4.break 退出单个循环, 如果需要退出嵌套循环, 需要在最外部循环设置标签, 在判断条件退出循环增加break+标签
 5.continue跳过本次循环,继续执行下面的循环
 ***/
