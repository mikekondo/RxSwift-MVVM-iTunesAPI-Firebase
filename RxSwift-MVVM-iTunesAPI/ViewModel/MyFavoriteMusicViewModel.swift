//
//  MyFavoriteMusicViewModel.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/12.
//

import RxSwift
import RxCocoa

// Input
struct MyFavoriteMusicViewModelInput{

}

// Output
protocol MyFavoriteMusicViewModelOutput{
    var userSubject: PublishSubject<User> { get }
    var favMusicPushSubject: BehaviorRelay<[Song]> { get }
}

class MyFavoriteMusicViewModel: MyFavoriteMusicViewModelOutput{
    var favMusicPushSubject = BehaviorRelay<[Song]>(value: [])
    var userSubject = PublishSubject<User>()

    let userLoadDB = UserLoadDB()
    let musicLoadDB = MusicLoadDB()

    func setup(){
        // ユーザ情報の取得
        userLoadDB.fetchUserFromFirestore { user in
            self.userSubject.onNext(user)
        } error: { error in
            print(error)
            return
        }

        // お気に入り楽曲情報の取得
        musicLoadDB.fetchFavMusicFromFirestore { songs in
            self.favMusicPushSubject.accept(songs)
        }
    }

}
