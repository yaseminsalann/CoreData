//
//  ViewController.swift
//  CoreData
//
//  Created by Yasemin salan on 8.02.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    @objc func addButtonTapped() {
        performSegue(withIdentifier: "toDetailVC", sender: n,l)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 5
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = UITableViewCell()
                 //cell.textLabel?.text! = "TableView"
                 var content = cell.defaultContentConfiguration()
           content.text = ""
                 cell.contentConfiguration = content
                 return cell
       }

}

