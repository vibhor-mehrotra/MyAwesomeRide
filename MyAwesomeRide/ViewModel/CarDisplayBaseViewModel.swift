//
//  BaseVM.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 20/02/22.
//

import Foundation

protocol CarDisplayViewModelDelegate: AnyObject{
    func showLoader()
    func hideLoader()
    func refreshScreen()
    func showError(_ error: String)
}

protocol CarDisplayBaseViewModelProtocol{
    func fetchCars()
}

class CarDisplayBaseViewModel: CarDisplayBaseViewModelProtocol{
    private let networkServices: NetworkServicesProtocol
    private let carAPIHost = "cdn.sixt.io"
    private let carAPIPath = "/codingtask/cars"
    private(set) var cars: [Car]?
    weak private(set) var delegate: CarDisplayViewModelDelegate?
    
    init(networkServices: NetworkServicesProtocol, delegate: CarDisplayViewModelDelegate){
        self.networkServices = networkServices
        self.delegate = delegate
    }
    
    func fetchCars(){
        self.delegate?.showLoader()
        self.networkServices.fetchData(host: carAPIHost, path: carAPIPath) { [weak self](result) in
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
}
