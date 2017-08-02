//
//  ViewController.swift
//  TagCollectionViewDemo
//
//  Created by XingfuQiu on 2017/7/26.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var taglist: [String] = ["ABC", "熊猫基地", "pandapia", "来来来", "熊猫大大", "四川腾森科技", "邱邱"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        let height: CGFloat = 120
        
        let tags1 = TagsView(.text) //OK
        tags1.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: height)
        tags1.padding = 10
        tags1.titles = taglist
        tags1.backgroundColor = UIColor.lightGray
        tags1.isEnableAdd = true
        view.addSubview(tags1)
        
        let tags2 = TagsView(.textclose) //OK
        tags2.frame = CGRect(x: 0, y: 64+(height+16)*1, width: UIScreen.main.bounds.size.width, height: height)
        tags2.padding = 6
        tags2.titles = taglist
        tags2.backgroundColor = UIColor.lightGray
        view.addSubview(tags2)
        
        let tags3 = TagsView(.imagetext) //OK
        tags3.frame = CGRect(x: 0, y: 64+(height+16)*2, width: UIScreen.main.bounds.size.width, height: height)
        tags3.padding = 6
        tags3.titles = taglist
        tags3.backgroundColor = UIColor.lightGray
        tags3.isEnableAdd = true
        view.addSubview(tags3)
        
        let tags4 = TagsView(.all) //OK
        tags4.frame = CGRect(x: 0, y: 64+(height+16)*3, width: UIScreen.main.bounds.size.width, height: height)
        tags4.padding = 3
        tags4.titles = taglist
        tags4.backgroundColor = UIColor.lightGray
        view.addSubview(tags4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

