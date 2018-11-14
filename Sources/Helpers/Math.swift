//  Copyright © 2018 JABT. All rights reserved.

import Foundation

public func clamp<T: Comparable>(_ val: T, min: T, max: T) -> T {
    guard min < max else {
        return min
    }
    if val < min { return min }
    if val > max { return max }
    return val
}

extension Double {

    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
