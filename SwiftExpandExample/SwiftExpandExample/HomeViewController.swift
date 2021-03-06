//
//  HomeViewController.swift
//  NNPlateKeborad
//
//  Created by Bin Shang on 2019/12/6.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import UIKit
import Foundation
import SwiftExpand
import WebKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupExtendedLayout()
        view.backgroundColor = UIColor.white

        title = "Home"
        textField.frame = CGRect.make(10, 20, kScreenWidth - 20, 35)
        view.addSubview(textField)
        
        let image = UIImage(named: "search_bar", podName: "SwiftExpand")!
        textField.addLeftViewButton { (sender) in
            sender.imageView?.contentMode = .scaleAspectFit
            sender.setImage(image, for: .normal)
//            sender.setBackgroundImage(image, for: .normal)

        } action: { (sender) in
            DDLog(sender);
        }

//        textField.setupLeftView(image: UIImage(named: "search_bar", podName: "SwiftExpand"))

        textField.becomeFirstResponder()
        
        _ = view.addGestureTap { (reco) in
            self.textField.resignFirstResponder()
        }
                
        view.getViewLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        textField.text = ""
    }
    
    //MARK: -lazy
    lazy var textField: UITextField = {
        let view = UITextField()
        view.font = UIFont.systemFont(ofSize: 14)
        view.placeholder = "请输入车牌号码"
        view.delegate = self;
        return view
    }()
        

}

extension HomeViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        DDLog(textField.text)
        return true
    }
}
