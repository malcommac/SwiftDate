Pod::Spec.new do |spec|
  spec.name = 'SwiftDate'
  spec.version = '1.0.7'
  spec.summary = 'Swift (1.2+) library to easily manage NSDate objects'
  spec.homepage = 'https://github.com/malcommac/SwiftDate'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Daniele Margutti' => 'me@danielemargutti.com' }
  spec.social_media_url = 'http://twitter.com/danielemargutti'
  spec.source = { :git => 'https://github.com/malcommac/SwiftDate.git', :tag => "#{spec.version}" }
  spec.source_files = 'SwiftDate/*.swift'
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.9'
  spec.requires_arc = true
  spec.module_name = 'SwiftDate'
end

