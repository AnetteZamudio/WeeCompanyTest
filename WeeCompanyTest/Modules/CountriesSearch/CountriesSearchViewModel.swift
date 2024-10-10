
import Foundation

class CountriesSearchViewModel: NSObject {
    var networkManger = NetworkManager()
    var allCountries = [AllCountriesResponse]()
    var cellIdentifier = "cell"
    
    func getCountryByName(countryName: String, completion: @escaping(Bool) -> Void) {
        networkManger.getCountryByName(countryByName: countryName) { [weak self] result in
            switch result {
            case .success(let success):
                self?.allCountries = success
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
