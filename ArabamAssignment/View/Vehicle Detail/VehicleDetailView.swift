//
//  VehicleDetailView.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 29.01.2021.
//

import UIKit

class VehicleDetailView: UIView {
        
    // MARK: - Properties
    var vehicleDetail: VehicleDetail? {
        didSet {
            guard let vehicleDetail = vehicleDetail else { return }
            let photos = vehicleDetail.photos.map { $0.replacingOccurrences(of: "{0}", with: K.ImageSize.size800x600) }
            let photo1Url = URL(string: photos[0])
            let photo2Url = URL(string: photos[1])
            
            vehicleImageView1.sd_setImage(with: photo1Url) { (_, error, _, _) in
                guard error == nil else { return }
                
                self.vehicleImageView2.sd_setImage(with: photo2Url) { (_, error, _, _) in
                    guard error == nil else { return }
                    self.activityIndicatorView.stopAnimating()
                }
            }
            DispatchQueue.main.async {
                self.detailView.vehicleDetail = vehicleDetail
                self.sellerDescView.vehicleDetail = vehicleDetail
            }
        }
    }
    
    var vehicleImageTappedHandler: ( (UIImage?) -> Void )?
    
    fileprivate let detailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.DetailView.vehicleDetails, for: .normal)
        button.setTitleColor(UIColor(named: K.CustomColor.labelColor), for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 0.2
        button.clipsToBounds = true
        return button
    }()
    
    fileprivate let sellerDescriptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.DetailView.sellerDescriptions, for: .normal)
        button.setTitleColor(UIColor(named: K.CustomColor.labelColor), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 0.2
        button.clipsToBounds = true
        return button
    }()
            
    fileprivate let activityIndicatorView : UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    fileprivate let imagePageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 2
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor(named: K.CustomColor.labelColor)?.withAlphaComponent(0.25)
        pc.currentPageIndicatorTintColor = UIColor(named: K.CustomColor.labelColor)?.withAlphaComponent(0.75)
        return pc
    }()
    
    fileprivate let imageSliderScrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.isPagingEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.clipsToBounds = true
        sv.layer.cornerRadius = 8
        return sv
    }()
    
    fileprivate let vehicleImageView1: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let vehicleImageView2: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let detailView = DetailView()
    fileprivate let sellerDescView = SellerDescriptionView()
    
    fileprivate var imageContentWidth: CGFloat = .zero
    fileprivate var imageContentHeight: CGFloat = .zero
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageContentWidth = frame.width
        self.imageContentHeight = frame.height
        
        imageSliderScrollView.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()

        if UIDevice.current.orientation.isLandscape {
            self.imageContentWidth *= 0.33
            self.imageContentHeight *= 0.66
            setupUIForLandscapeMode()
            setupLandscapeChangeDisplayButtonsUI()
            setupLandscapeBottomUI()
        } else {
            self.imageContentWidth *= 0.9
            self.imageContentHeight = self.imageContentWidth * 0.6
            setupTopImageSliderUI()
            setupChangeDisplayButtonsUI()
            setupBottomUI()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Function(s)
    // ===LANDSCAPE MODE=====================================================================================================
    fileprivate func setupUIForLandscapeMode() {
        addSubview(imageSliderScrollView)
        imageSliderScrollView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: imageContentWidth, height: imageContentHeight))
        imageSliderScrollView.delegate = self
        
        let imagesHStack = HorizontalStackView(
            arrangedSubviews: [
                vehicleImageView1,
                vehicleImageView2
            ], distribution: .fillEqually)
        
        imageSliderScrollView.addSubview(imagesHStack)
        imagesHStack.fillSuperview()

        imagesHStack.heightAnchor.constraint(equalTo: imageSliderScrollView.heightAnchor).isActive = true
        imagesHStack.widthAnchor.constraint(equalTo: imageSliderScrollView.widthAnchor, multiplier: 2).isActive = true
        
        
        imagePageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        addSubview(imagePageControl)
        imagePageControl.anchor(top: imageSliderScrollView.bottomAnchor, leading: imageSliderScrollView.leadingAnchor, bottom: nil, trailing: imageSliderScrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))


        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(vehicleImageTapped))
        imageSliderScrollView.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupLandscapeChangeDisplayButtonsUI() {
        let hstack = HorizontalStackView(
            arrangedSubviews: [detailsButton, sellerDescriptionButton],
            spacing: 8, distribution: .fillEqually, alignment: .center)
        
        addSubview(hstack)
        hstack.anchor(top: imageSliderScrollView.topAnchor, leading: imageSliderScrollView.trailingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 32))
        
        [detailsButton, sellerDescriptionButton].forEach {
            $0.addTarget(self, action: #selector(changeDisplayButtonsTapped(button:)), for: .primaryActionTriggered)
        }
    }
    
    fileprivate func setupLandscapeBottomUI() {
        addSubview(detailView)
        detailView.anchor(top: detailsButton.bottomAnchor, leading: detailsButton.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: sellerDescriptionButton.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))

        addSubview(sellerDescView)
        sellerDescView.anchor(top: detailsButton.bottomAnchor, leading: detailsButton.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: sellerDescriptionButton.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        sellerDescView.isHidden = true
    }
    
    

    
    // ===PORTRAIT MODE=====================================================================================================
    fileprivate func setupTopImageSliderUI() {
        addSubview(imageSliderScrollView)
        imageSliderScrollView.centerXInSuperview(topPadding: 8, size: .init(width: imageContentWidth, height: imageContentHeight))
        imageSliderScrollView.delegate = self
        
        let imagesHStack = HorizontalStackView(
            arrangedSubviews: [
                vehicleImageView1,
                vehicleImageView2
            ], distribution: .fillEqually)
        
        imageSliderScrollView.addSubview(imagesHStack)
        imagesHStack.fillSuperview()

        imagesHStack.heightAnchor.constraint(equalTo: imageSliderScrollView.heightAnchor).isActive = true
        imagesHStack.widthAnchor.constraint(equalTo: imageSliderScrollView.widthAnchor, multiplier: 2).isActive = true
        
        
        imagePageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        addSubview(imagePageControl)
        imagePageControl.anchor(top: imageSliderScrollView.bottomAnchor, leading: imageSliderScrollView.leadingAnchor, bottom: nil, trailing: imageSliderScrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))


        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(vehicleImageTapped))
        imageSliderScrollView.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupChangeDisplayButtonsUI() {
        let hstack = HorizontalStackView(
            arrangedSubviews: [detailsButton, sellerDescriptionButton],
            spacing: 8, distribution: .fillEqually, alignment: .center)
        
        addSubview(hstack)
        hstack.anchor(top: imagePageControl.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 32))
        
        [detailsButton, sellerDescriptionButton].forEach {
            $0.addTarget(self, action: #selector(changeDisplayButtonsTapped(button:)), for: .primaryActionTriggered)
        }
    }
    
    fileprivate func setupBottomUI() {
        addSubview(detailView)
        detailView.anchor(top: detailsButton.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))

        addSubview(sellerDescView)
        sellerDescView.anchor(top: detailsButton.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        sellerDescView.isHidden = true
    }
    
    // ========
    
    @objc fileprivate func vehicleImageTapped(_ sender: UITapGestureRecognizer) {
        
        if imagePageControl.currentPage == 0 {
            vehicleImageTappedHandler?(vehicleImageView1.image)
        } else {
            vehicleImageTappedHandler?(vehicleImageView2.image)
        }
    }
    
    @objc fileprivate func pageControlDidChange(pageControl: UIPageControl) {
        let current = CGFloat(pageControl.currentPage)
        imageSliderScrollView.setContentOffset(.init(x: current * imageContentWidth, y: 0), animated: true)
    }
    
    @objc fileprivate func changeDisplayButtonsTapped(button: UIButton) {
        
        UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve, animations: {
            switch button {
            case self.detailsButton:
                self.detailsButton.backgroundColor = .systemRed
                self.sellerDescriptionButton.backgroundColor = .clear
                self.detailView.isHidden = false
                self.sellerDescView.isHidden = true
                
            case self.sellerDescriptionButton:
                self.detailsButton.backgroundColor = .clear
                self.sellerDescriptionButton.backgroundColor = .systemRed
                self.detailView.isHidden = true
                self.sellerDescView.isHidden = false
                
            default:
                return
            }
        }, completion: nil)
    }
}

extension VehicleDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        imagePageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(imageContentWidth)))
    }
}
