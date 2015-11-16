#
# Be sure to run `pod lib lint DateInRegion.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DateInRegion"
  s.version          = "0.5.0"
s.summary          = "Yet another Swift date class"
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
# DateInRegion

[![CI Status](http://img.shields.io/travis/Hout/DateInRegion.svg?style=flat)](https://travis-ci.org/Hout/DateInRegion)
[![Version](https://img.shields.io/cocoapods/v/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)
[![License](https://img.shields.io/cocoapods/l/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)
[![Platform](https://img.shields.io/cocoapods/p/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)

DateInRegion is a wrapper around NSDate that exposes the properties of NSDateComponents, NSCalendar, NSTimeZone, NSLocale and NSDateFormatter. We are not there yet, but the intention is to replace your occurrence of NSDate with DateInRegion and get the same functionality plus lots of local date/calendar/time zone/formatter goodies. Thus offering date functions with a flexibility that I was looking for when creating this library:

- Use the object as an NSDate. I.e. as an absolute time.
- Offers many NSDate & NSDateComponent vars & methods
- Initialise a date with any combination of components
- Default date is `NSDate()`
- Default calendar is `NSCalendar.currentCalendar()`
- Default time zone is `NSTimeZone.defaultTimeZone()`
- Default locale is `NSLocale.currentLocale()`
- Contains a date (NSDate), a calendar (NSCalendar), a locale (NSLocale) and a timeZone (NSTimeZone) property
- Implements the ``Equatable`` & ``Comparable`` protocols betwen dates with operators. E.g. `==, !=, <, >, <=, >=`
- Implements the ``Hashable`` protocol so the date can be used as a key in a Dictionary.
- implements date addition and subtraction operators with date components. E.g. `date + 2.days`
- DateInRegion is immutable, so thread safe. It contains a constructor to easily create new ``DateInRegion`` occurrences with some properties adjusted.
DESC

  s.homepage         = "https://github.com/Hout/DateInRegion"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Hout" => "through Github" }
  s.source           = { :git => "https://github.com/Hout/DateInRegion.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/JerHout'

  s.ios.deployment_target   = '9.0'
  s.osx.deployment_target   = '10.10'
  s.tvos.deployment_target  = '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  #s.resource_bundles = {
  #    'DateInRegion' => ['Pod/Assets/*.png']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
