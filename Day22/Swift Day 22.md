# Swift Day 22
>今天又三个主题,会用到`UIBarButtonItem`,`UIActivityViewController`,完成本内容并完成三个挑战

## About technique projects
我们知道,app的种类有很多种.有商城,有游戏,有技术类,项目1是让用户在手机上浏览图像,项目2 是用户猜测国家旗帜的游戏

技术项目的目的是选择一个iOS技术并深入了解它,有的可能简单,有的可能比较复杂,所以我会尽可能缩短时间,让你更专注于做实际的东西

第一个技术项目很简单:就是修改项目1,允许用户与朋友分享图像

## UIActivityViewController explained
分享内容使用iOS提供的允许其他apps接收的强大标准组件,这个组件称为`UIActivityViewController`,你告诉它要分享的数据类型,它选择出最好的方式去分享

当我们处理图像的时候,`UIActivityViewController`可以自动的给我们提供功能选择,通过`iMessage`,`email`,`Twitter`和`Facebook`分享,同时,我们可以保存图片到相册,指定给联系人,打印,拷贝等等,

在我们接触`UIActivityViewController`之前,我们需要给处于一个触发分享的方法,我们可以在导航栏上增加一个 barButtonItem

我们拷贝项目1的所有文件,并更改为项目3,用Xcode启动,并打开DetailViewController.swift文件,在`viewDidLoad()`方法里加入

```

```
## Wrap up