# Swift中的捕获列表:强引用,弱引用,无主引用之间的区别

>捕获列表位于代码中的闭包参数列表之前，并将环境中的值捕获为强，弱或无主。我们经常使用它们，主要是为了避免循环引用

首先,看一下这个问题:

```
class Singer {
	func playSong() {
		print("Shake is off!")
	}
}
```
创建一个方法,方法中实例化`Singer`,并使用Singer实例的`playSong()`创建一个闭包,并返回这个闭包以供其他地方使用

```
func sing() -> () -> Void {
	let taylor = Singer()
	
	let singing = {
		taylor.playSong()
		return
	}
	return singing
}
```

最后，我们可以调用`sing()`来获取我们可以在任何想要打印`playSong()`的地方调用的函数

```
let singFunction = sing()
singFunction()      //打印出 Shake is off!
```

## 强引用

>除非你要求特别的东西，否则Swift会使用强大的捕获功能。这意味着闭包将捕获闭包内使用的任何外部值，并确保它们永远不会被破坏
>

```
func sing() -> () -> Void {
	let taylor = Singer()
	
	let singing = {
		taylor.playSong()
		return
	}
	return singing
}
```

那个`taylor`常量是在`sing()`函数内部进行的，所以通常它会在函数结束时被销毁。但是，它会在闭包内部使用，这意味着只要闭包存在某个地方，即使函数返回后，Swift也会自动确保它保持活动状态。

这是一个强大的捕获行动。如果Swift允许`taylor`被摧毁，那么关闭将不再是安全的 - 它的`taylor.playSong()`方法将不再有效

## 弱引用

>Swift让我们指定一个捕获列表来确定如何捕获闭包内使用的值。与强引用常见使用的是弱引用，它改变了两件事：

  1.闭包不能保持弱捕获的值，因此它们可能会被破坏并设置为`nil`。
    
  2.作为1的结果，弱引用值在Swift中始终是可选的。这会阻止你假设它们存在，而实际上它们可能不存在。

```
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor?.playSong()
        return
    }

    return singing
}
```

`[weak taylor]`是我们的捕获列表.它是闭包的一个特定部分，我们就如何捕获值给出具体指示,在这里我们说`taylor`应该被弱引用，这就是为什么我们需要使用`taylor？.playSong()` - 它现在是可选的，因为它可以在任何时候设置为`nil`

方法修改以后,调用`singFunction()`会发现不会打印任何东西,原因是`taylor`只存在于`sing()`中，因为它返回的闭包并没有强持有它。

如果上面代码修改成:

```
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor!.playSong()
        return
    }

    return singing
}
```
会引发崩溃,因为`taylor`是`nil`

## 无主引用

与`weak`对应的是`unowned`,其行为更像是隐式解包可选项。就像弱引用一样，无主引用允许值在未来的任何时候都变为nil。但是，您可以使用它们，就像它们总是在那里一样 --你不需要解包可选项

```
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [unowned taylor] in
        taylor.playSong()
        return
    }

    return singing
}
```

这里会发生崩溃,与我们之前强制解包类似:`unowned taylor` 告诉我们`taylor`会一直存在闭包的生命周期内,但实际上,`taylor`几乎立即被销毁,所以会崩溃

### 常见问题

当使用闭包捕获时，人们常常遇到四个问题:

1. 当闭包接受参数时，他们不确定在何处使用捕获列表。
2. 它们会产生循环引用，导致内存被消耗。
3. 他们无意中使用强引用，特别是在使用多个捕获时。
4. 他们复制闭包,并共享捕获的数据。

让我们通过简单的代码,看看都会发生什么

#### 捕获列表与参数在一起

当你第一次开始使用捕获列表时，这是一个常见的问题，但幸运的是，Swift为我们做了规定。

当一起使用捕获列表和闭包参数时，捕获列表必须始终首先出现，然后单词`in`来标记闭包体的开始 - 尝试将其放在闭包参数之后将阻止代码编译。

```
writeToLog { [weak self] user, message in 
    self?.addToLog("\(user) triggered event: \(message)")
}
```

#### 循环引用

当A持有B,同时B持有A,称之为循环引用

创建一个`House`类,有一个属性(闭包),一个方法,一个销毁器,当销毁时打印一条消息

```
class House {
    var ownerDetails: (() -> Void)?

    func printDetails() {
        print("This is a great house.")
    }

    deinit {
        print("I'm being demolished!")
    }
}
```
这有一个类似的类`Owner`,不同的是属性(闭包)

```
class Owner {
    var houseDetails: (() -> Void)?

    func printDetails() {
        print("I own a house.")
    }

    deinit {
        print("I'm dying!")
    }
}
```

我们在`do`block中创建两个类的示例,我们不需要`catch`,确保在`}`之前会销毁

```
print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
}

print("Done")

//Creating a house and an owner
//I’m dying!
//I'm being demolished!
//Done
```

现在我们创建一个循环引用

```
print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = house.printDetails
}

print("Done")
//Creating a house and an owner
//Done
```

销毁器中的信息不会被打印,这是因为 `house`有一个属性指向`owner`,同时`owner`有一个属性指向`house`,所以他们不能被安全销毁,会导致内存不能释放,称之为内存泄露,会降低系统性能甚至应用终止

为解决这个问题,我们需要创建一个新的闭包,使用弱引用

```
print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = { [weak owner] in owner?.printDetails() }
    owner.houseDetails = { [weak house] in house?.printDetails() }
}

print("Done")
```

没有必要将这两个值都使用弱引用 - 重要的是至少有一个值，因为它允许Swift在必要时销毁它们。

#### 意外强引用

>Swift默认为强引用，这可能会导致无意中的问题

```
func sing() -> () -> Void {
    let taylor = Singer()
    let adele = Singer()

    let singing = { [unowned taylor, adele] in
        taylor.playSong()
        adele.playSong()
        return
    }

    return singing
}
```
现在我们有两个值被闭包捕获,并且两个值在闭包内使用方式相同,但是,只有`taylor`被无主引用,--`adele`被强引用,因为`unowned`关键字被使用必须放在每个捕获值前面

如果要两个值都无主引用

```
[unowned taylor, unowned adele]
```

Swift确实提供了一些防止意外捕获的措施,但是有限的:如果你在一个闭包中使用`self`,Swift会强制你选择使用`self.`或者`self?`让你的意图更清晰

在Swift中使用隐式self会发生很多事,比如,这个初始化程序调用`playSong()`,真正意义是`self.playSong()`---`self`由上下文隐含

```
class Singer {
    init() {
        playSong()
    }

    func playSong() {
        print("Shake it off!")
    }
}
```

swift不会让你在闭包内使用隐含`self`,有助于减少循环引用

#### 闭包复制

闭包会和它的复制闭包共享捕获数据

```
var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()

let logger2 = logger1
logger2()
logger1()
logger2()

//1
//2
//3
//4
```

### 什么时候使用强引用,什么时候使用弱引用,什么时候使用无主引用

1. 如果你确定你的捕获值永远不会消失，而闭包有可能被调用，你可以使用`unowned`无主引用。这实际上只适用于`weak`会导致使用烦恼的少数几次，但可以在闭包内使用`guard let`修饰弱引用变量
2. 如果有循环引用的情况,那么两个中的一个应该使用弱引用,通常是首先被销毁的一个,所以如果视图控制器A呈现视图控制器B，则视图控制器B可能将弱引用持有A。
3. 如果不会发生循环引用,你可以使用强引用,例如执行动画不会在动画闭包内引起循环引用.所以你可以使用强引用


