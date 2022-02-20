//
//  CarMapWireframe.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import UIKit

final class CarMapWireframe{
    static func carMapVC() -> CarMapVC{
        let mapVC = (Constants.mainStoryboard.instantiateViewController(withIdentifier: CarMapVC.storyboardID) as! CarMapVC)
        mapVC.tabBarItem.title = "Map"
        mapVC.tabBarItem.image = UIImage(systemName: "map")
        
        /// Instantiate VM
        let mapVM = CarMapViewModel(networkServices: NetworkServices(), delegate: mapVC)
        
        /// Set mapVM as mapVC's viewModel
        mapVC.viewModel = mapVM
        
        return mapVC
    }
}
