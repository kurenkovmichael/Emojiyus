#
# Be sure to run `pod lib lint Emojiyus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name             = 'Emojiyus'
  s.version          = '0.1.0'
  s.summary          = 'Helper class for replacing text smileys to Emoji.'

  s.homepage         = 'https://github.com/kurenkovmichael/Emojiyus'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mikhail Kurenkov' => 'kurenkovmichael@gmil.com' }
  s.source           = { :git => 'https://github.com/kurenkovmichael/Emojiyus.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Emojiyus/Classes/**/*'
  
end
