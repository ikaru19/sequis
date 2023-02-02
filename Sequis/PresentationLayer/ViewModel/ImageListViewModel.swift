//
//  ImageListViewModel.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift

protocol ImageListViewModel: AnyObject {
    var errors: Observable<Error> { get }
    var images: Observable<[Domain.ImageEntity]> { get }
    var lastPage: Int? { get set }
    
    func getImageList(page: Int)
}
