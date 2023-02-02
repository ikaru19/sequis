//
//  ProvideViewControllerResolver.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation

protocol ProvideViewControllerResolver: AnyObject {
    var vcResolver: ViewControllerResolver { get }
}
