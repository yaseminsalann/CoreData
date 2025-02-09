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
    
    var selectedPainting = ""
    var selectedPaintingId: UUID?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        getDataFromCoreData()
    }
    override func viewWillAppear(_ animated: Bool) {
        //DetailViewController sayfasında gönderilen mesajı burda dinliyoruz.
        NotificationCenter.default.addObserver(self, selector: #selector(getDataFromCoreData), name: NSNotification.Name(rawValue: "newData"), object: nil)
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
           if results.count > 0 {
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
            }
        }catch {
            print("error")
        }
        
    }
    @objc func addButtonTapped() {
        selectedPainting = ""
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            //diğer sayfaya aktarmış oluyıruz.
            detailVC.chosenPainting = selectedPainting
            detailVC.chosenPaintingId = selectedPaintingId
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    func tableView(_ tableView:UITableView,commit editingStyle:UITableViewCell.EditingStyle,forRowAt IndexPath:IndexPath){
        if editingStyle == .delete{
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = idArray[IndexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id == %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try! context.fetch(fetchRequest)
                if results.count>0{
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == idArray[IndexPath.row]{
                                //coredatadan silme işlemi yapıldı
                                context.delete(result)
                                nameArray.remove(at: IndexPath.row)
                                idArray.remove(at: IndexPath.row)
                                self.tableView.reloadData()
                                
                                do{
                                    try context.save()
                                }catch{
                                    print("error")
                                }
                                
                                //yapı sağlam olmasaydı örneğin id değilde name den silmeye çalışsaydık for loop devam etmemesi için  arananan değer bulunup silindiyse break diyebilirz ve for loop dan çıkmış oluruz.
                               // break
                            }
                        }
                    }
                }
            }catch {
                print("error")
            }
            
            
        }
    }
}

