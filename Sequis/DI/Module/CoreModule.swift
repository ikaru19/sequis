//
//  CoreModule.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import Cleanse

struct CoreModule: Module {
    static func configure(binder: SingletonScope) {
        binder.include(module: PresentationModule.self)
        binder.include(module: DataModule.self)

        binder.bind(InjectorResolver.self)
                .to(factory: MainInjectorResolver.init)
    }
}
