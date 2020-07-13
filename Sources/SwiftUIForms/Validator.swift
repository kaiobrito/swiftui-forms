//
//  Validator.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 17/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import Foundation

public struct Rule<ValueType> {
    public var check: (ValueType) -> String?

    public init(check: @escaping (ValueType) -> String?) {
        self.check = check
    }
}

public struct Validator<ValueType> {

    public var rules: [Rule<ValueType>]

    public func validate(_ value: ValueType) -> [String] {
        self.rules.map({$0.check(value)}).compactMap({$0})
    }
}

extension Validator {
    public static func with<ValueType>(rules: [Rule<ValueType>]) -> (ValueType) -> [String] {
        Validator<ValueType>(rules: rules).validate
    }
}
