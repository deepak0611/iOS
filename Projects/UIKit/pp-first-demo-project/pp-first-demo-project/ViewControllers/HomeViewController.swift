//
//  HomeViewController.swift
//  pp-first-demo-project
//
//  Created by Deepak Kumar1 on 16/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Movies", "Popular", "Trending Tv", "Upcoming Movies", "Top Rated"]
    
    private let homeFeedTable: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.reusableIdentifier)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        addGradient()
        setupNavBarAppearance()
        setupNavBar()
        view.backgroundColor = .clear
        view.addSubview(homeFeedTable)
        
        homeFeedTable.dataSource = self
        homeFeedTable.delegate = self
        
        let tableHeaderView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = tableHeaderView
        
        getTrendingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
   
    
    private func setupNavBarAppearance() {
        let navigationBarAppearace = UINavigationBarAppearance()
        navigationBarAppearace.backgroundColor = .systemCyan
        navigationBarAppearace.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearace.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        
        let navigationBarAppearace2 = UINavigationBarAppearance()
        navigationBarAppearace2.backgroundColor = .clear
        navigationBarAppearace2.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearace2
        navigationController?.navigationBar.compactAppearance = navigationBarAppearace2
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearace
        
        
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.blue.cgColor,
            UIColor.black.cgColor
        ]
        navigationController?.navigationBar.layer.addSublayer(gradient)
        gradient.frame = navigationController?.navigationBar.bounds ?? .zero
    }
    
    private func setupNavBar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { string in
            
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .black
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y , width: 200, height: header.bounds.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.reusableIdentifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
}
