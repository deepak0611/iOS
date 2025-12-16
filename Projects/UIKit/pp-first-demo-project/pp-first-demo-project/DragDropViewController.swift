//
//  DragDropViewController.swift
//  pp-first-demo-project
//
//  Created by Deepak Kumar1 on 19/01/23.
//

import UIKit

class DragDropViewController: UIViewController {
    
    private var apiString: String = "https://www.apple.com/"
    
    private var successApiString: String = "https://api.mocklets.com/p68348/success_case"
    private var failureApiString: String = "https://api.mocklets.com/p68348/failure_case"
    
    private var reachedDownSide = false
    private var isDraggingVertically = false
    private var sx: CGFloat = 0.0
    private var sy: CGFloat = 0.0
    private var ex: CGFloat = 0.0
    
    private let image: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "arrow.down.circle")
        iv.tintColor = .systemRed
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let circularView: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let circularTransparentView: UIView = {
       let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    private let downCircularView: UIView = {
       let v = UIView()
        v.backgroundColor = .clear
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let downArrowImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.down")
        iv.tintColor = .green
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let topBlankView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    private let resultLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Result coming soon..."
        label.font = UIFont(name: label.font.fontName, size: 24)
        return label
    }()
    
    
    private let toggleView: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor =  .clear
        v.layer.cornerRadius = 8
        v.heightAnchor.constraint(equalToConstant: 42).isActive = true
        v.widthAnchor.constraint(equalToConstant: 42).isActive = true
        return v
    }()
    
    private let toggleStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = true
        sv.backgroundColor = .systemGreen
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fill
//        sv.spacing = 5
        sv.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private let toggleImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "play.circle")
        iv.tintColor = .white
        iv.heightAnchor.constraint(equalToConstant: 36).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 36).isActive = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let toggleText: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.setContentHuggingPriority(UILayoutPriority(100), for: .horizontal)
        return lbl
    }()
    
    private var isToggleViewExpanded: Bool = true
    private var isPlaying: Bool = true
    private var isToggleDisabled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan

        view.addSubview(circularView)
        view.addSubview(downArrowImage)
        view.addSubview(downCircularView)
        view.addSubview(circularTransparentView)
        view.addSubview(topBlankView)
        view.addSubview(toggleStackView)
        circularView.addSubview(image)
        topBlankView.addSubview(resultLabel)
        setupToggleStackView()
        
        view.isUserInteractionEnabled = true
        animateUpAndDown()
    }
    
    func setupToggleStackView() {
        toggleView.addSubview(toggleImage)
        
        toggleStackView.addArrangedSubview(toggleView)
//        toggleStackView.addArrangedSubview(toggleImage)
        toggleStackView.addArrangedSubview(toggleText)
        toggleText.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        addConstraint()
        
        
    }
    
    private func animateUpAndDown() {
        UIView.animate(withDuration: 1, delay: 0 ,options: [.repeat, .autoreverse], animations: {
                self.circularView.transform = CGAffineTransform(translationX: 0, y: 14)
            }, completion: nil)
    }
    
    private func stopAnimation() {
        circularView.layer.removeAllAnimations()
        circularView.transform = .identity
    }
    

    func addConstraint() {
        let constraints = [
            circularView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circularView.heightAnchor.constraint(equalToConstant: 70),
            circularView.widthAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(constraints)
        
        view.layoutIfNeeded()
        
        circularView.layer.cornerRadius = circularView.layer.bounds.height / 2
        circularView.clipsToBounds = true
        
        let imageconstraints = [
            image.centerXAnchor.constraint(equalTo: circularView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: circularView.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(imageconstraints)
        
        let downarrowimageconstraints = [
            downArrowImage.topAnchor.constraint(equalTo: circularView.bottomAnchor, constant: 32),
            downArrowImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(downarrowimageconstraints)
        
        let downCircularconstraints = [
            downCircularView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            downCircularView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downCircularView.heightAnchor.constraint(equalToConstant: 70),
            downCircularView.widthAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(downCircularconstraints)
        
        view.layoutIfNeeded()
        downCircularView.layer.cornerRadius = downCircularView.layer.bounds.height / 2
        downCircularView.clipsToBounds = true
        
        
        
        sx = circularView.frame.origin.x
        sy = circularView.frame.origin.y
        ex = circularView.frame.origin.x + circularView.frame.width
        
        circularTransparentView.frame = circularView.frame
        
        let topViewConstraints = [
            topBlankView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topBlankView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            topBlankView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            topBlankView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        NSLayoutConstraint.activate(topViewConstraints)
        
        let resultLabelConstraints = [
            resultLabel.leadingAnchor.constraint(equalTo: topBlankView.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: topBlankView.trailingAnchor,constant: -20),
            resultLabel.bottomAnchor.constraint(equalTo: topBlankView.bottomAnchor, constant: 40),
        ]
        
        NSLayoutConstraint.activate(resultLabelConstraints)
        
        
        let toggleViewConstraint = [
            toggleStackView.centerXAnchor.constraint(equalTo: topBlankView.centerXAnchor),
            toggleStackView.topAnchor.constraint(equalTo: topBlankView.topAnchor, constant: 12),
//            toggleStackView.widthAnchor.constraint(equalToConstant: 120),
//            toggleStackView.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        NSLayoutConstraint.activate(toggleViewConstraint)
        view.layoutIfNeeded()
        toggleStackView.layer.cornerRadius = toggleStackView.frame.height / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleToggleTap(_:)))
        toggleStackView.addGestureRecognizer(tap)
        
        
        toggleImage.centerXAnchor.constraint(equalTo: toggleView.centerXAnchor).isActive = true
        toggleImage.centerYAnchor.constraint(equalTo: toggleView.centerYAnchor).isActive = true
    }
    
    private func updateDownCircularView(resultString: String) {
        DispatchQueue.main.async {
            self.circularView.isHidden = true
            self.downCircularView.layer.borderWidth = 0
            self.downCircularView.backgroundColor = .white
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            UIView.animate(withDuration: 2) {
                self.downCircularView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height / 2) //self.view.frame.height + 10
            }
            
            self.resultLabel.text = resultString
            
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.transform = CGAffineTransform(translationX: 0, y: -60)
            }
            
        })
    }
    
    private func hideDownArrow(show: Bool) {
        self.downArrowImage.isHidden = !show
    }
    
    @objc func handleToggleTap(_ sender: UITapGestureRecognizer?) {

//        if toggleStackView.frame.height == toggleStackView.frame.width {
//            toggleStackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
////            toggleView.frame.size.width = 120
//        } else {
//            toggleStackView.widthAnchor.constraint(equalToConstant: toggleStackView.frame.height).isActive = true
////            toggleView.frame.size.width = 40
//        }
        if isToggleDisabled {
            return
        }
        isToggleDisabled = true
        if isPlaying {
            UIView.animate(withDuration: 0.3) {
                self.toggleImage.image = UIImage(systemName: "pause.circle")
                self.toggleStackView.backgroundColor = .systemRed
                
                self.toggleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
                self.toggleText.text = "PlayBack paused"
                self.toggleText.isHidden = false
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                UIView.animate(withDuration: 0.3) {
                    self.toggleText.isHidden = true
                    self.toggleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    self.isToggleDisabled = false
                }
            })
            
            isPlaying = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.toggleImage.image = UIImage(systemName: "play.circle")
                self.toggleStackView.backgroundColor = .systemGreen
                
                self.toggleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
                self.toggleText.text = "PlayBack started playing now"
                self.toggleText.isHidden = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                UIView.animate(withDuration: 0.3) {
                    self.toggleText.isHidden = true
                    self.toggleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    self.isToggleDisabled = false
                }
            })
            
            isPlaying = true
        }
        
//        if isToggleViewExpanded {
//            UIView.animate(withDuration: 0.5) {
////                toggleStackView.removeArrangedSubview(toggleText)
////                toggleText.removeFromSuperview()
//                self.toggleText.isHidden = true
//                self.toggleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                self.isToggleViewExpanded = false
//            }
//
//        } else {
//            UIView.animate(withDuration: 0.5) {
////                self.toggleStackView.addArrangedSubview(self.toggleText)
//                self.toggleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
//                self.toggleText.isHidden = false
//
//                self.isToggleViewExpanded = true
//            }
//
//        }
        
        
        
        toggleStackView.layoutIfNeeded()
        view.layoutIfNeeded()
    }

}

extension DragDropViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: circularTransparentView)
        if circularTransparentView.bounds.contains(location) {
            print("touch started")
            stopAnimation()
        }
        
        
        let location2 = touch.location(in: circularView)
        let location3 = touch.location(in: downCircularView)
        
        if circularView.bounds.contains(location2) && !downCircularView.bounds.contains(location3){
            isDraggingVertically = true
            hideDownArrow(show: false)
            print("touch started")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: view)
        if location.x >= sx && location.x <= ex && isDraggingVertically {
            circularView.frame.origin.y = location.y - (circularView.frame.height / 2)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch finished")
        guard let touch = touches.first else {
            return
        }

        if reachedDownSide {
            return
        }

        let location = touch.location(in: downCircularView)
        if downCircularView.bounds.contains(location) && isDraggingVertically {
            circularView.frame = downCircularView.frame
            reachedDownSide = true
            
            APIManager.shared.apiCall(urlString: apiString) { result in
                self.updateDownCircularView(resultString: result.rawValue)
            }
            
            
        } else {
            circularView.frame.origin.x = sx
            circularView.frame.origin.y = sy
            animateUpAndDown()
            hideDownArrow(show: true)
        }
        
        isDraggingVertically = false
    }
    
}

enum apiResult: String {
    case success = "Success"
    case failure = "Failure"
}

struct responseModel: Decodable {
    var success: Bool?
}

class APIManager {
    public static let shared = APIManager()
    
    func apiCall(urlString: String, completion: @escaping (apiResult) -> Void) {
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("deepak: \(error)")
                completion(.failure)
                return
            }
            guard let data = data else {
                completion(.failure)
                return
            }
            let responseData = try? JSONDecoder().decode(responseModel.self, from: data)
            
            if let repsonseData = responseData {
                let result = (repsonseData.success ?? false) ? "success" : "failure"
                completion(apiResult(rawValue: result) ?? .failure)
            }
            
            completion(.failure)
        }
        task.resume()
    }
    
    
}
