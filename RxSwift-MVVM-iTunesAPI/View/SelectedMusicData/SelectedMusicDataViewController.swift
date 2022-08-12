//
//  MusicDataViewController.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/12.
//

import UIKit
import PKHUD

class SelectedMusicDataViewController: UIViewController {

    @IBOutlet private weak var artWorkImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var favButton: UIButton!

    private let selectedMusicDataViewModel = SelectedMusicDataViewModel()
    var selectedMusic: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedMusic = selectedMusic else {
            return
        }
        setupMusicData(selectedMusic: selectedMusic)
        setupBindings(selectedMusic: selectedMusic)
    }

    private func setupMusicData(selectedMusic: Song){
        artWorkImageView.sd_setImage(with: URL(string: selectedMusic.artworkUrl100))
        trackNameLabel.text = selectedMusic.trackName
        artistNameLabel.text = selectedMusic.artistName
        releaseDateLabel.text = selectedMusic.releaseDate
    }

    private func setupBindings(selectedMusic: Song){
        let input = SelectedMusicDataViewModelInput(favButtonObservable: favButton.rx.tap.asObservable())
        selectedMusicDataViewModel.setup(input: input, selectedMusicData: selectedMusic)
    }

}
