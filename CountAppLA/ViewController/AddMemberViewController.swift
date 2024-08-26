//
//  AddMemberViewController.swift
//  CountAppLA
//
//  Created by 大場史温 on 2024/08/26.
//

import UIKit

class AddMemberViewController: UIViewController {

    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var countField: UITextField!
    
    var members: [Member] = []
    
    var nameText: String = ""
    
    var countNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func add() {
        
        nameText = nameTextField.text ?? ""
        
        countNum = Int(countField.text ?? "0") ?? 0
        
        if nameText == "" && countNum == 0 {
            let alert = UIAlertController(title: "未入力", message: "値を入れてください", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                print("error")
            }))
            present(alert, animated: true)
            return
        }
        
        members = DBCore().loadMembers() ?? []
        
        members.insert(Member(name: nameText, count: countNum), at: 0)
        
        DBCore().saveMembers(members)
        
        self.navigationController?.popViewController(animated: true)
    }

}
