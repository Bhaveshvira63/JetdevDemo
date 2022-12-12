//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import Kingfisher
import RxSwift

class AccountViewController: UIViewController {

	@IBOutlet weak var nonLoginView: UIView!
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var headImageView: UIImageView!
    
    var viewModel: AccountViewModelProtocol? = AccountViewModel()
    var disposeBag = DisposeBag()
    
	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
		nonLoginView.isHidden = false
		loginView.isHidden = false
        subcriberAdd()
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "is_login") == false {
            nonLoginView.isHidden = false
            loginView.isHidden = true
        } else {
            nonLoginView.isHidden = true
            loginView.isHidden = false
            viewModel?.getData()
        }
    }
	
	@IBAction func loginButtonTap(_ sender: UIButton) {
        let obj = LoginViewController()
         
            obj.modalPresentationStyle = .fullScreen
            self.present(obj, animated: true)
	}
    
    func subcriberAdd() {
        viewModel?.setData.subscribe(onNext: {[weak self]  user in
            if let url = URL(string: user?.userProfileURL ?? "") {
                self?.headImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "Avatar"))
            }
            self?.nameLabel.text = user?.userName
            self?.daysLabel.text = self?.viewModel?.getCreatedDateStyle(createdAt:   user?.createdAt ?? "")
        }).disposed(by: disposeBag)
    }
}
