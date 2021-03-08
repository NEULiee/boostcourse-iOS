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
    var checkPassword: String?
    var textView: String?
}
