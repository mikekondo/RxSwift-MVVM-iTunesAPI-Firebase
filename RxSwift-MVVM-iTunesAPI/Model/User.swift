//
//  User.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/12.
//

import Foundation

class User{
    var createAt: String
    var email: String
    var password: String
    var updateAt: String
    var userName: String
    var uuid: String

    init(dic: [String: Any]) {
        self.createAt = dic["createAt"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.password = dic["password"] as? String ?? ""
        self.updateAt = dic["updateAt"] as? String ?? ""
        self.userName = dic["userName"] as? String ?? ""
        self.uuid = dic["uuid"] as? String ?? ""
    }

}
