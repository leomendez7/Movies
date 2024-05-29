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
    
    class var key: String {
        return UrlBaseFactory.createKey()
    }
}

private class UrlBaseFactory {
    
    fileprivate static func createUrl() -> String {
        let host = "https://api.themoviedb.org/4/list/"
        return host
    }
    
    fileprivate static func createKey() -> String {
        let key = "ecd808c2e2821a26fd7b166a9a01bbe8"
        return key
    }
    
}
