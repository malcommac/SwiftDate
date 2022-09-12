Pod::Spec.new do |s|
  s.name         = "SwiftDate"
  s.version      = "7.0.0"
  s.summary      = "The best way to deal with Dates & Time Zones in Swift"
  s.homepage     = "https://github.com/malcommac/SwiftDate.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Daniele Margutti" => "hello@danielemargutti.com" }
  s.social_media_url   = "https://twitter.com/danielemargutti"
  s.ios.deployment_target = "13.0"
  s.osx.deployment_target = "10.15"
  s.watchos.deployment_target = "6.0"
  s.tvos.deployment_target = "13.0"
  s.source       = { :git => "https://github.com/malcommac/SwiftDate.git", :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
  s.frameworks  = "Foundation"
  s.swift_versions = ['5.5']
end
