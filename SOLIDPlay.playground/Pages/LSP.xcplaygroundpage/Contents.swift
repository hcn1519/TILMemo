//: [Previous](@previous)

import Foundation

// Billing-License Usage

let personalBilling = Billing(license: PersonalLicense())
let businessBilling = Billing(license: BusinessLicense())

personalBilling.calcBilling()
businessBilling.calcBilling()

// Taxi Driver ACME Usage
let configuration = DriverRequestConfiguration(type: .purple)
let requestForPurple = DriverRequest2(name: "Bob",
                                      pickupAddress: "24 Maple St.",
                                      pickupTime: "153",
                                      destination: "ORD",
                                      configuration: configuration)

let configuration2 = DriverRequestConfiguration(type: .acme)
let requestForAcme = DriverRequest2(name: "Bob",
                                    pickupAddress: "24 Maple St.",
                                    pickupTime: "153",
                                    destination: "ORD",
                                    configuration: configuration2)

print(requestForPurple.dispatchCommand)
print(requestForAcme.dispatchCommand)
