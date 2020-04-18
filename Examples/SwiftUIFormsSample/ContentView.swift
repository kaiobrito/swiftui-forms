//
//  ContentView.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 17/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI
import SwiftUIForms

struct SignUpFormData {
    @FormField(rules: [String.emptyValidation])
    var username: String = ""

    @FormField(rules: [String.emptyValidation])
    var password: String = ""

    @FormField(rules: [String.emptyValidation])
    var confirmPassword: String = ""

    @FormField(rules: [{ $0 ? nil : "isRequired" }])
    var agreeWithTerms: Bool = false
}

extension SignUpFormData: FormData {
    var errors: [PartialKeyPath<SignUpFormData> : [String]] {
        [
            \SignUpFormData.username: self._username.errors,
            \SignUpFormData.password: self._password.errors,
            \SignUpFormData.confirmPassword: self._confirmPassword.errors,
            \SignUpFormData.agreeWithTerms: self._agreeWithTerms.errors
        ]
    }
}

struct ContentView: View {
    @ObservedObject var form = BaseFormContext(SignUpFormData())

    var body: some View {
        VStack(alignment: .center) {
            Text("Sign Up")
                .font(.largeTitle)
            Spacer()
            VStack {
                FieldView(\.username, form: self.form) { value, meta, _ in
                    TextInputView(
                        value: value,
                        label: "Username",
                        placeholder: "e.g: foobarz1992",
                        errors: meta.errors
                    )
                }
                FieldView(\.password, form: self.form) { value, meta, _ in
                    TextInputView(
                        value: value,
                        label: "Password",
                        placeholder: "e.g: secret",
                        errors: meta.errors
                    )
                }
                FieldView(\.confirmPassword, form: self.form) { value, meta, _ in
                    TextInputView(
                        value: value,
                        label: "Confirm Password",
                        placeholder: "e.g: secret",
                        errors: meta.errors
                    )
                }
                FieldView(\.agreeWithTerms, form: self.form) { value, meta, _ in
                    FormGroupView(label: "", errors: meta.errors) {
                        Toggle(isOn: value) {
                            Text("I agree to Privacy Policy")
                        }
                    }
                }
            }
            Spacer()
            Button(action: self.form.submit) {
                Text("Submit")
                    .padding()
            }
            .disabled(!form.isValid)
            .foregroundColor(.white)
            .background(Color.primary)
            .cornerRadius(8.0)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
