//
//  MyLocalDatabase+Comment.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RxSwift
import RealmSwift

extension MyLocalDatabase: CommentLocalDataSource {
    func inserComment(comment: LocalCommentEntity) -> Completable {
        Completable.create(subscribe: { observer in
                    guard let realm = try? self.instantiate() else {
                        observer(.error(RealmError(reason: .cantInit, line: 16)))
                        return Disposables.create()
                    }

                    do {
                        try realm.safeWrite {
                            realm.add(comment, update: .all)
                        }
                        observer(.completed)
                    } catch {
                        observer(.error(error))
                    }
                    return Disposables.create()
                })
    }
    
    func fetchBy(contentId: String) -> Single<[LocalCommentEntity]> {
        Single.create(subscribe: { observer in
                    do {
                        var query = try self.fetch(
                                        NSPredicate(
                                                format: """
                                                        contentId == %@
                                                        """,
                                                contentId
                                        )
                                )
                                .sorted(byKeyPath: "timestamp", ascending: false)
                        observer(.success(Array(query)))
                    } catch {
                        observer(.error(error))
                    }
                    return Disposables.create()
                })
    }
    
    func deleteBy(commentId: String) -> Completable {
        Completable.create(subscribe: { observer in
                    do {
                        guard let realm = try? self.instantiate() else {
                            observer(.error(RealmError(reason: .cantInit, line: 56)))
                            return Disposables.create()
                        }

                        realm.refresh()

                        try realm.safeWrite {
                            realm.delete(
                                    realm.objects(LocalCommentEntity.self)
                                            .filter(
                                                    NSPredicate(
                                                            format: """
                                                                    commentId == %@
                                                                    """,
                                                            commentId
                                                    )
                                            )
                            )
                        }

                        observer(.completed)
                    } catch {
                        observer(.error(error))
                    }
                    return Disposables.create()
                })
    }
    
    
}

private extension MyLocalDatabase {
    private func fetch(_ predicate: NSPredicate) throws -> Results<LocalCommentEntity> {
        guard let realm = try? self.instantiate() else {
            throw RealmError(reason: .cantFetch, line: 16)
        }
        realm.refresh()

        let result = realm
                .objects(LocalCommentEntity.self)
                .filter(predicate)
        return result
    }
}
