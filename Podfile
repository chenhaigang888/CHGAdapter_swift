platform :ios, '8.0'
workspace 'CHGAdapter_swift.xcworkspace'

target "CHGAdapter_swift" do

use_frameworks!

#pod 'DZNEmptyDataSet', :modular_headers => true
pod 'EmptyDataSet-Swift', '~> 4.2.0'

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
         end
    end
  end
end
