//
//  ViewController.swift
//  pp-first-demo-project
//
//  Created by Deepak Kumar1 on 11/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .brown
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        v.clipsToBounds = true
        // TODO: I don't know why making it false.. centered the button in the view
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Hey Dear, Welcome to phonepe", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        // TODO: not getting how this translateAutoresing... works & how it affects the child constraint behaviour
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var vStack: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .black
        sv.clipsToBounds = true
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .center
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        configureScrollView()
        
        configureContentView()
        contentView.addSubview(greenView)
        
//        scrollView.addSubview(greenView)
//        view.addSubview(redView)
        configureGreenView3()
//        configureRedView()
        
        
        //        greenView.addSubview(button)
//        addButtonConstraints()
        
        
    }
    
    override func viewWillLayoutSubviews() {
//        addGradient(greenView)
    }
    
    override func viewDidLayoutSubviews() {
       
        
        
//        addGradient(greenView)
        
        // TODO: don't know why redView is not getting the gradient
//        addGradient(redView)
    }
    
    private func addButtonConstraints() {
        let btnConstraints = [
            button.leadingAnchor.constraint(equalTo: greenView.leadingAnchor),
            button.topAnchor.constraint(equalTo: greenView.topAnchor),
            button.trailingAnchor.constraint(equalTo: greenView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: greenView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(btnConstraints)
    }
    
    private func addGradient(_ hostView: UIView) {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.blue.cgColor,
            UIColor.black.cgColor
        ]
        gradient.frame = hostView.bounds
        hostView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func configureGreenView() {
        let constraints = [
            greenView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            greenView.topAnchor.constraint(equalTo: view.topAnchor),
            greenView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            greenView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            greenView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureGreenView2() {
        let constraints = [
            greenView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            greenView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            greenView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            greenView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            greenView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureGreenView3() {
        let constraints = [
            greenView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            greenView.topAnchor.constraint(equalTo: contentView.topAnchor),
            greenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            greenView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            greenView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            greenView.widthAnchor.constraint(equalToConstant: 400),
            greenView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor,constant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureRedView() {
        let constraints = [
            redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            redView.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 0),
            redView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureScrollView() {
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width),
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
//            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureContentView() {
        let constraints = [
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
}

