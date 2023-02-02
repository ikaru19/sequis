//
//  GetImageListDataSource.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift
import Alamofire

protocol GetImageListDataSource: AnyObject {
    func getImageList() -> Single<[Data.ImageEntity]>
}
