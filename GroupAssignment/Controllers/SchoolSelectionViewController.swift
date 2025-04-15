//
//  SchoolSelectionViewController.swift
//  GroupAssignment
//
//  Created by Dohee Kim on 2025-04-10.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SchoolSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    
    func loadUserProfile() {
        guard let user = Auth.auth().currentUser else {
            print("No user is currently logged in.")
            return
        }

        let db = Firestore.firestore()
        let docRef = db.collection("users").document(user.uid)

        docRef.getDocument { document, error in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists,
                  let data = document.data(),
                  let fullName = data["fullName"] as? String else {
                print("User document is missing or doesn't contain fullName.")
                self.nameLabel.text = "Welcome!"
                return
            }

            DispatchQueue.main.async {
                self.nameLabel.text = "Welcome, \(fullName)!"
            }
        }
    }

    
    let schools = ["Sheridan College", "University of Toronto", "University of Waterloo", "Humber College"]
    var selectedSchool: String?

    @IBOutlet weak var schoolTextField: UITextField!
    let pickerView = UIPickerView()

    @IBAction func skipBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToMainTabBar", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserProfile()
    }

    override func viewDidLoad() {
           super.viewDidLoad()
        

           pickerView.delegate = self
           pickerView.dataSource = self
           schoolTextField.inputView = pickerView
           schoolTextField.tintColor = .clear
           schoolTextField.placeholder = "Select School"
        
       }

       // MARK: - Picker View Data Source
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return schools.count
       }

       // MARK: - Picker View Delegate
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return schools[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           let selected = schools[row]
           schoolTextField.text = selected
           selectedSchool = selected

           // Save selection
           UserDefaults.standard.set(selectedSchool, forKey: "selectedSchool")

           // Trigger segue to Tab Bar Controller
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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

