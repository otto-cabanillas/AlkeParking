import UIKit

// MARK: AlkeParking Exercise 10

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var checkInTime: Date { get }
    var discountCard: String? { get }
}

struct Parking {
    var vehicles: Set<Vehicle> = []
    let parkingLimit = 20
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        guard vehicles.count < parkingLimit && vehicles.insert(vehicle).inserted else {
            return onFinish(false)
        }
        return onFinish(true)
    }
    
    mutating func checkOutVehicle(plate: String, onSuccess: (Int) ->(), onError: () -> ()) {
        guard let vehicle = vehicles.first(where: {$0.plate == plate }) else {
            return onError()
        }
        let hasDiscound = vehicle.discountCard != nil
        let fee = calculateFee(type: vehicle.type, parkedTime: vehicle.parkedTime, hasDiscountCard: hasDiscound)
        vehicles.remove(vehicle)
        onSuccess(fee)
    }
    
    func calculateFee(type: VehicleType, parkedTime: Int, hasDiscountCard: Bool) -> Int {
        var fee = type.hourFee
        print("fee: \(fee)")
        if parkedTime > 120 {
            let reminderMins = parkedTime - 120
            fee += Int(ceil(Double(reminderMins) / 15.0)) * 5
        }
        if hasDiscountCard {
            fee = Int(Double(fee) * 0.85)
        }
        return fee
    }
    
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

extension Date {
    static func createDate(hour: Int, mins: Int) -> Date {
        let dayCurrent = Calendar.current.date(bySettingHour: hour, minute: mins, second: 0, of: Date())
        let someDateTime = dayCurrent
        return someDateTime ?? Date()
    }
}


var alkeParking = Parking()

// 20 Vehicles
let car1 = Vehicle(plate: "AA111AA", type: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let car2 = Vehicle(plate: "B222BBB", type: .car, checkInTime: Date(), discountCard: nil)
let car3 = Vehicle(plate: "CC333CC", type: .car, checkInTime: Date(), discountCard: nil)
let car4 = Vehicle(plate: "DD444DD", type: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let car5 = Vehicle(plate: "AA111BB", type: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")

let motocycle6 = Vehicle(plate: "B222CCC", type: .motocycle, checkInTime: Date(), discountCard: "DISCOUNT_CARD_004")
let motocycle7 = Vehicle(plate: "CC333DD", type: .motocycle, checkInTime: Date(), discountCard: nil)
let motocycle8 = Vehicle(plate: "DD444EE", type: .motocycle, checkInTime: Date(), discountCard: "DISCOUNT_CARD_005")
let motocycle9 = Vehicle(plate: "AA111CC", type: .motocycle, checkInTime: Date(), discountCard: nil)
let motocycle10 = Vehicle(plate: "B222DDD", type: .motocycle, checkInTime: Date(), discountCard: nil)

let miniBus11 = Vehicle(plate: "CC333EE", type: .miniBus, checkInTime: Date(), discountCard: nil)
let miniBus12 = Vehicle(plate: "DD444GG", type: .miniBus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_006")
let miniBus13 = Vehicle(plate: "AA111DD", type: .miniBus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_007")
let miniBus14 = Vehicle(plate: "B222EEE", type: .miniBus, checkInTime: Date(), discountCard: nil)
let miniBus15 = Vehicle(plate: "CC333FF", type: .miniBus, checkInTime: Date(), discountCard: nil)

let bus16 = Vehicle(plate: "DD444HH", type: .bus, checkInTime: Date(), discountCard: nil)
let bus17 = Vehicle(plate: "AA111EE", type: .bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_008")
let bus18 = Vehicle(plate: "B222FFF", type: .bus, checkInTime: Date(), discountCard: nil)
let bus19 = Vehicle(plate: "CC333GG", type: .bus, checkInTime: Date.createDate(hour: 10, mins: 00), discountCard: "DISCOUNT_CARD_009")
let bus20 = Vehicle(plate: "DD444II", type: .bus, checkInTime: Date(), discountCard: nil)

// Plate duplicate
//let bus20 = Vehicle(plate: "CC333GG", type: .bus, checkInTime: Date(), discountCard: nil)

// Limit
let car21 = Vehicle(plate: "AA111EE", type: .car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_008")

let vehicles = [car1, car2, car3, car4, car5, motocycle6, motocycle7, motocycle8, motocycle9, motocycle10, miniBus11, miniBus12, miniBus13, miniBus14, miniBus15, bus16, bus17, bus18, bus19, car21, bus20]

var n: Int = 1
for vehicle in vehicles {
    
    alkeParking.checkInVehicle(vehicle) { success in
        if success {
            print("Welcome to AlkeParking! \(n)")
            n += 1
        } else {
            print("Sorry, the check-in failed")
        }
    }
}

alkeParking.vehicles.count

bus19.parkedTime
bus20.parkedTime

alkeParking.checkOutVehicle(plate: "CC333GG") { Cost in
    print("Su costo fue de \(Cost)")
} onError: {
    print("Disculpe tenemos problemas")
}

alkeParking.vehicles.count



