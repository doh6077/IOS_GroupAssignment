//
//  AssignmentListViewController.swift
//  GroupAssignment
//
//  Created by Hansol on 2025-04-11.
//
import CoreData
import UIKit

class AssignmentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AssignmentCellDelegate {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addAssignmentButton: UIButton!
    @IBOutlet weak var assignmentTableView: UITableView!

    var assignments: [UserTask] = []
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addAssignmentTapped(_ sender: UIButton) {
        print("add button clicked from list view")
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let createVC = storyboard.instantiateViewController(withIdentifier: "CreateAssignmentViewController") as? CreateAssignmentViewController {
               createVC.modalPresentationStyle = .fullScreen
               present(createVC, animated: true, completion: nil)
           }
       }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("➕ addButton was tapped")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        addAssignmentButton.addTarget(self, action: #selector(addAssignmentTapped), for: .touchUpInside)
        
        assignmentTableView.delegate = self
        assignmentTableView.dataSource = self
        
        // Register the custom cell
        assignmentTableView.register(UINib(nibName: "AssignmentCell", bundle: nil), forCellReuseIdentifier: "AssignmentCell")
        
        assignmentTableView.rowHeight = UITableView.automaticDimension
        assignmentTableView.estimatedRowHeight = 100
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAssignments()
    }

//    @objc func addAssignmentTapped() {
//        print("add button clicked from list view")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let createVC = storyboard.instantiateViewController(withIdentifier: "CreateAssignmentViewController") as? CreateAssignmentViewController {
//            createVC.modalPresentationStyle = .fullScreen
//            present(createVC, animated: true, completion: nil)
//        }
//    }

    func fetchAssignments() {
        let request: NSFetchRequest<UserTask> = UserTask.fetchRequest()
        do {
            assignments = try context.fetch(request)
            assignmentTableView.reloadData()
        } catch {
            print("❌ Failed to fetch tasks: \(error)")
        }
    }
    
    func didTapViewDetails(for assignment: UserTask) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "TaskDetailedViewController") as? TaskDetailedViewController {
                detailVC.assignment = assignment
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    
    func didTapDelete(for assignment: UserTask) {
        context.delete(assignment)
        
        do {
            try context.save()
            print("Task deleted successfully")
            fetchAssignments()  // refresh table
            
            // Show confirmation message
            let alert = UIAlertController(title: "Task Deleted", message: "The task has been deleted.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } catch {
            print("Failed to delete task: \(error)")
        }
    }




    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let assignment = assignments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath) as! AssignmentCell

        cell.taskTitleLabel.text = assignment.title
        cell.taskDetailLabel.text = assignment.detail
        cell.dueDateLabel.text = formattedDate(assignment.dueDate)
        cell.completionStatusLabel.text = assignment.completionStatus ? "Completed" : "In Progress"
        cell.completionStatusImage.image = UIImage(named: assignment.completionStatus ? "Completed_icon" : "InProgress_icon")
        
        // ✅ Set delegate and assignment
        cell.delegate = self
        cell.assignment = assignment

        return cell
    }




    // Helper for formatting date
    func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "No due date" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

}
    
