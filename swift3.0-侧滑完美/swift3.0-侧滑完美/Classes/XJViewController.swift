//
//  XJViewController.swift
//  swift3.0-侧滑完美
//
//  Created by 李胜兵 on 2016/11/21.
//  Copyright © 2016年 付公司. All rights reserved.
//

import UIKit

class XJViewController: XJDragerViewController {
    
    
    fileprivate lazy var navView : XJNavigationView = XJNavigationView.navView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

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
