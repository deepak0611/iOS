//
//  CollectionViewTableViewCell.swift
//  pp-first-demo-project
//
//  Created by Deepak Kumar1 on 17/01/23.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let reusableIdentifier = "CollectionViewTableViewCell"
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

}


extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = .green
        
        return cell
    }
    
}
