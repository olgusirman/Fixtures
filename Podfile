platform :ios, '16.4'

def testPods
    pod 'RxBlocking'
    pod 'RxTest'
end

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
  pod 'Moya/RxSwift'
end

target 'Fixtures' do
  use_frameworks!
  rxPods
  servicePods
  uiPods
end

target 'FixturesTests' do
  use_frameworks!
  rxPods
  servicePods
  uiPods
  testPods
end

