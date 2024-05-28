//
//  UrlBaseContainer.swift
//  Movies
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation

final class UrlBaseContainer {
    
    class var urlBase: String {
        return UrlBaseFactory.createUrl()
    }
}

private class UrlBaseFactory {
    
    fileprivate static func createUrl() -> String {
        let host = "https://api.themoviedb.org/4/list/2?api_key=ecd808c2e2821a26fd7b166a9a01bbe8"
        return host
    }
    
}
