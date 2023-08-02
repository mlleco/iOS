//
//  ViewController.swift
//  swiftSql
//
//  Created by NSR on 2023-07-10.
//

import UIKit
import CoreData

//xxxxxxxx.xx  is your server or hosting
class ViewController: UIViewController {
    
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var txtFull: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblTid: UILabel!
    @IBOutlet weak var lblUserid: UILabel!
    
    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var lblAuth: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func btnaction(_ sender: Any) {
        let url="https://xxxxxxxx.xx/userDetails.asmx/userDetails?usrname=\(txtFull.text!)&pass=\(txtpass.text!)"
        LoadURL(url: url)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let newRecord = MyDB(context: ctx)
        newRecord.id = (1)
        newRecord.key = txtFull.text
        do{
            ad.saveContext()
            print("Saved")
        }
        
        
        
    }
   
    @IBAction func btnShow(_ sender: Any) {
         
    }
    
    
    func LoadURL(url:String){
        
        //paralel process
        DispatchQueue.global().async {
            
            do{
                // load json server
                let AppURL=URL(string: url)
                let def =  URL (string: "https://xxxxxxxx.xx/userDetails.asmx/userDetails?usrname=&pass=")
                let data=try Data(contentsOf: ((AppURL ??  def)!))
                let json=try JSONSerialization.jsonObject(with: data ) as! [String:Any]
                //let fname=json["Fullname"] as!  [String:Any]
                
                print(json)
                // access to UI
                DispatchQueue.main.sync {
                    self.lblTid.text = "\(json["TID"]!)"
                    self.lblMessage.text = "\(json["Message"]!)"
                    self.lblUserid.text = "\(json["UserID"]!)"
                    self.lblFullname.text = "\(json["Fullname"]!)"
                    self.lblAuth.text = "\(json["Auth"]!)"
                    self.lblImage.text = "\(json["Image"]!)"
                    self.setImage(ImageUrl: "\(json["Image"]!)")
                    
                }
             }
            catch {
                print("cannot load from server")
            }
        }
        
    }
    
    // Load image URL from your server
    public func setImage(ImageUrl:String){
        DispatchQueue.global().async {
            do {
                let url = URL(string: ImageUrl)
                let def =  URL (string: "https://xxxxxxxx.xx/img/userimg/user.jpg")
                let data = try Data(contentsOf: ((url ??  def)!))
                 
                DispatchQueue.main.async {
                    self.userImg.image = UIImage(data: data)
                }
            } catch  {
                //handle the error
            }
            
            
        }
    }
}


 


