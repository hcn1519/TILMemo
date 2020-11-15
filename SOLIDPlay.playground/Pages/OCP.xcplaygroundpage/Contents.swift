import Foundation

// MARK: Controller
enum Controller {
    class FinancialReportController {
        let requester: FinancialReportRequester = Interactor.FinancialReportGenerator()
        let screenPresenter: FinancialReportPresenter = Presenter.ScreenPresenter()
        let printPresenter: FinancialReportPresenter = Presenter.PrintPresenter()

        func displayScreen() {
            let response = requester.requestData(request: .init())
            screenPresenter.presentReport(response: response)
        }

        func displayPDF() {
            let response = requester.requestData(request: .init())
            printPresenter.presentReport(response: response)
        }
    }
}

protocol FinancialReportRequester {
    func requestData(request: Interactor.FinancialReportRequest) -> Interactor.FinancialReportRespone
}

// MARK: Interactor
enum Interactor {
    /*
     - 추이 종속성을 제거하기 위해 Request/Response를 별도로 정의한다.
     - Interactor는 가장 높은 수준의 정책(업무 규칙)을 포함하고 있기 때문에, 가장 OCP를 잘 준수하고, 다른 것들로부터 영향을 덜 받는 구조로 구성된다.
     - A 컴포넌트가 B 컴포넌트를 사용하면 A 컴포넌트가 B 컴포넌트에 의존한다. 그런데 이 때, A 컴포넌트와 B 컴포넌트 사이에 인터페이스를 정의하면 의존성 역전이 발생하고,
     A 컴포넌트는 B 컴포넌트에 대해 의존하지 않게 된다. 이는 바꿔 말하면, 의존성 역전을 통해 A 컴포넌트가 B 컴포넌트의 변화로부터 보호 받게 되는 것을 의미한다.
     */
    struct FinancialReportRequest {

    }

    struct FinancialReportRespone {
        init(entity: FinancialEntity) {

        }
    }

    struct FinancialEntity {
        let data: Data
    }

    class FinancialReportGenerator: FinancialReportRequester {
        let dataGateway: FinancialDataGateway = Database.FinancialDataMapper()

        func requestData(request: Interactor.FinancialReportRequest) -> Interactor.FinancialReportRespone {
            let entity = dataGateway.retriveData()
            return FinancialReportRespone(entity: entity)
        }
    }
}

protocol FinancialDataGateway {
    func retriveData() -> Interactor.FinancialEntity
}

// MARK: Database
enum Database {
    struct FinancialDataMapper: FinancialDataGateway {
        let database = FinancialDatabase()

        func retriveData() -> Interactor.FinancialEntity {
            let data = database.data
            return Interactor.FinancialEntity(data: data)
        }
    }

    struct FinancialDatabase {
        let data = Data()
    }
}

protocol FinancialReportPresenter {
    func presentReport(response: Interactor.FinancialReportRespone)
}

// MARK: Presenter
enum Presenter {
    /*
     - 보고서를 표시/출력하는 책임을 웹/프린터에 따라 분리한다.(SRP)
     - 하나의 모듈이 하나의 Actor(웹, 프린터)에 대해서만 책임을 지도록 한다.
     */

    class ScreenPresenter: FinancialReportPresenter {
        func presentReport(response: Interactor.FinancialReportRespone) {
            let screenView: ScreenView = WebView(viewModel: ScreenViewModel(response: response))
            screenView.draw()
        }
    }

    class PrintPresenter: FinancialReportPresenter {
        func presentReport(response: Interactor.FinancialReportRespone) {
            let printView: PrintView = PDFView(viewModel: PrintViewModel(response: response))
            printView.draw()
        }
    }

    struct ScreenViewModel {
        init(response: Interactor.FinancialReportRespone) {

        }
    }

    struct PrintViewModel {
        init(response: Interactor.FinancialReportRespone) {

        }
    }
}

// MARK: View

enum ViewType {
    case web
    case pdf
}

protocol ScreenView {
    var viewModel: Presenter.ScreenViewModel { get set }
    func draw()
}

protocol PrintView {
    var viewModel: Presenter.PrintViewModel { get set }
    func draw()
}

struct WebView: ScreenView {
    var viewModel: Presenter.ScreenViewModel

    func draw() {

    }
}

struct PDFView: PrintView {
    var viewModel: Presenter.PrintViewModel

    func draw() {

    }
}

// MARK: usage

let controller = Controller.FinancialReportController()
controller.displayScreen()
controller.displayPDF()
