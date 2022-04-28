//
//  PresentableAsString.swift
//  CookuPots
//
//  Created by Kamil Chołyk on 28/04/2022.
//

import Foundation

protocol PresentableAsString {
    var stringValue: String { get }
}

extension String: PresentableAsString {
    var stringValue: String { self }
}

extension Int: PresentableAsString {
    var stringValue: String { String(self) }
}
