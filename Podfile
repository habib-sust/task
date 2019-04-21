# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'Task' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Task
   pod 'Kingfisher', '~> 5.0'
   pod 'RealmSwift'
   pod 'SwiftLint'
   pod 'OpenSSL-Static', '1.0.2.c1'
   
  target 'TaskTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
    pod 'Quick'
    pod 'Nimble'
    pod 'SwiftLint'
  end

  target 'WatchDemo Extension' do 
   use_frameworks!
   platform :watchos, '4.0'
   # Pods for Watch
   pod 'RealmSwift'
   pod 'SwiftLint'
  end

 post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
 end

end
