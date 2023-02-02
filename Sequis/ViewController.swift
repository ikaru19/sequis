//
//  ViewController.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import UIKit
import RxSwift
import RxAlamofire
import Cleanse

class ViewController: UIViewController {
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (UIApplication.shared.delegate as? ProvideInjectorResolver)?.injectorResolver.inject(self)
        goToMainPage()
    }

    private func goToMainPage() {
        if let vc = (UIApplication.shared.delegate as? ProvideViewControllerResolver)?.vcResolver.instantiateImageListViewController().get() {
            let vcNav = UINavigationController(rootViewController: vc)
            self.presentInFullScreen(vcNav, animated: true, completion: nil)
        }
    }


    func injectProperties(
            viewController: TaggedProvider<MyBaseUrl>
    ){

    }
}

