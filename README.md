# ZMJImageEditor

[![CI Status](http://img.shields.io/travis/keshiim/ZMJImageEditor.svg?style=flat)](https://travis-ci.org/keshiim/ZMJImageEditor)
[![Version](https://img.shields.io/cocoapods/v/ZMJImageEditor.svg?style=flat)](http://cocoapods.org/pods/ZMJImageEditor)
[![License](https://img.shields.io/cocoapods/l/ZMJImageEditor.svg?style=flat)](http://cocoapods.org/pods/ZMJImageEditor)
[![Platform](https://img.shields.io/cocoapods/p/ZMJImageEditor.svg?style=flat)](http://cocoapods.org/pods/ZMJImageEditor)

## 功能介绍
剪裁、涂鸦、文字。各种旋转各种好完，如果有bug，欢迎issue
![](https://github.com/keshiim/ZMJImageEditor/blob/master/1.png)

![](https://github.com/keshiim/ZMJImageEditor/blob/master/2.png)

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

## Requirements

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
