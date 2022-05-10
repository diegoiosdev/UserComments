//
//  CommentsViewController.swift
//  UserComments
//
//  Created by Diego Fernando on 09/05/22.
 

import UIKit

import UIKit

class CommentsViewController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView()
    private var comments: [CommentModel]? = nil
    private var postTitle: String?
    private var postId: Int?

    // MARK: - Initializer

    init(
        postTitle: String,
        postId: Int
    ) {
        super.init(nibName: nil, bundle: nil)
        self.postTitle = postTitle
        self.postId = postId
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.postTitle = nil
        self.postId = nil
    }
    // MARK: - LyfeCicle

    override func viewDidLoad() {
        super.viewDidLoad()

        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "O que a galera comentou sobre \n'\(postTitle ?? "")'"
        self.navigationItem.titleView = label
        self.navigationController?.navigationBar.backgroundColor = .darkGray

        view.addSubview(tableView)
        bindUI()
    }

    func bindUI() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentViewCell.self, forCellReuseIdentifier: "CommentViewCell")

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        if let postId = postId {
            requestComments(postId: postId)
        }
    }

    func requestComments(postId: Int) {

        API().requestCommentsWithId(postId: postId) { [weak self] comments, error in

            guard let strongSelf = self
            else {
                print("Erro ao capturar o self")
                return
            }

            if let error = error {
                print(error.errorDescription ?? "")
                return
            }

            strongSelf.comments = comments
            strongSelf.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let defaultCell = UITableViewCell()

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentViewCell", for: indexPath) as? CommentViewCell
        else {
            return defaultCell
        }

        if let comments = comments?[indexPath.row] {
            cell.setupCell(comment: comments)
            return cell
        }

        return defaultCell
    }
}
