//
//  Validator.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 17/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import Foundation

struct Validator<ValueType> {
    typealias Rule = (ValueType) -> String?

    var rules: [Rule]

    func validate(_ value: ValueType) -> [String] {
        self.rules.map({$0(value)}).compactMap({$0})
    }
}

extension Validator {
    static func with<ValueType>(rules: [(ValueType) -> String?]) -> (ValueType) -> [String] {
        Validator<ValueType>(rules: rules).validate
    }
}
