//
//  CarListWireframe.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import UIKit

class CarListWireframe{
    static func carListVC() -> CarListVC{
        
        /// Instantiate VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listVC = (storyboard.instantiateViewController(withIdentifier: CarListVC.storyboardID) as! CarListVC)
        listVC.tabBarItem.title = "List"
        listVC.tabBarItem.image = UIImage(systemName: "list.bullet")
        
        /// Instantiate VM
        let listVM = CarListViewModel(networkServices: NetworkServices(), delegate: listVC)
        
        /// Set listVM as listVC's viewModel
        listVC.viewModel = listVM
        
        return listVC        
    }
}

