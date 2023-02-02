//
//  RepositoryModule.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import Cleanse

struct DomainModule: Module {
    static func configure(binder: UnscopedBinder) {
        binder.bind(GetImagesRepository.self)
                .to(factory: GetImagesRepositoryImpl.init)
    }
}
