//
//  SearchMusicViewController.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/09.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchMusicViewController: UIViewController {

    // MARK: UI Parts
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()

    let searchMusicViewModel = SearchMusicViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    private func setupBindings(){
        let searchMusicViewModelInput = SearchMusicViewModelInput(searchTextFieldObservable: searchTextField.rx.text.map{$0 ?? ""}.asObservable())
        searchMusicViewModel.setup(input: searchMusicViewModelInput)

        let musicDataSource = MusicTableViewDataSource()
        searchMusicViewModel.pushMusic
            .bind(to: tableView.rx.items(dataSource: musicDataSource))
            .disposed(by: disposeBag)
    }

    private func setupTableView(){
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: MusicTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MusicTableViewCell.identifier)

        // セルの選択時にSelectedMusicDataVCに遷移
        tableView.rx.itemSelected.subscribe(onNext: {[weak self] indexPath in
            guard let selectedMusic = self?.searchMusicViewModel.fetchSelectedMusic(index: indexPath.row) else { return }
            let selectedMusicDataViewController = SelectedMusicDataViewController()
            selectedMusicDataViewController.selectedMusic = selectedMusic
            self?.navigationController?.pushViewController(selectedMusicDataViewController, animated: true)

        })
        .disposed(by: disposeBag)

    }


}
