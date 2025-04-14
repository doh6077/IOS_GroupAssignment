//
//  SignupViewController.swift
//  GroupAssignment
//
//  Created by Adegoke on 2025-04-13.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        handleSignUp()
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // Navigate to LoginViewController
        // e.g., performSegue(withIdentifier: "goToLogin", sender: self)
    }

    @IBAction func handleSignUp() {
        guard let fullName = fullNameTextField.text, !fullName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }

        // Optional: You can even log inputs before Firebase call
        print("Signing up with:", email, fullName)

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Firebase error: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([
                    "fullName": fullName,
                    "email": email
                ]) { error in
                    if let error = error {
                        self.showAlert(message: "Error saving user info: \(error.localizedDescription)")
                    } else {
                        print("✅ User profile saved to Firestore.")
                        // Navigate to SchoolSelectionViewController *after* successful save
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "goToSchool", sender: self)
                        }
                    }
                }
            }
        }

    }



    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "goToSchool"{
//           
//            let destinationVC = segue.destination as! SchoolSelectionViewController
//            
//            
//        }
//        
//    }
}
