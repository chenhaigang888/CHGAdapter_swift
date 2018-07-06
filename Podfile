platform :ios, '8.0'
workspace 'CHGAdapter_swift.xcworkspace'

target "CHGAdapter_swift" do

use_frameworks!

pod 'DZNEmptyDataSet', :modular_headers => true

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end

end
