#
# Be sure to run `pod lib lint ZMJImageEditor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZMJImageEditor'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZMJImageEditor.'
  s.homepage         = 'https://github.com/keshiim/ZMJImageEditor'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'keshiim' => 'keshiim@163.com' }
  s.source           = { :git => 'https://github.com/keshiim/ZMJImageEditor.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'ZMJImageEditor/Classes/**/*'
  
   s.resource = [
     'ZMJImageEditor/Assets/*.png',
     'ZMJImageEditor/Assets/*.{xib,storyboard}',
     'ZMJImageEditor/Assets/*.{pdf,xcassets}'
     ]

   s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'YYCategories', '~> 1.0.4'
end
