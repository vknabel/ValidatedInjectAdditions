Pod::Spec.new do |s|
  s.name             = "ValidatedInjectAdditions"
  s.version          = "0.1.1"
  s.summary          = "Adds convenience when using ValidatedExtension and EasyInject"
  s.description      = <<-DESC
                        ValidatedExtension-EasyInject is a μ-library that adds convenience methods to EasyInject and ValidatedExtension.
                        DESC
  #s.homepage         = "https://vknabel.github.io/ValidatedInjectAdditions"
  s.homepage         =  "https://github.com/vknabel/ValidatedInjectAdditions"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Valentin Knabel" => "develop@vknabel.com" }
  s.social_media_url = "https://twitter.com/vknabel"
  s.source           = { :git => "https://github.com/vknabel/ValidatedInjectAdditions.git", :tag => s.version.to_s }
  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true
  s.source_files     = 'Sources/**/*.swift'
  s.dependency 'EasyInject', '~> 0.5'
  s.dependency 'ValidatedExtension', '~> 3.0'
end
