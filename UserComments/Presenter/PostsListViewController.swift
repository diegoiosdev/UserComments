//
//  PostsListViewController.swift
//  UserComments
//
//  Created by Diego Fernando on 08/05/22.
//
import UIKit

class PostsListViewController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView()
    private var posts: [PostModel]? = nil

    // MARK: - LyfeCicle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Postagens Recentes"
        self.navigationController?.navigationBar.backgroundColor = .darkGray

        view.addSubview(tableView)
        bindUI()
        requestPosts()
    }

    // MARK: - Private funcitons

    func bindUI() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostViewCell.self, forCellReuseIdentifier: "PostViewCell")

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func requestPosts() {

        API().requestPosts { [weak self] posts, error in

            guard let strongSelf = self
            else {
                print("Erro ao capturar o self")
                return
            }

            if let error = error {
                print(error.errorDescription ?? "")
                return
            }

            strongSelf.posts = posts
            strongSelf.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension PostsListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let defaultCell = UITableViewCell()

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath) as? PostViewCell
        else {
            return defaultCell
        }

        if let post = posts?[indexPath.row] {
            cell.setupCell(post: post)
            return cell
        }

        return defaultCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let posts = posts else { return }

        let commentVC = CommentsViewController(postTitle: posts[indexPath.row].title, postId: posts[indexPath.row].id)

        self.navigationController?.pushViewController(commentVC, animated: true)
    }
}
