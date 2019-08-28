platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!

def shared_pods
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'IQKeyboardManagerSwift'
  pod 'PhoneNumberKit'
  pod 'RealmSwift'
  pod 'PromiseKit'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRealm'
  pod 'DifferenceKit'
end

target 'UserList' do
  shared_pods
  
  target 'UserListTests' do
    pod 'RxTest'
    pod 'RxBlocking'
  end
  
end


