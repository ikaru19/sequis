//
//  InjectorResolver.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation

protocol InjectorResolver: AnyObject {
    func inject(_ viewController: ViewController)
}
