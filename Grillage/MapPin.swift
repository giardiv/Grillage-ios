//
//  MapPin.swift
//  Grillage
//
//  Created by Vincent on 23/06/2016.
//  Copyright © 2016 Vincent. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}