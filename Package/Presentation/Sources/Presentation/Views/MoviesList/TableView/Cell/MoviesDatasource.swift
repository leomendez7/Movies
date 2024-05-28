//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 27/05/24.
//

import UIKit

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MoviesTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "moviesTableViewCell",
            for: indexPath
        ) as? MoviesTableViewCell else { return MoviesTableViewCell() }
        
        return cell
    }
    
}
