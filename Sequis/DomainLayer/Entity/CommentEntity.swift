//
//  CommentEntity.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation

extension Domain {
    struct CommentEntity {
        var id: String
        var firstName: String
        var lastName: String
        var comment: String
        var contentId: String
        var timeStamp: String?
    }
}
