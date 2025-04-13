import UIKit

protocol FilterSortDelegate: AnyObject {
    func applyFilter(status: String?, sortOption: String?)
}

class FilterSortViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var sortPicker: UIPickerView!
    
    weak var delegate: FilterSortDelegate?

    let statusOptions = ["All", "Completed", "In Progress"]
    let sortOptions = ["Due Date", "Title"]
    
    var selectedStatus: String?
    var selectedSort: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusPicker.delegate = self
        statusPicker.dataSource = self
        sortPicker.delegate = self
        sortPicker.dataSource = self
        
        // Set default selected values
        statusPicker.selectRow(0, inComponent: 0, animated: false)
        sortPicker.selectRow(0, inComponent: 0, animated: false)
        selectedStatus = statusOptions[0]
        selectedSort = sortOptions[0]
        

    }

    @IBAction func applyButtonTapped(_ sender: UIButton) {
        delegate?.applyFilter(status: selectedStatus, sortOption: selectedSort)
        dismiss(animated: true)
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension FilterSortViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == statusPicker ? statusOptions.count : sortOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == statusPicker ? statusOptions[row] : sortOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statusPicker {
            selectedStatus = statusOptions[row]
        } else {
            selectedSort = sortOptions[row]
        }
    }
}
