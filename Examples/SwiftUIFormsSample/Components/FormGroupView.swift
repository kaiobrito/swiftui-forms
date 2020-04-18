//
//  FormGroupView.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 17/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI

struct FormGroupView<Content: View>: View {
    var label: String
    var content: Content
    var errors: [String]
    
    init(label: String, errors: [String] = [], @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
        self.errors = errors
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .multilineTextAlignment(.leading)
            content
            Text(errors.joined(separator: ", "))
                .font(.caption)
                .foregroundColor(.red)
        }
    }
}

struct FormGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FormGroupView(label: "Label", errors: ["Error", "This is required"]) {
            Text("Read Only")
        }
    }
}
