//
//  ImageDetailViewModelImpl.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift
import RxRelay

class ImageDetailViewModelImpl: ImageDetailViewModel {
    private var _errors: PublishRelay<Error> = PublishRelay()
    private var _comments: PublishRelay<[Domain.CommentEntity]> = PublishRelay()
    
    var errors: Observable<Error> {
        _errors.asObservable()
    }
    
    var comment: Observable<[Domain.CommentEntity]> {
        _comments.asObservable()
    }
    
    var commentRepository: CommentRepository
    
    init(commentRepository: CommentRepository) {
        self.commentRepository = commentRepository
    }
    
    func getComment(byContentId: String) {
        commentRepository
            .getComment(byId: byContentId)
            .subscribe(
                onSuccess: { [weak self] data  in
                    self?._comments.accept(data)
                },
                onError: { [weak self] error in
                    self?._errors.accept(error)
                }
            )
    }
    
    func insertComment(comment: Domain.CommentEntity) -> RxSwift.Completable {
        commentRepository.insertComment(comment: comment)
    }
    
    func deleteComment(byId: String) -> RxSwift.Completable {
        commentRepository.deleteComment(byId: byId)
    }
    
    func firstNameGenerator() -> String {
        let firstName = JsonFileHelper.loadJson(filename: "firstNames")
        
        return firstName.randomElement() ?? "-"
    }
    
    func lastNameGenerator() -> String {
        let lastName = JsonFileHelper.loadJson(filename: "lastNames")
        
        return lastName.randomElement() ?? "-"
    }
    
    func commentGenerator() -> String {
        var nouns = JsonFileHelper.loadJson(filename: "nouns")
        let verbs = JsonFileHelper.loadJson(filename: "verbs")
        
        nouns.append(contentsOf: verbs)
        
        var final: [String] = []
        for i in 1...30 {
            if let word = nouns.randomElement() {
                final.append(word)
            }
        }
        
        return final.joined(separator: " ")
    }
}
