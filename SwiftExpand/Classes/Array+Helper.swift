
//
//  NSArray+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/6.
//  Copyright © 2018年 BN. All rights reserved.
//



public extension Array{
    
    /// ->Data
    var jsonData: Data? {
        return (self as NSArray).jsonData
    }
    
    /// ->String
    var jsonString: String {
        return (self as NSArray).jsonString
    }
    
    /// 快速生成一个数组(step代表步长)
    init(count: Int, generator: @escaping ((Int) ->Element)) {
        self = (0..<count).map(generator)
    }
    
    ///同 subarrayWithRange:
    func subarray(location: Int, length: Int) -> Array {
        return subarray(with: NSMakeRange(location, length))
    }
    
    ///同 subarrayWithRange:
    func subarray(with range: NSRange) -> Array {
        assert((range.location + range.length) <= self.count);
        return Array(self[range.location...(range.location + range.length - 1)])
    }
    
    /// <= index
    func subarray(to index: Int) -> Array {
        return Array(self[0...index])
    }
    
    /// >= index
    func subarray(from index: Int) -> Array {
        return Array(self[index...(self.count - 1)])
    }
}

public extension Array where Element == CGFloat{
    var sum: CGFloat {
        return self.reduce(0, +)
    }
    
    ///获取数组期望值
    var expectationValue: CGFloat {
        var dic = [CGFloat: Int]()
        let set = Set(self)
        
        for value in set {
            let filterArray = self.filter { $0 == value }
            dic[value] = filterArray.count
        }
//        DDLog(dic)
        
        let sum = dic.keys.map { $0 }.reduce(0, +)
//        DDLog(sum)
        
        var percentDic = [CGFloat: CGFloat]()
        set.forEach { (obj) in
            percentDic[obj] = CGFloat(obj/sum)
        }
//        DDLog(percentDic)
        
        var expectation: CGFloat = 0.0
        percentDic.forEach { (key: CGFloat, value: CGFloat) in
            expectation += key * value
        }
        DDLog("数组:\(self)\n各元素出现次数: \(dic)\n各元素出现概率: \(percentDic)\n总和: \(sum)\n期望值是: \(expectation)")
        return expectation
    }
    
}


public extension Array where Element : NSObject {
    ///嵌套数组扁平化
    func flatModels(_ childKey: String = "children") -> [Element] {
        ///内部函数
        func recursionModel(_ model: Element, list: inout [Element]) {
            guard let children = model.value(forKey: childKey) as? [Element] else { return }
            children.forEach { (child) in
                list.append(child)
                
                if let _ = child.value(forKey: childKey) as? [Element] {
                    recursionModel(child, list: &list)
                }
            }
        }
                        
        var list = [Element]()
        self.forEach { (model) in
            list.append(model)
            recursionModel(model, list: &list)
        }
        return list
    }
}

public extension Array where Element : View{
    
    enum DirectionShowStyle: Int {
        case topLeftToRight
        case topRightToLeft
        case bottomLeftToRight
        case bottomRightToLeft
    }
    
    ///更新 NSButton 集合视图
    func updateItemsConstraint(_ rect: CGRect,
                               numberOfRow: Int = 4,
                               minimumInteritemSpacing: CGFloat = kPadding,
                               minimumLineSpacing: CGFloat = kPadding,
                               sectionInset: EdgeInsets = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                               showStyle: DirectionShowStyle = .topLeftToRight) {
        if self.count == 0 || Swift.min(rect.width, rect.height) <= 10 {
            return;
        }
        
        let rowCount = self.count % numberOfRow == 0 ? self.count/numberOfRow : self.count/numberOfRow + 1;
        let itemWidth = (rect.width - sectionInset.left - sectionInset.right - CGFloat(numberOfRow - 1)*minimumInteritemSpacing)/CGFloat(numberOfRow)
        let itemHeight = (rect.height - sectionInset.top - sectionInset.bottom - CGFloat(rowCount - 1)*minimumLineSpacing)/CGFloat(rowCount)
        
        for e in self.enumerated() {
            let x = CGFloat(e.offset % numberOfRow) * (itemWidth + minimumInteritemSpacing)
            let y = CGFloat(e.offset / numberOfRow) * (itemHeight + minimumLineSpacing)
            var itemRect = CGRect(x: x, y: y, width: ceil(itemWidth), height: itemHeight)
            
            switch showStyle {
            case .topRightToLeft:
                itemRect = CGRect(x: rect.width - x - itemWidth,
                                  y: y,
                                  width: itemWidth,
                                  height: itemHeight)

            case .bottomLeftToRight:
                itemRect = CGRect(x: x,
                                  y: rect.height - y - itemHeight,
                                  width: itemWidth,
                                  height: itemHeight)

            case .bottomRightToLeft:
                itemRect = CGRect(x: rect.width - x - itemWidth,
                                  y: rect.height - y - itemHeight,
                                  width: itemWidth,
                                  height: itemHeight)

            default:
                break
            }
            let sender = e.element
            sender.frame = itemRect
        }
    }
}


@objc public extension NSArray{

    /// ->Data
    var jsonData: Data? {
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            print(error)
        }
        return data;
    }
    
    /// ->NSString
    var jsonString: String {
        guard let jsonData = self.jsonData as Data?,
        let jsonString = String(data: jsonData, encoding: .utf8) as String?
        else { return "" }
        return jsonString
    }

    /// 快速生成一个数组
    static func generate(count: Int, generator: @escaping ((Int)->Element)) -> NSArray {
        return Array.init(count: count, generator: generator) as NSArray;
    }
    
    ///获取数组期望值
    var expectationValue: CGFloat {
        if self.count == 0 {
            return 0.0
        }
        
        if let list = self as? [NSNumber] {
            let array = list.map({ CGFloat($0.floatValue) })
            return array.expectationValue
        }
        
        if let list = self as? [NSString] {
            let array = list.map({ CGFloat($0.floatValue) })
            return array.expectationValue
        }
        return 0.0
    }
}
