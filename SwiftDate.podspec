Pod::Spec.new do |spec|
  spec.name = 'SwiftDate'
  spec.version = '1.2'
  spec.summary = 'Swift library to easily manage NSDate objects (swift-2.0 is the branch for swift 2.0 compatibility version)'
  spec.homepage = 'https://github.com/malcommac/SwiftDate'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Daniele Margutti' => 'me@danielemargutti.com' }
  spec.social_media_url = 'http://twitter.com/danielemargutti'
  spec.source = { :git => 'https://github.com/malcommac/SwiftDate.git', :tag => "#{spec.version}" }
  spec.source_files = 'SwiftDate/*.swift'
  spec.ios.deployment_target = '8.0'
  spec.watchos.deployment_target = '2.0'
  spec.osx.deployment_target = '10.9'
  spec.tvos.deployment_target = '9.0'
  spec.requires_arc = true
  spec.module_name = 'SwiftDate'
end
