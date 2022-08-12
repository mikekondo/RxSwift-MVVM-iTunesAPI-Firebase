//
//  MusicSendDB.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/12.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MusicSendDB{

    func favMusicToFirestore(selectedMusicData: Song){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let document = [
            "artistName": selectedMusicData.artistName,
            "trackName": selectedMusicData.trackName,
            "artworkUrl100": selectedMusicData.artworkUrl100,
            "uid": uid,
            "releaseDate": selectedMusicData.releaseDate,
            "updateAt": Timestamp()
        ] as [String : Any]

        // Firestoreに楽曲情報を保存
        Firestore.firestore().collection("Songs").document().setData(document) { error in
            if let error = error {
                print("楽曲情報、Firestore送信、失敗",error)
                return
            }
            print("楽曲情報、Firestore送信、成功")
        }

    }
}
