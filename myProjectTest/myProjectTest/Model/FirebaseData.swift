//
//  FirebaseData.swift
//  myProjectTest
//
//  Created by Vincent Lin on 2021/4/7.
//

import Foundation

class Global {
    static var user: String?
    static var userName: String?
    static var password: String?
    static var userPost: String?
    static var userEmail: String?
}

/// 用戶
struct User {
    var user: String
    var password: String
    var userName: String
    var userPost: String
    var userEmail: String
}
extension User {
    init(dic: [String: Any]) {
        user = dic["user"] as? String ?? ""
        password = dic["password"] as? String ?? ""
        userName = dic["userName"] as? String ?? ""
        userPost = dic["userPost"] as? String ?? ""
        userEmail = dic["userEmail"] as? String ?? ""
    }
}

/// 對戰事件
struct Initiate {
    var initiateDetail: String
    var initiator: String
    var initiator_name: String
    var initiatorActive: Int
    var receiver: String
    var state: Bool
    var time: Date
}
extension Initiate {
    init(dic: [String: Any]) {
        initiateDetail = dic["initiateDetail"] as? String ?? ""
        initiator = dic["initiator"] as? String ?? ""
        initiator_name = dic["initiator_name"] as? String ?? ""
        initiatorActive = dic["initiatorActive"] as? Int ?? 0
        receiver = dic["receiver"] as? String ?? ""
        state = dic["state"] as? Bool ?? false
        time = dic["time"] as? Date ?? Date()
    }
}

/// 對戰紀錄
struct Record {
    var initiator_name: String
    var intitiatesId: String
    var user: String
    var user_name: String
    var result: Int
    var time: Date
}
extension Record {
    init(dic: [String: Any]) {
        intitiatesId = dic["intitiatesId"] as? String ?? ""
        user = dic["user"] as? String ?? ""
        user_name = dic["user_name"] as? String ?? ""
        initiator_name = dic["initiator_name"] as? String ?? ""
        result = dic["result"] as? Int ?? 0
        time = dic["time"] as? Date ?? Date()
    }
}

