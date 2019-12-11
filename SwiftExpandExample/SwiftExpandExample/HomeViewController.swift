//
//  HomeViewController.swift
//  NNPlateKeborad
//
//  Created by Bin Shang on 2019/12/6.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import UIKit
import SwiftExpand

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupExtendedLayout()
        view.backgroundColor = UIColor.white

        title = "Home"
        textField.frame = CGRect.make(10, 20, kScreenWidth - 20, 35)
        view.addSubview(textField)
        
        textField.setupLeftView(image: Bundle.image(named: "search_bar", podClassName: "SwiftExpand"))

//        textField.setupLeftView(image: Bundle.image(named: "search_bar", podClass: NSClassFromString("SwiftExpand")!.self))
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
