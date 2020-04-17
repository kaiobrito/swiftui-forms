//
//  FieldInput.swift
//  
//
//  Created by Kaio Brito on 17/04/20.
//
import SwiftUI

public struct MetaData {
    public var errors: [String]
}

protocol FieldInput: View {
    associatedtype Model: FormData
    associatedtype ValueType
    associatedtype Content: View

    // Custom content constructor
    typealias ContentBuilder = (Binding<ValueType>, MetaData, BaseFormContext<Model>) -> Content

    var form: BaseFormContext<Model> { get }
    var field: WritableKeyPath<Model, ValueType> { get }

    var content: ContentBuilder { get }
}

extension FieldInput {
    var fieldValue: ValueType {
        self.form.value[keyPath: self.field]
    }

    var value: Binding<ValueType> {
        Binding(get: { self.fieldValue }, set: {
            self.form.value[keyPath: self.field] = $0
        })
    }

    var errors: [String] {
        self.form.errors?[self.field] ?? []
    }
}
