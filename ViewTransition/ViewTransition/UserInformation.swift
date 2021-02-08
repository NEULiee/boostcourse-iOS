//
//  UserInformation.swift
//  ViewTransition
//
//  Created by Ha Neul Iee on 2021/02/05.
//

import Foundation

class UserInformation {
    // 보안 취약 !
    static let shared: UserInformation = UserInformation()
    
    var name: String?
    var age: String?
}
