//
//  CitySelectionCell.swift
//  MyWeatherApp
//
//  Created by Munsif Hayat on 02/02/2022.
//

import UIKit

class CitySelectionCell: UITableViewCell {
    
    @IBOutlet var lbCityName: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: CityCellViewModel? {
        didSet {
            lbCityName.text = cellViewModel?.cityName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbCityName.text = nil
    }
    
}
