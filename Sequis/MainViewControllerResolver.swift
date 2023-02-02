//
//  MainViewControllerResolver.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import Cleanse

class MainViewControllerResolver: ViewControllerResolver {
    var imageListVcProvider: Provider<ImageListViewController>
    
    init(
        imageListVcProvider: Provider<ImageListViewController>
    ) {
        self.imageListVcProvider = imageListVcProvider
    }

    func instantiateImageListViewController() -> Cleanse.Provider<ImageListViewController> {
        imageListVcProvider
    }
}
