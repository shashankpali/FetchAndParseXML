//
//  LoadXMLController.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import UIKit

class LoadXMLController: UITableViewController {

    var tableData: [Station]!
    var tableDataBySection = [[Station]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "XML Loader"
        groupStation()
        setupTable()
    }
    
    func groupStation() {
        let arr = tableData.sorted(by: { $0.band > $1.band })
        var refArray = [arr[0]]
        for idx in 1..<arr.count {
            if refArray.last!.band == arr[idx].band {
                refArray += [arr[idx]]
            }else {
                tableDataBySection += [refArray]
                refArray = [arr[idx]]
            }
        }
    }
    
    func setupTable() {
        tableView.register(LoadXMLCell.self, forCellReuseIdentifier: "LoadXMLCell")
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 50
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableDataBySection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableDataBySection[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoadXMLCell", for: indexPath) as! LoadXMLCell
        cell.setup(for: tableDataBySection[indexPath.section][indexPath.row])

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableDataBySection[section][0].band
    }
    
}
