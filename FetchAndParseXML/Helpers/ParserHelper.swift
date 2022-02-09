//
//  XMLParserHelper.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import Foundation

class ParserHelper: NSObject, XMLParserDelegate {
 
    var stations: [Station] = []
    var elementName = ""
    var name = ""
    var identifier = ""
    var logoURL = ""
    var band = ""
    
    init(withData: Data, callback: (([Station]) -> Void)?) {
        super.init()
        let parser = XMLParser(data: withData)
        parser.delegate = self
        parser.parse()
        guard let c = callback else {return}
        c(stations)
    }
    
    //MARK: XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "Item" {
            name = ""
            identifier = ""
            logoURL = ""
            band = ""
        }
        
        self.elementName = elementName
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "Item" && (name.count + identifier.count + logoURL.count + band.count != 0)) {
            let station = Station(name: name, identifier: identifier, logoURL: logoURL, band: band)
            stations.append(station)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "StationId" {
                identifier += data
            } else if self.elementName == "StationName" {
                name += data
            } else if self.elementName == "Logo" {
                logoURL += data
            } else if self.elementName == "Band" {
                band += data
            }
        }
    }
}
