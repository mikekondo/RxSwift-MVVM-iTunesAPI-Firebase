//
//  LoginViewModel.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/09.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: Input
struct LoginViewModelInput{
    var nameTextFieldObservable: Observable<String>
    var emailTextFieldObservable: Observable<String>
    var passwordTextFieldObservable: Observable<String>
    var signUpButtonObservable: Observable<Void>
}

protocol LoginViewModelOutput{
    var isEnableButtonObservable: PublishSubject<Bool> { get }
}

class LoginViewModel{
    // MARK: Output
    let isEnableButtonObservable = PublishSubject<Bool>()

    let sendDB = SendDB()
    let disposeBag = DisposeBag()

    func setup(input: LoginViewModelInput){

        let combine = Observable.combineLatest(input.nameTextFieldObservable, input.emailTextFieldObservable, input.passwordTextFieldObservable)

        // ボタンがすべて1文字以上であれば、ボタンを有効にする
        combine.subscribe(onNext: { [weak self] text1,text2,text3 in
            if !text1.isEmpty && !text2.isEmpty && !text3.isEmpty{
                self?.isEnableButtonObservable.onNext(true)
            }else{
                self?.isEnableButtonObservable.onNext(false)
            }
        })
        .disposed(by: disposeBag)

        input.nameTextFieldObservable.subscribe(onNext: { [weak self] nameText in
            print(nameText)
        })
        .disposed(by: disposeBag)

        input.emailTextFieldObservable.subscribe(onNext: { [weak self] emailText in
            print(emailText)
        })
        .disposed(by: disposeBag)

        input.passwordTextFieldObservable.subscribe(onNext: {[weak self] passwordText in
            print(passwordText)
        })
        .disposed(by: disposeBag)

        // ボタンを押した時にアカウント作成を行う
        input.signUpButtonObservable.subscribe (onNext: { [weak self] in
            combine.subscribe (onNext: { name,email,password in
                self?.sendDB.createUserFireStore(name: name, email: email, password: password)
            })
        })
        .disposed(by: disposeBag)

    }
}
