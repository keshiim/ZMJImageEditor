# ZMJImageEditor

[![CI Status](http://img.shields.io/travis/keshiim/ZMJImageEditor.svg?style=flat)](https://travis-ci.org/keshiim/ZMJImageEditor)
[![Version](https://img.shields.io/cocoapods/v/ZMJImageEditor.svg?style=flat)](http://cocoapods.org/pods/ZMJImageEditor)
[![License](https://img.shields.io/cocoapods/l/ZMJImageEditor.svg?style=flat)](http://cocoapods.org/pods/ZMJImageEditor)
[![Platform](https://img.shields.io/cocoapods/p/ZMJImageEditor.svg?style=flat)](http://cocoapods.org/pods/ZMJImageEditor)

## 功能介绍
剪裁、涂鸦、文字。各种旋转各种好完，如果有bug，欢迎issue，下面是几个介绍功能的GIF

1. draw功能

![draw](https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/draw.gif)


2. text

![text](https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/text.gif)
![text2](https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/text2.gif)

3. clip，rotation

![clip,rotation](https://github.com/keshiim/Swift_learn_CoreGraphics/blob/master/screenshot/clip.gif)
## Usage

调起

``` Objective-c
WBGImageEditor *editor = [[WBGImageEditor alloc] initWithImage:_imageView.image delegate:self];
[self presentViewController:editor animated:YES completion:nil];
```
回调delegate

``` Objective-c
#pragma mark - WBGImageEditorDelegate
- (void)imageEditor:(WBGImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image {
self.imageView.image = image;
[editor.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageEditorDidCancel:(WBGImageEditor *)editor {

}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

and this is the [demo](https://github.com/keshiim/ZMJImageEditorDemo) project

## Requirements

iOS7+

## Installation

ZMJImageEditor is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZMJImageEditor"
```

## Author

keshiim, keshiim@163.com

## License

ZMJImageEditor is available under the MIT license. See the LICENSE file for more info.
