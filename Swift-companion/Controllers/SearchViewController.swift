//
//  ViewController.swift
//  Swift-companion
//
//  Created by Quentin DEQUELEN on 1/22/18.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    var tableView: UITableView = UITableView()

    var users: [UserIdentifier] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Seach"

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60

        self.tableView.register(UserCell.self, forCellReuseIdentifier: "userCell")
        self.view.addSubview(self.tableView)

        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        api().getUsersRange({ (_users) in
            self.users = _users
            self.tableView.reloadData()
        });
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        
        api().getUsersRange(startWith: searchController.searchBar.text!) { (_users) in
            self.users = _users
            self.tableView.reloadData()
        }
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.tableView.layoutIfNeeded()
        self.tableView.updateConstraints()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        cell.userLogin = users[indexPath.row].login
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        api().getUser(withId: users[indexPath.row].id!) { (user) in
            let view = UserViewController()
            view.user = user;
            self.navigationController?.pushViewController(view, animated: true)
        }
    }

}

