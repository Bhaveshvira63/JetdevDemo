//
//  LoginViewModel.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 09/12/22.
//

import Foundation
import RxSwift
import RxCocoa
//import Moya

protocol LoginViewModelProtocol {
    
    var email: AnyObserver<String?> { get }
    var password: AnyObserver<String?> { get }
    var isValid: PublishSubject<(Bool)> { get }
    var showAlertMessage: PublishSubject<(String?)> { get }
    var loggedin: PublishSubject<Bool?> { get }
    
    func makeLogin()
    
}
class LoginViewModel: LoginViewModelProtocol {
    
    var email: AnyObserver<String?> { return emailChangeSubject.asObserver() }
    var password: AnyObserver<String?> { return passwordChangeSubject.asObserver() }
    private let emailChangeSubject = PublishSubject<String?>()
    private let passwordChangeSubject = PublishSubject<String?>()
    var isValid: PublishSubject<(Bool)> = PublishSubject<Bool>()
    var showAlertMessage = PublishSubject<String?>()
    var loggedin = PublishSubject<Bool?>()
    
    private var emailString: String = ""
    private var passwordString: String = ""
    var disposeBag = DisposeBag()
    
    init() {
        emailChangeSubject
            .subscribe(onNext: {[weak self]  emailText in
                self?.emailString = emailText ?? ""
                self?.isValidateForm()
                self?.showAlertMessage.onNext("")
            }).disposed(by: disposeBag)
        passwordChangeSubject.subscribe(onNext: {[weak self]  passwordText in
            self?.passwordString = passwordText ?? ""
            self?.showAlertMessage.onNext("")
            self?.isValidateForm()
        }).disposed(by: disposeBag)
    }
    
    func makeLogin() {
        let loginModel: LoginModel = LoginModel(email: emailString, password: passwordString)
        LoginDataRepository().login(data: loginModel)
            .subscribe({ [weak self] response in
                guard let self = self else {
                    return
                }
                switch response {
                case let .next(data):
                    print(data)
                    if data.result == 1 {
                        if let user = try? JSONEncoder().encode(data.data.user) {
                            let jsonUser = String(data: user, encoding: String.Encoding.utf16)
                            UserDefaults.standard.set(user, forKey: "profile_data")
                            UserDefaults.standard.set(true, forKey: "is_login")
                            self.loggedin.onNext(true)
                        }
                    } else {
                        self.showAlertMessage.onNext(data.errorMessage)
                        UserDefaults.standard.set(false, forKey: "is_login")
                        
                    }
                case let .error(error):
                    UserDefaults.standard.set(false, forKey: "is_login")
                case .completed:
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    func isValidateForm() {
        
        if emailString != "", passwordString != "" {
            isValid.onNext(true)
        } else {
            isValid.onNext(false)
        }
    }
    
}
