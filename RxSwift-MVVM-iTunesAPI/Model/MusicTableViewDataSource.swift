//
//  MusicTableViewDataSource.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/11.
//

import RxSwift
import RxCocoa
import SDWebImage
import UIKit

final class MusicTableViewDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType{

    typealias Element = [Song]
    var songs: [Song] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.identifier, for: indexPath) as! MusicTableViewCell
        let element = songs[indexPath.row]
        cell.artistNameLabel.text = element.artistName
        cell.trackNameLabel.text = element.trackName
        cell.artWorkImageView.sd_setImage(with: URL(string: element.artworkUrl100))
        return cell
    }

    func tableView(_ tableView: UITableView, observedEvent: Event<[Song]>) {
        Binder(self){ dataSource, element in
            dataSource.songs = element
            tableView.reloadData()
        }
        .on(observedEvent)
    }
}
