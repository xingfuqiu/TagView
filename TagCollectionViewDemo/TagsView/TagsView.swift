//
//  TagsView.swift
//  TagCollectionViewDemo
//
//  Created by XingfuQiu on 2017/7/26.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

import UIKit

class TagsView: UICollectionView {
    /// Cell类型
    ///
    /// - add: 只显示添加按钮
    /// - text: 只显示文字标签
    /// - imagetext: 显示图片+文字
    /// - textclose: 显示文字+关闭
    /// - all: 全部显示（图片+文字+关闭）
    public enum TagsType: Int {
        case add = 0
        case text
        case imagetext
        case textclose
        case all
    }
    
    /// 标签高度
    let tagHeight: CGFloat = 28
    /// 间距
    var padding: CGFloat = 6
    /// 标签类型
    var tagType: TagsType = .text
    /// 是否显示添加按钮 默认 false
    var isEnableAdd: Bool = false {
        didSet {
            reloadSections(IndexSet(integer: 0))
        }
    }
    /// 标签内容
    var titles: [String]? {
        didSet {
            reloadData()
        }
    }
    init(_ type: TagsType = .text) {
        tagType = type
        
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 10
        
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .white
        delegate = self
        dataSource = self
        register(TagCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension TagsView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEnableAdd {
            return titles!.count + 1
        } else {
            return titles?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TagCell
        
        cell.padding = padding
        cell.type = tagType
        cell.delegate = self
        
        if indexPath.item < titles!.count {
            cell.title = titles?[indexPath.row]
        } else {
            cell.type = .add
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TagsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item < titles!.count {
            guard let text = titles?[indexPath.row] else { return .zero }
        
            let size = (text as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
            print(text, size)
            
            switch tagType {
            case .text:
                return CGSize(width: size.width+1 + padding*2, height: tagHeight)
            case .imagetext:
                return CGSize(width: size.width+1 + tagHeight + padding*2, height: tagHeight)
            case .textclose:
                return CGSize(width: size.width+1 + tagHeight + padding , height: tagHeight)
            default: //all
                return CGSize(width: size.width+1 + tagHeight * 2+padding, height: tagHeight)
            }
        } else {
            return CGSize(width: tagHeight, height: tagHeight)
        }
    }
}

// MARK: - TagCellDelegate
extension TagsView: TagCellDelegate {
    func tagCellDidToucheditself(cell: TagCell) {
        print(cell.title ?? "空空如也！")
    }
    
    func tagCellDidTouchedAddButton(cell: TagCell) {
        titles?.append("新TAG")
        reloadSections(IndexSet(integer: 0))
    }
    
    func tagCellDidTouchedRemoveButton(cell: TagCell) {
        // 先获取点击的是哪个位置的删除按钮
        let indexPath = self.indexPath(for: cell)
        
        titles?.remove(at: indexPath!.item)
        
        reloadSections(IndexSet(integer: 0))
    }
}
