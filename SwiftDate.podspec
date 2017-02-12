Pod::Spec.new do |spec|
  spec.name = 'SwiftDate'
  spec.version = '4.0.13'
  spec.summary = 'The best way to deal with Dates & Time Zones in Swift'
  spec.homepage = 'https://github.com/malcommac/SwiftDate'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Daniele Margutti' => 'me@danielemargutti.com' }
  spec.social_media_url = 'http://twitter.com/danielemargutti'
  spec.source = { :git => 'https://github.com/malcommac/SwiftDate.git', :tag => "#{spec.version}" }
  spec.source_files = 'Sources/**/*.swift'
  spec.ios.deployment_target = '8.0'
  spec.watchos.deployment_target = '2.0'
  spec.osx.deployment_target = '10.10'
  spec.tvos.deployment_target = '9.0'
  spec.requires_arc = true
  spec.module_name = 'SwiftDate'
  spec.resource = 'Sources/SwiftDate/SwiftDate.bundle'
end
