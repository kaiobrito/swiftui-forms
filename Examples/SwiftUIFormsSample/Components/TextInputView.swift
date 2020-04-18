//
//  TextInputView.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 17/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct TextInputView: View {
    var value: Binding<String>
    var label, placeholder: String
    var errors: [String]

    var body: some View {
        FormGroupView(label: label, errors: errors) {
            TextField(placeholder, text: value)
                .padding()
                .background(Color.gray.opacity(0.2))

            .cornerRadius(8.0)
        }
    }
}

struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputView(value: Binding.constant(""), label: "Label", placeholder: "Placeholder", errors: [])
    }
}
