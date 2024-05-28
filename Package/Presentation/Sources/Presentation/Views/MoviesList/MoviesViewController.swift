//
//  MoviesViewController.swift
//  
//
//  Created by Leonardo Mendez on 27/05/24.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
