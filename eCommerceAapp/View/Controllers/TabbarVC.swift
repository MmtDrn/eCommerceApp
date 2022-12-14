//
//  TabbarVC.swift
//  InstaClone
//
//  Created by mehmet duran on 7.10.2022.
//

import UIKit

enum TabbarItem:Int {
    case Home
    case Search
    case Basket
    case Settings
    
    
    var title:String {
        switch self {
        case .Home: return "Home"
        case .Search: return "Search"
        case .Basket: return "Basket"
        case .Settings: return "Settings"
        }
    }
    
    var icon:UIImage {
        switch self {
        case .Home: return UIImage(systemName: "homekit") ?? .add
        case .Search: return UIImage(systemName: "magnifyingglass") ?? .add
        case .Basket: return UIImage(systemName: "cart") ?? .add
        case .Settings: return UIImage(systemName: "gearshape") ?? .add
        }
    }
    
    var viewController:UIViewController {
        switch self {
        case .Home: return HomeVC(viewModel: NetworkViewModel(services: NetworkServices()))
        case .Search: return SearchVC(viewModel: NetworkViewModel(services: NetworkServices()), coreDataViewModel: CoreDataViewModel(coreDataServices: CoreDataServices()))
        case .Basket: return BasketVC(viewModel: CoreDataViewModel(coreDataServices: CoreDataServices()))
        case .Settings: return SettingsVC()
        }
    }
}

final class TabbarController:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabbar()
    }
    
    private func configureTabbar() {
        tabBar.tintColor = .label
        
        let homeVC = UINavigationController(rootViewController: TabbarItem.Home.viewController)
        let searchVC = UINavigationController(rootViewController: TabbarItem.Search.viewController)
        let cartVC = UINavigationController(rootViewController: TabbarItem.Basket.viewController)
        let settingsVC = UINavigationController(rootViewController: TabbarItem.Settings.viewController)
        
        homeVC.tabBarItem = UITabBarItem(title: TabbarItem.Home.title, image: TabbarItem.Home.icon, tag: TabbarItem.Home.rawValue)
        searchVC.tabBarItem = UITabBarItem(title: TabbarItem.Search.title, image: TabbarItem.Search.icon, tag: TabbarItem.Search.rawValue)
        cartVC.tabBarItem = UITabBarItem(title: TabbarItem.Basket.title, image: TabbarItem.Basket.icon, tag: TabbarItem.Basket.rawValue)
        settingsVC.tabBarItem = UITabBarItem(title: TabbarItem.Settings.title, image: TabbarItem.Settings.icon, tag: TabbarItem.Settings.rawValue)
        
        viewControllers = [homeVC,searchVC,cartVC,settingsVC]
    }
    
}
