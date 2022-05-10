//
//  PostViewCell.swift
//  UserComments
//
//  Created by Diego Fernando on 08/05/22.
//

import UIKit

final class PostViewCell: UITableViewCell {

    // MARK: - Properties

    private var title = UILabel()
    private var body = UILabel()

    // MARK: - Initializer

    func setupCell(post: PostModel) {

        addSubview(title)
        addSubview(body)

        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            body.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])

        title.text = post.title
        title.font = .systemFont(ofSize: 10)
        body.text = post.body
        body.font = .systemFont(ofSize: 14)
    }
}
