
import UIKit

extension CountriesListView: UITableViewDataSource {
    func setCell(name: String, flag: String) -> String {
        return "\(flag) \(name)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = viewModel.allCountries[indexPath.row]
        cell.textLabel?.text = setCell(name: item.name?.common ?? "", flag: item.flag ?? "")
        return cell
    }
}

extension CountriesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goToDetail(name: viewModel.allCountries[indexPath.item].name?.common ?? "")
    }
    
    func goToDetail(name: String) {
        let factory = FactoryController()
        let vc = factory.createController(type: .detail).createViewController(countryName: name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
