Pod::Spec.new do |s|
  
  s.name             = 'WZPickerView'
  s.version          = '2.0.4'
  s.summary          = '我主良缘WZPickerView'
  
  s.description      = <<-DESC
  我主良缘WZPickerView选择弹窗
  DESC
  
  s.homepage         = 'https://github.com/WZLYiOS/WZPickerView'
  s.license          = 'MIT'
  s.author           = { 'xiaobin liu'=> '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/WZPickerView.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.static_framework = true
  s.swift_version         = '5.0'
  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Source'
  
  s.subspec 'Source' do |ss|
    ss.source_files = 'WZPickerView/Classes/*'
  end


#  s.subspec 'Binary' do |ss|
#    ss.vendored_frameworks = "Carthage/Build/iOS/Static/WZPickerView.framework"
#    ss.user_target_xcconfig = { 'LIBRARY_SEARCH_PATHS' => '$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)' }
#  end
end
