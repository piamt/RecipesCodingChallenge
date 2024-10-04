//
//  ViewDispatcher.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 3/10/24.
//

import Foundation

final class ViewDispatcher: ViewDipatcherProtocol {
    static var shared: ViewDispatcher = .init()
    var dispatcher: ViewDipatcherProtocol = DispatcherDefault()

    func execute(_ action: @escaping () -> Void) {
        dispatcher.execute(action)
    }
}

protocol ViewDipatcherProtocol: AnyObject {
    func execute(_ action: @escaping () -> Void)
}

class DispatcherDefault: ViewDipatcherProtocol {
    func execute(_ action: @escaping () -> Void) {
        DispatchQueue.main.async(execute: action)
    }
}

class DispatcherMock: ViewDipatcherProtocol {
    func execute(_ action: @escaping () -> Void) {
        action()
    }
}
