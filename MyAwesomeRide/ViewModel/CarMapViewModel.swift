//
//  CarMapViewModel.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 20/02/22.
//

import Foundation
import MapKit

protocol CarMapViewModelProtocol: CarDisplayBaseViewModel{
    var mapCentre: MKCoordinateRegion? { get }
    var annotations: [MKAnnotation] { get }
}

final class CarMapViewModel: CarDisplayBaseViewModel, CarMapViewModelProtocol{
    // set the approximate radius for now
    private let focusRadius: CLLocationDistance = 5000
    
    override init(networkServices: NetworkServicesProtocol, delegate: CarDisplayViewModelDelegate){
        super.init(networkServices: networkServices, delegate: delegate)
    }
    
    lazy var mapCentre: MKCoordinateRegion? = {
        guard let cars = self.cars, cars.count > 0 else {
            return nil
        }
        
        let car = cars[0]
        guard let lat = car.latitude, let long = car.longitude else {
            return nil
        }
        let homePinLocation = CLLocation(latitude: lat, longitude: long)
        
        return MKCoordinateRegion(center: homePinLocation.coordinate, latitudinalMeters: focusRadius, longitudinalMeters: focusRadius)
    }()
    
    lazy var annotations: [MKAnnotation] = {
        var annotations = [MKAnnotation]()
        if let cars = self.cars  {
            for car in cars {
                annotations.append(CarAnnotation(with: car))
            }
        }
        return annotations
    }()
}
