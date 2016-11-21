//
//  XJNavigationView.swift
//  swift3.0-侧滑完美
//
//  Created by 李胜兵 on 2016/11/21.
//  Copyright © 2016年 付公司. All rights reserved.
//

import UIKit

class XJNavigationView: UIView {
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!

}

extension XJNavigationView {
    class func navView() -> XJNavigationView{
        return Bundle.main.loadNibNamed("XJNavigationView", owner: self, options: nil)?.first as! XJNavigationView
    }

}
