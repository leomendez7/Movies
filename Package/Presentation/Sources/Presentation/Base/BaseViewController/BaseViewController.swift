//
//  BaseViewController.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import UIKit
import Domain
import Data

public class BaseViewController<ViewModel>: UIViewController {
    
    var viewModel: ViewModel
    
    // MARK: - Init
    
    public init?(viewModel: ViewModel, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    public init?(viewModel: ViewModel, nibName: String, bundle: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
