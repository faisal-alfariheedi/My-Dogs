//
//  addpicViewController.swift
//  My Dogs
//
//  Created by faisal on 04/05/1443 AH.
//

import UIKit
import CoreData


class addpicViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var food: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    var cr: NSManagedObjectContext?
    var imgp=UIImagePickerController()
    var con=false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        print(con)
        if(con){
            print("here")
            let dog=Dog(context: cr!)
            dog.name=String(name.text!)
            dog.color=String(color.text!)
            dog.food=String(food.text!)
            dog.img=img.image?.pngData()
            
            do{
                try cr?.save()
                print("saved")
            }catch{
                print("fuck there is error \(error)")
            }
            con=false
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addimg(_ sender: UIButton) {
        imgp.delegate = self
        imgp.allowsEditing=false
        imgp.sourceType = .photoLibrary
        present(imgp, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if let imgpick = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image=imgpick
        }
        con=true
        do{
        try cr?.save()
        }catch{
            print(error)
        }
        if cr!.hasChanges {
            do {
                try cr!.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        
    }
     
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        con=true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
