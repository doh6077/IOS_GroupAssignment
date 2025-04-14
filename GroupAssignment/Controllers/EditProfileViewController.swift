//
//  EditProfileViewController.swift
//  GroupAssignment
//
//  Created by Adegoke on 2025-04-14.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditProfileViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrentName()
    }

    func loadCurrentName() {
        guard let user = Auth.auth().currentUser else { return }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)

        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let fullName = document.data()?["fullName"] as? String ?? ""
                DispatchQueue.main.async {
                    self.fullNameTextField.text = fullName
                }
            } else {
                print("Unable to load name: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else { return }
        guard let fullName = fullNameTextField.text, !fullName.isEmpty else {
            showAlert(message: "Please enter a full name.")
            return
        }

        // Handle password update if fields are filled
        if let newPassword = newPasswordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           !newPassword.isEmpty {

            guard newPassword == confirmPassword else {
                showAlert(message: "Passwords do not match.")
                return
            }

            // Update password
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    self.showAlert(message: "Password update failed: \(error.localizedDescription)")
                } else {
                    print("Password updated successfully.")
                }
            }
        }

        // Update full name in Firestore
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).updateData(["fullName": fullName]) { error in
            if let error = error {
                self.showAlert(message: "Failed to update name: \(error.localizedDescription)")
            } else {
                self.showAlert(message: "Profile updated successfully.") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}
