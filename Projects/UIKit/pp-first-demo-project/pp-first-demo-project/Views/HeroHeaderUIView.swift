//
//  HeroHeaderUIView.swift
//  pp-first-demo-project
//
//  Created by Deepak Kumar1 on 17/01/23.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let downloadButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Download", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let playButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Play", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let heroImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "heroImage2")
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        layer.addSublayer(gradient)
        gradient.frame = bounds
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
}
