//
//  LoginViewController.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/09.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!

    private let disposeBag = DisposeBag()

    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        signUpButton.isEnabled = false
    }

    private func setupBindings(){
        let input = LoginViewModelInput(nameTextFieldObservable: nameTextField.rx.text.map{ $0 ?? ""}.asObservable(), emailTextFieldObservable: emailTextField.rx.text.map{$0 ?? ""}.asObservable(), passwordTextFieldObservable: passwordTextField.rx.text.map{$0 ?? ""}.asObservable(), signUpButtonObservable: signUpButton.rx.tap.asObservable())
        loginViewModel.setup(input: input)

        // 名前、メールアドレス、パスワードがすべて一文字以上であればボタンを有効にする
        loginViewModel.isEnableButtonObservable.subscribe(onNext: {[weak self] buttonFlag in
            self?.signUpButton.isEnabled = buttonFlag
        })
        .disposed(by: disposeBag)

    }



}
