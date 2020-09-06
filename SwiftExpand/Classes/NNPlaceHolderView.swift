//
//	NNPlaceHolderView.swift
//	MacTemplet
//
//	Created by shang on 2020/08/07 14:41
//	Copyright © 2020 shang. All rights reserved.
//


import UIKit
import SnapKit


@objc enum NNPlaceHolderViewState: Int {
    case nomrol, loading, empty, fail
}

@objc protocol NNPlaceHolderViewDelegate{
    @objc func placeholderViewTap(_ view: NNPlaceHolderView, tap: UITapGestureRecognizer)
    @objc optional func placeholderViewLayoutSubviews(_ view: NNPlaceHolderView, imgView: UIImageView, label: UILabel, btn: UIButton, inset: UIEdgeInsets)
    
}
        
///
@objcMembers public class NNPlaceHolderView: UIView {

    weak var delegate: NNPlaceHolderViewDelegate?

    var inset: UIEdgeInsets = UIEdgeInsets(top: 64, left: 30, bottom: 64, right: 30)
    //MARK: -lazy
    lazy var imgView: UIImageView = {
        var view = UIImageView(frame: .zero);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.image = UIImage(named: "icon_avatar")
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        view.contentMode = .center
        return view;
    }()
    
    lazy var label: UILabel = {
        let view = UILabel(frame: .zero);
        view.text = "请选择";
        view.textColor = .lightGray;
        view.textAlignment = .center;
        return view;
    }();
    
    lazy var btn: UIButton = {
        let view = UIButton(type: .custom);
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        view.setTitle("Learn more", for: .normal);
        view.setTitleColor(.systemBlue, for: .normal);
        view.addActionHandler({ (control) in
            if let sender = control as? UIButton {
                DDLog(control)
            }

        }, for: .touchUpInside)
        return view;
    }();
    
    
    private lazy var titleDic: [NNPlaceHolderViewState: String] = {
        return [NNPlaceHolderViewState.empty: "暂无数据",
                NNPlaceHolderViewState.loading: "加载中...",
                NNPlaceHolderViewState.fail: "请求失败",
                ]
    }()
    
    private lazy var imageDic: [NNPlaceHolderViewState: UIImage] = {
        return [NNPlaceHolderViewState.empty: UIImage(named: "img_data_empty")!,
                NNPlaceHolderViewState.loading: UIImage(named: "img_network_loading")!,
                NNPlaceHolderViewState.fail: UIImage(named: "img_network_error")!,
                ]
    }()
    
    var state: NNPlaceHolderViewState = .empty {
        willSet{
            isHidden = !(newValue == .fail)
            label.text = titleDic[newValue]
            imgView.image = imageDic[newValue]
        }
    }
    
    func setTitle(_ title: String, for state: NNPlaceHolderViewState) {
        titleDic[state] = title
    }
    
    func setImage(_ image: UIImage, for state: NNPlaceHolderViewState) {
        imageDic[state] = image
    }
    
    // MARK: -lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        addSubview(imgView)
        addSubview(label)
        addSubview(btn)
        btn.isHidden = true

        _ = addGestureTap { (reco) in
            self.delegate?.placeholderViewTap(self, tap: reco as! UITapGestureRecognizer)
        }
        getViewLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.height <= 10.0 {
            return;
        }
        
        if let delegate = delegate, delegate.placeholderViewLayoutSubviews?(self, imgView: imgView, label: label, btn: btn, inset: inset) != nil {
            return
        }
                
        let size = CGSize(width: bounds.width - 30*2, height: 0)
        let labelSize = label.sizeThatFits(size)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0)
            make.centerX.equalToSuperview().offset(0)
            make.width.equalTo(size.width)
            make.height.greaterThanOrEqualTo(labelSize.height)
        }
                
        imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(inset.top)
            make.left.equalToSuperview().offset(inset.left)
            make.right.equalToSuperview().offset(-inset.right)
            make.bottom.equalTo(label.snp.top).offset(-10)
        }
        
        let btnSize = btn.sizeThatFits(.zero)
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(10)
            make.size.equalTo(btnSize)
        }

    }
    
    // MARK: - funtions

    
}


@objc public extension UIScrollView{
    private struct AssociateKeys {
        static var placeHolderView   = "UIScrollView" + "placeHolderView"
    }
    ///占位视图
     var placeHolderView: NNPlaceHolderView {
        if let obj = objc_getAssociatedObject(self, &AssociateKeys.placeHolderView) as? NNPlaceHolderView {
            return obj
        }

        let holderView = NNPlaceHolderView(frame: self.bounds)
        addSubview(holderView)

        objc_setAssociatedObject(self, &AssociateKeys.placeHolderView, holderView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return holderView
    }
    
}


@objc public extension UITableView{
    
    class func initializeMethodForPlaceHolderView() {
        if self == UITableView.self {
            let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
            //DispatchQueue函数保证代码只被执行一次，防止又被交换回去导致得不到想要的效果
            DispatchQueue.once(token: onceToken) {
                let oriSel = #selector(reloadData)
                let repSel = #selector(hook_reloadData)
                _ = hookInstanceMethod(of: oriSel, with: repSel);
            }
        }
    }
    
    private func hook_reloadData() {
        if subView(NNPlaceHolderView.self) == nil {
            hook_reloadData()
            return
        }
        
        guard let dataSource = dataSource else {
            hook_reloadData()
            return
        }
                
        let isEmpty = dataSource.tableView(self, numberOfRowsInSection: 0) <= 0
        placeHolderView.isHidden = !isEmpty
        if isEmpty {
            placeHolderView.state = .empty
        }
        hook_reloadData()
    }
    

}
