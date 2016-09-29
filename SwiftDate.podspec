Pod::Spec.new do |spec|
  spec.name = 'SwiftDate'
  spec.version = '3.0.9'
  spec.summary = 'Swift library to easily manage dates; also with varying time zones, calendars and locales'
  spec.homepage = 'https://github.com/malcommac/SwiftDate'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Daniele Margutti' => 'me@danielemargutti.com' }
  spec.social_media_url = 'http://twitter.com/danielemargutti'
  spec.source = { :git => 'https://github.com/malcommac/SwiftDate.git', :tag => "#{spec.version}" }
  spec.source_files = 'Sources/SwiftDate/*.swift'
  spec.ios.deployment_target = '8.0'
  spec.watchos.deployment_target = '2.0'
  spec.osx.deployment_target = '10.10'
  spec.tvos.deployment_target = '9.0'
  spec.requires_arc = true
  spec.module_name = 'SwiftDate'
end
