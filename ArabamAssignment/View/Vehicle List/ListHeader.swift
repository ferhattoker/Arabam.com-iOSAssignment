//
//  ListHeader.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 2.02.2021.
//

import UIKit

class ListHeader: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier = K.ListHeader.identifier
        
    let headerLabel = UILabel(title: "", font: .preferredFont(forTextStyle: .footnote), numberOfLines: 0)

    
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
                    
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.textColor = .systemGray
        headerLabel.sizeToFit()
        
        addSubview(headerLabel)
        headerLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    func configure(isListEmpty: Bool, filter: Filter?, sort: Sort) {
        
        if isListEmpty {
            headerLabel.text = ""
            return
        }
        headerLabel.isHidden = false
        
        var headerTitle = ""
        
        if let filter = filter {
            headerTitle += K.ListHeader.beginning
            if let value = filter.categoryId {
                headerTitle +=  K.ListHeader.categoryId + " \(value), "
            }
            
            if let value = filter.maxDate {
                headerTitle += K.ListHeader.maxDate + " \(value), "
            }
            
            if let value = filter.minDate {
                headerTitle += K.ListHeader.minDate + " \(value), "
            }
            
            if let value = filter.minYear {
                headerTitle += K.ListHeader.minYear + " \(value), "
            }
            
            if let value = filter.maxYear {
                headerTitle += K.ListHeader.maxYear + " \(value), "
            }
            headerTitle.removeLast()
            headerTitle.removeLast()
        }
        
        if headerTitle.isEmpty {
            headerTitle += K.ListHeader.beginning
        } else {
            headerTitle += K.ListHeader.filtered
        }
        
        
        switch (sort.kind, sort.direction) {
        case (.price, .ascending):
            headerTitle += K.ListHeader.priceAscending
        case (.price, .descending):
            headerTitle += K.ListHeader.priceDescending
        case (.date, .ascending):
            headerTitle += K.ListHeader.dateAscending
        case (.date, .descending):
            headerTitle += K.ListHeader.dateDescending
        case (.year, .ascending):
            headerTitle += K.ListHeader.yearAscending
        case (.year, .descending):
            headerTitle += K.ListHeader.yearDescending
        }

        headerLabel.text = headerTitle
    }
}
