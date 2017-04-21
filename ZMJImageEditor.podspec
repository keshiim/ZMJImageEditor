#
# Be sure to run `pod lib lint ZMJImageEditor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZMJImageEditor'
  s.version          = '0.1.1'
  s.summary          = 'ZMJImageEditor 是一个和微信一样图片编辑的组件，功能强大，极易集成'
  s.homepage         = 'https://github.com/keshiim/ZMJImageEditor'
  # s.screenshots     = 'https://github.com/keshiim/ZMJImageEditor/blob/master/screenShot/draw.gif', 'https://github.com/keshiim/ZMJImageEditor/blob/master/screenShot/clip.gif', 'https://github.com/keshiim/ZMJImageEditor/blob/master/screenShot/text.gif', 'https://github.com/keshiim/ZMJImageEditor/blob/master/screenShot/text2.gif'
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

   s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'YYCategories', '~> 1.0.4'
end
