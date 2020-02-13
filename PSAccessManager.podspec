#
#  Be sure to run `pod spec lint PSAccessManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name = 'PSAccessManager'
  spec.version = '0.1.0'
  spec.summary = 'Access with touch/face id in 4 lines :)'
  spec.homepage = 'https://github.com/sergey-prikhodko/PSAccessManager'
  spec.license = 'MIT'

  spec.author = { 'Sergey Prikhodko' => 'sergey.prikhodko.95@gmail.com' }
  # spec.social_media_url   = "https://twitter.com/Sergey Prikhodko"
  # spec.platform     = :ios
  spec.platform = :ios, '11.0'
  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  spec.source = { :git => 'https://github.com/sergey-prikhodko/PSAccessManager.git', :tag => spec.version }
  spec.swift_version = ['5.0', '5.1']
  spec.source_files  = 'Source/*.swift'
  # spec.exclude_files = "Classes/Exclude"

end
