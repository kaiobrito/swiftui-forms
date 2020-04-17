//
//  File.swift
//  
//
//  Created by Kaio Brito on 17/04/20.
//

import SwiftUI

public struct FieldView<Model: FormData, ValueType, Content: View>: FieldInput {
    public var form: BaseFormContext<Model>

    public var field: WritableKeyPath<Model, ValueType>

    public typealias ContentBuilder = (Binding<ValueType>, MetaData, BaseFormContext<Model>) -> Content

    public var content: ContentBuilder

    public init(_ field: WritableKeyPath<Model, ValueType>,
                form: BaseFormContext<Model>,
                @ViewBuilder content: @escaping ContentBuilder) {
        self.field = field
        self.form = form
        self.content = content
    }

    public var body: Content {
        self.content(self.value, MetaData(errors: errors), self.form)
    }
}
