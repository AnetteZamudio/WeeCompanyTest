
import Foundation
public protocol EndpointsProtocol {
    var url: String { get }
    var filename: String { get }
}

public enum Endpoints: EndpointsProtocol {
    case countriesList
    case counrtyByName(String)
    
    public var url: String {
        switch self {
        case .countriesList:
            return "/v3.1/all"
        case let .counrtyByName(countryName):
            return "/v3.1/name/\(countryName)"
        }
    }
    
    public var filename: String {
        switch self  {
        case .countriesList:
            return "fatal error countries"
        case .counrtyByName(_):
            return "fatal error getting country detail"
        }
    }
}
