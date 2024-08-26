//
//  ViewController.swift
//  CountAppLA
//
//  Created by 大場史温 on 2024/08/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    
    var count: Int = 0
    
    var name: String!
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countLabel.text = String(count)
        nameLabel.text = name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        update(num: count)
    }
    
    func update(num: Int) {
        
        var data: [Member] = DBCore().loadMembers() ?? []
        data.remove(at: index)
        
        if num == 0 {
            DBCore().saveMembers(data)
        } else {
            data.insert(Member(name: name, count: num), at: 0)
            DBCore().saveMembers(data)
        }
    }
    
    @IBAction func plus() {
        count += 1
        countLabel.text = String(count)
    }
    
    @IBAction func minus() {
        if count > 0{
            count -= 1
            countLabel.text = String(count)
        }
    }
    
    
}

