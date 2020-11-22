//: [Previous](@previous)

import Foundation

// Billing-License Usage

let personalBilling = Billing(license: PersonalLicense())
let businessBilling = Billing(license: BusinessLicense())

personalBilling.calcBilling()
businessBilling.calcBilling()

// Taxi Driver ACME Usage
let configuration = Solution.DriverRequestConfiguration(type: .purple)
let requestForPurple = Solution.DriverRequest2(name: "Bob",
                                               pickupAddress: "24 Maple St.",
                                               pickupTime: "153",
                                               destination: "ORD",
                                               configuration: configuration)

let configuration2 = Solution.DriverRequestConfiguration(type: .acme)
let requestForAcme = Solution.DriverRequest2(name: "Bob",
                                             pickupAddress: "24 Maple St.",
                                             pickupTime: "153",
                                             destination: "ORD",
                                             configuration: configuration2)

print(requestForPurple.dispatchCommand)
print(requestForAcme.dispatchCommand)

// Rectangle, Square Usage
let rect = Solution.Rectangle(width: 3, height: 5)
let square = Solution.Square(side: 3)

let user1 = Solution.User(rect: rect)
let user2 = Solution.User(rect: square)
user1.useRectangle()
user2.useRectangle()
