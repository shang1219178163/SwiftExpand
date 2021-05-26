//
//  SwiftExpand.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2021/5/26.
//

import Foundation

#if os(macOS)
import AppKit
public typealias Screen = NSScreen
//public typealias Application = NSApplication
public typealias Control = NSControl
public typealias Color = NSColor
public typealias Font = NSFont
public typealias Image = NSImage
public typealias EdgeInsets = NSEdgeInsets
#else
import UIKit
public typealias Screen = UIScreen
//public typealias Application = UIApplication
public typealias Control = UIControl
public typealias Color = UIColor
public typealias Font = UIFont
public typealias Image = UIImage
public typealias EdgeInsets = UIEdgeInsets
#endif
