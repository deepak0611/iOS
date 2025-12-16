//
//  ViewController.swift
//  zomatoR1
//
//  Created by Deepak Kumar1 on 07/08/25.
//

import UIKit

class ViewController: UIViewController {

    
//    
//    let imageView: UIImageView = {
//        let imageView = UIImageView(image: .init(systemName: "plus"))
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    let label: UILabel = {
//        let label = UILabel()
//        label.text = "kjsbfjkebrfkjebf"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    var count = 0
    var rx: CGFloat = 0.0
    var ry: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(containerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        containerView.addGestureRecognizer(tapGesture)
        
        let width = UIScreen.main.bounds.width
        rx = width - 100
        
        let yC = view.bounds.maxY
        ry = yC - 100
      
    }

    @objc
    func tapped() {
        var transform = CGAffineTransform(translationX: 0, y: 0)
        transform = CGAffineTransform(translationX: rx, y: 0)
        containerView.layer.setAffineTransform(transform)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            transform = CGAffineTransform(translationX: 0, y: self.ry)
            self.containerView.layer.setAffineTransform(transform)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            transform = CGAffineTransform(translationX: self.rx, y: self.ry)
            self.containerView.layer.setAffineTransform(transform)
        }
        
//        transform = CGAffineTransform(translationX: 0, y: 0)
        
        
    }

}

//
//
//containerView.addSubview(imageView)
//containerView.addSubview(label)
//
//containerView.clipsToBounds = true
//
//
//NSLayoutConstraint.activate([
//    imageView.heightAnchor.constraint(equalToConstant: 56),
//    imageView.widthAnchor.constraint(equalToConstant: 56),
//    imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//    imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//    label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
//    label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
//    label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
//])
//
//view.addSubview(containerView)
//NSLayoutConstraint.activate([
//    containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//    containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//    containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
//])

