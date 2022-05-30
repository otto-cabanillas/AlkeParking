import UIKit

// MARK: AlkeParking Exercise 1

protocol Parkable {
    var plate: String { get }
}

struct Parking {
    var vehicles: Set<Vehicle> = []
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
}
