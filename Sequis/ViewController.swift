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
        test()
    }

    var data: GetImageListDataSource?
    func injectProperties(
            viewController: TaggedProvider<MyBaseUrl>,
            data: GetImageListDataSource
    ){
        self.data = data
    }
    
    func test() {
        data?
            .getImageList()
            .subscribe(
                onSuccess: { data in
                    print("40")
                    print(data.count)
                },
                onError: { error in
                    print("44")
                    print(error)
                }
            ).disposed(by: bag)
    }
}

