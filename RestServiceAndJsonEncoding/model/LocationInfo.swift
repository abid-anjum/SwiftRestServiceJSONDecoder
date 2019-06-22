//
//  LocationInfo.swift
//  RestServiceAndJsonEncoding
//
//  Created by abid hussain on 19/10/1440 AH.
//  Copyright © 1440 abid hussain. All rights reserved.
//

import Foundation

class LocationInfo: Codable {
    let objects: [LocationDetail]
    
    init(objects: [LocationDetail]) {
        self.objects = objects
    }
}

class LocationDetail: Codable {
    let id: Int
    let label, country, zip, city: String
    let street, streetNumber: String
    let lat, lon: Double
    let srid: Int
    
    enum CodingKeys: String, CodingKey {
        case id, label, country, zip, city, street
        case streetNumber = "street_number"
        case lat, lon, srid
    }
    
    init(id: Int, label: String, country: String, zip: String, city: String, street: String, streetNumber: String, lat: Double, lon: Double, srid: Int) {
        self.id = id
        self.label = label
        self.country = country
        self.zip = zip
        self.city = city
        self.street = street
        self.streetNumber = streetNumber
        self.lat = lat
        self.lon = lon
        self.srid = srid
    }
}
