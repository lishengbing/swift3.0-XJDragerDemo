//
//  XJLeftViewController.swift
//  swift3.0-侧滑完美
//
//  Created by 李胜兵 on 2016/11/21.
//  Copyright © 2016年 付公司. All rights reserved.
//

import UIKit
private let kCollectionViewCellID = "kCollectionViewCellID"
private let kEdgeMargin : CGFloat = 26
private let kMiddleMargin : CGFloat = 22
private let kTopMargin : CGFloat = 33.5

class XJLeftViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var targetRight : CGFloat = 0
    
    init(kTargetRight : CGFloat) {
        super.init(nibName: nil, bundle: nil)
        self.targetRight = kTargetRight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - 设置 UI
extension XJLeftViewController  {
    fileprivate func setupUI() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellID)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        let itemW : CGFloat = (targetRight - kEdgeMargin * 2 - kMiddleMargin) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemW, height: itemW)
        layout.minimumLineSpacing = kTopMargin
        layout.minimumInteritemSpacing = kMiddleMargin
        layout.sectionInset = UIEdgeInsetsMake(kTopMargin, kEdgeMargin, kMiddleMargin, kEdgeMargin)
    }
    
}

extension XJLeftViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
        
    }
}

