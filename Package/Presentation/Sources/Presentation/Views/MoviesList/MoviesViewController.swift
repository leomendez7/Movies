//
//  MoviesViewController.swift
//  
//
//  Created by Leonardo Mendez on 27/05/24.
//

import UIKit
import Combine

public class MoviesViewController: BaseViewController<MoviesListViewModel> {

    private var anyCancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies List"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.coordinator.navigationController = navigationController
        subscribeToViewModel()
        Task { await self.viewModel.fetchMovies() }
    }
    
    private func subscribeToViewModel() {
        viewModel.reloadData.receive(on: DispatchQueue.main).sink { _  in } receiveValue: { _ in
            self.tableView.reloadData()
        }.store(in: &anyCancellable)
    }
    
    @IBAction func changeMovieOrder(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("")
        case 1:
            print("")
        default:
            break
        }
    }
    
}
