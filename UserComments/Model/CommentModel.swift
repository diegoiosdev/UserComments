//
//  CommentModel.swift
//  UserComments
//
//  Created by Diego Fernando on 04/05/22.
//

import Foundation

struct CommentModel: Codable {

    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

