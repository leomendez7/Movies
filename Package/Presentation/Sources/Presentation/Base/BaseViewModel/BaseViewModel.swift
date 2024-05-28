//
//  BaseViewModel.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation
import Domain

public class BaseViewModel<UseCase, FlowCoordinator> {
    
    public var useCase: UseCase
    public var coordinator: FlowCoordinator
    
    public init(useCase: UseCase, coordinator: FlowCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

public extension BaseViewModel where UseCase == Array<any UseCaseProtocol> {
    func getUseCase<T: UseCaseProtocol>(typeOfUseCase: T.Type) -> T? {
        return useCase.first(where: { $0 is T }) as? T
    }
}
