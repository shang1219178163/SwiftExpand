//
//  UIImage+Helper.swift
//  SwiftTemplet
//
//  Created by dev on 2018/12/11.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

//MARK - UIImage
@objc public extension UIImage {
    private struct AssociateKeys {
        static var closure   = "UIImage" + "closure"
    }

    /// ->Data
    var jsonData: Data? {
        guard let data = self.jpegData(compressionQuality: 1.0) else { return nil }
        return data
    }
    
    var assetName: String? {
        guard let imageAsset = imageAsset else { return nil }
        return imageAsset.value(forKey:"assetName") as? String
    }
    
    ///颜色->图像
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let image = UIImage.color(color, size: size)
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init(cgImage: UIImage.color(.white, size: size).cgImage!)
        }
    }
    
    ///十六进制数值颜色->图像
    convenience init(hexValue: Int, a: CGFloat = 1.0) {
        let image = UIImage.color(UIColor.hexValue(hexValue, a: a))
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init(cgImage: UIImage.color(.white).cgImage!)
        }
    }
    
    ///十六进制字符串颜色->图像
    convenience init(hex: String, a: CGFloat = 1.0) {
        let image = UIImage.color(UIColor.hex(hex, a: a))
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init(cgImage: UIImage.color(.white).cgImage!)
        }
    }
    
    ///获取 pod bundle 图片资源
    convenience init?(named name: String, podClass: AnyClass, bundleName: String? = nil) {
        let bName = bundleName ?? "\(podClass)"
        if let image = UIImage(named: "\(bName).bundle/\(name)"), let cgImage = image.cgImage{
            self.init(cgImage: cgImage)
        } else {
            let filePath = Bundle(for: podClass).resourcePath! + "/\(bName).bundle"
            guard let bundle = Bundle(path: filePath) else { return nil}
            self.init(named: name, in: bundle, compatibleWith: nil)
        }
    }

    ///获取 pod bundle 图片资源
    convenience init?(named name: String, podName: String, bundleName: String? = nil) {
        let bName = bundleName ?? podName
        if let image = UIImage(named: "\(bName).bundle/\(name)"), let cgImage = image.cgImage{
            self.init(cgImage: cgImage)
        } else {
            let filePath = Bundle.main.resourcePath! + "/Frameworks/\(podName).framework/\(bName).bundle"
            guard let bundle = Bundle(path: filePath) else { return nil}
            self.init(named: name, in: bundle, compatibleWith: nil)
        }
    }
    
    /// UIImage 相等判断
    func equelTo(_ image: UIImage) -> Bool{
        guard let data0 = self.pngData(), let data1 = image.pngData() else {
            return false
        }
        return data0 == data1
    }
    /// 把颜色转成UIImage
    static func color(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat = 0) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.addPath(path.cgPath)
        context.setFillColor(color.cgColor)
        context.setLineJoin(.round)
        context.setLineCap(.round)
        context.fillPath()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
    /// color
    func maskWithColor(_ color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    ///生成含有图片和文字的图像
    static func textEmbededImage(image: UIImage, string: String, color: UIColor, imageAlignment: Int = 0, segFont: UIFont? = nil) -> UIImage {
        let font = segFont ?? UIFont.systemFont(ofSize: 16.0)
        let expectedTextSize: CGSize = (string as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
        let width: CGFloat = expectedTextSize.width + image.size.width + 5.0
        let height: CGFloat = max(expectedTextSize.height, image.size.width)
        let size: CGSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        let fontTopPosition: CGFloat = (height - expectedTextSize.height) / 2.0
        let textOrigin: CGFloat = (imageAlignment == 0) ? image.size.width + 5 : 0
        let textPoint: CGPoint = CGPoint(x: textOrigin, y: fontTopPosition)
        string.draw(at: textPoint, withAttributes: [NSAttributedString.Key.font: font,
                                                    NSAttributedString.Key.foregroundColor: color])
        
        let flipVertical: CGAffineTransform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
        context.concatenate(flipVertical)
        
        let alignment: CGFloat = (imageAlignment == 0) ? 0.0 : expectedTextSize.width + 5.0
        context.draw(image.cgImage!, in: CGRect(x: alignment,
                                                y: ((height - image.size.height) / 2.0),
                                                width: image.size.width,
                                                height: image.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    
    ///下采样 imageURL
    static func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        //生成CGImageSourceRef 时，不需要先解码。
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        //kCGImageSourceShouldCacheImmediately
        //在创建Thumbnail时直接解码，这样就把解码的时机控制在这个downsample的函数内
        let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                 kCGImageSourceShouldCacheImmediately: true,
                                 kCGImageSourceCreateThumbnailWithTransform: true,
                                 kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        //生成
        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
        return UIImage(cgImage: downsampledImage)
    }
    
    /// Fix image orientaton to protrait up
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            break
        }
        
        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
    /// rotation by UIImage.Orientation
    func rotation(_ orientation: UIImage.Orientation) -> UIImage {
        var rotate: Double = 0.0
        var rect: CGRect = .zero
        var translateX: CGFloat = 0
        var translateY: CGFloat = 0
        var scaleX: CGFloat = 1.0
        var scaleY: CGFloat = 1.0
        switch orientation {
            case .left:
                rotate = Double.pi / 2
                rect = CGRectMake(0, 0, size.height, size.width)
                translateX = 0
                translateY = -rect.size.width
                scaleY = rect.size.width/rect.size.height
                scaleX = rect.size.height/rect.size.width
                break
                
            case .right:
                rotate = 3*Double.pi / 2
                rect = CGRectMake(0, 0, size.height, size.width)
                translateX = -rect.size.height
                translateY = 0
                scaleY = rect.size.width/rect.size.height
                scaleX = rect.size.height/rect.size.width
                break
                
            case .down:
                rotate = Double.pi
                rect = CGRectMake(0, 0, size.width, size.height)
                translateX = -rect.size.width
                translateY = -rect.size.height
                break
                
            default:
                rotate = 0.0
                rect = CGRectMake(0, 0, size.width, size.height)
                translateX = 0
                translateY = 0
                
            break
        }
        
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        defer {
            UIGraphicsEndImageContext()
        }
        
        //做CTM变换
        context.translateBy(x: 0.0, y: rect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.rotate(by: CGFloat(rotate))
        context.translateBy(x: translateX, y: translateY)
        context.scaleBy(x: scaleX, y: scaleY)
        //绘制图片
        self.draw(in: rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        return image
    }
    ///裁剪
    func croppedImage(bound: CGRect) -> UIImage {
        let scaledBounds = CGRect(x:bound.origin.x * self.scale,
                                  y:bound.origin.y * self.scale,
                                  width:bound.size.width * self.scale,
                                  height:bound.size.height * self.scale)
        let imageRef = cgImage?.cropping(to:scaledBounds)
        let croppedImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: .up)
        return croppedImage
    }
    
    /// 保存UIImage对象到相册
    func toSavedPhotoAlbum(_ action: @escaping((NSError?) -> Void)) {
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        let obj = objc_getAssociatedObject(self, &AssociateKeys.closure)
        if obj == nil {
            objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if let obj = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSError?) -> Void) {
            obj(error)
        }
    }
    
    /// 生成二维码图片
    static func generateQRCode(_ string: String, width: CGFloat, height: CGFloat) -> UIImage? {
                
        guard let data: Data = string.data(using: .isoLatin1, allowLossyConversion: false),
            let filter = CIFilter(name: "CIQRCodeGenerator") else {
                return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let qrcodeImage = filter.outputImage else {
            return nil
        }
        
        // 消除模糊
        let scaleX: CGFloat = width/qrcodeImage.extent.size.width
        // extent 返回图片的frame
        let scaleY: CGFloat = height/qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        return UIImage(ciImage: transformedImage)
    }

    /// 生成二维码图片
    static func generateQRCodeImage(_ string: String, size: CGSize, logo: UIImage?) -> UIImage? {
        guard let data: Data = string.data(using: .isoLatin1, allowLossyConversion: false),
            let filter = CIFilter(name: "CIQRCodeGenerator") else {
                return nil
        }

        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        guard let qrcodeImage = filter.outputImage else {
            return nil
        }
        // 消除模糊
        let scaleX: CGFloat = size.width/qrcodeImage.extent.size.width
        // extent 返回图片的frame
        let scaleY: CGFloat = size.height/qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        // 返回二维码图片
        var qrImage = UIImage(ciImage: transformedImage)
        if let colorFilter = CIFilter(name: "CIFalseColor") {
            // 创建颜色滤镜
            colorFilter.setDefaults()
            colorFilter.setValue(transformedImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            
            if let outputImage = colorFilter.outputImage {
                qrImage = UIImage(ciImage: outputImage)
            }
        }
                
        let imageRect = size.width > size.height ?
            CGRect(x: (size.width - size.height) / 2, y: 0, width: size.height, height: size.height) :
            CGRect(x: 0, y: (size.height - size.width) / 2, width: size.width, height: size.width)
            UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        qrImage.draw(in: imageRect)
        if let logo = logo {
            let logoSize = size.width > size.height ?
                CGSize(width: size.height * 0.25, height: size.height * 0.25) :
                CGSize(width: size.width * 0.25, height: size.width * 0.25)
            logo.draw(in: CGRect(x: (imageRect.size.width - logoSize.width)/2,
                                 y: (imageRect.size.height - logoSize.height)/2,
                                 width: logoSize.width,
                                 height: logoSize.height))
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 切圆角图片
    func roundImage(byRoundingCorners: UIRectCorner = .allCorners, cornerRadii: CGSize = CGSize(width: 5, height: 5)) -> UIImage? {
        
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        let bezierPath = UIBezierPath(roundedRect: imageRect,
                                      byRoundingCorners: byRoundingCorners,
                                      cornerRadii: cornerRadii)
        bezierPath.close()
        bezierPath.addClip()
        self.draw(in: imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    /// 将原来的 UIImage 剪裁出圆角
    func imageWithRoundedCorner(_ radius: CGFloat, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        guard let ctx = UIGraphicsGetCurrentContext() else { return self}
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let path: CGPath = UIBezierPath(roundedRect: rect,
                                        byRoundingCorners: .allCorners,
                                        cornerRadii: CGSize(width: radius, height: radius)).cgPath
        ctx.addPath(path)
        ctx.clip()

        self.draw(in: rect)
        ctx.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
    }
    
    // 缩放本地大图
    static func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        return image.resizeImage(size, isScaleFit: true)
    }
    
    // 缩放图片
    func resizeImage(_ size: CGSize, isScaleFit: Bool = true) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
//        if isScaleFit == false {
//            UIGraphicsBeginImageContext(size)
//            self.draw(in: CGRect(origin: .zero, size: size))
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return image
//        }
//
//        let imageSize = self.size
//        let widthRatio  = size.width  / imageSize.width
//        let heightRatio = size.height / imageSize.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width:imageSize.width * heightRatio, height: imageSize.height * heightRatio)
//        } else {
//            newSize = CGSize(width:imageSize.width * widthRatio, height: imageSize.height * widthRatio)
//        }
//
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        self.draw(in: CGRect(origin: .zero, size: newSize))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage
    }
    
    /// 根据最大尺寸限制压缩图片
    static func compressData(_ image: UIImage, limit: Int = 1024*1024*2) -> Data {
        var compression: CGFloat = 1.0
        let maxCompression: CGFloat = 0.1
        
        var imageData = image.jpegData(compressionQuality: compression)
        while imageData!.count > limit && compression > maxCompression {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)
        }
        DDLog("压缩后图片大小:\(imageData!.count/1024)kb_压缩系数:\(compression)")
        return imageData!
    }
    
    static func binaryCompressData(_ image: UIImage, limit: Int = 1024*1024) -> Data {
        var compression: CGFloat = 1
        var data = image.jpegData(compressionQuality: compression)
        if data!.count < limit {
            return data!
        }
        var max: CGFloat = 1
        var min: CGFloat = 0
        
        for _ in 0..<6 {
            compression = (max+min)/2
            data = image.jpegData(compressionQuality: compression)
            if data!.count < limit*Int(0.9) {
                min = compression
            } else if data!.count > limit {
                max = compression
            } else {
                break
            }
        }
        DDLog("压缩后图片大小:\(data!.count)kb_压缩系数:\(compression)")
        return data!
    }

    
    /// 获取图片data的类型
    static func contentType(_ imageData: NSData) -> String {
        var type: String = "jpg"
        
        var c: UInt8?
        imageData.getBytes(&c, length: 1)
        switch c {
        case 0xFF:
            type = "jpeg"
        case 0x89:
            type = "png"
        case 0x47:
            type = "gif"
        case 0x49,0x4D:
            type = "tiff"
        case 0x42:
            type = "bmp"
        case 0x52:
            if (imageData.count < 12) {
                type = "none"
            }
            let string: NSString = NSString(data: imageData.subdata(with: NSMakeRange(0, 12)), encoding: String.Encoding.ascii.rawValue)!
            if string.hasPrefix("RIFF"),string.hasSuffix("WEBP") {
                type = "webp"
            }
        default:
            break
        }
        return type
    }
    
    func imageFromCurrentImageContext() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // 把两张图片绘制成一张图片(添加小图到大图上)
    func combine(image: UIImage) -> UIImage {
        
        // 1.1.获取第一张图片的宽度
        let width: CGFloat = max(self.size.width, image.size.width)
        // 1.2.获取第一张图片的高度
        let height: CGFloat = max(self.size.height, image.size.height)

        // 1.3.开始绘制图片的大小
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        // 1.4.绘制第一张图片的起始点
        self.draw(at: CGPoint(x: 0, y: 0))
        // 1.5.绘制第二章图片的起始点
        let point = CGPoint(x: (width - image.size.width)*0.5, y: (height - image.size.height)*0.5)
        image.draw(at: point)

        // 1.6.获取已经绘制好的
        let imageLong = UIGraphicsGetImageFromCurrentImageContext()!
        // 1.7.结束绘制
        UIGraphicsEndImageContext()
        // 1.8.返回已经绘制好的图片
        return imageLong
    }
}



@objc public extension UIImage {
    /// btn_add
    static let btn_add = UIImage(named: "btn_add")!
    /// icon_arowDown_gray
    static let icon_arowDown_gray = UIImage(named: "icon_arowDown_gray")!
    /// icon_arowLeft_black
    static let icon_arowLeft_black = UIImage(named: "icon_arowLeft_black")!
    /// icon_arowRight_gray
    static let icon_arowRight_gray = UIImage(named: "icon_arowRight_gray")!
    /// icon_close
    static let icon_close = UIImage(named: "icon_close")!
    /// icon_delete
    static let icon_delete = UIImage(named: "icon_delete")!
    /// icon_eye_close
    static let icon_eye_close = UIImage(named: "icon_eye_close")!
    /// icon_eye_open
    static let icon_eye_open = UIImage(named: "icon_eye_open")!
    /// icon_finish
    static let icon_finish = UIImage(named: "icon_finish")!
    /// icon_location
    static let icon_location = UIImage(named: "icon_location")!
    /// icon_selected_no_blue
    static let icon_selected_no_blue = UIImage(named: "icon_selected_no_blue")!
    /// icon_selected_no_default
    static let icon_selected_no_default = UIImage(named: "icon_selected_no_default")!
    /// icon_selected_no_gray
    static let icon_selected_no_gray = UIImage(named: "icon_selected_no_gray")!
    /// icon_selected_yes_blue
    static let icon_selected_yes_blue = UIImage(named: "icon_selected_yes_blue")!
    /// icon_selected_yes_green
    static let icon_selected_yes_green = UIImage(named: "icon_selected_yes_green")!
    /// img_NFC
    static let img_NFC = UIImage(named: "img_NFC")!
    /// img_arrowDown_black
    static let img_arrowDown_black = UIImage(named: "img_arrowDown_black")!
    /// img_arrowDown_gray
    static let img_arrowDown_gray = UIImage(named: "img_arrowDown_gray")!
    /// img_arrowDown_orange
    static let img_arrowDown_orange = UIImage(named: "img_arrowDown_orange")!
    /// img_arrowDown_white
    static let img_arrowDown_white = UIImage(named: "img_arrowDown_white")!
    /// img_arrowLeft_white
    static let img_arrowLeft_white = UIImage(named: "img_arrowLeft_white")!
    /// img_arrowRight_gray
    static let img_arrowRight_gray = UIImage(named: "img_arrowRight_gray")!
    /// img_arrowUp_blue
    static let img_arrowUp_blue = UIImage(named: "img_arrowUp_blue")!
    /// img_dialog_inquiry
    static let img_dialog_inquiry = UIImage(named: "img_dialog_inquiry")!
    /// img_dialog_update
    static let img_dialog_update = UIImage(named: "img_dialog_update")!
    /// img_dialog_warning
    static let img_dialog_warning = UIImage(named: "img_dialog_warning")!
    /// img_elemet_decrease
    static let img_elemet_decrease = UIImage(named: "img_elemet_decrease")!
    /// img_elemet_increase
    static let img_elemet_increase = UIImage(named: "img_elemet_increase")!
    /// img_failedDefault
    static let img_failedDefault = UIImage(named: "img_failedDefault")!
    /// img_failedDefault_S
    static let img_failedDefault_S = UIImage(named: "img_failedDefault_S")!
    /// img_like_H
    static let img_like_H = UIImage(named: "img_like_H")!
    /// img_like_W
    static let img_like_W = UIImage(named: "img_like_W")!
    /// img_location_H
    static let img_location_H = UIImage(named: "img_location_H")!
    /// img_more
    static let img_more = UIImage(named: "img_more")!
    /// img_network_loading_orang
    static let img_network_loading_orang = UIImage(named: "img_network_loading_orang")!
    /// img_notice
    static let img_notice = UIImage(named: "img_notice")!
    /// img_pictureAdd
    static let img_pictureAdd = UIImage(named: "img_pictureAdd")!
    /// img_pictureDelete
    static let img_pictureDelete = UIImage(named: "img_pictureDelete")!
    /// img_portrait_H
    static let img_portrait_H = UIImage(named: "img_portrait_H")!
    /// img_portrait_N
    static let img_portrait_N = UIImage(named: "img_portrait_N")!
    /// img_scan
    static let img_scan = UIImage(named: "img_scan")!
    /// img_sex_boy
    static let img_sex_boy = UIImage(named: "img_sex_boy")!
    /// img_sex_gril
    static let img_sex_gril = UIImage(named: "img_sex_gril")!
    /// img_update
    static let img_update = UIImage(named: "img_update")!
    /// photo_number
    static let photo_number = UIImage(named: "photo_number")!
    /// search_bar
    static let search_bar = UIImage(named: "search_bar")!
    /// toast_error
    static let toast_error = UIImage(named: "toast_error")!
    /// toast_loading
    static let toast_loading = UIImage(named: "toast_loading")!
    /// toast_success
    static let toast_success = UIImage(named: "toast_success")!
}
