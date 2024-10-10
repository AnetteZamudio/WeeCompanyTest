
import Foundation

class CountryDetailViewModel: NSObject {
    var networkManger = NetworkManager()
    var countryName = ""
    var flagUrl = ""
    var locationUrl = ""
    
    func getCountryByName(completion: @escaping(AllCountriesResponse?) -> Void) {
        networkManger.getCountryByName(countryByName: countryName) { [weak self] result in
            switch result {
            case .success(let success):
                self?.flagUrl = success.first?.flags?.png ?? ""
                self?.locationUrl = success.first?.maps?.googleMaps ?? ""
                completion(success.first)
            case .failure(let failure):
                completion(nil)
            }
        }
    }
}
