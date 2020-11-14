//: [Previous](@previous)

import Foundation

/*: Problem
 1. 하나의 모듈이 여러 Actor에 대한 책임을 가지고 있다.
    여기서는 Employee가 CFO, COO, CTO 모두에 대한 책임을 가지고 있다.
 2. 메소드를 중복으로 사용할 경우, Actor에 따라 서로 다른 영향을 미칠 수 있다.
 */
struct Employee {

    // CFO에 대한 책임
    func calculatePay() -> Int {
        let hours = regularHours()
        return hours * 5000
    }

    // COO에 대한 책임
    func reportHours() -> Int {
        let hours = regularHours()
        return hours * 2
    }

    // CFO 팀의 방식대로 변경시 COO 팀의 로직에 영향을 준다.
    func regularHours() -> Int {
        return 8
    }

    // CTO에 대한 책임
    func save() {

    }
}

/*: Solution
 - 모듈들이 하나의 Actor(CFO, COO, CTO)에 대해서만 책임지도록 데이터와 메소드를 분리한다. 즉, 메소드를 담당하는 모듈(e.g. PayCalculator)을 정의하고, 데이터(EmployeeData)도 별도로 정의한다.
 - 퍼사드 패턴을 통해 데이터(EmployeeData)를 수월하게 관리하도록 한다.
*/

// CFO에 대한 책임
struct PayCalculator {
    func calculatePay() -> EmployeeData {
        let hours = regularHours()
        return EmployeeData(hours: hours)
    }

    func regularHours() -> Int {
        return 8
    }
}

// COO에 대한 책임
struct HourReporter {

    func reportHours() -> EmployeeData {
        let hours = regularHours()
        return EmployeeData(hours: hours)
    }

    func regularHours() -> Int {
        return 7
    }
}

// CTO에 대한 책임
struct EmployeeSaver {
    func save() -> EmployeeData {
        let hours = regularHours()
        return EmployeeData(hours: hours)
    }

    func regularHours() -> Int {
        return 7
    }
}

struct EmployeeData {
    let hours: Int
}

struct EmployeeFacade {
    private let payCalculator = PayCalculator()
    private let hourReporter = HourReporter()
    private let employeeSaver = EmployeeSaver()

    func calculatePay() -> EmployeeData {
        return payCalculator.calculatePay()
    }

    func reportHours() -> EmployeeData {
        return hourReporter.reportHours()
    }

    func save() -> EmployeeData {
        return employeeSaver.save()
    }
}

let employee = EmployeeFacade()
let cfoData = employee.calculatePay()
let cooData = employee.reportHours()
let ctoData = employee.save()
