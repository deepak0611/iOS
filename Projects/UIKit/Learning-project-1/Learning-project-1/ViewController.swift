//
//  ViewController.swift
//  Learning-project-1
//
//  Created by Deepak Kumar1 on 09/06/24.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func openFLow(_ sender: Any) {
        let vc = SecondViewController()
        self.present(vc, animated: true)
    }
    
    
    
}

