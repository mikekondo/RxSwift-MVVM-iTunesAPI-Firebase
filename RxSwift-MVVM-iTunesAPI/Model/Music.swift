//
//  Music.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/11.
//

import Foundation

struct Songs: Codable{
    let results: [Song]
}

struct Song: Codable{
    let artistName: String
    let trackName: String
    let artworkUrl100: String
}

class Music{
    func fetchMusicData(url: URL,completion: @escaping([Song]) -> Void){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("urlの取得に失敗しました",error)
                return
            }
            guard let data = data else {
                print("dataの取得に失敗しました")
                return
            }
            do{
                let songs = try JSONDecoder().decode(Songs.self, from: data)
                completion(songs.results)
            }catch(let error){
                print("音楽情報を取得できませんでした",error)
            }
        }
        task.resume()
    }
}
