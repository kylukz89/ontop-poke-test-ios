 
import UIKit

extension UIColor {
    static let tmDarkGray = UIColor(hex: "#3f3f3f")
    static let tmDarkGreen = UIColor(hex: "#3c948b")
    static let tmLightGray = UIColor(hex: "#b9e3de")
    static let tmWhite = UIColor(hex: "#FFFFFF")
    static let tmBlack = UIColor(hex: "#000000")
}

extension UIColor {
    convenience init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

