
import UIKit

protocol ControllerProtocol {
    func createViewController(countryName: String) -> UIViewController
    func createPopViewContoller(imgUrl: String) -> UIViewController
}

class FactoryController {
    enum ControllerType {
        case search
        case detail
        case imagePop
    }
    
    // Método fábrica para crear ViewControllers
    func createController(type: ControllerType) -> ControllerProtocol {
        switch type {
        case .search:
            return CountriesSearchView()
        case .detail:
            return CountryDetailView()
        case .imagePop:
            return ImagePopUpView()
        }
    }
}
