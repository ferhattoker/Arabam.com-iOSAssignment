//
//  BottomSheetView.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 28.01.2021.
//

import UIKit

protocol BottomSheetViewDelegate: class {
    func didDismissButtonTapped()
    func didSortButtonsTapped(sort: Sort)
    func didApplyFilterButtonTapped(filter: Filter)
}

class BottomSheetView: UIView {
    
    // MARK: - Properties
    weak var delegate: BottomSheetViewDelegate?
    
    let currentPageType: BottomSheetPageType
    
    var dismissButtonHandler: ( () -> Void )?
    
    var sortButtonsHandler: ( (Sort) -> Void )?
    var applyButtonHandler: ( (Filter) -> Void )?
    
    fileprivate let dismissButton = UIButton(image: #imageLiteral(resourceName: "cancel"), tintColor: .systemRed)
    
    let sortView = BottomSortView()
    let filterView = BottomFilterView()
    

    // MARK: - Initializers
    init(for pageType: BottomSheetPageType) {
        self.currentPageType = pageType
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: K.CustomColor.primaryColor)

        setupUI()
                
        if pageType == .sort {
            setupSortView()
        } else {
            setupFilterView()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Method(s)
    fileprivate func setupUI() {
        
        layer.cornerRadius = 24
        dismissButton.backgroundColor = UIColor(named: K.CustomColor.primaryColor)
        dismissButton.clipsToBounds = true
        dismissButton.layer.cornerRadius = 18
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: -9, left: 0, bottom: 0, right: 0), size: .init(width: 36, height: 36))
        
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .primaryActionTriggered)
    }
    
    fileprivate func setupSortView() {
        addSubview(sortView)
        sortView.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        sortView.sortButtonsHandler = { [weak self] sort in
            self?.delegate?.didSortButtonsTapped(sort: sort)
            self?.delegate?.didDismissButtonTapped()
        }
    }
    
    fileprivate func setupFilterView() {
        addSubview(filterView)
        filterView.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        filterView.applyFilterButtonHandler = { [weak self] filter in
            self?.delegate?.didApplyFilterButtonTapped(filter: filter)
            self?.delegate?.didDismissButtonTapped()
        }
    }
    
    @objc fileprivate func dismissButtonTapped() {
        delegate?.didDismissButtonTapped()
    }
    
}
