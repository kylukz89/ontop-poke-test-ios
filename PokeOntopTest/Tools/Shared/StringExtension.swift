 
import Foundation

extension String? {
    func extraIdByURL() -> Int {
        guard let url = self else { return -1 }
        let components = url.split(separator: "/").map(String.init)
        return Int(components.last ?? "") ?? -1
    }
}
