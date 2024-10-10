
import UIKit
import MapKit

class CountryDetailView: UIViewController {
    // IBOutlets
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var officialNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationMap: MKMapView!
    
    // VM
    var viewModel = CountryDetailViewModel()
    // Properties
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setGestures()
        fetchData()
    }
    
    // Service methods
    private func fetchData() {
        viewModel.getCountryByName { [weak self] data in
            if let safeData = data {
                self?.fillData(data: safeData)
                self?.setCustomLocation(data: safeData)
            }
        }
    }
    private func fillData(data: AllCountriesResponse) {
        mainImg.DownloadImgFromURL(uri: data.flags?.png ?? "")
        countryNameLabel.text = "Country: " + (data.name?.common ?? "")
        officialNameLabel.text = "Official Name: " + (data.name?.official ?? "")
        capitalLabel.text = "Capital: " + (data.capital?.first ?? "")
        let key = data.currencies?.keys.first ?? ""
        let item = data.currencies?[key]
        currencyLabel.text = "Currency: " + "\(item?.name ?? "")" + " (\(data.currencies?[key]?.symbol ?? ""))"
    }
    // UI methods
    private func setupUI() {
        locationMap.layer.cornerRadius = 16
        mainImg.layer.cornerRadius = 16
    }
    // Gesture methods
    private func setGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openFlagImg))
        mainImg.addGestureRecognizer(tap)
    }
    // Location methods
    private func setCustomLocation(data: AllCountriesResponse) {
        let latitude: CLLocationDegrees = data.latlng?[0] ?? 0.0
        let longitude: CLLocationDegrees = data.latlng?[1] ?? 0.0
        let customLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let regionRadius: CLLocationDistance = 100000
        let coordinateRegion = MKCoordinateRegion(center: customLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        locationMap.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = customLocation
        annotation.title = data.name?.common ?? ""
        locationMap.addAnnotation(annotation)
    }
    
    private func openMapLocation() {
        if let url = URL(string: viewModel.locationUrl) {
            UIApplication.shared.open(url)
        }
    }
    // @objc methods
    @objc func openFlagImg() {
        let factory = FactoryController()
        let vc = factory.createController(type: .imagePop).createPopViewContoller(imgUrl: viewModel.flagUrl)
        self.present(vc, animated: true)
    }
    // @IBAction
    @IBAction func openMapsAction(_ sender: Any) {
        openMapLocation()
    }
}
