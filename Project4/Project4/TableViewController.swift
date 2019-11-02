//
//  TableViewController.swift
//  Project4
//
//  Created by Vlad Bataev on 11/2/19.
//  Copyright © 2019 Vlad Bataev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let webView = ViewController()
    var websites = ["youtube.com", "github.com", "facebook.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSite = websites[indexPath.row]
        webView.currentSite = currentSite

        navigationController?.pushViewController(webView, animated: true)
    }
}
