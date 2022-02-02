//
//  LoadXMLController.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import UIKit

class LoadXMLController: UITableViewController {

    var tableData: [Station]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "XML Loader"
        setupTable()
    }
    
    func setupTable() {
        tableView.register(LoadXMLCell.self, forCellReuseIdentifier: "LoadXMLCell")
        tableView.rowHeight = 80
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoadXMLCell", for: indexPath) as! LoadXMLCell
        cell.setup(for: tableData[indexPath.row])

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
