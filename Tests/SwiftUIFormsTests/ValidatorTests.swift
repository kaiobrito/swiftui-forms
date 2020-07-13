//
//  File.swift
//  
//
//  Created by Kaio Brito on 17/04/20.
//

import XCTest
@testable import SwiftUIForms


class ValidatorTests: XCTestCase {
    static let EMPTY_ERROR_MESSAGE = "Cannot be empty"
    struct DummyFormData: FormData {
        @FormField(rules: [ Rule {$0.isEmpty ? EMPTY_ERROR_MESSAGE: nil} ])
        var title = ""
        
        var errors: [PartialKeyPath<DummyFormData> : [String]] {
            [
                \DummyFormData.title: self._title.errors
            ]
        }
    }
    
    func testValidationOnUpdate() {
        var formData = DummyFormData()
        XCTAssertEqual(formData.errors[\DummyFormData.title], [Self.EMPTY_ERROR_MESSAGE])
        
        formData.title = "1234"
        XCTAssert(formData.errors[\DummyFormData.title]!.isEmpty)
    }
}
