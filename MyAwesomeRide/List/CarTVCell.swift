//
//  CarTVCell.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import UIKit

final class CarTVCell: UITableViewCell {
    static let reuseID = "CarTVCell"
    
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var owner: UILabel!
    @IBOutlet private weak var modelName: UILabel!
    @IBOutlet private weak var fuelType: UILabel!
    @IBOutlet private weak var cleanliness: UILabel!
    @IBOutlet private weak var transmission: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// Set placeholder image
        carImageView.image = #imageLiteral(resourceName: "ridePlaceholder.png")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        /// Reset the values before reuse
        carImageView.image = #imageLiteral(resourceName: "ridePlaceholder.png")
        owner.text = nil
        modelName.text = nil
        fuelType.text = nil
        cleanliness.text = nil
        transmission.text = nil
    }
    
    func configure(with data: Car){
        carImageView.loadImage(url: data.carImageUrl)
        owner.attributedText = attributedString(with: Car.DisplayKeys.owner.rawValue, value: data.name ?? "")
        modelName.attributedText = attributedString(with: Car.DisplayKeys.modelName.rawValue, value: data.modelName)
        fuelType.attributedText = attributedString(with: Car.DisplayKeys.fuelType.rawValue, value: data.fuelType?.displayTitle)
        cleanliness.attributedText = attributedString(with: Car.DisplayKeys.cleanliness.rawValue, value: data.innerCleanliness?.displayTitle)
        transmission.attributedText = attributedString(with: Car.DisplayKeys.transmission.rawValue, value: data.transmission?.displayTitle)
    }

}

private extension CarTVCell {
    
    /// Used to generate a combined attributed string with titles in Bold and value with regular weight.
    func attributedString(with title: String, value: String?) -> NSAttributedString? {
        guard let _value = value else{
            return nil
        }
        let attribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedTitle = NSMutableAttributedString(string: title, attributes: attribute)
        attributedTitle.append(NSAttributedString(string: ": \(_value)"))
        return attributedTitle
    }
}
