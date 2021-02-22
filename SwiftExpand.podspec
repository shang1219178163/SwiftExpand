
Pod::Spec.new do |s|

    s.name         = "SwiftExpand"
    s.version      = "6.3.1"
    s.summary      = "系统类功能扩展, 极大的提高工作效率."
    s.description  = "主要通过分类实现"

    s.homepage     = "https://github.com/shang1219178163/SwiftExpand"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "BIN" => "shang1219178163@gmail.com" }
    s.source       = { :git => "https://github.com/shang1219178163/SwiftExpand.git", :tag => "#{s.version}" }

    s.source_files = "SwiftExpand/Classes/**/*"
    s.resource_bundles = {
      'SwiftExpand' => ['SwiftExpand/*.xcassets']
    }

    s.ios.deployment_target = '10.0'
    s.swift_version = "5"
    s.requires_arc = true
    s.frameworks = 'UIKit', 'CoreFoundation', 'CoreGraphics', 'CoreImage',
      'CoreLocation','QuartzCore', 'WebKit'

    s.dependency 'SnapKit'


end
