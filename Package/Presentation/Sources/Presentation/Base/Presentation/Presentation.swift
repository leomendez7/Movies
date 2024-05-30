//
//  Presentation.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation

public final class Presentation: NSObject {
    public static var bundle: Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: Presentation.self)
#endif
    }
}
