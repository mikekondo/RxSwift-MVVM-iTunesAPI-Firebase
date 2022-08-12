//
//  SelectedMusicDataViewModel.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/12.
//

import RxSwift
import RxCocoa

// Input
struct SelectedMusicDataViewModelInput{
    var favButtonObservable: Observable<Void>
}

// Output
protocol SelectedMusicDataViewModelOutput{
}

class SelectedMusicDataViewModel: SelectedMusicDataViewModelOutput{

    // TODO: なんかここで空で定義するのは違う気がする。。
    var selectedMusicData = Song(artistName: "", trackName: "", artworkUrl100: "", releaseDate: "")

    var musicSendDB = MusicSendDB()

    let disposeBag = DisposeBag()

    func setup(input: SelectedMusicDataViewModelInput,selectedMusicData: Song){
        self.selectedMusicData = selectedMusicData

        // お気に入りボタンをタップした時にFirestoreに楽曲情報を保存する
        input.favButtonObservable.subscribe(onNext: {[weak self] in
            self?.musicSendDB.favMusicToFirestore(selectedMusicData: selectedMusicData)
        })
        .disposed(by: disposeBag)
    }

}
