//
//  UserProfileViewController.swift
//  Project1
//
//  Created by Thanh Quach on 7/25/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import SnapKit

class UserProfileViewController: UIViewController {

    fileprivate let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupConstraints()
    }

    fileprivate func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    fileprivate func setupConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 1 {
            cell.textLabel?.text = "Logout"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            // Logout
            UserManager.share.signOut()
        }

        return nil
    }

}
