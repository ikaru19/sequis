//
//  CommentRepositoryImpl.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift

class CommentRepositoryImpl: CommentRepository {
    private var commentLocalDataSource: CommentLocalDataSource
    private var disposeBag = DisposeBag()
    
    init(
            commentLocalDataSource: CommentLocalDataSource
    ) {
        self.commentLocalDataSource = commentLocalDataSource
    }
    
    func getComment(byId: String) -> RxSwift.Single<[Domain.CommentEntity]> {
        Single.create(subscribe: { [self] observer in
            commentLocalDataSource
                .fetchBy(contentId: byId)
                    .subscribe(
                            onSuccess: { [weak self] data in
                                var finalData : [Domain.CommentEntity] = []
                                var processedData = self?.rawDataMapper(datas: data)
                                finalData.append(contentsOf: processedData ?? [])
                                observer(.success(finalData))
                            },
                            onError: { error in
                                observer(.error(error))
                            }
                    )
            return Disposables.create()
        })
    }
    
    func insertComment(comment: Domain.CommentEntity) -> RxSwift.Completable {
        let data = rawDataMapper(data: comment)
        return commentLocalDataSource.inserComment(comment: data)
    }
    
    func deleteComment(byId: String) -> RxSwift.Completable {
        commentLocalDataSource.deleteBy(commentId: byId)
    }
    
    
}

extension CommentRepositoryImpl {
    private func rawDataMapper(datas: [LocalCommentEntity]) -> [Domain.CommentEntity] {
        var finalData : [Domain.CommentEntity] = []
        for data in datas {
            var rawData = Domain.CommentEntity(
                id: data.commentId,
                firstName: data.firstName,
                lastName: data.lastName,
                comment: data.content,
                contentId: data.contentId
            )
            finalData.append(rawData)
        }
        return finalData
    }
    
    private func rawDataMapper(data: Domain.CommentEntity) -> LocalCommentEntity {
        return LocalCommentEntity(
            commentId: data.id,
            firstName: data.firstName,
            lastName: data.lastName,
            content: data.comment,
            contentId: data.contentId,
            timestamp: Int(Date().timeIntervalSince1970)
        )
    }
}
