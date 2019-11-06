//
//  ViewController.swift
//  ChatApp
//
//  Created by Thidar Phyo on 10/17/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var listOfChatInfo = [Chat]()
    var ref = DatabaseReference.init()
    var UserName : String?
    @IBOutlet weak var chatListTableView: UITableView!
    
    
    @IBOutlet weak var txtChat: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAnony()
        self.ref = Database.database().reference()
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfChatInfo.count
        //print(listOfChatInfo.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellChat: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellChat", for: indexPath) as! ChatTableViewCell
        cellChat.setChat(chat: listOfChatInfo[indexPath.row])
        //print(listOfChatInfo[indexPath.row])
        //self.chatListTableView.reloadData()
        return cellChat
    }
    
    func loadChatRoom() {
        self.ref.child("chat").queryOrdered(byChild: "postDate").observe(.value, with:
            {
                (snapshot) in
                self.listOfChatInfo.removeAll()
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        if let postData = snap.value as? [String: AnyObject] {

                            let username = postData["name"] as? String
                            let text = postData["text"] as? String
                            //let postDate = postData[""]
                            //print("userName\(username)")
                            //print("text\(text)")
                            var postDate: CLong?
                            if let postdateIn = postData["postDate"] as? CLong {
                                postDate = postdateIn
                            }
                            self.listOfChatInfo.append(Chat(userName: username!, textSMS: text!, datePost: "\(postDate!)"))
//                            self.listOfChatInfo.append(Chat(userName: username!, textSMS: text!, datePost: "\(postDate)"))
                            //print(self.listOfChatInfo)
                            //self.listOfChatInfo.append(postData)
                            print("postData\(postData)")
                                }
                            }
                    print(self.listOfChatInfo.count)
                    self.chatListTableView.reloadData()
                    let indexPath = IndexPath(row: self.listOfChatInfo.count - 1, section: 0)
                    //print(indexPath.row)
                    self.chatListTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
        })
//        self.ref.child("chat").queryOrdered(byChild: "postDate").observe(.value) { (snapshot) in
//            self.listOfChatInfo.removeAll()
//            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
//                for snap in snapshot {
//                    if let postData = snap.value as? [String: AnyObject] {
//                        let username = postData["name"] as? String
//                        let text = postData["text"] as? String
//                        //let postDate = postData[""]
//                        var postDate: CLong?
//                        if let postdateIn = postData["postDate"] as? CLong {
//                            postDate = postdateIn
//                        }
////                        self.listOfChatInfo.append(Chat(userName: username!, text: text!, datePost: "\(postDate)"))
//                        self.listOfChatInfo.append(Chat(userName: username!, text: text!, datePost: "\(postDate!)"))
//                    }
//                }
//                self.chatListTableView.reloadData()
//                let indexPath = IndexPath(row: self.listOfChatInfo.count - 1, section: 0)
//                self.chatListTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//            }
//        }
    }
    func loginAnony() {
        Auth.auth().signInAnonymously() {
            (user,error) in
            if let error = error {
                print("Can't login\(error)")
            } else {
                print("user UID \(user?.user.uid)")
                //print("name\(self.UserName)")
                //print("Text\()")
                self.loadChatRoom()
//                let ref = Database.database().reference().child("chat").child((user?.user.uid)!)
//                ref.observe(.childAdded, with: {
//                    snapshot in
//                    let postData = snapshot.value as? [String: AnyObject]
//                    let username = postData!["name"] as? String
//                    let text = postData!["text"] as? String
//                    var postDate: CLong?
//                    if let postdateIn = postData!["postDate"] as? CLong {
//                        postDate = postdateIn
//                    }
//                    self.listOfChatInfo.append(Chat(userName: username!, textSMS: text!, datePost: "\(postDate!)"))
//                    //print(self.listOfChatInfo)
//                    self.chatListTableView.reloadData()
//                    let indexPath = IndexPath(row: self.listOfChatInfo.count - 1, section: 0)
//                    self.chatListTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                })
                
            }
        }
    }
    
    @IBAction func btnSendToRoom(_ sender: UIButton) {
        let dict = [
            "text": txtChat.text,
            "name": UserName!,
            "postDate": ServerValue.timestamp()
        ] as [String: Any]
        //print(txtChat.text)
        self.ref.child("chat").childByAutoId().setValue(dict)
    }
    

}

