//
//  SecureInputView.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 18/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct SecureInputView: View {
    var value: Binding<String>
     var label, placeholder: String
     var errors: [String]

     var body: some View {
         FormGroupView(label: label, errors: errors) {
             SecureField(placeholder, text: value)
                 .padding()
                 .background(Color.gray.opacity(0.2))

             .cornerRadius(8.0)
         }
     }
}

struct SecureInputView_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputView(value: Binding<String>.constant(""), label: "Password", placeholder: "secret", errors: [])
    }
}
