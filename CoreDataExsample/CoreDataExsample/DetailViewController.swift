//
//  DetailViewController.swift
//  CoreDataExsample
//
//  Created by Yasemin salan on 9.02.2025.
//

import UIKit
import CoreData

class DetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var saveClickButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingId:UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if chosenPainting != ""{
            //butonun görünürlüğünü ayarladık.true yapıldığında button görünmez oldu.
            saveClickButton.isHidden = true
            //core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            //coredata dan verileri çekereken filtreleme işlemi yapılması
            let idString = chosenPaintingId?.uuidString
            //id si idString e eşit olan argümanı bul demek
            fetchRequest.predicate = NSPredicate(format: "id == %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
              let results = try context.fetch(fetchRequest)
                //results verisinin boyutu sıfırdan büyük ise geri kalan işlemleri yap
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if let name = result.value(forKey: "name") as? String{
                            nameTextField.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            artistTextField.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            yearTextField.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data{
                            imageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }catch {
                print("error")
            }
            
        }else{
            saveClickButton.isEnabled = false
            //butonun tıklanabilirliğini ayarladık. false ile buton tıklanamaz hale geldi
            saveClickButton.isEnabled = false
            //yukarıdaki ayarlarla button görünür ama tıklanamaz şeklinde ayarlandı
        }
        
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
        saveClickButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    @objc func dismissKeyboard(){
        //ekranda herhangi bir yere tıklandığında klavyeyi kapatılması için eklendi.
        view.endEditing(true)
    }
    
    @IBAction func saveClickButton(_ sender: Any) {
        
        //
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //AppDelegate içindeki context e  ulaşıldı.
        let context = appDelegate.persistentContainer.viewContext
        
        
        let newPaintingEntry = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newPaintingEntry.setValue(nameTextField.text!, forKey: "name")
        newPaintingEntry.setValue(artistTextField.text, forKey: "artist")
        
        if let year = Int(yearTextField.text!){
            //düzgün değer gelip gelmediğini kontrol etmek için eklenmişdir.
            newPaintingEntry.setValue(year, forKey: "year")
        }
        newPaintingEntry.setValue(UUID(), forKey: "id")
        //image i dataya çevirme
        //compressionQuality demek ne kadar küçültüleceği bilgisini verir
        let data = imageView.image!.jpegData(compressionQuality: 0.5)!
        newPaintingEntry.setValue(data, forKey: "image")

        do{
            try context.save()
            print("succes")
        }catch{
            print("error")
        }
         
        //veriyi işlediğimizi söyleyip coredatadan tekrar çekmek için yapılan işlemler
        //yani datanın yenilendiğini bildirmemiz gerekiyor.
        //NotificationCenter diğer viewControllara mesaj yollamamızı sağlar.mesaj gönderilen sayfada newData değikeni dinlenir ve böyle bir mesaj gelirse gerekli işlemler güncellenir.newData stringi yerine istediğiniz bir string değerini girebilirsiniz sadece dinlenen sayfadaki değişkenle aynı olması gerekiuor çünkü bu değişken dineleniyor.
        NotificationCenter().post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    

}
