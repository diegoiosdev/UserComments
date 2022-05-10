//
//  PostModel.swift
//  UserComments
//
//  Created by Diego Fernando on 04/05/22.
//

import Foundation

struct PostModel: Codable {

    let userId: Int
    let id: Int
    let title: String
    let body: String
}

