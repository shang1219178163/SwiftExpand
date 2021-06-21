
Pod::Spec.new do |s|

    s.name         = "SwiftExpand"
    s.version      = "7.7.1"
    s.summary      = "系统类功能扩展, 极大的提高工作效率."
    s.description  = "通过 extension 实现, 低耦合(iOS && macOS)"

    s.homepage     = "https://github.com/shang1219178163/SwiftExpand"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "BIN" => "shang1219178163@gmail.com" }
    s.source       = { :git => "https://github.com/shang1219178163/SwiftExpand.git", :tag => "#{s.version}" }

    
    s.source_files = 'SwiftExpand/Classes/*'
    s.ios.source_files = 'SwiftExpand/ios/*.swift'
    s.osx.source_files = 'SwiftExpand/osx/*.swift'
    s.resource_bundles = {
      'SwiftExpand' => ['SwiftExpand/*.xcassets']
    }

    s.ios.deployment_target = '10.0'
    s.osx.deployment_target = '10.13'
    
    s.swift_version = "5"
    s.requires_arc = true
    
    s.frameworks = 'Foundation', 'QuartzCore', 'WebKit', 'Photos'
    s.ios.frameworks = 'UIKit'
    s.osx.frameworks = 'AppKit'
end
