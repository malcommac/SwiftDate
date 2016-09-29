<p align="center" >
  <img src="https://raw.githubusercontent.com/malcommac/SwiftDate/release/swiftdate-4.0/swiftdate-4-logo.png" width=189px height=191 alt="SwiftDate" title="SwiftDate">
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CI Status](https://travis-ci.org/malcommac/SwiftDate.svg)](https://travis-ci.org/malcommac/SwiftDate) [![Version](https://img.shields.io/cocoapods/v/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![License](https://img.shields.io/cocoapods/l/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![Platform](https://img.shields.io/cocoapods/p/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)

We really ❤ Swift and we use it since the beginning.

We also think that dates and timezones management should be painless: this is the reason we made SwiftDate, probability the best way to manage date and time in Swift.

Choose SwiftDate for your next project, or migrate over your existing projects—you'll be happy you did!

## SwiftDate [website is here](http://malcommac.github.io/SwiftDate)

## Main features
That's an highlight of the main features you can found in SwiftDate:

* **Simple math operation with dates!** Example: `aDate + 2.weeks + 1.hours or (1.years - 2.hours + 16.minutes).fromNow()`
* **Easy conversions to and from timezone, locale and calendar**. Use helper class `DateInRegion` and perform conversions with components and operations!
* **Compare dates with math operators** `<,>,==,<=,>=`. For example you can do `aDate1 >= aDate2 or aDate1.isIn(anotherDate,.day)`
* **Easily work with time components**. E.g. `aDateInRegion.day` or `hour`, `minutes` etc. expressed in your favourite timezone!
* **Easy and optimized way to get and transform a date from and to strings**: supports both colloquial (human readable) and fixed formats (**ISO8601, AltRSS, RSS, Extended, .NET and custom string as per Unicode standard**)
* **Express time interval in other time units**; for example `120.seconds.in(.minutes) // 2 minutes`
* **Many shortcuts to get intervals, work with time units, intervals and common date operations** (`isYesterday,isTomorrow,isBefore()`...)
* ... [many many other shiny things!](http://malcommac.github.io/SwiftDate)

## How to get started

* **Check our website [http://malcommac.github.io/SwiftDate/index.html](http://malcommac.github.io/SwiftDate) to learn more about all available functions with a comprehensive list of examples**
* Install SwiftDate via CocoaPods, Chartage or Swift Package Manager
* Have fun!

## Documentation
* **On [http://malcommac.github.io/SwiftDate/index.html](http://malcommac.github.io/SwiftDate/index.html) to learn more about all available functions with a comprehensive list of examples**
* The **latest [full class documentation is available here](http://malcommac.github.io/SwiftDate/docs-latest/)**

Code is documented for XCode, so you can use built in documentation panel to learn more about the library.

You can also generate latest documentation using [Jazzy](https://github.com/realm/jazzy); install Jazzy via ```gem install jazzy``` then, from terminal, move to ```/SwiftDate``` folder and type ```jazzy -c jazzy.yaml```. Documentation will be generated in ```docs``` folder.

## Communication
- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/swiftdate). (Tag 'swiftdate')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/swiftdate).
- If you **found a bug**, _and can provide steps to reliably reproduce it_, [open an issue](https://github.com/malcommac/SwiftDate/issues/new).
- If you **have a feature request**, [open an issue](https://github.com/malcommac/SwiftDate/issues/new).
- If you **want to contribute**, [submit a pull request](https://github.com/malcommac/SwiftDate/compare).

## Help Us!
Currently we need translations for [SwiftDate.bundle](https://github.com/malcommac/SwiftDate/tree/master/src/Support/SwiftDate.bundle).
Help us with a pull request!

## Installation

SwiftDate supports multiple methods for installing the library in a project.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SwiftDate in your projects.You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.0.1+ is required to build SwiftDate 4+ (along with Swift 3 and XCode 8).

#### Podfile

To integrate SwiftDate into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'SwiftDate', '~> 4.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SwiftDate into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "malcommac/SwiftDate" ~> 4.0
```

Run `carthage` to build the framework and drag the built `SwiftDate.framework` into your Xcode project.

## Requirements

Actually current official version is 4.0.0 and it's compatible with:

* Swift 3.0+
* iOS 8 or later
* macOS 10.10 or later
* watchOS 2.0 or later
* tvOS 9.0 or later
* ...and virtually any platform which is compatible with Swift 3 and implements the Swift Foundation Library

Are you searching for an old (unsupported) SwiftDate version?
Check out:
* [Swift 2.3 Branch](https://github.com/malcommac/SwiftDate/tree/feature/swift_23)
* Swift 2.2 use version 3.0.8 in CocoaPods


## Credits & License
SwiftDate is owned and maintained by [Daniele Margutti](http://www.danielemargutti.com/) along with main contribution of [Jeroen Houtzager](https://github.com/Hout).

As open source creation any help is welcome!

The code of this library is licensed under MIT License; you can use it in commercial products without any limitation.

The only requirement is to add a line in your Credits/About section with the text below:

```
Date and Time Management is provided by SwiftDate - http://www.swift-date.com
Created by Daniele Margutti and licensed under MIT License.
```

## Your App and SwiftDate
If you want we are interested in making a list of all projects which uses this library. Feel free to open an Issue on GitHub so with the name and links of your project; we'll add it to this site.
