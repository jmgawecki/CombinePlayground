//
//  Follower.swift
//  SignUpFormCombine
//
//  Created by Jakub Gawecki on 26/05/2021.
//

import UIKit

protocol FollowerProtocol {
   var login: String { get set }
   var avatarUrl: String { get set }
}

struct Follower: FollowerProtocol, Codable, Hashable, Identifiable {
   var id = UUID()
    var login:      String
    var avatarUrl:  String
}
