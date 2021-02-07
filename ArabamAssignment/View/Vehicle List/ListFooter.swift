//
//  ListFooter.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 28.01.2021.
//

import UIKit

class ListFooter: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier = K.ListFooter.identifier
    
    fileprivate let activityIndicatorView : UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    private let loadingLabel = UILabel(title: K.ListFooter.loading, font: .preferredFont(forTextStyle: .body))

    
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
        
        loadingLabel.textAlignment = .center
        
        let hstack = HorizontalStackView(arrangedSubviews: [
            activityIndicatorView,
            loadingLabel
        ], spacing: 8.0, alignment: .center)
        
        addSubview(hstack)
        hstack.centerInSuperview()
    }
    
    func configure() {
        activityIndicatorView.startAnimating()
    }
}
