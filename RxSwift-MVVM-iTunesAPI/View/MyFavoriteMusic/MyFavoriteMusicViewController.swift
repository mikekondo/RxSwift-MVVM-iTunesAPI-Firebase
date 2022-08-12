//
//  MyFavoriteMusicViewController.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/09.
//

import UIKit
import RxSwift
import RxCocoa

final class MyFavoriteMusicViewController: UIViewController {
    @IBOutlet private weak var displayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let myFavoriteMusicViewModel = MyFavoriteMusicViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    private func setupBindings(){
        myFavoriteMusicViewModel.setup()

        let favMusicDataSource = FavMusicTableViewDataSource()
        myFavoriteMusicViewModel.favMusicPushSubject
            .bind(to: tableView.rx.items(dataSource: favMusicDataSource))
            .disposed(by: disposeBag)

        myFavoriteMusicViewModel.userSubject.subscribe(onNext: {[weak self] user in
            self?.displayLabel.text = "\(user.userName)さんのお気に入り"
        })
        .disposed(by: disposeBag)
    }

    private func setupTableView(){
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: FavMusicTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: FavMusicTableViewCell.identifier)
    }

}
