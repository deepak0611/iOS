//
//  SecondViewController.swift
//  Learning-project-1
//
//  Created by Deepak Kumar1 on 09/06/24.
//

import Foundation
import UIKit


class SecondViewController: UIViewController {

    private lazy var actionableStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = .zero
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var actionableImageHolderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = .green
//        view.setContentHuggingPriority(priority, for: axis)
        return view
    }()//getEmptyView
    
    private lazy var actionableImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.snp.makeConstraints { make in
//            make.width.height.equalTo(24)
//        }
        return imageView
    }()
    
    private lazy var actionableDetailHolderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints  = false
//        view.setContentHuggingPriority(priority, for: axis)
        return view
    }()//getEmptyView(.defaultLow, for: .horizontal)
    
    private lazy var actionableDetailStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .center
        view.backgroundColor = .clear
        return view
    }()

    private lazy var actionableTitleHolderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints  = false
//        view.setContentHuggingPriority(priority, for: axis)
        return view
    }()//getEmptyView(.defaultHigh, for: .horizontal)
    
    private lazy var actionableTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 10)//PPFont.boldFontWithSize(PPFont.captionFontSize)
        label.lineBreakMode = .byWordWrapping
//        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var actionableSubTitleHolderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints  = false
//        view.setContentHuggingPriority(priority, for: axis)
        return view
    }()//getEmptyView(.defaultHigh, for: .horizontal)
    
    private lazy var actionableSubTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 10)//PPFont.regularFontWithSize(PPFont.captionFontSize)
        label.lineBreakMode = .byWordWrapping
//        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var actionableButtonHolderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()//getEmptyView(.defaultHigh, for: .horizontal)
    
    private lazy var actionableButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)//PPFont.boldFontWithSize(PPFont.captionFontSize)
        button.isUserInteractionEnabled = false
//        button.setInsets(forContentPadding: UIEdgeInsets(topBottom: 8, leftRight: 12), imageTitleSpacing: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.translatesAutoresizingMaskIntoConstraints  = false
//        button.titleLabel?.numberOfLines = 1
//        button.titleLabel?.lineBreakMode = .byTruncatingTail
        return button
    }()
    
    
    private lazy var actionableView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor  = .white
        view.addSubview(actionableView)
        let leadingConstraint = actionableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = actionableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let topConstraint = actionableView.topAnchor.constraint(equalTo: view.topAnchor)
        let heightConstraint = actionableView.heightAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, heightConstraint])
        
        setupStac()
        setupDetailsView()
//        setupActionableView()
        view.layoutIfNeeded()
    }
    
    func setupStac() {
        actionableView.addSubview(actionableStackView)
        let leadingConstraint = actionableStackView.leadingAnchor.constraint(equalTo: actionableView.leadingAnchor)
        let trailingConstraint = actionableStackView.trailingAnchor.constraint(equalTo: actionableView.trailingAnchor)
        let topConstraint = actionableStackView.topAnchor.constraint(equalTo: actionableView.topAnchor)
        let bottomConstraint = actionableStackView.bottomAnchor.constraint(equalTo: actionableView.bottomAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
    }
    
    func setupImage() {
        
    }
    
    func setupDetailsView() {
                actionableStackView.addArrangedSubview(actionableDetailHolderView)
        actionableDetailHolderView.addSubview(actionableDetailStackView)
        
        let leadingConstraint = actionableDetailStackView.leadingAnchor.constraint(equalTo: actionableDetailHolderView.leadingAnchor)
        let trailingConstraint = actionableDetailStackView.trailingAnchor.constraint(equalTo: actionableDetailHolderView.trailingAnchor)
        let topConstraint = actionableDetailStackView.topAnchor.constraint(equalTo: actionableDetailHolderView.topAnchor)
        let bottomConstraint = actionableDetailStackView.bottomAnchor.constraint(equalTo: actionableDetailHolderView.bottomAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        
//        actionableTitleHolderView.addSubview(actionableTitleLabel)
//        let leadingConstraint2 = actionableTitleLabel.leadingAnchor.constraint(equalTo: actionableTitleHolderView.leadingAnchor)
//        let trailingConstraint2 = actionableTitleLabel.trailingAnchor.constraint(equalTo: actionableTitleHolderView.trailingAnchor)
//        let topConstraint2 = actionableTitleLabel.topAnchor.constraint(equalTo: actionableTitleHolderView.topAnchor)
//        let bottomConstraint2 = actionableTitleLabel.bottomAnchor.constraint(equalTo: actionableTitleHolderView.bottomAnchor)
//        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
//        
//        
//        actionableSubTitleHolderView.addSubview(actionableSubTitleLabel)
//        let leadingConstraint3 = actionableSubTitleLabel.leadingAnchor.constraint(equalTo: actionableTitleHolderView.leadingAnchor)
//        let trailingConstraint3 = actionableSubTitleLabel.trailingAnchor.constraint(equalTo: actionableTitleHolderView.trailingAnchor)
//        let topConstraint3 = actionableSubTitleLabel.topAnchor.constraint(equalTo: actionableTitleHolderView.topAnchor)
//        let bottomConstraint3 = actionableSubTitleLabel.bottomAnchor.constraint(equalTo: actionableTitleHolderView.bottomAnchor)
//        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
//        
//        actionableDetailStackView.addArrangedSubview(actionableTitleHolderView)
//        actionableDetailStackView.addArrangedSubview(actionableSubTitleHolderView)
        
        actionableTitleLabel.text = "Your policy is expiring soon blah blah blah blah blah"//data.actionableTitle
        actionableSubTitleLabel.text = "Provide required documents for quick KYC verification blah blah blah"//data.actionableSubtitle
        
        actionableDetailStackView.addArrangedSubview(actionableTitleLabel)
    }
    
    private func setupActionableView() {
        
//        actionableStackView.addArrangedSubview(actionableImageHolderView)
//        actionableStackView.addArrangedSubview(actionableDetailHolderView)
//        actionableStackView.addArrangedSubview(actionableButtonHolderView)

        
//        actionableStackView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//        }
        
        
        
       
        //imageView
        actionableImageHolderView.addSubview(actionableImageView)
//        actionableImageView.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
        
        let leadingConstraint2 = actionableImageView.leadingAnchor.constraint(equalTo: actionableImageHolderView.leadingAnchor)
        let trailingConstraint2 = actionableImageView.trailingAnchor.constraint(equalTo: actionableImageHolderView.trailingAnchor)
        let centerYConstraint2 = actionableImageView.topAnchor.constraint(equalTo: actionableImageHolderView.centerYAnchor)
        NSLayoutConstraint.activate([leadingConstraint2, trailingConstraint2, centerYConstraint2])
        
        
        //labels
        actionableDetailHolderView.addSubview(actionableDetailStackView)
//        actionableDetailStackView.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().inset(16)
//            make.top.equalToSuperview().offset(12)
//            make.bottom.equalToSuperview().inset(12)
//        }
        
        actionableTitleHolderView.addSubview(actionableTitleLabel)
//        actionableTitleLabel.snp.makeConstraints { make in
//            make.leading.trailing.top.bottom.equalToSuperview()
//        }
        
        actionableSubTitleHolderView.addSubview(actionableSubTitleLabel)
//        actionableSubTitleLabel.snp.makeConstraints { make in
//            make.leading.trailing.top.bottom.equalToSuperview()
//        }
        actionableDetailStackView.addArrangedSubview(actionableTitleHolderView)
        actionableDetailStackView.addArrangedSubview(actionableSubTitleHolderView)

        
        // button
        actionableButtonHolderView.addSubview(actionableButton)
//        actionableButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().inset(16)
//        }
        
        //content filling
        if true { //data.actionableRowVisible {
            actionableTitleLabel.text = "Your policy is expiring soon blah blah blah blah blah"//data.actionableTitle
            actionableSubTitleLabel.text = "Provide required documents for quick KYC verification blah blah blah"//data.actionableSubtitle
//            actionableButton.setTitle(data.actionableCtaText, for: .normal)
            actionableButton.setTitle("Renew", for: .normal)
            
            if actionableButton.frame.size.width > 150 {
//                actionableButton.snp.makeConstraints { make in
//                    make.width.equalTo(150)
//                }
            }
            
            actionableImageView.image = UIImage(systemName: "square.and.arrow.up.circle.fill")
        }
        
        
        actionableStackView.layoutIfNeeded()
    }
    
    
}
