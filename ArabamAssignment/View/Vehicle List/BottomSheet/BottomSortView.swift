//
//  BottomSortView.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 2.02.2021.
//

import UIKit

class BottomSortView: UIView {
        
    var sortButtonsHandler: ( (Sort) -> Void )?
    
    fileprivate let sortLabel =
        UILabel(title: K.BottomSheetSortView.sort, font: .preferredFont(forTextStyle: .headline), textAlignment: .natural)

    fileprivate let sortPriceFromLowerToHigherButton =
        UIButton(title: K.BottomSheetSortView.priceAscending, contentHorizontalAlignment: .leading)
    
    fileprivate let sortPriceFromHigherToLowerButton =
        UIButton(title: K.BottomSheetSortView.priceDescending, contentHorizontalAlignment: .leading)
    
    fileprivate let sortDateFromLowerToHigherButton =
        UIButton(title: K.BottomSheetSortView.dateAscending, contentHorizontalAlignment: .leading)
    
    fileprivate let sortDateFromHigherToLowerButton =
        UIButton(title: K.BottomSheetSortView.dateDescending, contentHorizontalAlignment: .leading)
    
    fileprivate let sortYearFromLowerToHigherButton =
        UIButton(title: K.BottomSheetSortView.yearAscending, contentHorizontalAlignment: .leading)
    
    fileprivate let sortYearFromHigherToLowerButton =
        UIButton(title: K.BottomSheetSortView.yearDescending, contentHorizontalAlignment: .leading)
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSortView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    fileprivate func setupSortView() {
        sortLabel.textColor = .systemRed
        
        [
            sortPriceFromLowerToHigherButton, sortPriceFromHigherToLowerButton,
            sortDateFromLowerToHigherButton, sortDateFromHigherToLowerButton,
            sortYearFromLowerToHigherButton, sortYearFromHigherToLowerButton
        ].forEach {
            $0.addTarget(self, action: #selector(sortButtonsTapped), for: .primaryActionTriggered)
            $0.setTitleColor(UIColor(named: K.CustomColor.labelColor), for: .normal)
        }
        
        let vstack = VerticalStackView(
            arrangedSubviews: [
                sortLabel,
                sortPriceFromLowerToHigherButton, sortPriceFromHigherToLowerButton,
                sortDateFromLowerToHigherButton, sortDateFromHigherToLowerButton,
                sortYearFromLowerToHigherButton, sortYearFromHigherToLowerButton
            ], distribution: .fillEqually )
        
        addSubview(vstack)
        vstack.fillSuperview()
    }
    
    @objc fileprivate func sortButtonsTapped(button: UIButton) {
        
        let sortKind: SortKind
        let sortDirection: SortDirections
        
        switch button {
        case sortPriceFromLowerToHigherButton:
            sortKind = .price
            sortDirection = .ascending
            
        case sortPriceFromHigherToLowerButton:
            sortKind = .price
            sortDirection = .descending
            
        case sortDateFromLowerToHigherButton:
            sortKind = .date
            sortDirection = .ascending
            
        case sortDateFromHigherToLowerButton:
            sortKind = .date
            sortDirection = .descending
            
        case sortYearFromLowerToHigherButton:
            sortKind = .year
            sortDirection = .ascending
            
        case sortYearFromHigherToLowerButton:
            sortKind = .year
            sortDirection = .descending
            
        default:
            return
        }
        
        let sort = Sort(kind: sortKind, direction: sortDirection)
        sortButtonsHandler?(sort)
    }
}
