//
//  SearchMusicViewModel.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/11.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: Input
struct SearchMusicViewModelInput{
    var searchTextFieldObservable: Observable<String>
}

// MARK: Output
protocol SearchMusicViewModelOutput{
    var pushMusic: BehaviorRelay<[Song]> { get }
}

final class SearchMusicViewModel: SearchMusicViewModelOutput{
    var pushMusic = BehaviorRelay<[Song]>(value: [])

    private var music = Music()

    let disposeBag = DisposeBag()

    func setup(input: SearchMusicViewModelInput){
        input.searchTextFieldObservable.subscribe(onNext: {[weak self] text in
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(text)&entity=song&contry=jp") else { return }
            self?.music.fetchMusicData(url: url) { songs in
                self?.pushMusic.accept(songs)
            }
        })
        .disposed(by: disposeBag)
    }
}
