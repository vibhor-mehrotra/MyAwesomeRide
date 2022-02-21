//
//  CarListVC.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import UIKit

final class CarListVC: CarDisplayBaseVC{
    static let storyboardID = "CarListVC"
    
    @IBOutlet private var tableView: UITableView!
    
    var viewModel: CarListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCars()
    }
}

//MARK: - UITableView Datasource Methods
extension CarListVC: UITableViewDataSource, UITableViewDelegate{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = viewModel.dataForRow(at: indexPath) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTVCell.reuseID, for: indexPath) as! CarTVCell
        cell.configure(with: data)
        return cell
    }
}

//MARK: - CarDisplayViewModelDelegate Methods
extension CarListVC: CarDisplayViewModelDelegate{
    func showLoader(){
        showActivityIndicator()
    }
    
    func hideLoader(){
        hideActivityIndicator()
    }
    
    func refreshScreen(){
        self.tableView.reloadData()
    }
    
    func showError(_ error: String){
        showAlertView(message: error)
    }
}
