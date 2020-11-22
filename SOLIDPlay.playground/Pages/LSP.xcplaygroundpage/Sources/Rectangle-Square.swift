import Foundation

public enum Old {
    public class User {
        let rect: Rectangle

        public init(rect: Rectangle) {
            self.rect = rect
        }

        /*
         https://en.wikipedia.org/w/index.php?title=Liskov_substitution_principle&oldid=794793800#A_typical_violation
         구현체가 Sqaure(정사각형)일 경우, width와 height이 항상 같아야 하는 문제가 발생한다.
         하지만, Rectangle은 width와 height이 같지 않아도 된다. 즉, 이 상황에서 Rectangle과 Square는 서로 치환을 할 수 없다.
         */
        func useRectangle() {
            rect.setW(width: 3)
            rect.setH(height: 5)
        }
    }

    public class Rectangle {
        var width: Int
        var height: Int

        public init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }

        func setW(width: Int) {
            self.width = width
        }

        func setH(height: Int) {
            self.height = height
        }
    }

    public class Square: Rectangle {
        public override init(width: Int, height: Int) {
            super.init(width: width, height: height)
        }
    }
}

public enum New {
    public class User {
        let rect: Rectangle

        public init(rect: Rectangle) {
            self.rect = rect
        }

        public func useRectangle() {
            print(rect.width, rect.height)
        }
    }

    public class Rectangle {
        // Property를 immutable하게 만듦으로써, LSP 위반을 피할 수 있다.
        public let width: Int
        public let height: Int

        public init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
    }

    public class Square: Rectangle {
        public init(side: Int) {
            super.init(width: side, height: side)
        }
    }
}
