import UIKit

extension CountriesSearchView: ControllerProtocol {
    func createViewController(countryName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CountriesSearchView") as? CountriesSearchView else { return UIViewController() }
        return vc
    }
    
    func createPopViewContoller(imgUrl: String) -> UIViewController {
        return UIViewController()
    }
}

extension CountriesSearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doSearch(query: searchBar.text ?? "")
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            recentSearchTable.isHidden = true
            validateSavaedSearch()
            doSearch(query: "")
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        validateSavaedSearch()
        recentSearchTable.isHidden = true
    }
}
