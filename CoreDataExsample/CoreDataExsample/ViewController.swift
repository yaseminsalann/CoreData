//
//  ViewController.swift
//  CoreDataExsample
//
//  Created by Yasemin salan on 9.02.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    @objc func addButtonTapped() {
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 5
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = UITableViewCell()
                 //cell.textLabel?.text! = "TableView"
                 var content = cell.defaultContentConfiguration()
           content.text = "cORE dATA"
                 cell.contentConfiguration = content
                 return cell
       }

}

