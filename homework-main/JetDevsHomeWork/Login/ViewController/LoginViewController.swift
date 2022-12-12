//
//  LoginViewController.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 09/12/22.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblErrorMessage: UILabel!
    var viewModel: LoginViewModelProtocol? = LoginViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subcriberAdd()
        self.loginButton(enable: false)
    }
    func loginButton(enable: Bool) {
        self.btnLogin.isEnabled = enable
        if enable {
            self.btnLogin.alpha = 1.0
            self.btnLogin.setBackgroundImage(UIImage.init(named: "button_enable"), for: .normal)
        } else {
            self.btnLogin.alpha = 0.4
            self.btnLogin.setBackgroundImage(UIImage.init(named: "button_disable"), for: .normal)
        }
    }
    
    func subcriberAdd() {
        guard let viewModel = viewModel else {
            return
        }
        txtEmail.rx.text
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        txtPassword.rx.text
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        viewModel.isValid.subscribe(onNext: {[weak self]  valid in
            print(valid)
            DispatchQueue.main.async {
                self?.loginButton(enable: valid)
            }
        }).disposed(by: disposeBag)
        
        viewModel.showAlertMessage.subscribe(onNext: {[weak self]  alertMessage in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                
                self?.lblErrorMessage.text = alertMessage
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.loggedin.subscribe(onNext: {[weak self] login in
            if login ?? false {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self?.dismiss(animated: true)
                }
            }
        }
        ).disposed(by: disposeBag)
        
        btnLogin.rx.tap.bind { [weak self] _ in
            SVProgressHUD.show()
            self?.viewModel?.makeLogin()
        }.disposed(by: disposeBag)
        
        btnDismiss.rx.tap.bind { [weak self] _ in
            self?.dismiss(animated: true)
            SVProgressHUD.dismiss()
        }.disposed(by: disposeBag)
    }
}
