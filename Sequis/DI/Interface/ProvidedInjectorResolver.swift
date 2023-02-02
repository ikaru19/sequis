//
//  ProvidedInjectorResolver.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation

protocol ProvideInjectorResolver: AnyObject {
    var injectorResolver: InjectorResolver { get }
}
