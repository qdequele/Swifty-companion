//
//  UserViewController.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var user: UserModel?

    var projects: [ProjectModel]?

    var header: UserHeaderView = UserHeaderView()

    var scrollingView: UIScrollView = UIScrollView()
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false

        self.tableView.insetsContentViewsToSafeArea = true

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProjectCell.self, forCellReuseIdentifier: "projectCell")

        header.user = user
        projects = user?.projectsUsers?.filter({ (p) -> Bool in
            return p.cursusId != 4
        })
        scrollingView.isScrollEnabled = true

        scrollingView.addSubview(header)
        scrollingView.addSubview(tableView)
        self.view.addSubview(scrollingView)

        scrollingView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        header.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }


        tableView.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }

        self.tableView.reloadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.view.updateConstraints()
        self.view.layoutIfNeeded()

        self.scrollingView.updateConstraints()
        self.scrollingView.layoutIfNeeded()
        scrollingView.contentSize = CGSize(width: view.frame.width, height: header.frame.height + tableView.bounds.height)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollingView.contentSize = CGSize(width: view.frame.width, height: header.frame.height + tableView.bounds.height)
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects!.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectCell
        cell.project = projects![indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
