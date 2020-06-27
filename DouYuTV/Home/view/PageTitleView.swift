//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by 黄武 on 2020/6/27.
//  Copyright © 2020 黄武. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate:class {
    
    func PageTitleViewDidclick(index:Int,pageTitleView:PageTitleView)
}

class PageTitleView: UIView {
    var titles:[String];
    
    var scrollerLineW:CGFloat
    var labelsAr:[UILabel]
    
    var currentIndex:Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    
    private lazy var scrollerLine : UIView = {
        let line = UIView()
        line.backgroundColor = .orange
        return line
    }()
    
    private lazy var mainScrollerView:UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.isPagingEnabled = false
        scrollerView.bounces = false;
        scrollerView.showsHorizontalScrollIndicator = false
        return scrollerView
    }()
    
    init(frame:CGRect,titles:[String]) {
        self.titles = titles;
        scrollerLineW = 40
        self.labelsAr = Array()
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    func setupUI() {
        addSubview(mainScrollerView)
        mainScrollerView.frame = self.bounds
        addLabels()
        addBotonLineAndScrollerLine()
    }
    
    
    func addLabels()  {
        let labelW = bounds.width / CGFloat(titles.count)
        scrollerLineW = labelW
        let labelH = bounds.height
        let labelY:CGFloat = 0.0
        
        
        for (index,title) in titles.enumerated() {
            
            let labelX = CGFloat(index)  * labelW
            let label  = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textAlignment = .center
            if index==0 {
                label.textColor = .orange
            }else{
                label.textColor = .darkGray

            }
            label.text = title
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleClick(tap:)))
            label.addGestureRecognizer(tap)
            mainScrollerView.addSubview(label)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            labelsAr.append(label)
        }
    }
    
    
    func addBotonLineAndScrollerLine() {
        let lineH = 0.5
        
        let bottonLine = UIView()
        bottonLine.backgroundColor = .orange
        
        
        bottonLine.frame = CGRect.init(x: 0.0, y: Double(bounds.height) - lineH, width: Double(bounds.size.width), height: lineH)
        
        addSubview(bottonLine)
        
        mainScrollerView.addSubview(scrollerLine)
        let sLineH:CGFloat = 2.0
        
        scrollerLine.frame = CGRect(x: 0.0, y: CGFloat(bounds.height-sLineH), width: scrollerLineW, height: sLineH)
        
    }
    
    
    
    
}

extension PageTitleView{
    @objc private func titleClick(tap:UITapGestureRecognizer){
        let currentL = tap.view as? UILabel
        guard (currentL != nil) else {
            return
        }
        let lastL = labelsAr[currentIndex]
        lastL.textColor = .darkGray
        currentL?.textColor = .orange
        titleLineAnimation(label: currentL!)
        currentIndex = labelsAr.firstIndex(of: currentL!)!
    
        delegate?.PageTitleViewDidclick(index: currentIndex, pageTitleView: self)
    }
    
    func titleLineAnimation(label:UILabel)  {
        let leftX = label.frame.origin.x
        var lineRect = scrollerLine.frame
        lineRect.origin.x = leftX;
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.scrollerLine.frame = lineRect
        }) { (Bool) in
            
        }
        
        
        
    }
}
