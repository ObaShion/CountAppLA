//
//  HomeViewController.swift
//  CountAppLA
//
//  Created by 大場史温 on 2024/08/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var selectedItem: Member = Member(name: "", count: 0)
    
    
    var members: [Member] = []
    
    let test: [Member] = [
        //        Member(name: "ショーン", count: 10),
        //        Member(name: "羊", count: 10),
        //        Member(name: "田中", count: 10)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        //        DBCore().saveMembers(test)
        members = DBCore().loadMembers() ?? []
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        members = DBCore().loadMembers() ?? []
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            guard let destination = segue.destination as? ViewController else {
                fatalError("Failed to prepare DetailViewController.")
            }
            destination.count = members[tableView.indexPathForSelectedRow!.row].count
            destination.name = members[tableView.indexPathForSelectedRow!.row].name
            destination.index = tableView.indexPathForSelectedRow!.row
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = members[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        members.remove(at: indexPath.row)
        
        DBCore().saveMembers(members)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    
}
