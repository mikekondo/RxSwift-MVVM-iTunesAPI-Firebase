//
//  LoadDB.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/09.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UserLoadDB {
    func fetchUserFromFirestore(completion: @escaping(User) -> (),error: @escaping(Error) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Users").document(uid).getDocument { snapShot, error in
            if let error = error {
                print("Firestore、ユーザ情報の取得、失敗",error)
            }
            print("Firestore、ユーザ情報の取得、成功")
            guard let data = snapShot?.data() else { return }
            let user = User(dic: data)
            completion(user)
        }
    }
}
