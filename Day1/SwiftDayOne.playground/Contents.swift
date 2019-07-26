import UIKit
/*
 简单类型
 */
//变量
var str = "Hello, playground"
str = "swift"

var age = 18
var population = 9_000_000

var str1 = """
This goes
over multiple
lines
"""

var str2 = """
This goes \
over mutiple \
lines
"""
var pi = 3.141

var awesome = true


var score = 85
var str3 = "Your score was \(score)"

var results = "The test result are here: \(str3)"

//常量
let taylor = "swift"

let str4 = "Hello playground"

let album: String = "Reputation"
let year: Int = 2000
let height: Double = 1.78
let taylorRocks: Bool = true

//第一天的总结:
//1.变量使用var定义,常量使用let定义,最好尽可能使用常量
//2.String类型开始和结束用",如果要多行显示 使用"""..."""
//3.Integers包含所有数字,doubles包含小数,booleans 包含true和false
//4.插入字符串\() 可以让你创建字符串并把其他常量或变量的值插入到字符串中
//5.Swift可以通过类型推断来分配每个变量或常量的类型,但是如果需要,可以提供显示类型



