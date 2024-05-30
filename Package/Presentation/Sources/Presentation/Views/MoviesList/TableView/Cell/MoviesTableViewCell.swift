//
//  MoviesTableViewCell.swift
//  
//
//  Created by Leonardo Mendez on 27/05/24.
//

import UIKit
import Domain

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var upcommingLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func config(movie: Movie) {
        let urlImage = movie.posterPath
        if urlImage != "" {
            let uslString = String(format: "https://image.tmdb.org/t/p/w500%@", urlImage ?? "")
            guard let safeURL = uslString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return
            }
            guard let url = URL(string: safeURL) else {
                return
            }
            DispatchQueue.main.async {
                self.movieImage.loadImage(from: url)
            }
        } else {
            movieImage.backgroundColor = UIColor.black
        }
        movieNameLabel.text = movie.originalTitle
        popularityLabel.text = String(format: "Popularity: %.1f", movie.popularity ?? "")
        rateLabel.text = String(format: "Rate: %.1f", movie.voteAverage ?? "")
        upcommingLabel.text = String(format: "upcomming: %@", movie.releaseDate ?? "")
        languageLabel.text = String(format: "Language: %@", movie.originalLanguage ?? "")
    }
    
}
