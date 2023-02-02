//
//  GetImageRepositoryImpl.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift

class GetImagesRepositoryImpl: GetImagesRepository {
    private var getImageListDataSource: GetImageListDataSource
    private var disposeBag = DisposeBag()
    
    init(
            getImageListDataSource: GetImageListDataSource
    ) {
        self.getImageListDataSource = getImageListDataSource
    }

    func getImages(page: Int) -> RxSwift.Single<[Domain.ImageEntity]> {
        Single.create(subscribe: { [self] observer in
            getImageListDataSource
                .getImageList(page: page)
                    .subscribe(
                            onSuccess: { [weak self] data in
                                var finalData : [Domain.ImageEntity] = []
                                var processedData = rawDataMapper(datas: data)
                                finalData.append(contentsOf: processedData ?? [])
                                observer(.success(finalData))
                            }, onError: { error in
                        observer(.error(error))
                    }
                    )
            return Disposables.create()
        })
    }
}

extension GetImagesRepositoryImpl {
    private func rawDataMapper(datas: [Data.ImageEntity]) -> [Domain.ImageEntity] {
        var finalData : [Domain.ImageEntity] = []
        for data in datas {
            if let id = data.id,
               let author = data.author,
               let url = data.downloadURL {
                var rawData = Domain.ImageEntity(
                    id: id,
                    author: author,
                    downloadURL: url
                )
                finalData.append(rawData )
            }
        }
        return finalData
    }}
