//
//  File.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var rgbInt: UInt64 = 0
        let newHex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: newHex)
        scanner.scanHexInt64(&rgbInt)
        let r: CGFloat = CGFloat((rgbInt & 0xFF0000) >> 16) / 255.0
        let g: CGFloat = CGFloat((rgbInt & 0x00FF00) >> 8) / 255.0
        let b: CGFloat = CGFloat(rgbInt & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
