import UIKit
import CoreData
import FirebaseAuth
import FirebaseFirestore

class CreateAssignmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var saveTaskButton: UIButton!
    @IBOutlet weak var taskTitleField: UITextField!
    @IBOutlet weak var taskDetailField: UITextField!
    @IBOutlet weak var submissionTimePickerField: UIDatePicker!
    @IBOutlet weak var dueDatePickerField: UIDatePicker!
    @IBOutlet weak var estTimePickerField: UIPickerView!
    @IBOutlet weak var remindMePickerField: UIPickerView!

    @IBOutlet weak var backButton: UIButton!
    // Data sources
    let estTimeOptions: [Double] = stride(from: 0.5, through: 72.0, by: 0.5).map { $0 }
    let remindMeOptions = ["Yes", "No"]

    // Core Data context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Picker setup
        estTimePickerField.delegate = self
        estTimePickerField.dataSource = self

        remindMePickerField.delegate = self
        remindMePickerField.dataSource = self

        // Set min selectable date for due date picker
        dueDatePickerField.minimumDate = Date()
    }

    // MARK: - Picker View Data Source & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == estTimePickerField {
            return estTimeOptions.count
        } else if pickerView == remindMePickerField {
            return remindMeOptions.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == estTimePickerField {
            return "\(estTimeOptions[row]) hrs"
        } else if pickerView == remindMePickerField {
            return remindMeOptions[row]
        }
        return nil
    }

    // MARK: - Save Task
    @IBAction func saveTaskTapped(_ sender: UIButton) {
        guard let title = taskTitleField.text, !title.isEmpty else {
                showAlert(message: "Title is required.")
                return
            }

            let dueDate = dueDatePickerField.date
            if dueDate <= Date() {
                showAlert(message: "Please select a valid due date (future date).")
                return
            }

            guard let detail = taskDetailField.text else {
                print("❌ Missing detail")
                return
            }

            let submissionTime = submissionTimePickerField.date
            let selectedEstIndex = estTimePickerField.selectedRow(inComponent: 0)
            let estCompletionTime = estTimeOptions[selectedEstIndex]

            let selectedRemindMeIndex = remindMePickerField.selectedRow(inComponent: 0)
            let remindMe = remindMeOptions[selectedRemindMeIndex] == "Yes"

            let newTask = UserTask(context: self.context)
            newTask.userId = Auth.auth().currentUser?.uid
            newTask.title = title
            newTask.detail = detail
            newTask.submissionTime = submissionTime
            newTask.dueDate = dueDate
            newTask.estCompletionTime = estCompletionTime
            newTask.remindMe = remindMe
            newTask.completionStatus = false

            do {
                try context.save()
                print("Task saved successfully!")
                
                // Show success alert
                let alert = UIAlertController(title: "Success", message: "Task saved successfully!", preferredStyle: .alert)
                
                // In the success alert handler
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    // Reset all form fields
                    self.resetFormFields()
                    
                    // Switch to the second tab (AssignmentListViewController)
                    if let tabBarController = self.tabBarController {
                        tabBarController.selectedIndex = 1  // Index of the AssignmentListViewController tab
                    }
                }))

                present(alert, animated: true, completion: nil)

            } catch {
                print("Failed to save task: \(error)")
                showAlert(message: "Failed to save task. Please try again.")
            }
        }
    
        // MARK: - Back Button Action
        @IBAction func backButtonTapped(_ sender: UIButton) {
            print("Back button tapped in Create Assignment View")
            dismiss(animated: true, completion: nil)
        }
    
    // MARK: - Helper Method to Show Alerts
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func resetFormFields() {
        taskTitleField.text = ""
        taskDetailField.text = ""
        submissionTimePickerField.date = Date()
        dueDatePickerField.date = Date()
        estTimePickerField.selectRow(0, inComponent: 0, animated: false)
        remindMePickerField.selectRow(0, inComponent: 0, animated: false)
    }
}

