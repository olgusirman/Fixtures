platform :ios, '12.0'

def rxPods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
    pod 'Action'
end

def uiPods
    pod 'Nuke'
end

def servicePods
  pod 'Moya/RxSwift', '~> 14.0.0-beta.6'
end

target 'Fixtures' do
  use_frameworks!
  rxPods
  servicePods
  uiPods
end