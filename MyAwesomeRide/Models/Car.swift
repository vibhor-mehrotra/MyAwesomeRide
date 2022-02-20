//
//  Car.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import Foundation

struct Car: Decodable{
    /// Car ID
    var id: String?
    
    /// Model name of the car
    var modelName: String?
    
    /// Car owner's name
    var name: String?
    
    /// Car company
    var make: String?
    
    /// Car color
    var color: String?
    
    /// Fuel type of the car
    var fuelType: FuelType?
    
    /// Car license plate
    var licensePlate: String?
    
    ///  Car latitude
    var latitude: Double?
    
    /// Car longitude
    var longitude: Double?
    
    /// Car image URL
    var carImageUrl: String?
    
    /// Car transmission mode
    var transmission: TransmissionMode?
    
    /// Car inner cleanliness
    var innerCleanliness: Cleanliness?
       
    
    /// Used for display purposes in the UI.
    enum DisplayKeys: String {
        case owner = "Owner"
        case modelName = "Model Name"
        case fuelType = "Fuel Type"
        case cleanliness = "Cleanliness"
        case transmission = "Transmission"
    }
    
    /// Type of fuel used by the car
    enum FuelType: String, Decodable {
        case diesel = "D"
        case petrol = "P"
        case electric = "E"
        
        var displayTitle: String {
            switch self {
            case .diesel:
                return "Diesel"
            case .petrol:
                return "Petrol"
            case .electric:
                return "Electric"
            }
        }
    }
    
    
    /// Mode of tranmission of the vehicle
    enum TransmissionMode: String, Decodable {
        case manual = "M"
        case automatic = "A"
        
        var displayTitle: String {
            switch self {
            case .manual:
                return "Manual"
            case .automatic:
                return "Automatic"
            }
        }
    }
    
    /// Cleanliness state of the car
    enum Cleanliness: String, Decodable {
        case clean = "CLEAN"
        case veryClean = "VERY_CLEAN"
        case regular = "REGULAR"
        
        var displayTitle: String {
            switch self {
            case .clean:
                return "Clean"
            case .veryClean:
                return "Very Clean"
            case .regular:
                return "Regular"
            }
        }
    }
}
