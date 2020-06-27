//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by 黄武 on 2020/6/27.
//  Copyright © 2020 黄武. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var  pageTitlesView: PageTitleView = {[weak self] in
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleFrame = CGRect.init(x: 0.0, y: kNavbarHeight+kStatusBarHeight+24.0, width: kScreenWidth, height: 44.0)
        let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    
    private lazy var contentView:PageContentView = {[weak self] in
        
        let contentFrame = CGRect(x: 0, y:kNavbarHeight+kStatusBarHeight+24+44, width: kScreenWidth, height: kScreenHeight-(kNavbarHeight+kStatusBarHeight+24+44))
        
        var tempCons:[UIViewController] = [UIViewController]();
        
        for _ in 0..<4{
            let con = UIViewController()
            con.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            tempCons.append(con)
            
        }
        let contentV = PageContentView.init(frame: contentFrame, controllers: tempCons, parentViewController: tempCons[0])
        return contentV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    



}

// MARK:- 设置界面
extension HomeViewController{
    
    
    
    private func setupUI(){
        setupNav()
        view.addSubview(pageTitlesView)
        
        view.addSubview(contentView)
        pageTitlesView.delegate = contentView
    }
    
    private func setupNav(){
        
        let btn  = UIButton()
        btn.setImage(UIImage.init(named: "logo"), for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        
        let size = CGSize.init(width: 40, height: 40)
        
        let history = UIBarButtonItem.createItem(imageName: "image_my_history", hightlightName: "Image_my_history_click", size: size)
        
        let search = UIBarButtonItem.createItem(imageName: "btn_search", hightlightName: "btn_search_clicked", size: size)
        
        let qrcode = UIBarButtonItem.createItem(imageName: "Image_scan", hightlightName: "Image_scan_click", size: size)
        
    
        navigationItem.rightBarButtonItems = [history,search,qrcode]
        
    }
}


