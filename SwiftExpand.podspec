
Pod::Spec.new do |s|

    s.name         = "SwiftExpand"
    s.version      = "1.7.5"
    s.summary      = "系统类功能扩展."
    s.description  = "主要通过分类实现"

    s.homepage     = "https://github.com/shang1219178163/SwiftExpand"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "BIN" => "shang1219178163@gmail.com" }
    s.source       = { :git => "https://github.com/shang1219178163/SwiftExpand.git", :tag => "#{s.version}" }

    s.source_files = "SwiftExpand/*.swift"
    s.resource_bundles = {
      'SwiftExpand' => ['SwiftExpand/Resources/*.xcassets']
    }

    s.ios.deployment_target = '8.0'
    s.swift_version = "5.0"
    s.requires_arc = true
    s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage',
      'CoreLocation','CoreTelephony', 'GLKit','QuartzCore', 'WebKit'

end
