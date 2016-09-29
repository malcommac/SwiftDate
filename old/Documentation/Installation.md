# Installation
## CocoaPods
SwiftDate 2 is compatible with both CocoaPods and Carthage.

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SwiftDate. Simply add these lines to your pod file:

```
platform :ios, '8.0'
pod "SwiftDate"
```

## Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SwiftDate into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "malcommac/SwiftDate"
```

Run `carthage` to build the framework and drag the built `SwiftDate.framework` into your Xcode project.


