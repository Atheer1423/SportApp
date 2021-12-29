//
//  AddNewSport.swift
//  SportApp
//
//  Created by admin on 29/12/2021.
//

import UIKit
import CoreData

class AddNewSport: UIViewController {

    @IBOutlet weak var BtnOutlet: UIButton!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var  context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    @IBOutlet weak var TextFieldOutlet: UITextField!
    var sportToEdit : Sport?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if sportToEdit != nil {
            editSport()
        }
        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func AddBtnPressed(_ sender: UIButton) {
        if sportToEdit != nil {
            sportToEdit?.title = TextFieldOutlet.text
            sportToEdit.
            
        }else{
            
        let sport = Sport(context: context)
        if let text = TextFieldOutlet.text {
        sport.title = text
        }
        }
        
        do {
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func editSport(){
        TextFieldOutlet.text = sportToEdit?.title
        BtnOutlet.titleLabel?.text = "Edit"
    }
  

}
