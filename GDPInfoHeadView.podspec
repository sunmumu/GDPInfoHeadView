#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/

Pod::Spec.new do |s|
  s.name         = 'GDPInfoHeadView'
  s.version      = '1.0.0'
  s.summary      = '封装个人中心,头像视图, 可以更改头像.'
  s.homepage     = 'https://github.com/sunmumu/GDPInfoHeadView'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'sunmumu' => '335089101@qq.com' }
  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/sunmumu/GDPInfoHeadView.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'GDPInfoHeadView/**/*.{h,m}'
  s.public_header_files = 'GDPInfoHeadView/**/*.{h}'
  
  s.libraries = 'z'
  s.frameworks = 'UIKit'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  

end
