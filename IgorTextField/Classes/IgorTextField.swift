
import RxCocoa
import UIKit


public extension  UITextField   {
    struct ValidityStruct {
        static var _isValid:Bool = false
        static var validTextFields:[UITextField] = []
        static var notValidTextFields:[UITextField] = []
    }
    var ValidTextFields:[UITextField] {
        get {
            UITextField.ValidityStruct.validTextFields
        }
        set(newValue) {
            UITextField.ValidityStruct.validTextFields = newValue
            
            
        }
    }
    var NotValidTextFields:[UITextField] {
        get {
            UITextField.ValidityStruct.notValidTextFields
        }
        set(newValue) {
            UITextField.ValidityStruct.notValidTextFields = newValue
            
            
        }
    }
    
    
    var removeAll:Bool {
        get {
            false
        }
        set(newValue) {
            ValidityStruct.validTextFields.removeAll()
        }
    }
    var isValid:Bool {
        get {
            return  ValidityStruct.validTextFields.contains(self)
        }
        set(newValue) {
            if (newValue) {
                if  !ValidityStruct.validTextFields.contains(self) {
                    ValidityStruct.validTextFields.append(self)
                }
            } else {
                
                guard let indeks = ValidityStruct.validTextFields.firstIndex(of: self) else {return }
                ValidityStruct.validTextFields.remove(at: indeks)
            }
        }
    }
    enum ValidationRule {
        case hasNumber(_ value:Bool)
        case hasUpperCase(_ value:Bool)
        case charactersCountMoreThan(_ numberOfCharacters:Int)
        case hasSpecialCharacter(_ value:Bool)
        case hasLowerCase(_ value:Bool)
        case hasSpace(_ value:Bool)
    }
    func addValidation(validators:[ValidationRule], errorLabel:UILabel? = nil, generalErrorString:String? = nil,disableThisButton:UIButton? = nil) {
        let parentVC = self.parentViewController
        _ =  parentVC?.rx.deallocating.bind(onNext: {
            print(self.ValidTextFields)
            self.removeAll = true
        })
        _ =  self.rx.text.bind { text in
            guard let text = text else {
                return
            }
            var errorFound:Bool = false
            validators.forEach {validator in
                switch validator {
                case .charactersCountMoreThan(let numberofcharacters):
                    if text.count < numberofcharacters {
                        errorFound = true
                    }
                    break;
                case .hasNumber(let shouldHaveNumber):
                    if self.hasNumbers(text) != shouldHaveNumber {
                        errorFound = true
                    }
                    break;
                case .hasUpperCase(let shouldHaveUpperCase):
                    if self.hasUpperCase(text) != shouldHaveUpperCase {
                        errorFound = true
                    }
                    break;
                case .hasSpecialCharacter(let shouldHaveSpecialCharacter):
                    if self.hasSpecialCharacter(text) != shouldHaveSpecialCharacter {
                        errorFound = true
                    }
                    break;
                case .hasLowerCase(let shouldHaveLowerCase):
                    if self.hasLowerCase(text) != shouldHaveLowerCase {
                        errorFound = true
                    }
                    break;
                case .hasSpace(let shouldhaveSpace):
                    if self.hasSpace(text) != shouldhaveSpace {
                        errorFound = true
                    }
                    break;
                }
                self.isValid = !errorFound
                if errorFound {
                    var currentNotValid = self.NotValidTextFields
                    if !self.NotValidTextFields.contains(self) {
                        currentNotValid.append(self)
                        self.NotValidTextFields = currentNotValid
                    }
                    disableThisButton?.isEnabled = false
                    errorLabel?.isHidden = false
                    errorLabel?.text = generalErrorString
                    errorLabel?.rootSuperView().layoutIfNeeded()
                } else {
                    self.NotValidTextFields = self.NotValidTextFields.filter {$0 != self}
                    
                        
                    
                    if (self.NotValidTextFields.count == 0) {
                        disableThisButton?.isEnabled = true
                    }
                    errorLabel?.isHidden = true
                    errorLabel?.text = ""
                    errorLabel?.rootSuperView().layoutIfNeeded()
                }
                }
            }
        }
        func hasNumbers(_ text:String) -> Bool {
            for character in text{
                if character.isNumber{
                    return true
                }
            }
            return false
        }
        func hasSpecialCharacter(_ text:String) -> Bool {
            for character in text{
                if character.isSymbol{
                    return true
                }
            }
            return false
        }
        func hasSpace(_ text:String) -> Bool {
            for character in text{
                if character.isWhitespace{
                    return true
                }
            }
            return false
        }
        func hasUpperCase(_ text:String)-> Bool {
            
            for character in text{
                if character.isUppercase  {
                    return true
                }
            }
            return false
        }
        func hasLowerCase(_ text:String)-> Bool {
            
            for character in text{
                if character.isLowercase  {
                    return true
                }
            }
            return false
        }
    }

public   extension UIView {
    func rootSuperView() -> UIView
    {
        var view = self
        while let s = view.superview {
            view = s
        }
        return view
    }
}
public extension UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
