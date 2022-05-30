import UIKit

// MARK: AlkeParking Exercise 4

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var checkInTime: Date { get }
    var discountCard: String? { get }
}

struct Parking {
    var vehicles: Set<Vehicle> = []
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    var checkInTime: Date
    var discountCard: String?
    
    var parkedTime: Int {
        return Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
    }
    
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

var alkeParking = Parking()

let car = Vehicle(plate: "AA111AA", type: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")

let moto = Vehicle(plate: "B222BBB", type: .motocycle, checkInTime: Date(), discountCard: nil)

let miniBus = Vehicle(plate: "CC333CC", type: .miniBus, checkInTime: Date(), discountCard: nil)

let bus = Vehicle(plate: "DD444DD", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")

alkeParking.vehicles.insert(car) // True

alkeParking.vehicles.insert(moto) // True

alkeParking.vehicles.insert(miniBus) // True

alkeParking.vehicles.insert(bus) // True
