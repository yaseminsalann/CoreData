//
//  ViewController.swift
//  CoreDataExsample
//
//  Created by Yasemin salan on 9.02.2025.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        getDataFromCoreData()
    }
    override func viewWillAppear(_ animated: Bool) {
        //DetailViewController sayfasında gönderilen mesajı burda dinliyoruz.
        NotificationCenter.default.addObserver(self, selector: #selector(getDataFromCoreData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
            }
            
    
    @objc func getDataFromCoreData() {
        //dizi içindeki aynı değerlerin tekrarını önlemek için yapıldı.
        nameArray.removeAll(keepingCapacity:false)
        idArray.removeAll(keepingCapacity:false)
        //coredatadan veri çekerkende kayıt ederkende bu yapıyı hep çağırmamız gerekiyor.
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = AppDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do{
           //geri döndürülen cevabı bir dizi içinde veriyor. coredata model objesi olarak gelir.
          let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                //yeni veri geldiğinde tableview ı güncelleme işlemi yapılır.
                self.tableView.reloadData()
                
            }
        }catch {
            print("error")
        }
        
    }
    @objc func addButtonTapped() {
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text =  nameArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }

}

