Pod::Spec.new do |s|
  s.name = 'Twinkle'
  s.version = '0.6.0'
  s.license = 'MIT'
  s.summary = 'Swift and easy way to make elements in your iOS or tvOS app twinkle'
  s.homepage = 'https://github.com/piemonte/twinkle'
  s.social_media_url = 'http://twitter.com/piemonte'
  s.authors = { 'patrick piemonte' => "patrick.piemonte@gmail.com" }
  s.source = { :git => 'https://github.com/piemonte/twinkle.git', :tag => s.version }
  s.ios.deployment_target = '15.0'
  s.tvos.deployment_target = '15.0'
  s.source_files = 'Sources/*.swift'
  s.resources = 'Sources/Resources/*.png'
  s.requires_arc = true
  s.swift_version = '5.9'
  s.screenshot = "https://raw.github.com/piemonte/Twinkle/master/twinkle.gif"
end
