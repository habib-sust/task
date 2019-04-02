# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

def sharedPods
    pod 'RealmSwift'
end

target 'Task' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Task
   pod 'Kingfisher', '~> 5.0'
   sharedPods

  target 'TaskTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
    pod 'Quick'
    pod 'Nimble'
  end

  target 'WatchDemo Extension' do 
   platform :watchos, '2.0'
     sharedPods
  end

end
