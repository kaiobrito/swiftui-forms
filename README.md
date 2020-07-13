# SwiftUIForms

This a lightweight package based on [Formik](https://github.com/jaredpalmer/formik) to handle forms on SwiftUI. 

### Getting Started

SwiftUI forms works on top of a BaseFormContext and FormData. The BaseFormContext handles the form validation and submission, while FormData represents the data manipuled by the form. See the example below: 


```
struct SignUpFormData {
    var username: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var agreeWithTerms: Bool = false
}

extension SignUpFormData: FormData {
    var errors: Errors {
        [
            \SignUpFormData.username: self.username.isEmpty ? [] : [REQUIRED_ERROR_MESSAGE],
            \SignUpFormData.password: self.password.isEmpty ? [] : [REQUIRED_ERROR_MESSAGE],
            \SignUpFormData.confirmPassword: self.confirmPassword == self.password ? [] : [MATCHING_PASSWORD_ERROR_MESSAGE],
            \SignUpFormData.agreeWithTerms: self.agreeWithTerms ? [] : [REQUIRED_ERROR_MESSAGE]
        ]
    }
}
```
The FormData has an errors attribute that's a dictionary type where the key is a `PartialKeyPath<FormData>` and the value is an array with all the error messages. As an alternative, you can use a property wrapper called `@FormField` and pass validation rules as a parameters. Like in this example: 

```
struct SignUpFormData {
    @FormField(rules: [String.emptyValidation, String.with(min: 3, max: 25)])
    var username: String = ""

    @FormField(rules: [String.emptyValidation])
    var password: String = ""

    @FormField(rules: [String.emptyValidation])
    var confirmPassword: String = ""

    @FormField(rules: [{ $0 ? nil : "isRequired" }])
    var agreeWithTerms: Bool = false
}

extension SignUpFormData: FormData {
    var errors: Errors {
        [
            \SignUpFormData.username: self._username.errors,
            \SignUpFormData.password: self._password.errors,
            \SignUpFormData.confirmPassword: self._confirmPassword.errors,
            \SignUpFormData.agreeWithTerms: self._agreeWithTerms.errors
        ]
    }
}
```

With the FormData defined, you can use the BaseFormContext and connect it with your view:
```
let signUpForm = BaseFormContext(SignUpFormData())

SignUpView(form: signUpForm)
```
