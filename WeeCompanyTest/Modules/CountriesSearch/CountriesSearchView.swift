
import UIKit

class CountriesSearchView: UIViewController {
    // @IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recentSearchTable: UITableView!
    @IBOutlet weak var seeRecentButton: UIButton!
    @IBOutlet weak var emptyHolderView: UIView!
    @IBOutlet weak var resultCollection: UICollectionView!
    @IBOutlet weak var recentTableHeight: NSLayoutConstraint!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // VM
    var viewModel = CountriesSearchViewModel()
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configCollection()
        configTable()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        recentTableHeight.constant = recentSearchTable.contentSize.height
    }
    
    // Set methods
    private func setupUI() {
        validateSavaedSearch()
        recentSearchTable.addShadow()
    }
    
    private func configCollection() {
        resultCollection.register(UINib(nibName: FlagCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FlagCollectionViewCell.identifier)
        resultCollection.delegate = self
        resultCollection.dataSource = self
    }
    private func configTable() {
        recentSearchTable.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        recentSearchTable.dataSource = self
        recentSearchTable.delegate = self
    }
    // Persitance methods
    private func saveSearch(query: String) {
        guard var array = DefaultsKeys.recentSearch.getArrayByKey() as? [String] else { return }
        array.append(query)
        if array.count >= 5 {
            array.remove(at: 0)
        }
        DefaultsKeys.recentSearch.saveSuccessSearch(querys: Array(Set(array)))
    }
    
    func validateSavaedSearch() {
        let array = DefaultsKeys.recentSearch.getArrayByKey() as? [String]
        seeRecentButton.isHidden = array?.count == 0
    }
    
    func showLoader() {
        loader.startAnimating()
        loader.alpha = 1
    }
    
    func hideloader() {
        loader.stopAnimating()
        loader.alpha = 0
    }
    
    // Search methods
    func doSearch(query: String) {
        emptyHolderView.isHidden = true
        recentSearchTable.isHidden = true
        showLoader()
        viewModel.getCountryByName(countryName: query) { [weak self]  result in
            self?.hideloader()
            self?.resultCollection.reloadData()
            if !result {
                self?.emptyHolderView.isHidden = false
                self?.resultCollection.isHidden = true
                return
            }
            self?.emptyHolderView.isHidden = true
            self?.resultCollection.isHidden = false
            self?.saveSearch(query: query)
        }
    }
    
    // @IBAction
    @IBAction func seeAllAction(_ sender: Any) {
        view.endEditing(true)
        seeRecentButton.isHidden = true
        recentSearchTable.reloadData()
        recentSearchTable.isHidden = false
    }
}
