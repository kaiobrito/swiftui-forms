//
//  FormContext.swift
//  SwiftUIForm
//
//  Created by Kaio Brito on 15/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import SwiftUI
import Combine

protocol FormContext: ObservableObject {
    associatedtype ValueType: FormData

    typealias ValidationErrors = [PartialKeyPath<ValueType>: [String]]

    var value: ValueType { get set }
    var errors: ValidationErrors? { get }

    var isValid: Bool { get }

    func validate(value: ValueType) -> ValidationErrors?
    func onSubmit(value: ValueType)
    func reset()
}

open class BaseFormContext<ValueType: FormData>: FormContext {
    public typealias ValidationErrors = [PartialKeyPath<ValueType>: [String]]
    public typealias ValidationMethod = (ValueType) -> ValidationErrors?

    public var initialValues: ValueType
    @Published public var value: ValueType
    @Published public var errors: ValidationErrors?
    var onValidate: ValidationMethod?
    private var validationCancellable: AnyCancellable!

    public init(_ value: ValueType, onValidate: ValidationMethod? = nil) {
        self.initialValues = value
        self.value = value
        self.onValidate = onValidate

        // Validates the form whenever the form value changes
        self.validationCancellable = self.$value.sink(receiveValue: {
            self.errors = self.validate(value: $0) ?? [:]
        })
    }

    /// This method will handle the form submission like an API request or a database update
    /// - Parameter value: valid form value
    open func onSubmit(value: ValueType) {
        fatalError("Not implemented yet")
    }

    final public func submit() {
        if self.isValid {
            self.onSubmit(value: self.value)
        }
    }

    func validate(value: ValueType) -> ValidationErrors? {
        let formErrors = self.onValidate?(value) ?? [:]

        return value.errors
            .merging(formErrors, uniquingKeysWith: { $0 + $1 })
            .filter({ _, value in !value.isEmpty })
    }

    func reset() {
        self.value = self.initialValues
    }

    public var isValid: Bool {
        if let errors = self.errors, !errors.isEmpty {
            return false
        }
        return true
    }

    deinit {
        self.validationCancellable.cancel()
    }
}
