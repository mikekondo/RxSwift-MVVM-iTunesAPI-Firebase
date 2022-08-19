//
//  MusicLoadDB.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/12.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class MusicLoadDB {
    func fetchFavMusicFromFirestore(completion: @escaping([Song]) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Songs").whereField("uid", isEqualTo: "\(uid)").getDocuments { snapShot, error in
            if let error = error {
                print("Firestore、お気に入り楽曲の取得、失敗",error)
            }
            print("Firestore、お気に入り楽曲の取得、成功")
            var songs = [Song]()
            snapShot?.documents.forEach({ snapShot in
                let data = snapShot.data()
                let song = Song(artistName: data["artistName"] as? String ?? "",
                                trackName: data["trackName"] as? String ?? "",
                                artworkUrl100: data["artworkUrl100"] as? String ?? "",
                                releaseDate: data["releaseDate"] as? String ?? "")
                songs.append(song)
            })
            completion(songs)
        }
    }
}
