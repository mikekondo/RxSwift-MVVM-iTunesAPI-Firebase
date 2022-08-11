//
//  SendDB.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/09.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SendDB {
    let db = Firestore.firestore()
    func createUserFireStore(name: String,email: String,password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("アカウント作成のエラー",error)
            }
            print("アカウント作成成功")
            // Firestoreにユーザ情報を送る
            guard let uuid = Auth.auth().currentUser?.uid else { return }
            
            let document = [
                "userName": name,
                "email": email,
                "password": password,
                "uuid": uuid,
                "createAt": Timestamp(),
                "updateAt": Timestamp()
            ] as [String : Any]

            self.db.collection("Users").document(String(uuid)).setData(document) { error in
                if let error = error {
                    print("Firestoreにアカウント情報を保存できませんでした",error)
                }
                print("Firestoreにアカウント情報を保存しました")
            }
        }
    }
}
