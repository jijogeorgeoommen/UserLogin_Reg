//
//  ViewController.swift
//  UserLogin_Reg
//
//  Created by JIJO G OOMMEN on 30/08/19.
//  Copyright © 2019 JIJO G OOMMEN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class UserModel {
    
    var id : String?
    var UserEmail : String?
    var Password : String?
    
    init(id : String, useremail : String, password : String) {
        self.id = id
        self.UserEmail = useremail
        self.Password = password
    }
    }

class LoginPage: UITableViewController {
    
    @IBOutlet var lg_email: UITextField!
    @IBOutlet var lg_password: UITextField!
    
    var usdefault_email : String?
    var usdefault_password : String?
    var user_ref : DatabaseReference!
    var userDetails = [UserModel]()
    
    @IBOutlet var loginoutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let backgroundImage = UIImage(named: "back5.jpg")
        
        let imageView = UIImageView(image: backgroundImage)
        self.loginoutlet.backgroundView = imageView
        
    }
    @IBAction func rEgbtn(_ sender: Any) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterPageid") as! RegisterPage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func lOginaCtion(_ sender: UIButton) {
        
        
        if lg_email.hasText && lg_password.hasText {
        obj.set(self.lg_email.text!, forKey: "useremail")
        obj.set(self.lg_password.text!,forKey: "userpassword")
        logintofirebase(email: lg_email.text!, password: lg_password.text!)
        usdefault_email = obj.value(forKey: "useremail") as? String
        print(usdefault_email)
        usdefault_password = obj.value(forKey: "userpassword")as? String
        print(usdefault_password)
        }
        else {
            popalert(title: "Empty fields", message: "")
        }
    }
    func logintofirebase (email : String, password :  String){
        user_ref = Database.database().reference().child("UserDetails")
        user_ref.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                for user in snapshot.children.allObjects as! [DataSnapshot]{
                    let userobject = user.value as? [String : AnyObject]
                    let userEmail = userobject?["UserEmail"] as? String
                    let userPassword = userobject?["Password"] as? String
                    if userEmail == self.lg_email.text! && userPassword == self.lg_password.text {
                        let ac = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePageid")as! ProfilePage
                        ac.useremail = self.usdefault_email as? String
                        self.navigationController?.pushViewController(ac, animated: true)
                    }
                   /* else {
                        self.popalert(title: "Inavalid", message: "Retry")
                    }*/
                }
            }
        }
    }
}

