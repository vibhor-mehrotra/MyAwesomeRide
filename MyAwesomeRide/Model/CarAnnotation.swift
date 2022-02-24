//
//  CarAnnotation.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 20/02/22.
//

import Foundation
import MapKit

/// Custum Annotation  for the car
final class CarAnnotation: NSObject {
    static let carAnnotationID = "carAnnotationID"
    let car: Car
    
    init(with car: Car) {
        self.car = car
    }
}

// Mark: - Extension to implement MKAnnotation
extension CarAnnotation: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        guard let lat = car.latitude, let long = car.longitude else {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String? {
        return car.modelName
    }
    
    var subtitle: String? {
        return car.licensePlate
    }
}
