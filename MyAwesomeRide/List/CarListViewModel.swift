//
//  CarListViewModel.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import Foundation

protocol CarListViewModelDelegate: AnyObject{
    func showLoader()
    func hideLoader()
    func refreshScreen()
    func showError(_ error: String)
}

protocol CarListViewModelProtocol{
    func fetchCars()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func dataForRow(at indexPath: IndexPath) -> Car?
}

class CarListViewModel: CarListViewModelProtocol{
    private let networkServices: NetworkServices
    private let carAPIHost = "cdn.sixt.io"
    private let carAPIPath = "/codingtask/cars"
    private var cars: [Car]?
    weak private var delegate: CarListViewModelDelegate?
    
    init(networkServices: NetworkServices, delegate: CarListViewModelDelegate){
        self.networkServices = networkServices
        self.delegate = delegate
    }
    
    func fetchCars(){
        self.delegate?.showLoader()
        self.networkServices.fetchDataFor(host: carAPIHost, path: carAPIPath) { [weak self](result) in
            guard let `self` = self else{
                return
            }
            self.delegate?.hideLoader()
            switch result{
            case .success(let data):
                do{
                    self.cars = try JSONDecoder().decode([Car].self, from: data)
                    self.delegate?.refreshScreen()
                } catch let error{
                    self.delegate?.showError(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.showError(error.localizedDescription)
            }
        }
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
