import Foundation

public enum TaxiType {
    case purple
    case acme
}

public protocol DriverRequestProtocol {
    var type: TaxiType { get }
    var name: String { get }
    var pickupAddress: String { get }
    var pickupTime: String { get }
    var destination: String { get }
    var dispatchCommand: String { get }
}

public struct DriverRequest: DriverRequestProtocol {
    public let type: TaxiType
    public let name: String
    public let pickupAddress: String
    public let pickupTime: String
    public let destination: String

    public var dispatchCommand: String {
        // 문제점: 새로운 택시 회사가 추가될 때마다 해당 택시 회사에 대한 예외처리를 추가해야 한다.
        switch type {
        case .purple:
            return "/driver/\(name)/pickupAddress/\(pickupAddress)/pickupTime/\(pickupTime)/destination/\(destination)"
        case .acme:
            return "/driver/\(name)/pickupAddress/\(pickupAddress)/pickupTime/\(pickupTime)/dest/\(destination)"
        }
    }
}

public protocol DriverRequest2Protocol {
    var name: String { get }
    var pickupAddress: String { get }
    var pickupTime: String { get }
    var destination: String { get }
    var dispatchCommand: String { get }
}

public struct DriverRequestConfiguration {
    let type: TaxiType

    public init(type: TaxiType) {
        self.type = type
    }

    func format() -> String {
        if type == .acme {
            return "/driver/%@/pickupAddress/%@/pickupTime/%@/dest/%@"
        }
        return "/driver/%@/pickupAddress/%@/pickupTime/%@/destination/%@"
    }
}

public struct DriverRequest2: DriverRequest2Protocol {
    public let name: String
    public let pickupAddress: String
    public let pickupTime: String
    public let destination: String

    // 버그가 발생할 확률이 높은 예외처리는 별도 객체로 분리하여 관리한다.
    let configuration: DriverRequestConfiguration

    public init(name: String,
                pickupAddress: String,
                pickupTime: String,
                destination: String,
                configuration: DriverRequestConfiguration) {
        self.name = name
        self.pickupAddress = pickupAddress
        self.pickupTime = pickupTime
        self.destination = destination
        self.configuration = configuration
    }
    
    public var dispatchCommand: String {
        return String(format: configuration.format(), arguments: [name, pickupAddress, pickupTime, destination])
    }
}
