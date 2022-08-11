//
//  MainTabViewController.swift
//  RxSwift-MVVM-iTunesAPI
//
//  Created by 近藤米功 on 2022/08/09.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initTabBar()
    }

    private func initTabBar(){
        let searchMusicVC = SearchMusicViewController()
        searchMusicVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let searchMusicNVC = UINavigationController(rootViewController: searchMusicVC)

        let myFavoriteMusicVC = MyFavoriteMusicViewController()
        myFavoriteMusicVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let myFavoriteMusicNVC = UINavigationController(rootViewController: myFavoriteMusicVC)

        let favoriteMusicListVC = FavoriteMusicListViewController()
        favoriteMusicListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        let favoriteMusicListNVC = UINavigationController(rootViewController: favoriteMusicListVC)

        let loginVC = LoginViewController()
        loginVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        let loginNVC = UINavigationController(rootViewController: loginVC)

        setViewControllers([searchMusicNVC, myFavoriteMusicNVC, favoriteMusicListNVC, loginNVC], animated: false)
    }

}
