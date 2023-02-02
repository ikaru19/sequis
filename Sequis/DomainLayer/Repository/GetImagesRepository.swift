//
//  GetImagesRepository.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift

protocol GetImagesRepository: AnyObject {
    func getImages(page: Int) -> Single<[Domain.ImageEntity]>
}
