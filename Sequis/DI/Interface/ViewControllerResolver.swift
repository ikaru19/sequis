//
//  ViewControllerResolver.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import Cleanse

protocol ViewControllerResolver: AnyObject {
    func instantiateImageListViewController() -> Provider<ImageListViewController>
    func instantiateImageDetailViewController() -> Provider<ImageDetailViewController>
}
