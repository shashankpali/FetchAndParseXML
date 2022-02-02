//
//  LoadXMLCell.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import UIKit

class LoadXMLCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(for model: Station) {
        textLabel?.text = model.name
        imageView?.imageFromServerURL(urlString: model.logoURL, PlaceHolderImage: UIImage.init(named: "Placeholder")!)
    }

}
