Pod::Spec.new do |s|
  s.name         = "JRTools"
  s.version      = "0.0.2"
  s.summary      = "Jabber 开发的一系列工具文件。"
  s.description  = "1、基本工具，网络请求，控制器基类。"
  s.homepage     = "https://github.com/jackfrow/JRKitsDemo"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Jackfrow" => "1184571039@qq.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/jackfrow/JRKitsDemo.git", :tag => s.version}
  s.source_files = "JRTools/**/*.{h,m}"
  s.requires_arc = true
  s.dependency "AFNetworking"
  s.dependency "YYModel"


end
