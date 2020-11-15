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
