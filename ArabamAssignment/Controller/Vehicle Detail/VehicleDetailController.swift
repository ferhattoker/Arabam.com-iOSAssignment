//
//  VehicleDetailController.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 28.01.2021.
//

import UIKit

class VehicleDetailController: UIViewController {
    
    // MARK: - Properties
    fileprivate let id: Int
    fileprivate var vehicleDetail: VehicleDetail?
                
    fileprivate let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate let floatingCallView: UIView = {
        let fcv = UIView()
        fcv.layer.cornerRadius = 12.0
        fcv.clipsToBounds = true
        fcv.backgroundColor = UIColor.systemRed.withAlphaComponent(0.7)
        return fcv
    }()
    
    fileprivate let floatingCallViewHeight: CGFloat = 60.0

        
    fileprivate lazy var detailView = VehicleDetailView(frame: self.view.frame)
    
    // MARK: - Initializers
    init(id: Int, modelName: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = modelName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: K.CustomColor.primaryColor)
              
        setupScrollView()
        setupDetailView()
        fetchVehicleDetails()
        setupFloatingCallView()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanGestureHandler(recognizer:)))
        panGesture.delegate = self
        scrollView.addGestureRecognizer(panGesture)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods
    fileprivate func fetchVehicleDetails() {
        Service.shared.fetchVehicleDetail(of: id) { (result, error) in
            
            if let _ = error {
                DispatchQueue.main.async {
                    self.view.showAlert(
                        title: K.AlertMessage.networkErrorTitle,
                        message: K.AlertMessage.networkErrorMessage,
                        positiveActionTitle: K.AlertMessage.positiveTitle)
                    return
                }
            }
            
            self.vehicleDetail = result
            if let vehicleDetail = self.vehicleDetail {
                DispatchQueue.main.async {
                    self.detailView.vehicleDetail = vehicleDetail
                }
            }
        }
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
 
        scrollView.addSubview(contentView)
        contentView.anchor(top: scrollView.contentLayoutGuide.topAnchor, leading: scrollView.contentLayoutGuide.leadingAnchor, bottom: scrollView.contentLayoutGuide.bottomAnchor, trailing: scrollView.contentLayoutGuide.trailingAnchor)
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.centerInSuperview()
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = .init(250)
        heightConstraint.isActive = true
    }
        
    fileprivate func setupDetailView() {
        contentView.addSubview(detailView)
        detailView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
        
        detailView.vehicleImageTappedHandler = { [weak self] img in
            self?.imageTapped(img)
        }
    }
    
    fileprivate func setupFloatingCallView() {
        scrollView.addSubview(floatingCallView)
        floatingCallView.anchor(
            top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 16.0, bottom: -floatingCallViewHeight, right: 16.0),
            size: .init(width: 0, height: floatingCallViewHeight))
        
        let sellerlabel = UILabel(title: K.Detail.callOwner, font: .preferredFont(forTextStyle: .body))
        let callButton = UIButton(title: K.Detail.call, backgroundColor: UIColor(named: K.CustomColor.secondaryColor), cornerRadius: 8.0)
        callButton.setTitleColor(UIColor(named: K.CustomColor.labelColor), for: .normal)
        callButton.constrainWidth(constant: 80.0)
        callButton.addTarget(self, action: #selector(callButtonTapped), for: .primaryActionTriggered)
        
        let hstack = HorizontalStackView(
            arrangedSubviews: [
                sellerlabel,
                callButton
            ], spacing: 8.0, distribution: .equalCentering)
        floatingCallView.addSubview(hstack)
        hstack.fillSuperview(padding: .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0))
    }
    
    
    
    fileprivate func imageTapped(_ img: UIImage?) {
        let fullScreenImgView = UIImageView(image: img)
        fullScreenImgView.backgroundColor = .black
        fullScreenImgView.contentMode = .scaleAspectFit
        fullScreenImgView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        fullScreenImgView.addGestureRecognizer(tapGesture)
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(fullScreenImgView)
        fullScreenImgView.fillSuperview()
    }

    @objc fileprivate func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @objc fileprivate func callButtonTapped() {
        // doesn't work on simulator
        // use physical device
        if let phoneNumber = vehicleDetail?.userInfo.phoneFormatted,
           let url = URL(string: K.Detail.urlQueryScheme + phoneNumber),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc fileprivate func viewPanGestureHandler(recognizer: UIPanGestureRecognizer) {
        let translationY = recognizer.translation(in: scrollView).y
        
        let transform = translationY < 0 ? CGAffineTransform(translationX: 0, y: -floatingCallViewHeight - getStatusBarHeight()) : .identity
        
        UIView.animate(
            withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut,
            animations: {
                self.floatingCallView.transform = transform
        })
    }
    
    fileprivate func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}

extension VehicleDetailController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

