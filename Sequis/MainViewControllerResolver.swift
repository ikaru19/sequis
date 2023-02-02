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
    var imageDetailVcProvider: Provider<ImageDetailViewController>
    
    init(
        imageListVcProvider: Provider<ImageListViewController>,
        imageDetailVcProvider: Provider<ImageDetailViewController>
    ) {
        self.imageListVcProvider = imageListVcProvider
        self.imageDetailVcProvider = imageDetailVcProvider
    }

    func instantiateImageListViewController() -> Cleanse.Provider<ImageListViewController> {
        imageListVcProvider
    }
    
    func instantiateImageDetailViewController() -> Cleanse.Provider<ImageDetailViewController> {
        imageDetailVcProvider
    }
}
