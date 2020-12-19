//
//  UIImageView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/27.
//

import UIKit

@objc public extension UIImageView{
    private struct AssociateKeys {
        static var isSelected    = "UIImageView" + "isSelected"
    }
    
    var isSelected: Bool {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.isSelected) as? Bool {
                return obj
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.isSelected, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// [源]UIImageView创建
    static func create(_ rect: CGRect = .zero, imgName: String) -> Self {
        let view = self.init(frame: rect);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = true;
        view.contentMode = .scaleAspectFit;
        view.image = UIImage(named: imgName);
        
        return view
    }
    ///MARK:默认渲染AlwaysTemplate方式
    func renderTintColor(_ tintColor: UIColor = .theme, mode: UIImage.RenderingMode = .alwaysTemplate) {
        self.tintColor = tintColor
        self.image = self.image?.withRenderingMode(mode)
    }
    /// 翻转动画
    func addFlipAnimtion(_ image: UIImage, backImage: UIImage, isRepeat: Bool = true) {
        let opts: UIView.AnimationOptions = [.transitionFlipFromLeft]
        UIView.transition(with: self, duration: 1.35, options: opts, animations: {
            self.image = (self.image == image) ? backImage : image
       
        }) { (finished) in
            if isRepeat {
                self.addFlipAnimtion(image, backImage: backImage)
            }
        }
    }
    
    /// 全屏展示,支持缩放
    func showImageEnlarge() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(enlargeImageView(_:)))
        tap.numberOfTapsRequired = 1  //轻点次数
        tap.numberOfTouchesRequired = 1  //手指个数
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(tap)
             
        enlargeImageView(tap)
    }
    
    private func enlargeImageView(_ tap: UITapGestureRecognizer) {
        guard let tapView = tap.view as? UIImageView,
              let window = UIApplication.shared.keyWindow
        else { return }
        
        let oldFrame = tapView.convert(tapView.frame, to: window)
        
        let imageView: UIImageView = {
          let view = UIImageView(frame: oldFrame)
            view.contentMode = .scaleAspectFit
            view.tag = 1001;
                                    
            view.addGesturePinch { (reco) in
                
            }
            
            view.addGesturePan { (reco) in
                
            }
            
            view.addGestureRotation { (reco) in
                
            }
            return view;
        }()
        imageView.image = tapView.image
        
        let backgroundView: UIView = {
            let view = UIView(frame: window.bounds)
            view.backgroundColor = .black
            view.tag = 1000;
            view.alpha = 0;
            return view;
        }()
        backgroundView.addSubview(imageView)
        window.insertSubview(backgroundView, at: 1)
                
        UIView.animate(withDuration: 0.15) {
            imageView.frame = window.bounds;
            backgroundView.alpha = 1;
        }
        
        backgroundView.addGestureTap { (reco) in
            UIView.animate(withDuration: 0.15, animations: {
                backgroundView.alpha = 0;

            }) { (finished) in
                if finished == true {
                    reco.view?.removeFromSuperview()
                }
            }
        }
    }
    
    func download(from url: URL, contentMode: UIView.ContentMode = .scaleAspectFit, placeholder: UIImage? = nil, completionHandler: ((UIImage?) -> Void)? = nil) {
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data) else {
                completionHandler?(nil)
                return
            }
            DispatchQueue.main.async { [unowned self] in
                self.image = image
                completionHandler?(image)
            }
        }.resume()
    }
}



