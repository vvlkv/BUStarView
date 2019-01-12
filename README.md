# BUStarView

[![CI Status](https://img.shields.io/travis/vvlkv/BUStarView.svg?style=flat)](https://travis-ci.org/vvlkv/BUStarView)
[![Version](https://img.shields.io/cocoapods/v/BUStarView.svg?style=flat)](https://cocoapods.org/pods/BUStarView)
[![License](https://img.shields.io/cocoapods/l/BUStarView.svg?style=flat)](https://cocoapods.org/pods/BUStarView)
[![Platform](https://img.shields.io/cocoapods/p/BUStarView.svg?style=flat)](https://cocoapods.org/pods/BUStarView)

BUStarView is a **Fully customizable** star view. Using this library you can create any star you want and edit any parameters which is forming star:
* number of vertices;
* inner radius;
* outer radius;
* inner round;
* outer round.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BUStarView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BUStarView'
```

## Usage
### Storyboards
1. Choose **UIView** from Object Library and drag it into your Xib.
2. In *Identity Inspector* override class to **BUStarView**.
3. In *Attribute Inspector* you can customize your star.

### Code
Create BUStarView like simple UIView
```swift
let starView = BUStarView()
view.addSubview(starView)
```
You can customize star properties by code:
```swift
// Number of vertices
starView.vertices = 5
//
```

## Author

vvlkv, vvlkv@icloud.com

## License

BUStarView is available under the MIT license. See the LICENSE file for more info.
