require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'CapacitorAppLauncher'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.homepage = 'https://capacitorjs.com'
  s.author = package['author']
  s.source = { :git => 'https://github.com/programic/capacitor-plugins.git', :tag => package['name'] + '@' + package['version'] }
  s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}', 'app-launcher/ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
  s.ios.deployment_target  = '12.0'
  s.dependency 'Capacitor'
  s.swift_version = '5.1'
end
