# swift3.0-XJDragerDemo
swift3.0完美侧滑

>> github链接:
>> https://github.com/lishengbing/XJQRCodeToolDemo
>> https://github.com/lishengbing/swift3.0-XJDragerDemo


>> my.oschina.com链接：
>> https://my.oschina.net/shengbingli/blog/787809


>>![XJDmain](https://github.com/lishengbing/swift3.0-XJDragerDemo/blob/master/swift3.0-%E4%BE%A7%E6%BB%91%E5%AE%8C%E7%BE%8E/swift3.0-%E4%BE%A7%E6%BB%91%E5%AE%8C%E7%BE%8E/a1.gif)

>>![XJDmain](https://github.com/lishengbing/swift3.0-XJDragerDemo/blob/master/swift3.0-%E4%BE%A7%E6%BB%91%E5%AE%8C%E7%BE%8E/swift3.0-%E4%BE%A7%E6%BB%91%E5%AE%8C%E7%BE%8E/a2.gif)
             


>>核心父类:
>>XJDragerViewController
             
>>使用说明
>>01-创建一个主控制器继承自XJDragerViewController即可

>>注意点:
>>01-以后在主控制器上添加自定义控件的时候，需要添加到mainView上，而不是添加到view上即可
>>如:demo中XJViewController中使用同理

>>02-添加左侧控制器的时候：1-加到leftView上即可 2-需要添加一行代码:
//左边添加需要添加这一句: addChildViewController(leftVc)


 代码演示：

extension XJViewController {
fileprivate func setupUI() {
// 01-注意: 只要继承自我的类:XJDragerViewController,以后所有加在view上的视图控件都统统加到mainView上就可以了
mainView.addSubview(navView)
navView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)
navView.leftBtn.addTarget(self, action: #selector(leftClick(btn:)), for: .touchUpInside)


// 02-增加左边控制器：同理：左边都是统统加在leftView上就可以了
let leftVc = XJLeftViewController(kTargetRight: kTargetRight)
leftView.addSubview(leftVc.view)
leftVc.view.frame = CGRect(x: 0, y: 0, width:  kTargetRight, height: UIScreen.main.bounds.size.height)
// 03-注意:左边添加需要添加这一句
addChildViewController(leftVc)
}

@objc fileprivate func leftClick(btn : UIButton) {
leftPanClick(btn: btn)
}
}


