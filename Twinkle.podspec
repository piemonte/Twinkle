Pod::Spec.new do |s|
  s.name = 'Twinkle'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'a Swift and easy way to make elements in your iOS app twinkle''
  s.homepage = 'https://github.com/piemonte/twinkle'
  s.social_media_url = 'http://twitter.com/piemonte'
  s.authors = { 'patrick piemonte' => "piemonte@alumni.cmu.edu" }
  s.source = { :git => 'https://github.com/piemonte/twinkle.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/*.swift'
  s.resources = 'Source/Resources/*.png'
  s.requires_arc = true
end
