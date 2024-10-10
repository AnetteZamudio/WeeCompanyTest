//
//  ImagePopUpView.swift
//  WeeCompanyTest
//
//  Created by Pablo Luis Velazquez Zamudio on 09/10/24.
//

import UIKit

class ImagePopUpView: UIViewController {
    // IBOutlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var flagImg: UIImageView!
    // VM
    var viewModel = ImagePopUpViewModel()
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadFlagImg()
    }
    // Service methods
    private func downloadFlagImg() {
        flagImg.DownloadImgFromURL(uri: viewModel.imgUrl)
    }
    // @IBActions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

