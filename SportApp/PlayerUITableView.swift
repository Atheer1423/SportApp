//
//  PlayerUITableView.swift
//  SportApp
//
//  Created by admin on 29/12/2021.
//

import UIKit
import CoreData
class PlayerUITableView: UITableViewController {
    
    @IBOutlet weak var NavigationTitle: UINavigationItem!
    var sportItem = " "
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var  context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    var players : [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationTitle.title = sportItem
        getPlayers()
    }

    @IBAction func AddBtnPressed(_ sender: UIBarButtonItem) {
        
         let addNewPlayerVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddPlayer.self)) as!  AddPlayer
        addNewPlayerVC.sportItem2 = sportItem
         self.navigationController?.pushViewController(addNewPlayerVC, animated: true)
    }
    
    func getPlayers() {
      
        let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
        let predicate = NSPredicate.init(format:"sportItem = %@", sportItem )
        fetchRequest.predicate = predicate
        do {
            try players = context.fetch(fetchRequest)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteSport(_ playerI:Player){
        context.delete(playerI)
        do{
            try context.save()
            getPlayers()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteSport(players[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addPlayerVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddPlayer.self)) as!  AddPlayer
        addPlayerVC.playerToEdit = players[indexPath.row]
        self.navigationController?.pushViewController(addPlayerVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var name = " "
        let  cell =
               tableView.dequeueReusableCell(withIdentifier: String(describing: playerCell.self), for: indexPath) as! playerCell
        if let Name = players[indexPath.row].name {
            name = Name
        }else {
            name = " "
        }
        
        cell.label.text = "\(name) - age: \(players[indexPath.row].age) , hieght: \(players[indexPath.row].hight) "
        
       return cell
    }
}
