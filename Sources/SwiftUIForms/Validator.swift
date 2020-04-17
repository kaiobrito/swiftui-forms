//
//  Validator.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 17/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import Foundation

public struct Validator<ValueType> {
    public typealias Rule = (ValueType) -> String?

    public var rules: [Rule]

    public func validate(_ value: ValueType) -> [String] {
        self.rules.map({$0(value)}).compactMap({$0})
    }
}

extension Validator {
    public static func with<ValueType>(rules: [(ValueType) -> String?]) -> (ValueType) -> [String] {
        Validator<ValueType>(rules: rules).validate
    }
}
