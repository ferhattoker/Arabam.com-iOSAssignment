//
//  BottomFilterView.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 2.02.2021.
//

import UIKit

class BottomFilterView: UIView {
    
    var applyFilterButtonHandler: ( (Filter) -> Void )?
    
    fileprivate let filterLabel =
        UILabel(title: K.BottomSheetFilterView.filter, font: .preferredFont(forTextStyle: .body), textAlignment: .natural)
        
    fileprivate let categoryIdLabel = UILabel(title: K.BottomSheetFilterView.categoryId, font: .preferredFont(forTextStyle: .callout), textAlignment: .left, numberOfLines: 1)
    
    fileprivate lazy var categoryIdTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = K.BottomSheetFilterView.categoryId
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad
        tf.delegate = self
        tf.backgroundColor = UIColor(named: K.CustomColor.secondaryColor)?.withAlphaComponent(0.5)
        return tf
    }()

    fileprivate let dateRangeLabel = UILabel(title: K.BottomSheetFilterView.dateRangeTitle, font: .preferredFont(forTextStyle: .callout), textAlignment: .left, numberOfLines: 1)
    
    fileprivate let dateRangeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = K.BottomSheetFilterView.dateRangePlaceholder
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(named: K.CustomColor.secondaryColor)?.withAlphaComponent(0.5)
        tf.textColor = .systemGray
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    fileprivate let clearButton = UIButton(title: K.BottomSheetFilterView.clear)
    
    fileprivate let minDateLabel = UILabel(title: K.BottomSheetFilterView.min, font: .preferredFont(forTextStyle: .callout), textAlignment: .left, numberOfLines: 1)
    
    fileprivate let minDateDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.contentMode = .bottom
        dp.datePickerMode = .date
        dp.locale = .autoupdatingCurrent
        dp.tintColor = .systemRed
        dp.autoresizesSubviews = true
        return dp
    }()
        
    fileprivate let maxDateLabel = UILabel(title: K.BottomSheetFilterView.max, font: .preferredFont(forTextStyle: .callout), textAlignment: .left, numberOfLines: 1)
            
    fileprivate let maxDateDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.contentMode = .bottom
        dp.datePickerMode = .date
        dp.locale = .autoupdatingCurrent
        dp.tintColor = .systemRed
        dp.autoresizesSubviews = true
        return dp
    }()
    
    fileprivate let modelYearLabel = UILabel(title: K.BottomSheetFilterView.modelYear, font: .preferredFont(forTextStyle: .callout), textAlignment: .left, numberOfLines: 1)
            
    fileprivate lazy var minYearTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = K.BottomSheetFilterView.min
        tf.borderStyle = .roundedRect
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.backgroundColor = UIColor(named: K.CustomColor.secondaryColor)?.withAlphaComponent(0.5)
        return tf
    }()
    
    
    fileprivate lazy var maxYearTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = K.BottomSheetFilterView.max
        tf.borderStyle = .roundedRect
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.backgroundColor = UIColor(named: K.CustomColor.secondaryColor)?.withAlphaComponent(0.5)
        return tf
    }()
    
    fileprivate let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.BottomSheetFilterView.applyFilter, for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFilterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    fileprivate func setupFilterView() {
        filterLabel.textColor = .systemRed
        
        [categoryIdTextField, minYearTextField, maxYearTextField].forEach { $0.textColor = .systemRed }
     
        let seperatorLabel = UILabel(title: K.BottomSheetFilterView.seperator, font: .preferredFont(forTextStyle: .headline), textAlignment: .center)
        seperatorLabel.sizeToFit()
            
        let vstack = VerticalStackView(
            arrangedSubviews: [
                filterLabel,
                HorizontalStackView(arrangedSubviews: [categoryIdLabel, categoryIdTextField], distribution: .fillEqually, alignment: .center),
                dateRangeLabel,
                HorizontalStackView(arrangedSubviews: [dateRangeTextField, clearButton], spacing: 4, distribution: .fillProportionally, alignment: .center),
                HorizontalStackView(arrangedSubviews: [minDateLabel, minDateDatePicker, maxDateLabel, maxDateDatePicker], distribution: .fillProportionally, alignment: .center),
                HorizontalStackView(arrangedSubviews: [modelYearLabel, HorizontalStackView(arrangedSubviews: [minYearTextField, seperatorLabel, maxYearTextField], distribution: .fillEqually)], distribution: .fillEqually, alignment: .center),
                applyButton
            ], distribution: .fillEqually)
        
        addSubview(vstack)
        vstack.fillSuperview()
      
        setupFilterElementsTargets()
    }
    
    fileprivate func setupFilterElementsTargets() {
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .primaryActionTriggered)
        
        [minDateDatePicker, maxDateDatePicker].forEach {
            $0.addTarget(self, action: #selector(datePickerValueChangedHandler), for: .valueChanged)
        }
        
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .primaryActionTriggered)
    }
    
    fileprivate var minDate: (isPicked: Bool, date: String) = (false, K.BottomSheetFilterView.minDate)
    fileprivate var maxDate: (isPicked: Bool, date: String) = (false, K.BottomSheetFilterView.maxDate)
    
    @objc fileprivate func clearButtonTapped() {
        minDate = (false, K.BottomSheetFilterView.minDate)
        maxDate = (false, K.BottomSheetFilterView.maxDate)
        dateRangeTextField.text = ""
    }
    
    @objc fileprivate func datePickerValueChangedHandler(datepicker: UIDatePicker) {
        
        if datepicker == minDateDatePicker {

            dateRangeTextField.text = "\(datepicker.date.displayDate) - \(maxDate.date)"

            minDate = (true, datepicker.date.displayDate)
            return
        }
        
        if datepicker == maxDateDatePicker {
            
            dateRangeTextField.text = "\(minDate.date) - \(datepicker.date.displayDate)"
            
            maxDate = (true, datepicker.date.displayDate)
            return
        }
    }
    
    @objc fileprivate func applyButtonTapped() {
        
        var category, minYear, maxYear: Int?
        var minDate, maxDate: String?
    
        if let text = categoryIdTextField.text {
            category = Int(text)
        }
        
        if let text = minYearTextField.text, text.count > 0 {
            if text.count == 4 {
                minYear = Int(text)
            } else {
                showAlert(title: K.AlertMessage.YearDigitsErrorTitle,
                          message: K.AlertMessage.YearDigitsErrorMessage,
                          positiveActionTitle: K.AlertMessage.positiveTitle)
                return
            }
        }
        
        if let text = maxYearTextField.text, text.count > 0 {
            if text.count == 4 {
                maxYear = Int(text)
            } else {
                showAlert(title: K.AlertMessage.YearDigitsErrorTitle,
                          message: K.AlertMessage.YearDigitsErrorMessage,
                          positiveActionTitle: K.AlertMessage.positiveTitle)
                return
            }
        }
        
        if self.minDate.isPicked {
            minDate = minDateDatePicker.date.formattedDate
        }
        
        if self.maxDate.isPicked {
            maxDate = maxDateDatePicker.date.formattedDate
        }
        
        if category == nil, minDate == nil, maxDate == nil, minYear == nil, maxYear == nil {
            return
        }
               
        let filter = Filter(categoryId: category, minDate: minDate, maxDate: maxDate, minYear: minYear, maxYear: maxYear)
        applyFilterButtonHandler?(filter)
    }
    
}



extension BottomFilterView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == categoryIdTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        let maxLength = 4
        let s = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        guard NSString(string: s).length <= maxLength else { return false }
        
        if textField.text?.count == 0 {
            guard NSCharacterSet(charactersIn: K.BottomSheetFilterView.allowedFirstDigits).isSuperset(of: NSCharacterSet(charactersIn: string) as CharacterSet) else { return false }
            return true
        } else {
            guard NSCharacterSet(charactersIn: K.BottomSheetFilterView.allowedCharacters).isSuperset(of: NSCharacterSet(charactersIn: string) as CharacterSet) else { return false }
            return true
        }
    }
}
