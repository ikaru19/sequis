//
//  CommentLocalDataSource.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift
import RealmSwift

protocol CommentLocalDataSource: AnyObject {
    func inserComment(
            comment: LocalCommentEntity
    ) -> Completable

    func fetchBy(
        contentId: String
    ) -> Single<[LocalCommentEntity]>
    
    func deleteBy(
        commentId: String
    ) -> Completable
}
