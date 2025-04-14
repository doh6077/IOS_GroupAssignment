//
//  ProfileViewController.swift
//  GroupAssignment
//
//  Created by Adegoke on 2025-04-14.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserProfile()
    }
   

    func loadUserProfile() {
        guard let user = Auth.auth().currentUser else { return }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)

        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let fullName = document.data()?["fullName"] as? String ?? "Unknown User"
                DispatchQueue.main.async {
                    self.nameLabel.text = "Welcome, \(fullName)!"
                }
            } else {
                print("Failed to fetch user profile: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    @IBAction func editProfileTapped(_ sender: UIButton) {
//        performSegue(withIdentifier: "goToEditProfile", sender: self)
    }

    @IBAction func logoutTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "GetStartedViewController") as? GetStartedViewController {

                // Embed in Navigation Controller if needed
                let navVC = UINavigationController(rootViewController: loginVC)

                // Reset root view controller to login screen
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = navVC
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if segue.identifier == "goToEditProfile"{
    
                let destinationVC = segue.destination as! EditProfileViewController
    
    
            }
    
        }



}
