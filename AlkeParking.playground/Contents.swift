import UIKit

// MARK: AlkeParking Exercise 2

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
}

struct Parking {
    var vehicles: Set<Vehicle> = []
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
}

enum VehicleType {
    case car
    case motocycle
    case miniBus
    case bus
    
    var hourFee: Int {
        switch self {
        case .car:
            return 20
        case .motocycle:
            return 15
        case .miniBus:
            return 25
        case .bus:
            return 30
        }
    }
}
