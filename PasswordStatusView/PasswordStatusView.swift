//
//  PasswordStatusView.swift
//  Password
//
//  Created by miadjalili on 5/24/22.
//


import UIKit

class  PasswordStatusView: UIView{
    let stackView = UIStackView()
    
    let criteriaLabel = UILabel()
    
    let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
    let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    
    var shouldRestCriteria: Bool  = true

    override init(frame: CGRect){
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width:200, height: 200)
    }
}

extension PasswordStatusView {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false

        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.distribution = .equalCentering
        
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowerCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowerCaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2.0),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2.0)
        ])
    }
}


extension PasswordStatusView {
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

        return attrText
    }
}

extension PasswordStatusView {
    func updateDisplay(_ text:String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        if shouldRestCriteria {
            lengthAndNoSpaceMet
            
            ?lengthCriteriaView.isCriteriaMet = true
            :lengthCriteriaView.rest()
            
            uppercaseMet
            ?uppercaseCriteriaView.isCriteriaMet = true
            :uppercaseCriteriaView.rest()
            
            lowercaseMet
            ?lowerCaseCriteriaView.isCriteriaMet = true
            :lowerCaseCriteriaView.rest()
            
            digitMet
            ?digitCriteriaView.isCriteriaMet = true
            :digitCriteriaView.rest()
            
            specialCharacterMet
            ?specialCharacterCriteriaView.isCriteriaMet = true
            :specialCharacterCriteriaView.rest()
            
        }else {
            lengthCriteriaView.isCriteriaMet = lengthAndNoSpaceMet
            uppercaseCriteriaView.isCriteriaMet = uppercaseMet
            lowerCaseCriteriaView.isCriteriaMet = lowercaseMet
            digitCriteriaView.isCriteriaMet = digitMet
            specialCharacterCriteriaView.isCriteriaMet = specialCharacterMet
        }
    }
    
    
    
    func validate(_ text: String) -> Bool {
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        let checkable = [uppercaseMet, lowercaseMet, digitMet, specialCharacterMet]
        let metCriteria = checkable.filter { $0 }
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        
        if lengthAndNoSpaceMet && metCriteria.count >= 3 {
            return true
        }
        
        // Ready Player1 🕹
        // Check for 3 of 4 criteria here...
        
        return false
    }
    
    
    
    func rest (){
        lengthCriteriaView.rest()
        uppercaseCriteriaView.rest()
        lowerCaseCriteriaView.rest()
        digitCriteriaView.rest()
        specialCharacterCriteriaView.rest()
    }
    
}

