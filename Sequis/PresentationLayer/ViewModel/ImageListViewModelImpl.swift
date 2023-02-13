//
//  ImageListViewModelImpl.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift
import RxRelay

class ImageListViewModelImpl: ImageListViewModel {
    private var _errors: PublishRelay<Error> = PublishRelay()
    private var _images: BehaviorRelay<[Domain.ImageEntity]> = BehaviorRelay<[Domain.ImageEntity]>(value: [])
    
    var errors: Observable<Error> {
        _errors.asObservable()
    }
    
    var images: Observable<[Domain.ImageEntity]> {
        _images.asObservable()
    }
    
    var lastPage: Int?
    var getImagesRepository: GetImagesRepository?
    
    init(getImagesRepository: GetImagesRepository) {
        self.getImagesRepository = getImagesRepository
    }

    func getImageList(page: Int) {
        getImagesRepository?
            .getImages(page: page)
            .subscribe(
                onSuccess: { [weak self] data in
                    let value: [Domain.ImageEntity] = self?._images.value ?? []
                    self?._images.accept(value + data)
                },
                onError: { [weak self] error in
                    self?._errors.accept(error)
                }
            )
    }
}
