//
//  SwiftExpand.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2021/5/26.
//

import Foundation

#if os(macOS)
import AppKit
public typealias View = NSView
public typealias StackView = NSStackView
public typealias Screen = NSScreen
public typealias Control = NSControl
public typealias Button = NSButton
public typealias Color = NSColor
public typealias Font = NSFont
public typealias Image = NSImage
public typealias EdgeInsets = NSEdgeInsets
public typealias CollectionViewFlowLayout = NSCollectionViewFlowLayout
public typealias CollectionViewDelegateFlowLayout = NSCollectionViewDelegateFlowLayout

/// 屏幕宽度
public let kScreenWidth: CGFloat    = NSScreen.main!.frame.size.width
/// 屏幕高度
public let kScreenHeight: CGFloat   = NSScreen.main!.frame.size.height

extension NSEdgeInsets {
    public static let zero: NSEdgeInsets = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
}

#else
import UIKit
public typealias View = UIView
public typealias StackView = UIStackView
public typealias Screen = UIScreen
public typealias Control = UIControl
public typealias Button = UIButton
public typealias Color = UIColor
public typealias Font = UIFont
public typealias Image = UIImage
public typealias EdgeInsets = UIEdgeInsets
public typealias CollectionViewFlowLayout = UICollectionViewFlowLayout
public typealias CollectionViewDelegateFlowLayout = UICollectionViewDelegateFlowLayout

/// 屏幕宽度
public let kScreenWidth: CGFloat    = UIScreen.main.bounds.size.width
/// 屏幕高度
public let kScreenHeight: CGFloat   = UIScreen.main.bounds.size.height
#endif

