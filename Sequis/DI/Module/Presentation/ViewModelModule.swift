//
//  ViewModelModule.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import Cleanse

struct ViewModelModule: Module {
    static func configure(binder: UnscopedBinder) {
        binder.bind(ImageListViewModel.self)
                .to(factory: ImageListViewModelImpl.init)
    }
}
