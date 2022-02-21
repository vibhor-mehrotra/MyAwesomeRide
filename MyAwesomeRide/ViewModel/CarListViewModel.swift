//
//  CarListViewModel.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import Foundation


protocol CarListViewModelProtocol: CarDisplayBaseViewModelProtocol{
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func dataForRow(at indexPath: IndexPath) -> Car?
}

final class CarListViewModel: CarDisplayBaseViewModel, CarListViewModelProtocol{

    override init(networkServices: NetworkServicesProtocol, delegate: CarDisplayViewModelDelegate){
        super.init(networkServices: networkServices, delegate: delegate)
    }
    
    func numberOfSections() -> Int{
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int{
        return cars?.count ?? 0
    }
    
    func dataForRow(at indexPath: IndexPath) -> Car?{
        guard let car = cars?[indexPath.row] else{
            return nil
        }
        return car
    }
}
