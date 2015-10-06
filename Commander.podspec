Pod::Spec.new do |spec|
  spec.name = 'Commander'
  spec.version = '0.2.2'
  spec.summary = 'Compose beautiful command line interfaces'
  spec.homepage = 'https://github.com/kylef/Commander'
  spec.license = { :type => 'BSD', :file => 'LICENSE' }
  spec.author = { 'Kyle Fuller' => 'kyle@fuller.li' }
  spec.social_media_url = 'http://twitter.com/kylefuller'
  spec.source = { :git => 'https://github.com/kylef/Commander.git', :tag => spec.version }
  spec.source_files = 'Commander/*.{h,swift}'
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.9'
  spec.requires_arc = true
end

