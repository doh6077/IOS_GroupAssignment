//
//  GetStartedViewController.swift
//  GroupAssignment
//
//  Created by Dohee Kim on 2025-04-10.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func signUpBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUp", sender: self)
    }
}
