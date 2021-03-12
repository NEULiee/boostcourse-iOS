//
//  UserInformation.swift
//  mySignUpProj
//
//  Created by Ha Neul Iee on 2021/03/08.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var password: String?
    var textView: String?
    
    func insertInformation(id: String?, password: String?, textView: String?) {
        self.id = id
        self.password = password
        self.textView = textView
    }
    
    func deleteInformation() {
        self.id = nil
        self.password = nil
        self.textView = nil
    }
    
    private init() {}
}
