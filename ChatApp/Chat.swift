//
//  Chat.swift
//  ChatApp
//
//  Created by Thidar Phyo on 10/17/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class Chat {
    var userName: String?
    var textSMS: String?
    var datePost: String?
    
    
    init(userName: String, textSMS: String, datePost: String) {
        self.userName = userName
        self.textSMS = textSMS
        self.datePost = datePost
    }
}
