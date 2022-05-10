//
//  API.swift
//  UserComments
//
//  Created by Diego Fernando on 04/05/22.
//

import Foundation
import Alamofire

class API {

    func requestPosts(completion: @escaping ([PostModel]?, AFError?) -> Void) {

        AF
        .request("https://jsonplaceholder.typicode.com/posts")
        .validate()
        .responseDecodable(of: [PostModel].self) { response in

            if let error = response.error {
                completion(nil, error)
                return
            }

            completion(response.value, nil)
        }
    }

    func requestCommentsWithId(postId: Int, completion: @escaping ([CommentModel]?, AFError?) -> Void) {

        AF
        .request("https://jsonplaceholder.typicode.com/posts/\(String(postId))/comments")
        .validate()
        .responseDecodable(of: [CommentModel].self) { response in

            if let error = response.error {
                completion(nil, error)
                return
            }

            completion(response.value, nil)
        }
    }
}
