
import UIKit

extension CountryDetailView: ControllerProtocol {
    func createPopViewContoller(imgUrl: String) -> UIViewController {
        return UIViewController()
    }
    
    func createViewController(countryName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CountryDetailView") as? CountryDetailView else { return UIViewController() }
        vc.viewModel.countryName = countryName
        return vc
    }
}

