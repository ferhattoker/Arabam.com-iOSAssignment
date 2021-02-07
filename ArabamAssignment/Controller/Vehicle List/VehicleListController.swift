//
//  VehicleListController.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 27.01.2021.
//

import UIKit

class VehicleListController: UIViewController {
        
    // MARK: - Properties
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    fileprivate let settingsFloatingButtonView = FloatingButtonView()
    
    private lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.66)
        view.alpha = 0
        view.isUserInteractionEnabled = true
        return view
    }()
    
    fileprivate let nothingFoundLabel = UILabel(title: K.List.listEmptyMessage, font: .preferredFont(forTextStyle: .callout), numberOfLines: 0)

    fileprivate var isBottomSheetVisible = false
    
    var vehiclesList = [VehiclesList]()
    private var isPaginating = false
    private var isDonePaginating = false
    fileprivate var currentSortType: Sort = .init(kind: .date, direction: .ascending)
    fileprivate var currentFilterMode: Filter?
    
    fileprivate let cellHeight: CGFloat = 130.0
    fileprivate let numberOfCellInOneSection: CGFloat = 4.0
    fileprivate let spacingBtwCells: CGFloat = 10.0
    fileprivate var collectionViewHeight: CGFloat {
        return (cellHeight * numberOfCellInOneSection) + ((numberOfCellInOneSection - 1) * spacingBtwCells)
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: K.CustomColor.primaryColor)
    
        fetchVehicleList(sort: currentSortType, skip: 0, take: 10)
        setupCollectionView()
        setupDimView()
        setupSettingsFloatingButtonView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        dimView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = K.List.listTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Helper Functions
    fileprivate func fetchVehicleList(filter: Filter? = nil, sort: Sort, skip: Int, take: Int) {
        Service.shared.fetchVehicleList(filter: filter, sort: sort, skip: skip, take: take) { (list, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    self.view.showAlert(
                        title: K.AlertMessage.networkErrorTitle,
                        message: K.AlertMessage.networkErrorMessage,
                        positiveActionTitle: K.AlertMessage.positiveTitle)
                    return
                }
            }
            
            guard let list = list else { return }
            
            if list.count == 0 {
                self.isDonePaginating = true
            }
            sleep(1)
            self.vehiclesList += list
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                
                let shouldRemove = !(self.vehiclesList.count == 0)
                self.setupNothingFoundUI(shouldRemove: shouldRemove)
                if self.vehiclesList.count == take {
                    self.collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .top, animated: false)
                }
            }
            
            self.isPaginating = false
        }
    }
        
    fileprivate func setupNothingFoundUI(shouldRemove: Bool) {
        
        if shouldRemove {
            nothingFoundLabel.removeFromSuperview()
        } else {
            self.currentFilterMode = nil
            view.addSubview(nothingFoundLabel)
            nothingFoundLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        }
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeAreaLayoutGuide(padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ListHeader.identifier)
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.identifier)
        collectionView.register(ListFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ListFooter.identifier)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.decelerationRate = .fast
        }
    }
    
    fileprivate func setupDimView() {
        view.addSubview(dimView)
        dimView.fillSuperview()
    }
    
    fileprivate func setupSettingsFloatingButtonView() {
        view.addSubview(settingsFloatingButtonView)
        settingsFloatingButtonView.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 0))

        settingsFloatingButtonView.settingsButtonHandler = { [weak self] isHidden in
            self?.dimView.alpha = isHidden ? 0 : 1
        }
        
        settingsFloatingButtonView.sortButtonHandler = { [weak self] in
            self?.displayBottomSheet(for: .sort)
        }
        
        settingsFloatingButtonView.filterButtonHandler = { [weak self] in
            self?.displayBottomSheet(for: .filter)
        }
    }
    
    fileprivate var bottomSheetView = BottomSheetView(for: .sort)
    fileprivate func displayBottomSheet(for pageType: BottomSheetPageType) {
        
        isBottomSheetVisible = true
    
        bottomSheetView = BottomSheetView(for: pageType)
        
        let height: CGFloat
        if UIDevice.current.orientation.isLandscape {
            height = view.bounds.height * (pageType == .sort ? 0.5 : 0.8)
        } else {
            height = view.bounds.height * (pageType == .sort ? 0.33 : 0.5)
        }
        
        view.addSubview(bottomSheetView)
        bottomSheetView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: height))
        
        bottomSheetView.delegate = self
                
        bottomSheetView.animShow()
    }
        
    @objc fileprivate func viewTapped(gesture: UITapGestureRecognizer) {
        // if floating button's popup view is visible then dismiss it
        if dimView.alpha != 0, !isBottomSheetVisible, let view = gesture.view, view != settingsFloatingButtonView {
            settingsFloatingButtonView.dismissPopupButtons()
        }
    }
    
    
}

extension VehicleListController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehiclesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        
        let vehicle = vehiclesList[indexPath.item]
        cell.vehicle = vehicle
        
        if indexPath.item == self.vehiclesList.count - 1 && !isPaginating {
            isPaginating = true
            fetchVehicleList(filter: self.currentFilterMode, sort: self.currentSortType, skip: self.vehiclesList.count, take: 10)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ListHeader.identifier, for: indexPath) as! ListHeader
            
            header.configure(isListEmpty: self.vehiclesList.count == 0, filter: currentFilterMode, sort: currentSortType)

            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ListFooter.identifier, for: indexPath) as! ListFooter
            
            footer.configure()
            
            return footer
        }
    }
    
    
}

extension VehicleListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedVehicle = vehiclesList[indexPath.item]
        let vehicleDetailController = VehicleDetailController(id: selectedVehicle.id,
                                                              modelName: selectedVehicle.modelName)
        
        navigationController?.pushViewController(vehicleDetailController, animated: true)  
    }
    
    
}

extension VehicleListController: UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width - 32, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(item: 0, section: section)
        if let listHeader = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? ListHeader {
            let size = listHeader.headerLabel.sizeThatFits(.init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 0))
            return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: size.height + 16)
        }
        
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : cellHeight
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: height)
    }
    
    
}

extension VehicleListController: BottomSheetViewDelegate {
    
    func didDismissButtonTapped() {
        isBottomSheetVisible = false
        UIView.transition(with: bottomSheetView, duration: 0.2, options: .curveEaseInOut) {
            self.bottomSheetView.animHide()
            self.dimView.alpha = 0
        }
    }
    
    func didSortButtonsTapped(sort: Sort) {
        vehiclesList = []
        currentSortType = sort
        fetchVehicleList(filter: currentFilterMode, sort: sort, skip: 0, take: 10)
        bottomSheetView.dismissButtonHandler?()
        
    }
    
    func didApplyFilterButtonTapped(filter: Filter) {
        vehiclesList = []
        currentFilterMode = filter
        fetchVehicleList(filter: filter, sort: currentSortType, skip: 0, take: 10)
        bottomSheetView.dismissButtonHandler?()
    }
}
