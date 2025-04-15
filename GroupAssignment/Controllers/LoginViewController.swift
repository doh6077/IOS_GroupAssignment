//
//  LoginViewController.swift
//  GroupAssignment
//
//  Created by Adegoke on 2025-04-14.
//
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        handleLogin()
    }

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        if Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: "goToTabBar", sender: self)
//        }
//    }


    // MARK: - Login Function
    func handleLogin() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in both email and password.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Firebase Login Error: \(error.localizedDescription)")
                self.showAlert(message: "Login failed: \(error.localizedDescription)")
            } else {
                print("Login successful! UID: \(authResult?.user.uid ?? "No UID")")
                self.showAlert(message: "Login Successful!") {
                    // Navigate to homepage (e.g., with segue)
                    self.performSegue(withIdentifier: "goToTabBar", sender: self)
                    
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController {
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = tabBarController
                        sceneDelegate.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }

    // MARK: - Alert Helper
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "goToTabBar"{
//           
//            let destinationVC = segue.destination as! UITabBarController
//            
//            
//        }
//        
//    }
}

