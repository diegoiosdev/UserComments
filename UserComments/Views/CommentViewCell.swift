//
//  CommentViewCell.swift
//  UserComments
//
//  Created by Diego Fernando on 08/05/22.
//

import UIKit

final class CommentViewCell: UITableViewCell {

    // MARK: - Properties

    private var name = UILabel()
    private var email = UILabel()
    private var body = UILabel()

    // MARK: - Initializer

    func setupCell(comment: CommentModel) {

        addSubview(name)
        addSubview(email)
        addSubview(body)

        name.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 150),
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            email.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            body.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 5),
            body.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])

        name.text = "Name: \(comment.name)"
        name.font = .systemFont(ofSize: 10)
        email.text = "Email: \(comment.email)"
        email.font = .systemFont(ofSize: 10)
        body.text = comment.body
        body.font = .systemFont(ofSize: 14)
        body.numberOfLines = 0
    }
}

