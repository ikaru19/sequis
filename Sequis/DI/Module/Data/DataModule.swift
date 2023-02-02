//
//  DataModule.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import Cleanse

struct DataModule: Module {
    static func configure(binder: SingletonScope) {
        binder.include(module: NetworkingModule.self)
        binder.include(module: MyAPIModule.self)
        binder.include(module: RealmDatabaseModule.self)
        binder.bind(GetImageListDataSource.self)
                .sharedInScope()
                .to { (api: MyJsonAPI) in
                    api
                }
    }
}
