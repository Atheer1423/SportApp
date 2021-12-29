//
//  AddPlayer.swift
//  SportApp
//
//  Created by admin on 29/12/2021.
//

import UIKit
import CoreData
class AddPlayer: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var  context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    @IBOutlet weak var Hieght: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var name: UITextField!
    var sportItem2 = " "
    @IBOutlet weak var BtnOutlet: UIButton!
    var playerToEdit : Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        if playerToEdit != nil {
            editPlayer()
        }
    }
    
    @IBAction func AddBtnPressed(_ sender: UIButton) {
        
        if playerToEdit != nil {
            playerToEdit!.name = name.text
            if let age = age.text {
            playerToEdit!.age = Int16(age) ?? 0
            }
            if let height = Hieght.text {
            playerToEdit!.hight = Int16(height) ?? 0
            }
            
        }else{
            
        let player = Player(context: context)
            player.sportItem = sportItem2
        
        if let Name = name.text {
            player.name = Name
        }
        if let age = age.text {
            player.age = Int16(age) ?? 0
        }
        if let hight = Hieght.text {
          
            player.hight = Int16(hight) ?? 0
        }
        }
        
        do {
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func editPlayer(){
        name.text = playerToEdit?.name
        age.text = String(Int(playerToEdit!.age))
        Hieght.text = String(Int(playerToEdit!.hight))
        BtnOutlet.titleLabel?.text = "Edit"
    }
    
}
