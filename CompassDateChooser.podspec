#
# Be sure to run `pod lib lint CompassDateChooser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CompassDateChooser'
  s.version          = '0.0.2'
  s.summary          = 'A date picker for date choosing.'
  s.swift_versions   = '4.0'

  s.description      = <<-DESC
  'Compass date chooser is a lib aimed to use in our travel order project -> Compass. If there are any bugs, please contact us.'
                       DESC

  s.homepage         = 'https://github.com/kiraclf/compassDateChooser'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kiraclf' => 'kiraclf@outlook.com' }
  s.source           = { :git => 'https://github.com/kiraclf/compassDateChooser.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'CompassDateChooser/Classes/**/*'
  
  s.frameworks = 'UIKit'
  s.dependency 'SnapKit', '~> 5.0.1'
end
