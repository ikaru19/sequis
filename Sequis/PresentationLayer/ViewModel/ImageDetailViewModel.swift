//
//  ImageDetailViewModel.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift

protocol ImageDetailViewModel: AnyObject {
    var errors: Observable<Error> { get }
    var comment: Observable<[Domain.CommentEntity]> { get }
    
    func getComment(byContentId: String)
    func insertComment(comment: Domain.CommentEntity) -> Completable
    func deleteComment(byId: String) -> Completable
    
    func firstNameGenerator() -> String
    func lastNameGenerator() -> String
    func commentGenerator() -> String
}
