//
//  XJDragerViewController.swift
//  swift版本侧滑
//
//  Created by 李胜兵 on 16/10/2.
//  Copyright © 2016年 付公司. All rights reserved.
//

import UIKit
private let kMargin : CGFloat = 5
private let kEdgeMargin : CGFloat = 60
private let animDuration : TimeInterval = 0.25

enum XJDragerStyle {
    case defaultStyle
    case left
    case right
    case Same
}

class XJDragerViewController: UIViewController {

    // MARK: - 赋值对象
    lazy var leftView : UIView = UIView()
    lazy var rightView : UIView = UIView()
    lazy var mainView : UIView = UIView()
    
    // 值：正数越大效果越明显，负数越小越明显<左滑至右边值>
    var kTargetRight : CGFloat = UIScreen.main.bounds.width - kEdgeMargin {
        didSet {
            if fabs(kTargetRight) > UIScreen.main.bounds.width {
                kTargetRight = UIScreen.main.bounds.width - kEdgeMargin
            }else {
                kTargetRight = fabs(kTargetRight)
            }
        }
    }
    // 值：正数越大效果越明显，负数越小越明显<右滑至左边值>
    var kTargetLeft : CGFloat = UIScreen.main.bounds.width - kEdgeMargin  {
        didSet {
            if fabs(kTargetLeft) > UIScreen.main.bounds.width {
                kTargetLeft = kEdgeMargin - UIScreen.main.bounds.width
            }else {
                kTargetLeft = -fabs(kTargetLeft)
            }
        }
    }
    
    // 默认是100，正数和负数都可以设置，效果一样
    var kMaxY : CGFloat = 100
    
    // MARK: - 默认是左右滑动高度都变化
    var kDirection : XJDragerStyle = .left

    // 默认是不允许右侧可以滑动:true－－> 允许右侧滑动 false:不允许右侧滑动
    var isPanRightEable : Bool = false
    
    // 默认是从左到右
    static var isDirection : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGes()
    }
}

extension XJDragerViewController {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.lightGray
        leftView.frame = view.bounds
        leftView.backgroundColor = UIColor.white
        view.addSubview(leftView)
        
        rightView.frame = view.bounds
        rightView.backgroundColor = UIColor.white
        view.addSubview(rightView)
        
        mainView.frame = view.bounds
        mainView.backgroundColor = UIColor.white
        view.addSubview(mainView)
        
        mainView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        mainView.layer.shadowOffset = CGSize(width: -2, height: -1)
        mainView.layer.shadowOpacity = 0.7
        mainView.layer.shadowRadius = 2
    }
}

extension XJDragerViewController  {
    fileprivate func setupGes() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(panGes:)))
        mainView.addGestureRecognizer(panGesture)
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tap(tapGes:)))
        mainView.addGestureRecognizer(tapgesture)
    }
}

extension XJDragerViewController {
    
    @objc fileprivate func tap(tapGes: UITapGestureRecognizer) {
        enableSubViews(isEable: false)
        UIView.animate(withDuration: animDuration) {
            self.mainView.frame = self.view.frame;
        }
    }

    @objc fileprivate func pan(panGes : UIPanGestureRecognizer) {
        setupFrameOffset(pagGes: panGes)
    }
    
    fileprivate func setupFrameOffset(pagGes : UIPanGestureRecognizer) {
        let tranP = pagGes.translation(in: mainView)
        let velocity = pagGes.velocity(in: mainView)
        
        if tranP.x > 0 {
            XJDragerViewController.isDirection = false
        }else if (tranP.x < 0) {
            XJDragerViewController.isDirection = true
        }
        
        if !isPanRightEable, tranP.x < 0 {
            if mainView.frame.origin.x == 0 {
               mainView.frame = frameWithOffsetX(offsetX: 0)
            }else {
                mainView.frame.origin.x +=  tranP.x
                if mainView.frame.origin.x <= 0 {
                    mainView.frame.origin.x = 0
                }
                
                let maxOffsetY : CGFloat = changeStyleWithDirection(type: kDirection)
                mainView.frame.origin.y = fabs(mainView.frame.origin.x * maxOffsetY / UIScreen.main.bounds.width)
                mainView.frame.size.height = UIScreen.main.bounds.height - 2 * mainView.frame.origin.y
                
            }
            pagGes.setTranslation(CGPoint.zero, in: mainView)
            return
        }
        
        mainView.frame = frameWithOffsetX(offsetX: tranP.x)
        
        if mainView.frame.origin.x > 0 {
            rightView.isHidden = true
            mainView.layer.shadowOffset = CGSize(width: -3, height: -1)
        }
        
        if mainView.frame.origin.x == 0 {
            enableSubViews(isEable: false)
        }else {
            enableSubViews(isEable: true)
        }
        
        if mainView.frame.origin.x < 0 {
            rightView.isHidden = false
            mainView.layer.shadowOffset = CGSize(width: 3, height: 1)
        }
        
        if pagGes.state == .ended {
            var target : CGFloat = 0
            if mainView.frame.origin.x > 0 {
                if velocity.x >= 0 {
                    if mainView.frame.origin.x > kMargin {
                        target = kTargetRight
                    }
                }else {
                    enableSubViews(isEable: false)
                    if mainView.frame.origin.x < UIScreen.main.bounds.width - kMargin {
                        target = 0
                    }
                }
            }
            
            if mainView.frame.origin.x < 0 {
                if XJDragerViewController.isDirection {
                    if mainView.frame.maxX < UIScreen.main.bounds.width  - kMargin {
                        target = -fabs(kTargetLeft)
                    }
                }
            }
        
            let offset : CGFloat = target - mainView.frame.origin.x
            UIView.animate(withDuration: animDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2, options: [], animations: {
                self.mainView.frame = self.frameWithOffsetX(offsetX: offset)
                }, completion: { (_) in
            })
        }
        if mainView.frame.origin.x > kTargetRight {
            mainView.frame.origin.x = kTargetRight
        }
        pagGes.setTranslation(CGPoint.zero, in: mainView)
    }
    
    fileprivate func frameWithOffsetX(offsetX : CGFloat) -> CGRect {
        mainView.frame.origin.x += offsetX
        
        let maxOffsetY : CGFloat = changeStyleWithDirection(type: kDirection)
        mainView.frame.origin.y = fabs(mainView.frame.origin.x * maxOffsetY / UIScreen.main.bounds.width)
        mainView.frame.size.height = UIScreen.main.bounds.height - 2 * mainView.frame.origin.y
        return mainView.frame
    }
    
    fileprivate func changeStyleWithDirection(type : XJDragerStyle) -> CGFloat {
        var maxOffsetY : CGFloat = kMaxY
        if mainView.frame.origin.x > 0 {
            switch type {
            case .left , .Same:
                maxOffsetY = 0
            default:
                maxOffsetY = kMaxY
            }
        }
        
        if mainView.frame.origin.x < 0 {
            switch type {
            case .right , .Same:
                maxOffsetY = 0
            default:
                maxOffsetY = kMaxY
            }
        }
        return maxOffsetY
    }
}

extension XJDragerViewController {
    // 外面按钮点击事件调用方法即可
   func leftPanClick(btn : UIButton) {
        enableSubViews(isEable: true)
        btn.isSelected = !btn.isSelected
        if mainView.frame.origin.x >= 0 {
            rightView.isHidden = true
            leftView.isHidden = false
            changeStatusWithLeft()
        }
    }
    
   fileprivate  func enableSubViews(isEable : Bool) {
        for subView in mainView.subviews {
            if isEable {
                subView.isUserInteractionEnabled = false
            }else {
                subView.isUserInteractionEnabled = true
            }
        }
    }
    
    fileprivate func changeStatusWithLeft() {
        var offset : CGFloat = 0
        if mainView.frame.origin.x == 0 {
            offset = kTargetRight
        }else {
            offset = -fabs(kTargetLeft)
        }
        UIView.animate(withDuration: animDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: [], animations: {
            self.mainView.frame = self.frameWithOffsetX(offsetX: offset)
            }, completion: { (_) in
        })
    }
}





