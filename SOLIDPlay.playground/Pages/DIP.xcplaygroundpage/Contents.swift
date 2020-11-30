//: [Previous](@previous)

import Foundation

protocol ServiceFactory {
    func makeSvc() -> [Service]
}

protocol Service {

}

enum Factory {
    class Application {
        let serviceFactory: ServiceFactory = ServiceFactoryImpl()
        private var services: [Service] = []

        // Application은 ConcreteImpl 사용하지만, ServiceFactory 인터페이스만 아는 상태로 ConcreteImpl을 생성한다.
        // 이러한 추상 팩토리는 구체 컴포넌트에 의존하지 않도록 소스코드를 작성할 수 있도록 해준다.
        // 왜 이런 작업을 하는가? - 일반적으로 구체 클래스는 추상 클래스에 비해 변동성이 높다.(단적으로, 추상 클래스가 변경될 경우, 구체 클래스는 변경되어야 하지만, 그 반대는 그렇지 않은 경우가 많다). 이러한 변동성에 앱이 대응하기 위해서는 앱의 모든 객체는 변동성이 적은 객체에만 의존해야 한다.
        func makeSvcs() {
            services = serviceFactory.makeSvc()
        }
    }

    class ServiceFactoryImpl: ServiceFactory {

        func makeSvc() -> [Service] {
            return [ConcreteImpl()]
        }
    }

    class ConcreteImpl: Service {

    }
}

// Usage
let application = Factory.Application()
application.makeSvcs()
