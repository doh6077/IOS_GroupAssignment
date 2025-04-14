//
//  TaskDetailedViewController.swift
//  GroupAssignment
//
//  Created by Hansol on 2025-04-11.
//

import UIKit

class TaskDetailedViewController: UIViewController {

    @IBOutlet weak var backHomeButton: UIButton!
    @IBOutlet weak var markCompleteButton: UIButton!
    @IBOutlet weak var redmindMeField: UITextField!
    @IBOutlet weak var dueDateField: UITextField!
    @IBOutlet weak var submissionTimeLabel: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var estCompletionTimeField: UITextField!
    
    var assignment: UserTask?
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
            markCompleteButton.addTarget(self, action: #selector(markAsComplete), for: .touchUpInside)
        }

        func updateUI() {
            guard let task = assignment else { return }

            titleLabel.text = task.title
            redmindMeField.text = task.remindMe ? "Yes, Remind Me" : "No, Don't Remind Me"
            dueDateLabel.text = formattedDate(task.dueDate)
            dueDateField.text = formattedDate(task.dueDate)
            submissionTimeLabel.text = formattedDate(task.submissionTime)
            estCompletionTimeField.text = "\(task.estCompletionTime) Hours"

            if task.completionStatus {
                markCompleteButton.setTitle("", for: .normal)
                markCompleteButton.isEnabled = false
            } else {
                markCompleteButton.setTitle("", for: .normal)
                markCompleteButton.isEnabled = true
            }
        }

        @objc func markAsComplete() {
            guard let task = assignment else { return }

            task.completionStatus = true

            do {
                try context.save()
                updateUI()
            } catch {
                print("❌ Failed to update task: \(error)")
            }
        }

        func formattedDate(_ date: Date?) -> String {
            guard let date = date else { return "No date set" }
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
    }
