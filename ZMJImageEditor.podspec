#
# Be sure to run `pod lib lint ZMJImageEditor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZMJImageEditor'
  s.version          = '0.3.0'
  s.summary          = 'ZMJImageEditor is a component of image editing like WeChat, powerful and easy to integrate, and supports the functions of drawing, text, rotation, cutting, mapping and so on. (是一个和微信一样图片编辑的组件，功能强大，极易集成，支持绘制、文字、旋转、剪裁、贴图等功能)'
  s.homepage         = 'https://github.com/keshiim/ZMJImageEditor'
  # s.screenshots     = 'https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/draw.gif', 'https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/text.gif', 'https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/text2.gif', 'https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/clip.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'keshiim' => 'keshiim@163.com' }
  s.source           = { :git => 'https://github.com/keshiim/ZMJImageEditor.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'ZMJImageEditor/Classes/**/*'
  
   s.resource = [
     'ZMJImageEditor/Assets/*.png',
     'ZMJImageEditor/Assets/*.{xib,storyboard}',
     'ZMJImageEditor/Assets/*.{pdf,xcassets}',
     'ZMJImageEditor/Assets/*.{lproj}',
     'ZMJImageEditor/Assets/**/*.png',
     'ZMJImageEditor/Assets/**/*.{xib,storyboard}',
     'ZMJImageEditor/Assets/**/*.{pdf,xcassets}',
     'ZMJImageEditor/Assets/**/*.{strings}'
     ]

   s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'YYCategories', '~> 1.0.4'
   s.dependency 'Masonry',      '~> 1.0.1'
end
