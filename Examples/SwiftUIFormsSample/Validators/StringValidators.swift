//
//  StringValidators.swift
//  SwiftUIFormsSample
//
//  Created by Kaio Brito on 17/04/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import Foundation
import SwiftUIForms

extension String {
    static var emptyValidation: Rule<String> = {
        $0.isEmpty ? "Cannot be empty" : nil
    }
}
