//
//  File.swift
//  
//
//  Created by Kaio Brito on 17/04/20.
//

import Foundation

public protocol FormData {
    typealias Errors = [PartialKeyPath<Self>: [String]]
    
    var errors: Errors { get }
}

@propertyWrapper
public struct FormField<Value> {
    public var wrappedValue: Value {
        didSet {
            self.errors = self.validation(self.wrappedValue)
        }
    }
    public var validation: (Value) -> [String]
    public var errors: [String] = []

    public init(wrappedValue value: Value, validation: @escaping (Value) -> [String]) {
        self.wrappedValue = value
        self.validation = validation
        self.errors = validation(value)
    }
    
    public init(wrappedValue value: Value, rules: [(Value) -> String?]) {
        self.wrappedValue = value
        self.validation = Validator<Value>.with(rules: rules)
        self.errors = validation(value)
    }
    
    public var containErrors: Bool {
        !self.errors.isEmpty
    }
}
