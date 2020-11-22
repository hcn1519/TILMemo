//: [Previous](@previous)

import Foundation

enum Problem {
    struct User1 {
        var ops: OPS

        // 사용하지 않는 ops2, ops3의 변경에 영향을 받는다.
        func useOPS() {
            ops.ops1()
        }
    }

    struct User2 {
        var ops: OPS

        func useOPS() {
            ops.ops2()
        }
    }

    struct User3 {
        var ops: OPS

        func useOPS() {
            ops.ops3()
        }
    }

    final class OPS {
        func ops1() {
            print(#function)
        }

        func ops2() {
            print(#function)
        }

        func ops3() {
            print(#function)
        }
    }
}

protocol U1OPS {
    func ops1()
}

protocol U2OPS {
    func ops2()
}

protocol U3OPS {
    func ops3()
}

enum Solution {
    final class User1 {
        // OPS에 의존하지 않고, U1OPS 인터페이스에만 의존하므로써, 불필요한 재컴파일, 재배포를 방지한다.
        let ops: U1OPS

        public init(ops: U1OPS) {
            self.ops = ops
        }

        func useOPS() {
            ops.ops1()
        }
    }

    final class User2 {
        let ops: U2OPS

        public init(ops: U2OPS) {
            self.ops = ops
        }

        func useOPS() {
            ops.ops2()
        }
    }

    final class User3 {
        let ops: U3OPS

        public init(ops: U3OPS) {
            self.ops = ops
        }

        func useOPS() {
            ops.ops3()
        }
    }

    final class OPS: U1OPS, U2OPS, U3OPS {
        func ops1() {
            print(#function)
        }

        func ops2() {
            print(#function)
        }

        func ops3() {
            print(#function)
        }
    }
}
