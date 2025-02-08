//
//  DetailViewController.swift
//  CoreDataExsample
//
//  Created by Yasemin salan on 9.02.2025.
//

import UIKit

class DetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var artistTextField: UITextField!
    
    
    @IBOutlet weak var yearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        
    }
    @objc func selectImage(){
        //kullanıcı image e tıkladığında galeri yada kameranın açılması işlemleri bu kısımda yapılır.
        //UIImagePickerControllerDelegate,UINavigationControllerDelegate sınıflarını UIImagePickerController kullanabilmek için eklendi.
        let picker = UIImagePickerController()
        picker.delegate = self
        
        //kameramı,galerimi açılacağı bilgisi seçilir.
        picker.sourceType = .photoLibrary
        //seçilen resimin üzerinde düzenleme yapılabilmesi için ayarlandı.
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    //resim seçildikten sonra ne yapılacağı işlemleri burada yapılır.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    @objc func dismissKeyboard(){
        //ekranda herhangi bir yere tıklandığında klavyeyi kapatılması için eklendi.
        view.endEditing(true)
    }
    
    @IBAction func saveClickButton(_ sender: Any) {
    }

}
