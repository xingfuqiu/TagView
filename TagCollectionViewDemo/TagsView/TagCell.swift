//
//  TagCell.swift
//  TagCollectionViewDemo
//
//  Created by XingfuQiu on 2017/7/26.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

import UIKit

protocol TagCellDelegate: NSObjectProtocol {
    /// 点击添加按钮
    ///
    /// - Parameter cell: self
    func tagCellDidTouchedAddButton(cell: TagCell)
    /// 点击删除按钮
    ///
    /// - Parameter cell: self
    func tagCellDidTouchedRemoveButton(cell: TagCell)
    /// 点击自己？
    ///
    /// - Parameter cell: self
    func tagCellDidToucheditself(cell: TagCell)
}

// MARK: - 这里是用来解决使用 optional 关键字报错的问题
extension TagCellDelegate {
    func tagCellDidToucheditself(cell: TagCell) {}
    func tagCellDidTouchedRemoveButton(cell: TagCell) {}
    func tagCellDidTouchedAddButton(cell: TagCell) {}
}

class TagCell: UICollectionViewCell {
    /// deldgate
    weak var delegate: TagCellDelegate?
    /// 间距
    var padding: CGFloat = 6
    /// 标签内容
    var title: String? {
        didSet {
            label.text = title
        }
    }
    /// 标签左边的图片
    var image: UIImage? {
        didSet {
            avatar.image = image
        }
    }
    /// 展示类型
    var type: TagsView.TagsType = .add {
        didSet {
            refreshUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 圆角
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 按钮点击事件
    ///
    /// - Parameter sender: uibutton
    func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 101:
            delegate?.tagCellDidTouchedAddButton(cell: self)
        case 102:
            delegate?.tagCellDidTouchedRemoveButton(cell: self)
        default: break
        }
    }
    
    /// 点击自己
    func didTouchItSelf() {
        delegate?.tagCellDidToucheditself(cell: self)
    }
    
    /// 根据类型刷新UI样式
    func refreshUI() {
        // 先清空 subviews
        contentView.subviews.forEach({ (view) in
            view.removeFromSuperview()
        })
        // 根据类型刷新指定样式的 UI
        switch type {
        case .add:
            contentView.addSubview(addButton)
            contentView.addConstraint(NSLayoutConstraint(item: addButton, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: addButton, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: addButton, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: addButton, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0))
        case .text:
            contentView.addSubview(label)
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: padding))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -padding))
            
            label.sizeToFit()
        case .imagetext:
            contentView.addSubview(avatar)
            contentView.addSubview(label)
            // 图片
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 3))
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 3))
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -3))
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: -6))
            // 文字标签
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: avatar, attribute: .right, multiplier: 1, constant: padding))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -padding))
            
            label.sizeToFit()
        case .textclose:
            contentView.addSubview(label)
            contentView.addSubview(closeButton)
            // 文字标签
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: padding))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: closeButton, attribute: .left, multiplier: 1, constant: 6))
            // 按钮
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0))

            label.sizeToFit()
        default:
            contentView.addSubview(avatar)
            contentView.addSubview(label)
            contentView.addSubview(closeButton)
            // 图片
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 3))
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 3))
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -3))
            contentView.addConstraint(NSLayoutConstraint(item: avatar, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: -6))
            // 文字标签
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: avatar, attribute: .right, multiplier: 1, constant: padding))
            contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: closeButton, attribute: .left, multiplier: 1, constant: 6))
            // 按钮
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0))
            
            label.sizeToFit()
        }
        
        // 通知刷新？
        layoutIfNeeded()
    }

    //: MARK: - Lazy loading...
    /// 头像
    fileprivate lazy var avatar: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = (self.frame.size.height - 6) / 2
        iv.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        iv.layer.borderWidth = 1
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TagCell.didTouchItSelf)))
        return iv
    }()
    /// 文字标签
    fileprivate lazy var label: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textAlignment = .center
        lb.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.00)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isUserInteractionEnabled = true
        lb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TagCell.didTouchItSelf)))
        return lb
    }()
    /// 关闭按钮
    fileprivate lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "icon_layer_cancle_normal"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 102
        btn.addTarget(self, action: #selector(TagCell.buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
    /// 添加按钮
    fileprivate lazy var addButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setImage(#imageLiteral(resourceName: "icon_pandalist_add2_normal"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 101
        btn.addTarget(self, action: #selector(TagCell.buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
}
