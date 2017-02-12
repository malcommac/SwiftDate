<p align="center" >
  <img src="https://raw.githubusercontent.com/malcommac/SwiftDate/master/logo.png" width=210px height=211 alt="SwiftDate" title="SwiftDate">
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CI Status](https://travis-ci.org/malcommac/SwiftDate.svg)](https://travis-ci.org/malcommac/SwiftDate) [![Version](https://img.shields.io/cocoapods/v/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![License](https://img.shields.io/cocoapods/l/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![Platform](https://img.shields.io/cocoapods/p/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)

We really ♥ Swift and we think that dates and timezones management should be painless: this is the reason we made SwiftDate, probably the best way to manage date and time in Swift.

Choose SwiftDate for your next project, or migrate over your existing projects—you'll be happy you did!

<p align="center" >★★ <b>Star our github repository to help us!</b> ★★</p>
<p align="center" >Created by <a href="http://www.danielemargutti.com">Daniele Margutti</a> (<a href="http://www.twitter.com/danielemargutti">@danielemargutti</a>)</p>

## Main features
Here's a highlight of the main features you can find in SwiftDate:

* **Simple math operations with dates!** Example: `aDate + 2.weeks + 1.hour or (1.year - 2.hours + 16.minutes).fromNow()`
* **Easy conversions to and from timezone, locale and calendar**. Use the helper class `DateInRegion` and perform conversions with components and operations!
* **Compare dates with math operators** `<,>,==,<=,>=`. For example, you can do `aDate1 >= aDate2 or aDate1.isIn(anotherDate,.day)`
* **Easily work with time components**. E.g. `aDateInRegion.day` or `hour`, `minutes` etc. expressed in your favourite timezone!
* **Easy and optimized way to get and transform a date from and to strings**: supports both colloquial (human readable) and fixed formats (**ISO8601, AltRSS, RSS, Extended, .NET and custom string as per Unicode standard**)
* **Express time interval in other time units**; for example `120.seconds.in(.minutes) // 2 minutes`
* **Many shortcuts to get intervals, work with time units, intervals and common date operations** (`isYesterday,isTomorrow,isBefore()`...)
* ... [many many other shiny things!](http://malcommac.github.io/SwiftDate)

## You also may like

Do you like `SwiftDate`? I'm also working on several other opensource libraries.

Take a look here:

* **[Hydra](https://github.com/malcommac/Hydra)** - Promises & Await/Async in Swift - Write better async code in Swift
* **[SwiftLocation](https://github.com/malcommac/SwiftLocation)** - CoreLocation and Beacon Monitoring on steroid!
* **[SwiftRichString](https://github.com/malcommac/SwiftRichString)** - Elegant and painless attributed string in Swift
* **[SwiftScanner](https://github.com/malcommac/SwiftScanner)** - String scanner in pure Swift with full unicode support
* **[SwiftSimplify](https://github.com/malcommac/SwiftSimplify)** - Tiny high-performance Swift Polyline Simplification Library

## How to get started

* **Check our website [http://malcommac.github.io/SwiftDate/index.html](http://malcommac.github.io/SwiftDate) to learn more about all available functions with a comprehensive list of examples**
* Install SwiftDate via CocoaPods, Carthage or Swift Package Manager
* Have fun!

## Documentation
* **On [http://malcommac.github.io/SwiftDate/index.html](http://malcommac.github.io/SwiftDate/index.html) to learn more about all available functions with a comprehensive list of examples**
* The **latest [full class documentation is available here](http://cocoadocs.org/docsets/SwiftDate/4.0.8/)**

Code is documented for Xcode, so you can use the built-in documentation panel to learn more about the library.

You can also generate the latest documentation using [Jazzy](https://github.com/realm/jazzy); install Jazzy via ```gem install jazzy``` then, from terminal, move to the ```/SwiftDate``` folder and type ```jazzy -c jazzy.yaml```. Documentation will be generated in ```docs``` folder.

## Communication
- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/swiftdate). (Tag 'swiftdate')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/swiftdate).
- If you **found a bug**, _and can provide steps to reliably reproduce it_, [open an issue](https://github.com/malcommac/SwiftDate/issues/new).
- If you **have a feature request**, [open an issue](https://github.com/malcommac/SwiftDate/issues/new).
- If you **want to contribute**, [submit a pull request](https://github.com/malcommac/SwiftDate/compare).

## Current Release

Latest release is: 4.0.13 [Download here](https://github.com/malcommac/SwiftDate/releases/tag/4.0.13).

A complete list of changes for each release is available in the [CHANGELOG](CHANGELOG.md) file.

## Help Us!
Currently we need translations for [SwiftDate.bundle](https://github.com/malcommac/SwiftDate/tree/master/Sources/SwiftDate/SwiftDate.bundle).
Help us with a pull request!

Currently SwiftDate supports:
* English (since 4.0.0)
* Italian (since 4.0.0)
* German (made by to [hackolein](https://github.com/hackolein), since 4.0.3)
* Dutch (made by [hout](https://github.com/Hout), since 4.0.0)
* French (made by [pierrolivier](https://github.com/pierrolivier), since 4.0.5)
* Indonesian (made by [suprie](https://github.com/suprie), since 4.0.5)
* Simplified Chinese (made by [codingrhythm](https://github.com/codingrhythm), since 4.0.5)
* Traditional Chinese (made by [rynecheow](https://github.com/rynecheow), since 4.0.7)
* Spanish (made by [adrimarti](https://github.com/adrimarti) and [Sepho](https://github.com/Sepho), since 4.0.8)
* Czech (made by [rbukovansky](https://github.com/rbukovansky), since 4.0.8)
* Danish (made by [emilpedersen](https://github.com/emilpedersen), since 4.0.8)
* Slovak (made by [beretis](https://github.com/beretis), since 4.0.8)
* Korean (made by [KisukPark](https://github.com/KisukPark), since 4.0.8)
* Turkish (made by [fatihyildizhan](https://github.com/fatihyildizhan), since 4.0.8)
* Vietnamese (made by [solbadguyky](https://github.com/solbadguyky), since 4.0.9)
* Japanese (made by [bati668](https://github.com/bati668), since 4.0.9)
* Brazilian Portuguese (made by [ipedro](https://github.com/ipedro), since 4.0.11)
* Hebrew (made by [@ilandbt](https://github.com/ilandbt), since 4.0.12)
* Swedish (made by [@traneHead](https://github.com/traneHead), since 4.0.12)
* Arabic (made by [@abdualrhmanIO](https://github.com/abdualrhmanIO), since 4.0.13)

Make a pull request and add your language!

## Installation

SwiftDate supports multiple methods for installing the library in a project.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SwiftDate in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.0.1+ is required to build SwiftDate 4+ (along with Swift 3 and Xcode 8).

#### Podfile

To integrate SwiftDate into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
  use_frameworks!
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

Current version is compatible with:

* Swift 3.0+
* iOS 8 or later
* macOS 10.10 or later
* watchOS 2.0 or later
* tvOS 9.0 or later
* ...and virtually any platform which is compatible with Swift 3 and implements the Swift Foundation Library

Are you searching for an old (unsupported) SwiftDate version?
Check out:
* [Swift 2.3 Branch](https://github.com/malcommac/SwiftDate/tree/feature/swift_23)
* Swift 2.2: Use version 3.0.8 in CocoaPods


## Credits & License
SwiftDate is owned and maintained by [Daniele Margutti](http://www.danielemargutti.com/) along with main contributions of [Jeroen Houtzager](https://github.com/Hout).

As open source creation any help is welcome!

The code of this library is licensed under MIT License; you can use it in commercial products without any limitation.

The only requirement is to add a line in your Credits/About section with the text below:

```
Date and Time Management is provided by SwiftDate - http://www.swift-date.com
Created by Daniele Margutti and licensed under MIT License.
```

## Your App and SwiftDate
We are interested in making a list of all projects which use this library. Feel free to open an Issue on GitHub with the name and links of your project; we'll add it to this site.
