//
//  CarListWireframe.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import UIKit

final class CarListWireframe{
    static func carListVC() -> CarListVC{
        
        /// Instantiate VC
        let listVC = (Constants.mainStoryboard.instantiateViewController(withIdentifier: CarListVC.storyboardID) as! CarListVC)
        listVC.tabBarItem.title = "List"
        listVC.tabBarItem.image = UIImage(systemName: "list.bullet")
        
        /// Instantiate VM
        let listVM = CarListViewModel(networkServices: NetworkServices(), delegate: listVC)
        
        /// Set listVM as listVC's viewModel
        listVC.viewModel = listVM
        
        return listVC        
    }
}

