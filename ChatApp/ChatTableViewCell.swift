//
//  ChatTableViewCell.swift
//  ChatApp
//
//  Created by Thidar Phyo on 10/17/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var textMess: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setChat(chat: Chat) {
        userName.text = chat.userName
        message.text = chat.textSMS
         
    }

}
