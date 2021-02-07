//
//  ListCell.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 27.01.2021.
//

import UIKit
import SDWebImage

class ListCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = K.ListCell.identifier
    
    var vehicle: VehiclesList! {
        didSet {
            modelNameLabel.text = vehicle.modelName
            titleLabel.text = vehicle.title
            propertiesLabel.text = vehicle.properties.toString
            locationLabel.text = "📌 \(vehicle.location.toString)"
            priceLabel.text = "🏷 \(vehicle.price)₺"
            
            let photoString = vehicle.photo.replacingOccurrences(of: "{0}", with: K.ImageSize.size120x90)
            let photoUrl = URL(string: photoString)
            
            vehicleImageView.sd_setImage(with: photoUrl)
        }
    }
    

        
    fileprivate let vehicleImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    fileprivate let modelNameLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .headline))

    fileprivate let titleLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .footnote))
    
    fileprivate let propertiesLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .caption1))

    fileprivate let locationLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .caption2))
    
    fileprivate let priceLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .caption2))
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper(s)
    fileprivate func setupUI() {
        
        priceLabel.textColor = #colorLiteral(red: 0.9215686275, green: 0.3019607843, blue: 0.2941176471, alpha: 1)
                
        let imgSize: CGSize = .init(width: frame.height * 0.75, height: frame.height * 0.75)

        let imgContainerView = UIView()
        imgContainerView.layer.borderWidth = 0.5
        imgContainerView.layer.borderColor = UIColor.systemGray.cgColor
        imgContainerView.layer.cornerRadius = 4
        imgContainerView.clipsToBounds = true
        
        addSubview(imgContainerView)
        imgContainerView.centerYInSuperview(leadingPadding: 0, size: imgSize)
        
        imgContainerView.addSubview(vehicleImageView)
        vehicleImageView.fillSuperview()

        
        let vstack = VerticalStackView(
            arrangedSubviews: [
                modelNameLabel,
                titleLabel,
                propertiesLabel,
                locationLabel
            ],
            distribution: .equalCentering,
            alignment: .leading)

        addSubview(vstack)
        vstack.anchor(top: imgContainerView.topAnchor, leading: imgContainerView.trailingAnchor, bottom: imgContainerView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        vstack.addSubview(priceLabel)
        priceLabel.anchor(top: locationLabel.topAnchor, leading: nil, bottom: locationLabel.bottomAnchor, trailing: vstack.trailingAnchor)
        
        let seperatorView = UIView()
        addSubview(seperatorView)
        seperatorView.backgroundColor = .systemRed
        seperatorView.anchor(top: nil, leading: imgContainerView.leadingAnchor, bottom: bottomAnchor, trailing: vstack.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.2))
    }
}

