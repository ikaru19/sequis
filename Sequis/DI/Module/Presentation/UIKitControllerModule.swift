//
//  UIKitControllerModule.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import Cleanse

struct UIKitControllerModule: Module {
    static func configure(binder: UnscopedBinder) {
        binder.bind(ImageListViewController.self)
            .to {
                ImageListViewController(nibName: nil, bundle: nil, viewModel: $0)
            }
        binder.bind(ImageDetailViewController.self)
            .to {
                ImageDetailViewController(nibName: nil, bundle: nil, viewModel: $0)
            }
    }
}
