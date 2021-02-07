//
//  HorizontalStackView.swift
//  
//
//  Created by Ferhat TOKER on 27.11.2020.
//

import UIKit

class HorizontalStackView: UIStackView {

    init(arrangedSubviews: [UIView], spacing: CGFloat = 0.0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        super.init(frame: .zero)
        
        self.axis = .horizontal
        arrangedSubviews.forEach { addArrangedSubview($0) }
        
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
