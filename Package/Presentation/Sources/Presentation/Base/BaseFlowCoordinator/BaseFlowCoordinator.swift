//
//  BaseFlowCoordinator.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation
import UIKit

public protocol BaseFlowCoordinator {
    
    associatedtype BaseFlowRoute
    associatedtype Factory
    var factory: Factory { get }
    func navigate(to flowRoute: BaseFlowRoute)
    var navigationController: UINavigationController? { get set }
    
}
