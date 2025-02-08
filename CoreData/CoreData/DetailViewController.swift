//
//  DetailViewController.swift
//  CoreData
//
//  Created by Yasemin salan on 8.02.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var artistTextField: UITextField!
    
    
    @IBOutlet weak var yearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    @objc func dismissKeyboard(){
        //ekranda herhangi bir yere tıklandığında klavyeyi kapatılması için eklendi.
        view.endEditing(true)
    }

    @IBAction func saveButton(_ sender: Any) {
    }
    
}
