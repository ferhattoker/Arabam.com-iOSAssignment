//
//  DetailView.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 1.02.2021.
//

import UIKit

class DetailView: UIView {
        
    // MARK: - Properties
    var vehicleDetail: VehicleDetail? {
        didSet {
            guard let vehicleDetail = vehicleDetail else { return }
            
            DispatchQueue.main.async {
                self.titleLabel.text = vehicleDetail.title
                self.propertiesLabel.text = vehicleDetail.properties.toString
                self.categoryInfoTextView.text = String(vehicleDetail.category.id)
                self.modelInfoTextView.text = vehicleDetail.modelName
                self.locationInfoTextView.text = vehicleDetail.location.toString
                self.priceInfoTextView.text = "\(vehicleDetail.price)₺"
                self.adDateInfoTextView.text = vehicleDetail.dateFormatted
                self.sellerInfoTextView.text = vehicleDetail.userInfo.nameSurname
                self.sellerContactInfoTextView.text = vehicleDetail.userInfo.phoneFormatted
            }
        }
    }
    
                
    fileprivate let titleLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .headline), numberOfLines: 0, height: 32)
    fileprivate let propertiesLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .footnote), textAlignment: .center, numberOfLines: 2, height: 32)
    
    
    fileprivate let categoryTextView = UITextView(title: K.DetailView.categoryId, font: .preferredFont(forTextStyle: .callout), height: 32)
    fileprivate let categoryInfoTextView = UITextView(font: .preferredFont(forTextStyle: .callout), textAlignment: .right, height: 32)
    
    fileprivate let modelTextView = UITextView(title: K.DetailView.model, font: .preferredFont(forTextStyle: .callout), height: nil)
    fileprivate let modelInfoTextView = UITextView(font: .preferredFont(forTextStyle: .callout), textAlignment: .right, height: nil)
        
    fileprivate let locationTextView = UITextView(title: K.DetailView.location, font: .preferredFont(forTextStyle: .callout), height: 32)
    fileprivate let locationInfoTextView = UITextView(font: .preferredFont(forTextStyle: .callout), textAlignment: .right, height: 32)
    
    fileprivate let priceTextView = UITextView(title: K.DetailView.price, font: .preferredFont(forTextStyle: .callout), height: 32)
    fileprivate let priceInfoTextView = UITextView(font: .preferredFont(forTextStyle: .callout), textAlignment: .right, height: 32)
    
    fileprivate let adDateTextView = UITextView(title: K.DetailView.date, font: .preferredFont(forTextStyle: .callout), height: 32)
    fileprivate let adDateInfoTextView = UITextView(font: .preferredFont(forTextStyle: .callout), textAlignment: .right, height: 32)
        
    fileprivate let sellerTextView = UITextView(title: K.DetailView.seller, font: .preferredFont(forTextStyle: .callout), height: 32)
    fileprivate let sellerInfoTextView = UITextView(font: .preferredFont(forTextStyle: .callout), textAlignment: .right, height: 32)
    
    fileprivate let sellerContactTextView = UITextView(title: K.DetailView.sellerContact, font: .preferredFont(forTextStyle: .callout), height: 32)
    fileprivate let sellerContactInfoTextView = UITextView(font: .preferredFont(forTextStyle: .callout), textAlignment: .right, height: 32)
        
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
            
        setupVehicleDetailsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Function(s)
    fileprivate func setupVehicleDetailsUI() {
        
        let categoryHStack = HorizontalStackView(arrangedSubviews: [categoryTextView, categoryInfoTextView], spacing: 8, distribution: .equalCentering)
        let locationHStack = HorizontalStackView(arrangedSubviews: [locationTextView, locationInfoTextView], spacing: 8, distribution: .equalCentering)
        let adDateHStack = HorizontalStackView(arrangedSubviews: [adDateTextView, adDateInfoTextView], spacing: 8, distribution: .equalCentering)
        let sellerContactHStack = HorizontalStackView(arrangedSubviews: [sellerContactTextView, sellerContactInfoTextView], spacing: 8, distribution: .equalCentering)

        [categoryHStack, locationHStack, adDateHStack, sellerContactHStack].forEach {
            $0.layer.cornerRadius = 4
            $0.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        }
        
        let vstack = VerticalStackView(
            arrangedSubviews: [
                titleLabel,
                propertiesLabel,
                categoryHStack,
                HorizontalStackView(arrangedSubviews: [modelTextView, modelInfoTextView], spacing: 8, distribution: .equalCentering),
                locationHStack,
                HorizontalStackView(arrangedSubviews: [priceTextView, priceInfoTextView], spacing: 8, distribution: .equalCentering),
                adDateHStack,
                HorizontalStackView(arrangedSubviews: [sellerTextView, sellerInfoTextView], spacing: 8, distribution: .equalCentering),
                sellerContactHStack,
            ],
            spacing: 4)

        addSubview(vstack)
        vstack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }

}


