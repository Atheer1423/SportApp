//
//  ViewController.swift
//  SportApp
//
//  Created by admin on 29/12/2021.
//

import UIKit
import CloudKit
import CoreData

class ViewController: UITableViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var  context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    var sport : [Sport] = []
    var textFieldAlert : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSport()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sport.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: sportCell.self), for: indexPath) as! sportCell
        cell.labelOutlet.text =
        sport[indexPath.row].title!
        if let imageData = sport[indexPath.row].image{
            cell.imageOutlet.image = UIImage(data: imageData)}
        cell.index = indexPath.row
        cell.sport = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteSport(sport[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goToPlayerVC = storyboard?.instantiateViewController(withIdentifier: String(describing: PlayerUITableView.self)) as!  PlayerUITableView
        goToPlayerVC.sportItem = sport[indexPath.row].title!
        self.navigationController?.pushViewController(goToPlayerVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addNewSportVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddNewSport.self)) as!  AddNewSport
        addNewSportVC.sportToEdit = sport[indexPath.row]
        self.navigationController?.pushViewController(addNewSportVC, animated: true)
    }
    
    @IBAction func AddBtnPressed(_ sender: UIBarButtonItem) {
       
        let addNewSportVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddNewSport.self)) as!  AddNewSport
        self.navigationController?.pushViewController(addNewSportVC, animated: true)
    
    }
    
    func deleteSport(_ sportI:Sport){
        context.delete(sportI)
        do{
            try context.save()
            getSport()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func getSport(){
        let fetchRequest = NSFetchRequest<Sport>(entityName:"Sport")
        do {
            try sport = context.fetch(fetchRequest)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch {
            print(error.localizedDescription)
        }
    }
}
