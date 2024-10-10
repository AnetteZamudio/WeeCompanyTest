
import UIKit

class CountriesListView: UIViewController {
    // IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countriesTable: UITableView!
    // VM
    var viewModel = CountriesListViewModel()
    var cellIdentifier = "CELL"
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configTableView()
        //UserDefaults.standard.removeObject(forKey: DefaultsKeys.recentSearch)
    }
    // Config methods
    private func configTableView() {
        countriesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        countriesTable.dataSource = self
        countriesTable.delegate = self
    }
    // Set methods
    private func setDelegates() {
        searchBar.delegate = self
    }
    // Service methods
    private func fetchData() {
        viewModel.getAllCountries { [weak self]withError in
            if withError {
                return
            }
            self?.countriesTable.reloadData()
        }
    }
}
