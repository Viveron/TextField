#
# Be sure to run `pod lib lint TextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TextField'
  s.version          = '1.0.7'
  s.summary          = 'Extended version of UITextField.'

  s.description      = <<-DESC
Extended version of UITextField. Lightweight implementation with helpful additional elements and objects.
                       DESC

  s.homepage         = 'https://github.com/viveron/TextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'viveron' => 'shabanov.dev.git@gmail.com' }
  s.source           = { :git => 'https://github.com/viveron/TextField.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  
  s.source_files = 'TextField/Classes/**/*'
end
