
import Foundation

class CountriesListViewModel: NSObject {
    var networkManger = NetworkManager()
    var allCountries = [AllCountriesResponse]()
    
    func getAllCountries(completion: @escaping(_ withError: Bool) -> Void) {
        networkManger.getAllCountries { [weak self] result in
            switch result {
            case .success(let success):
                self?.allCountries = success
                completion(false)
            case .failure(let failure):
                completion(true)
                print("fallaron los paises \(failure.message)")
            }
        }
    }
}
