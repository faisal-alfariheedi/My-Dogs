//
//  ViewController.swift
//  My Dogs
//
//  Created by faisal on 04/05/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var colv: UICollectionView!
    
    var list=[Dog]()
    let cr=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getall()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getall()
    }
    
    func getall(){
        let req=NSFetchRequest<NSFetchRequestResult>(entityName: "Dog")
        do{
            let fet = try cr.fetch(req)
            list = fet as! [Dog]
            
        }catch{
            print(error)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="add"{
           let seg = segue.destination as! addpicViewController
            seg.cr=cr
            
            
        }else if segue.identifier=="edit"{
            let seg = segue.destination as! editpicViewController
            seg.cr=cr
            seg.sel=(sender as! Dog)
            
        }
        
    }

}

extension ViewController:UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colv.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "edit", sender: list[indexPath.row])
    }
}
