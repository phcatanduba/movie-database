//
//  Publisher.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 09/08/22.
//

import Combine

extension Publisher {
    func getOutput(store: inout Set<AnyCancellable>, completion: @escaping (Self.Output) -> ()) {
        sink(receiveCompletion: { _ in
            //handle the error
        }) { output in
            completion(output)
        }.store(in: &store)
    }
}
