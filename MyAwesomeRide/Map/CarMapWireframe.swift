//
//  CarMapWireframe.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import UIKit

final class CarMapWireframe{
    static func carMapVC() -> CarMapVC{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = (storyboard.instantiateViewController(withIdentifier: CarMapVC.storyboardID) as! CarMapVC)
        mapVC.tabBarItem.title = "Map"
        mapVC.tabBarItem.image = UIImage(systemName: "map")
        return mapVC
    }
}
