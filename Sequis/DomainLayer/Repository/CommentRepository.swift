//
//  CommentRepository.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift

protocol CommentRepository: AnyObject {
    func getComment(byId: String) -> Single<[Domain.CommentEntity]>
    func insertComment(comment: Domain.CommentEntity) -> Completable
    func deleteComment(byId: String) -> Completable
}
