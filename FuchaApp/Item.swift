//
//  Item.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
