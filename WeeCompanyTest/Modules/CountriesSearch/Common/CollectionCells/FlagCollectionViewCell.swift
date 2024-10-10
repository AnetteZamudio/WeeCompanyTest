import UIKit

class FlagCollectionViewCell: UICollectionViewCell {
    // @IBOutlets
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    // Properties
    static let identifier = "FlagCollectionViewCell"
    // Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // General methods
    func setupCellData(name: String, imgUrl: String) {
        flagLabel.text = name
        flagImg.DownloadImgFromURL(uri: imgUrl)
    }
}
