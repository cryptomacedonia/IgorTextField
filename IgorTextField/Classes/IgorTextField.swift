
import RxCocoa


public extension  UITextField   {
    enum ValidationRule {
        case hasNumber(_ value:Bool)
        case hasUpperCase(_ value:Bool)
        case charactersCountMoreThan(_ numberOfCharacters:Int)
        case hasSpecialCharacter(_ value:Bool)
        case hasLowerCase(_ value:Bool)
        case hasSpace(_ value:Bool)
    }
    func addValidation(validators:[ValidationRule], errorLabel:UILabel, generalErrorString:String? = nil) {
       
        self.rx.text.bind { text in
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
                    if hasNumbers(text) != shouldHaveNumber {
                        errorFound = true
                    }
                    break;
                case .hasUpperCase(let shouldHaveUpperCase):
                    if hasUpperCase(text) != shouldHaveUpperCase {
                        errorFound = true
                    }
                    break;
                case .hasSpecialCharacter(let shouldHaveSpecialCharacter):
                    if hasSpecialCharacter(text) != shouldHaveSpecialCharacter {
                        errorFound = true
                    }
                    break;
                case .hasLowerCase(let shouldHaveLowerCase):
                    if hasLowerCase(text) != shouldHaveLowerCase {
                        errorFound = true
                    }
                    break;
                case .hasSpace(let shouldhaveSpace):
                    if hasSpace(text) != shouldhaveSpace {
                        errorFound = true
                    }
                    break;
                }
                if errorFound {
                    errorLabel.isHidden = false
                    errorLabel.text = generalErrorString
                    errorLabel.rootSuperView().layoutIfNeeded()
                } else {
                    errorLabel.isHidden = true
                    errorLabel.text = ""
                    errorLabel.rootSuperView().layoutIfNeeded()
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
