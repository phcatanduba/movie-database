//
//  APP+Injection.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 11/08/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        register { DetailsViewModel() }
    }
}
