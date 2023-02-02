//
//  MyJsonAPI+ImageList.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

extension MyJsonAPI: GetImageListDataSource {
    func getImageList() -> Single<[Data.ImageEntity]> {
        let endpoint = "v2/list"
        return Single.create(subscribe: { [weak self] observer in
            self?.jsonRequestService.get(to: endpoint, param: [:], header: [:])
                    .subscribe(
                            onNext: { [weak self] data in
                                var postsData : [Data.ImageEntity] = []
                                if let dict = data as? [[String: Any]] {
                                    let processedData = self?.rawDataMapper(dictionary: dict)
                                    postsData.append(contentsOf: processedData ?? [])
                                }
                                observer(.success(postsData))
                            },
                            onError: { [weak self] error in
                                observer(.error(error))
                            }
                    )
            return Disposables.create()
        })
    }
}

private extension MyJsonAPI {
    func rawDataMapper(dictionary: [[String:Any]]) -> [Data.ImageEntity] {
        var posts : [Data.ImageEntity] = []

        for processed in dictionary {
            let data = Data.ImageEntity(
                id: processed["id"] as? String,
                author: processed["author"] as? String,
                width: processed["width"] as? Int,
                height: processed["height"] as? Int,
                url: processed["url"] as? String,
                downloadURL: processed["download_url"] as? String
            )
           posts.append(data)
        }
        return posts
    }
}
