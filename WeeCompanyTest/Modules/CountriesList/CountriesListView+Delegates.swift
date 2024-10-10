
import UIKit

extension CountriesListView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let factory = FactoryController()
        let vc = factory.createController(type: .search).createViewController(countryName: "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
