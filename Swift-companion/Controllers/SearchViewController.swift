//
//  ViewController.swift
//  Swift-companion
//
//  Created by Quentin DEQUELEN on 1/22/18.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit

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
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = true

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 50

        self.tableView.register(UserCell.self, forCellReuseIdentifier: "userCell")
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
        api().getUsersRange({ (_users) in
            self.users = _users
        });
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        
        api().getUsersRange(startWith: searchController.searchBar.text!) { (_users) in
            self.users = _users
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        return cell
    }

}

