//
//  editpicViewController.swift
//  My Dogs
//
//  Created by faisal on 04/05/1443 AH.
//

import UIKit
import CoreData

class editpicViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var food: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    var sel:Dog?
    var cr: NSManagedObjectContext?
    var imgp=UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text=sel?.name
        color.text=sel?.color
        food.text=sel?.food
        img.image=UIImage(data: (sel?.img)!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func don(_ sender: UIBarButtonItem) {
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
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cans(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func chang(_ sender: UIButton) {
        imgp.delegate = self
        imgp.allowsEditing=false
        imgp.sourceType = .photoLibrary
        present(imgp, animated: true, completion: nil)
    }
    
    @IBAction func del(_ sender: UIButton) {
        cr?.delete(sel!)
        if cr!.hasChanges {
            do {
                try cr!.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if let imgpick = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image=imgpick
        }
        sel!.img = img.image?.pngData()
       
        
    }
     
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
