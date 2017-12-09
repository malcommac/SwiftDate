Pod::Spec.new do |s|
  s.name         = "SwiftDate"
  s.version      = "4.5.1"
  s.summary      = "The best way to deal with Dates & Time Zones in Swift"
  s.homepage     = "https://github.com/malcommac/SwiftDate"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Daniele Margutti" => "me@danielemargutti.com" }
  s.social_media_url   = "http://twitter.com/danielemargutti"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/malcommac/SwiftDate.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*.swift"
  s.frameworks  = "Foundation"
  s.requires_arc = true
  s.module_name = 'SwiftDate'
  s.resource = 'Sources/SwiftDate/SwiftDate.bundle'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
