//
//  HomeTabBarViewController.swift
//  pp-first-demo-project
//
//  Created by Deepak Kumar1 on 16/01/23.
//

import UIKit

class MasterTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.navigationBar.tintColor = .purple
//        navigationController?.isNavigationBarHidden = true
//        title = "Netflix clone"
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: vc2())
        let vc3 = UINavigationController(rootViewController: vc3())
        let vc4 = UINavigationController(rootViewController: vc4())
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Downloads"

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        self.tabBar.tintColor = .red
        tabBar.barTintColor = .white
        
//        let appearance = UITabBarAppearance()
//        appearance.backgroundColor = .green
//        appearance.backgroundImage = UIImage()
//        tabBar.standardAppearance = appearance
        
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
        
    }
   
    
    
    
    

}

class vc1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .lightGray
    }
}
class vc2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemPink
    }
}
class vc3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemCyan
    }
}
class vc4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemMint
    }
}
