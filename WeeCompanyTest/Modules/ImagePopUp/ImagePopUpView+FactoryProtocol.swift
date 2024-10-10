//
//  ImagePopUpView+FactoryProtocol.swift
//  WeeCompanyTest
//
//  Created by Pablo Luis Velazquez Zamudio on 09/10/24.
//

import UIKit

extension ImagePopUpView: ControllerProtocol {
    func createPopViewContoller(imgUrl: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ImagePopUpView") as? ImagePopUpView else { return UIViewController() }
        vc.viewModel.imgUrl = imgUrl
        return vc
    }
    
    func createViewController(countryName: String) -> UIViewController {
        return UIViewController()
    }
}
