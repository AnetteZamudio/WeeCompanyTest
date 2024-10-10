
import UIKit

extension CountriesSearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlagCollectionViewCell.identifier, for: indexPath) as? FlagCollectionViewCell else { return UICollectionViewCell() }
        let item = viewModel.allCountries[indexPath.item]
        cell.setupCellData(name: item.name?.common ?? "", imgUrl: item.flags?.png ?? "")
        return cell
    }
}

extension CountriesSearchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let factory = FactoryController()
        let vc = factory.createController(type: .detail).createViewController(countryName: viewModel.allCountries[indexPath.item].name?.common ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CountriesSearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension CountriesSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let saved = DefaultsKeys.recentSearch.getArrayByKey() as? [String]
        return saved?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        let array = DefaultsKeys.recentSearch.getArrayByKey() as? [String]
        cell.textLabel?.text = array?[indexPath.item] ?? ""
        recentSearchTable.layoutIfNeeded()
        
        return cell
    }
}

extension CountriesSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let array = DefaultsKeys.recentSearch.getArrayByKey() as? [String]
        recentSearchTable.isHidden = true
        seeRecentButton.isHidden = false
        searchBar.text = array?[indexPath.row] ?? ""
        doSearch(query: array?[indexPath.row] ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
