//
//  SellerDescriptionView.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 1.02.2021.
//

import UIKit

class SellerDescriptionView: UIView {
        
    // MARK: - Properties
    var vehicleDetail: VehicleDetail? {
        didSet {
            guard let vehicleDetail = vehicleDetail else { return }
        
            DispatchQueue.main.async {
                let text = vehicleDetail.text.htmlToString
                if vehicleDetail.text.htmlToString.isEmpty {
                    self.descriptionInfoTextView.text = K.DetailView.descriptionEmptyMessage
                    self.descriptionInfoTextView.textColor = .darkGray
                } else {
                    self.descriptionInfoTextView.text = text
                }
            }
        }
    }
        
    fileprivate let descriptionInfoTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = .preferredFont(forTextStyle: .callout)
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
            
        setupSellerDescriptionsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Function(s)
    fileprivate func setupSellerDescriptionsUI() {
        addSubview(descriptionInfoTextView)
        descriptionInfoTextView.fillSuperview()
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
