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
        Task {
            do {
                let data = try await networkServices.fetchData(host: carAPIHost, path: carAPIPath)
                self.cars = try JSONDecoder().decode([Car].self, from: data)
                await MainActor.run {
                    self.delegate?.hideLoader()
                    self.delegate?.refreshScreen()
                }
            } catch{
                await MainActor.run {
                    self.delegate?.hideLoader()
                    self.delegate?.showError(error.localizedDescription)
                }
            }
        }
    }
}
