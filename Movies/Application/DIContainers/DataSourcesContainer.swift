//
//  DataSourcesContainer.swift
//  Movies
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation
import Data
import Domain

final class DataSourcesContainer {
    
    class func reloadLoginUrlBase() {
        DataSourcesContainer.fetchMoviesListDataSource = FetchMoviesListDataSource(urlBase: UrlBaseContainer.urlBase)
    }
    
    static var fetchMoviesListDataSource = FetchMoviesListDataSource(urlBase: UrlBaseContainer.urlBase)
}
