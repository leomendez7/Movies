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
    let searchBar = UISearchBar()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies List"
        navigationController?.navigationBar.prefersLargeTitles = false
        let rightBarButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didTapAddButton))
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        viewModel.coordinator.navigationController = navigationController
        tableView.rowHeight = UITableView.automaticDimension
        subscribeToViewModel()
        Task { await self.viewModel.fetchMovies() }
    }
    
    @objc private func didTapAddButton() {
        let alert = UIAlertController(title: "Filter", message: "Select a filter criteria", preferredStyle: .actionSheet)
        let filterByAdultAction = UIAlertAction(title: "Filter by Adult", style: .default) { _ in
            self.viewModel.filterByAdult()
        }
        let filterByLanguageAction = UIAlertAction(title: "Filter by Original Language", style: .default) { _ in
            self.filterByLanguage()
        }
        let filterByVoteAction = UIAlertAction(title: "Filter by Vote", style: .default) { _ in
            //self.viewModel.filterByVote()
        }
        let reset = UIAlertAction(title: "Reset", style: .default) { _ in
            self.viewModel.reset()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(filterByAdultAction)
        alert.addAction(filterByLanguageAction)
        alert.addAction(filterByVoteAction)
        alert.addAction(reset)
        alert.addAction(cancelAction)
        if let popoverController = alert.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func filterByLanguage() {
        let alert = UIAlertController(title: "Language", message: "Select a Language", preferredStyle: .actionSheet)
        let filterByEn = UIAlertAction(title: "Filter by english", style: .default) { _ in
            self.viewModel.filterByOriginalLanguageEn()
        }
        let filterByFr = UIAlertAction(title: "Filter by french", style: .default) { _ in
            self.viewModel.filterByOriginalLanguageFr()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(filterByEn)
        alert.addAction(filterByFr)
        alert.addAction(cancelAction)
        if let popoverController = alert.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func subscribeToViewModel() {
        viewModel.reloadData.receive(on: DispatchQueue.main).sink { _  in } receiveValue: { _ in
            self.tableView.reloadData()
        }.store(in: &anyCancellable)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Movies"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
    }
    
    @IBAction func changeMovieOrder(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.sortedByPopularity = true
            viewModel.sortedPopularity()
        case 1:
            viewModel.sortedByPopularity = false
            viewModel.sortedTopRate()
        default:
            break
        }
    }
    
}

extension MoviesViewController {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        if offsetY > contentHeight - frameHeight {
            loadMoreMovies()
        }
    }
    
    private func loadMoreMovies() {
        guard !viewModel.isLoading else { return }
        viewModel.pages += 1
        Task { await self.viewModel.fetchMovies() }
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(with: searchText)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.searchMovies(with: "")
        searchBar.resignFirstResponder()
    }
    
}
