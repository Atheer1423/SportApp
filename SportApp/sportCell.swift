//
//  sportCell.swift
//  SportApp
//
//  Created by admin on 29/12/2021.
//

import UIKit

class sportCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var AddBtnOutlet: UIButton!
    var sport:ViewController?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageOutlet.isHidden = false
      
    }

    @IBAction func addImageBtnPressed(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        AddBtnOutlet.isHidden = true
        imageOutlet.isHidden = false
        sport!.present(imagePicker,animated: true, completion: nil)

    }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]) {

            let context = appDelegate.persistentContainer.viewContext
            let imagepicker = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            imageOutlet.image = imagepicker
            sport?.sport[index].image = imageOutlet.image?.jpegData(compressionQuality: 1)

            do {
                try context.save()

            }catch{
                print(error.localizedDescription)
            }
            picker.dismiss(animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
