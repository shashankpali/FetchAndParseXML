//
//  UIImageView+Extension.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        let loader = UIActivityIndicatorView.init(style: .large)
        self.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.make(center: .horizontally, toView: self)
        loader.make(center: .vertically, toView: self)
        loader.set(widthRatio: 0.8, respectToView: self)
        loader.startAnimating()
        
        Networking.get(forURLString: urlString, policy: .returnCacheDataElseLoad) { success, data, errorString in
            DispatchQueue.main.async(execute: { () -> Void in
                loader.removeFromSuperview()
                self.image = UIImage.init(named: "BlankImgHolder")!
                guard success else {return}
                let image = UIImage(data: data!)
                self.image = image
            })
        }
    }}
