//
//  MovieDetailsViewController.swift
//  
//
//  Created by Leonardo Mendez on 27/05/24.
//

import UIKit
import Domain

@MainActor
public class MovieDetailsViewController: BaseViewController<MovieDetailViewModel> {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var upcommingLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = viewModel.movie else { return }
        let urlImage = movie.posterPath
        if urlImage != "" {
            let uslString = String(format: "https://image.tmdb.org/t/p/w500%@", urlImage ?? "")
            guard let safeURL = uslString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return
            }
            guard let url = URL(string: safeURL) else {
                return
            }
            posterImageView.loadImage(from: url)
        } else {
            posterImageView.backgroundColor = UIColor.black
        }
        titleLabel.text = movie.originalTitle
        overviewLabel.text = movie.overview
        popularityLabel.text = String(format: "Popularity: %.1f", movie.popularity ?? "")
        rateLabel.text = String(format: "Rate: %.1f", movie.voteAverage ?? "")
        upcommingLabel.text = String(format: "upcomming: %@", movie.releaseDate ?? "")
        languageLabel.text = String(format: "Language: %@", movie.originalLanguage ?? "")
    }

}
