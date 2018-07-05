platform :ios, '8.0'
workspace 'CHGAdapter_swift.xcworkspace'

target "CHGAdapter_swift" do

use_frameworks!
use_modular_headers!

pod 'DZNEmptyDataSet', :modular_headers => true

pre_install do |installer|
    
    Pod::PodTarget.send(:define_method, :static_framework?) { return true }
end

end
