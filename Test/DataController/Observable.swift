//
//  Observe.swift
//  Test
//
//  Created by Daniel on 04.11.21.
//

import Foundation

class Observable<T> : NSObject {

    var observe : ((T) -> Void)?
    
    var property : T? {
        willSet(newValue) {
            self.observe?(newValue!)
        }
    }
    
    init(_ value: T? = nil) {
        self.property = value
    }
    
    deinit {
        print("Observable deinit")
    }
    
}
