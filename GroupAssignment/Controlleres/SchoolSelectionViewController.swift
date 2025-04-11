//
//  SchoolSelectionViewController.swift
//  GroupAssignment
//
//  Created by Dohee Kim on 2025-04-10.
//

import UIKit

class SchoolSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let schools = ["Sheridan College", "University of Toronto", "University of Waterloo", "Humber College"]
    var selectedSchool: String?

    @IBOutlet weak var schoolTextField: UITextField!
    let pickerView = UIPickerView()

    @IBAction func skipBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToMainTabBar", sender: self)
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
               self.performSegue(withIdentifier: "goToMainTabBar", sender: self)
           }
       }
}

