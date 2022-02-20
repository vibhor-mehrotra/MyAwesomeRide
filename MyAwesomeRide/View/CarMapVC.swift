//
//  CarMapVC.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import UIKit
import MapKit

final class CarMapVC: CarDisplayBaseVC {
    static let storyboardID = "CarMapVC"
    
    @IBOutlet private var mapView: MKMapView!
    var viewModel: CarMapViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomAnnotation()
        viewModel.fetchCars()
    }
    
    private func registerCustomAnnotation(){
        mapView.register(CarAnnotationView.self, forAnnotationViewWithReuseIdentifier: CarAnnotationView.reuseID)
    }
}

extension CarMapVC: CarDisplayViewModelDelegate{
    func showLoader(){
        showActivityIndicator()
    }
    
    func hideLoader(){
        hideActivityIndicator()
    }
    
    func refreshScreen(){
        if let centre = viewModel.mapCentre {
            mapView.setRegion(centre, animated: true)
        }
        mapView.addAnnotations(viewModel.annotations)
    }
    
    func showError(_ error: String){
        showAlertView(message: error)
    }
}

// MARK: - MKMapViewDelegate Methods
extension CarMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let carAnnotation = annotation as? CarAnnotation else {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CarAnnotationView.reuseID) as? CarAnnotationView
        if annotationView == nil {
            annotationView = CarAnnotationView(annotation: carAnnotation, reuseIdentifier: CarAnnotationView.reuseID)
        }
        annotationView?.configureAnnotationView(with: carAnnotation)
        return annotationView
    }
}
