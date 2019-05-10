
Pod::Spec.new do |s|

s.name         = "BTCaptchaView"
s.version      = "1.0.0"
s.summary      = "图形验证码视图"
s.homepage     = "https://github.com/biostome"
s.license        = { :type => "MIT", :file => "LICENSE" }
s.author       = { "biostome" => "453816118@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/biostome/BTCaptchaView.git", :tag => s.version }
s.source_files = "BTCaptchaView/**/*.{swift,h}"
s.requires_arc = true
s.swift_version = "5.0"
#s.frameworks = "SomeFramework", "AnotherFramework"
#s.framework    = "UIKit","Foundation"
#s.ios.deployment_target = "12.0"

end
