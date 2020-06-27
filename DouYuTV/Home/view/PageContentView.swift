//
//  PageContentView.swift
//  DouYuTV
//
//  Created by 黄武 on 2020/6/27.
//  Copyright © 2020 黄武. All rights reserved.
//

import UIKit

 private let kCellID = "cellID"

protocol PageContentViewDelegate : class {
    
    func PageContentViewDidScrollToIndex(currentIndex index : Int)
    
}

class PageContentView: UIView {

    private var controllers:[UIViewController]
    private  var pController:UIViewController
    weak var delegaye:PageTitleViewDelegate?
    
    private lazy var mainCollectionV:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 0.1
        layout.minimumLineSpacing = 0.1
        layout.scrollDirection = .horizontal
        layout.itemSize = self?.bounds.size as! CGSize
        let collectionV = UICollectionView.init(frame: self?.bounds as! CGRect, collectionViewLayout: layout)
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false;
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.bounces = false
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellID)
        
        return collectionV
        
    }()
    
    
    init(frame:CGRect,controllers:[UIViewController],parentViewController:UIViewController) {
        self.controllers = controllers
        self.pController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainCollectionV.frame = self.bounds
    }
}

extension PageContentView{
    
    func setupUI() {
        addSubview(mainCollectionV)
        mainCollectionV.frame = self.bounds
        mainCollectionV.backgroundColor = .purple
    }
}

extension PageContentView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath);
        
        for  view in cell.contentView.subviews {
            view.removeFromSuperview()
            
        }
        
        let con:UIViewController = controllers[indexPath.item]
        
        con.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(con.view)
        
        return cell
    }
    
    
}

//extension PageContentView :UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.bounds.size.width, height: self.bounds.size.height)
//    }
//}
extension PageContentView :UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index:CGFloat = floor(scrollView.contentOffset.x/scrollView.bounds.width);
        print("\(index)")

    }
}
extension PageContentView:PageTitleViewDelegate{
    
    func PageTitleViewDidclick(index: Int, pageTitleView: PageTitleView) {
        
        mainCollectionV.setContentOffset(CGPoint(x: CGFloat(index)*self.bounds.size.width, y: 0), animated: false)
    }
}
