//
//  ServerPickerTableViewCell.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import UIKit

protocol ServerPickerSelectionDelegate {
    func select(server: Anime.ServerIdentifier)
}

class ServerPickerTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var serverPickerView: UIPickerView!
 
    var _servers = [(identifier : Anime.ServerIdentifier, name : String)]()
    
    var servers: [Anime.ServerIdentifier: String]?  {
        set {
            _servers = newValue!.map { (identifier: $0.key, name: $0.value)}
        }
        get {return nil}
    }
    
    var delegate: ServerPickerSelectionDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        serverPickerView.delegate = self
        serverPickerView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _servers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return _servers[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.select(server: _servers[row].identifier)
    }
}
