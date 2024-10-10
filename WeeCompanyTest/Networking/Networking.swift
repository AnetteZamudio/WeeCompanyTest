
import Foundation

struct NetworkManager {
    var network = ServiceNetwork.init(host: Constats.baseHost)
    
    public func getAllCountries(completion: @escaping(Result<[AllCountriesResponse], RequestError>) -> Void) {
        network.get(path: Endpoints.countriesList) { data, error, _, statusCode in
            switch statusCode {
            case .ok:
                if let data = data {
                    if let result = network.decode(jsonData: data, using: [AllCountriesResponse].self) {
                        completion(.success(result))
                        return
                    } else if let result = network.decode(jsonData: data, using: [AllCountriesResponse].self), statusCode != .ok {
                        completion(.failure(.customMessage(message: "Error get \(result.count)")))
                        return
                    }
                }
                completion(.failure(.decode))
            default:
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }
    }
    
    public func getCountryByName(countryByName: String,
                                 completion: @escaping(Result<[AllCountriesResponse], RequestError>) -> Void) {
        network.get(path: Endpoints.counrtyByName(countryByName)) { data, error, _, statusCode in
            switch statusCode {
            case .ok:
                if let data = data {
                    if let result = network.decode(jsonData: data, using: [AllCountriesResponse].self) {
                        completion(.success(result))
                        return
                    } else if let result = network.decode(jsonData: data, using: [AllCountriesResponse].self), statusCode != .ok {
                        completion(.failure(.customMessage(message: "Error get \(result.count)")))
                        return
                    }
                }
                completion(.failure(.decode))
            default:
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }
    }
}
