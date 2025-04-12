//
//  AssignmentCell.swift
//  GroupAssignment
//
//  Created by Hansol on 2025-04-11.
//

import UIKit

protocol AssignmentCellDelegate: AnyObject {
    func didTapViewDetails(for assignment: UserTask)
    func didTapDelete(for assignment: UserTask)
}

class AssignmentCell: UITableViewCell {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDetailLabel: UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var completionStatusLabel: UILabel!
    @IBOutlet weak var deleteTaskButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var completionStatusImage: UIImageView!
    
    weak var delegate: AssignmentCellDelegate?
        var assignment: UserTask?

        override func awakeFromNib() {
            super.awakeFromNib()
            viewDetailsButton.addTarget(self, action: #selector(viewDetailsTapped), for: .touchUpInside)
            deleteTaskButton.addTarget(self, action: #selector(deleteTaskTapped), for: .touchUpInside)
        }

        @objc func viewDetailsTapped() {
            print("detail button tapped from Cell")
            if let task = assignment {
                delegate?.didTapViewDetails(for: task)
            }
        }
    
        @objc func deleteTaskTapped() {
            print("Delete button tapped from Cell")
            if let task = assignment {
                delegate?.didTapDelete(for: task)
            }
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    }
