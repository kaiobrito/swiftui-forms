//
//  File.swift
//  
//
//  Created by Kaio Brito on 17/04/20.
//

import XCTest
@testable import SwiftUIForms

class BaseFormContextTests: XCTestCase {
    public struct DummyModel: FormData {
        @FormField(validation: {
            return ($0.isEmpty) ? ["Cannot be empty"] : []
        })
        public var title: String = ""

        public var errors: [PartialKeyPath<BaseFormContextTests.DummyModel> : [String]] {
            [
                \DummyModel.title: self._title.errors
            ]
        }
    }

    func testFielValidation() {
        let context = BaseFormContext(DummyModel(title: ""))
        XCTAssertFalse(context.isValid)
        XCTAssertEqual(context.errors![\DummyModel.title], ["Cannot be empty"])
        
        context.value.title = "Title"
        XCTAssert(context.isValid)
    }

    func testFormValidation() {
        let context = BaseFormContext(DummyModel(title: ""), onValidate: self.validate)
        let expected = self.validate(context.value)
        
        XCTAssertFalse(context.isValid)
        XCTAssertEqual(context.errors![\DummyModel.title], ["Cannot be empty"] + expected[\DummyModel.title]!)
        
        context.value.title = "Title"
        XCTAssertFalse(context.isValid)
        XCTAssertEqual(context.errors, expected)
    }

    private func validate(_ value: DummyModel) -> [PartialKeyPath<DummyModel>: [String]] {
        [
            \DummyModel.title: ["Form invalidated it"]
        ]
    }
}
