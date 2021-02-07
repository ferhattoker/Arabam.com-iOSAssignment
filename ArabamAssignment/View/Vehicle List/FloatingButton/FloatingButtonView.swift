//
//  FloatingButtonView.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 28.01.2021.
//

import UIKit

class FloatingButtonView: UIView {
    
    // MARK: - Properties
    var settingsButtonHandler: ( (Bool) -> Void )?
    var sortButtonHandler: ( () -> Void )?
    var filterButtonHandler: ( () -> Void )?
    
    fileprivate let settingsButton = UIButton(image: #imageLiteral(resourceName: "cogwheel"), tintColor: .systemRed)
    
    fileprivate let settingsContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    fileprivate let sortButton =
        UIButton(title: K.FloatingActionView.sort, backgroundColor: UIColor(named: K.CustomColor.secondaryColor), cornerRadius: 4)
    
    fileprivate let filterButton = UIButton(title: K.FloatingActionView.filter, backgroundColor: UIColor(named: K.CustomColor.secondaryColor), cornerRadius: 4)
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        setupSettingsButton()
        setupSettingsContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // to be able to recognize touch events on popup buttons
        for view in self.subviews {
            if view.isUserInteractionEnabled, view.point(inside: self.convert(point, to: view), with: event) {
                return true
            }
        }
        return false
    }
    
    fileprivate func setupSettingsButton() {
        settingsButton.backgroundColor = UIColor(named: K.CustomColor.primaryColor)
        settingsButton.clipsToBounds = true
        settingsButton.layer.cornerRadius = 24
        addSubview(settingsButton)
        settingsButton.constrainWidth(constant: 48.0)
        settingsButton.constrainHeight(constant: 48.0)
        settingsButton.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 16))
    }
    
    fileprivate func setupSettingsContainerView() {
        
        [settingsButton, sortButton, filterButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
            $0.tintColor = .systemRed
        }
        
        addSubview(settingsContainerView)
        settingsContainerView.anchor(top: nil, leading: nil, bottom: settingsButton.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 8), size: .init(width: 75, height: 0))

        let vstack = VerticalStackView(arrangedSubviews: [sortButton, filterButton], spacing: 4)
        settingsContainerView.addSubview(vstack)
        vstack.fillSuperview()
    }
    
    fileprivate var shouldButtonsPopup = true

    @objc fileprivate func buttonTapped(button: UIButton) {
        shouldButtonsPopup = !shouldButtonsPopup
        performAnimations(on: button)
    }
        
    fileprivate func performAnimations(on button: UIButton) {
        
        let img = self.shouldButtonsPopup ? #imageLiteral(resourceName: "cogwheel") : #imageLiteral(resourceName: "cancel")

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.settingsContainerView.isHidden = strongSelf.shouldButtonsPopup
            strongSelf.settingsButton.transform = strongSelf.settingsButton.transform.rotated(by: CGFloat.pi)
            strongSelf.settingsButton.setImage(img, for: .normal)

            switch button {
            case strongSelf.settingsButton:
                strongSelf.settingsButtonHandler?(strongSelf.shouldButtonsPopup)
                
            case strongSelf.sortButton:
                strongSelf.sortButtonHandler?()
                
            case strongSelf.filterButton:
                strongSelf.filterButtonHandler?()
                
            default:
                return
            }
        })

    }
    
    func dismissPopupButtons() {
        buttonTapped(button: settingsButton)
    }
}
