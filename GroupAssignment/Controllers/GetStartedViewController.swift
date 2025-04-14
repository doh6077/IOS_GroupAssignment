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
//        performSegue(withIdentifier: "goToSignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSignUp"{
           
            let destinationVC = segue.destination as! SignupViewController
            
            
        }
        else if segue.identifier == "goToLogin"{
           
            let destinationVC = segue.destination as! LoginViewController
            
            
        }
        
    }
    
}
