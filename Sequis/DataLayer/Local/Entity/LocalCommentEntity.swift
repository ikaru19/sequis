//
//  CommentEntity.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import RealmSwift

class LocalCommentEntity: Object {
    @objc dynamic var commentId: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var contentId: String = ""
    dynamic var timestamp = RealmOptional<Int>()

    convenience init(
            commentId: String,
            firstName: String,
            lastName: String,
            content: String,
            contentId: String,
            timestamp: Int?
    ) {
        self.init()
        self.commentId = commentId
        self.firstName = firstName
        self.lastName = lastName
        self.content = content
        self.contentId = contentId
        self.timestamp.value = timestamp
    }

    override static func primaryKey() -> String? {
        "commentId"
    }
}
