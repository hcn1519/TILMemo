import Foundation

public class Billing {
    // License의 하위 타입이 무엇인지 모른다.(의존하지 않는다)
    let license: License

    public init(license: License) {
        self.license = license
    }

    public func calcBilling() -> Double {
        let licenseFee = license.calcFee()
        let productFee: Double = 200

        return licenseFee + productFee
    }
}

public class License {
    public init() {}

    public func calcFee() -> Double {
        return 30
    }
}

public final class PersonalLicense: License {
    public override init() {
        super.init()
    }

    public override func calcFee() -> Double {
        let defaultFee = super.calcFee()

        return defaultFee * (1.2)
    }
}

public final class BusinessLicense: License {
    public override init() {
        super.init()
    }

    public override func calcFee() -> Double {
        let defaultFee = super.calcFee()

        return defaultFee * (1.5)
    }
}
