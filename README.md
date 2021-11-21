# IgorTextField

[![CI Status](https://img.shields.io/travis/cryptomacedonia/IgorTextField.svg?style=flat)](https://travis-ci.org/cryptomacedonia/IgorTextField)
[![Version](https://img.shields.io/cocoapods/v/IgorTextField.svg?style=flat)](https://cocoapods.org/pods/IgorTextField)
[![License](https://img.shields.io/cocoapods/l/IgorTextField.svg?style=flat)](https://cocoapods.org/pods/IgorTextField)
[![Platform](https://img.shields.io/cocoapods/p/IgorTextField.svg?style=flat)](https://cocoapods.org/pods/IgorTextField)

## Example
add UITextfield's to your view, connect the outlets, add optional button that need to be enabled when all validation passes, and use something along the llines as written below. Enjoy!

 self.textField.addValidation(validators: [.hasUpperCase(true), .hasSpace(true)], errorLabel: errorLabel, generalErrorString: "Not valid string!",disableThisButton: submitButton)
 
 self.textField2.addValidation(validators: [.hasUpperCase(true)], errorLabel: errorLabel2, generalErrorString: "Not valid string2!",disableThisButton: submitButton)
    
        
## Requirements

## Installation

IgorTextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IgorTextField', :git => 'https://github.com/cryptomacedonia/IgorTextField.git'
```

## Author

cryptomacedonia, igor@edit8.com

## License

IgorTextField is available under the Macedonian license. You must post a tweet with content "Republic of Macedonia forever!"
