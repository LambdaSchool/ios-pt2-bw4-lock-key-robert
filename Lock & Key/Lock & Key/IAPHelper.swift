//
//  IAPHelper.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 3/2/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import StoreKit

enum IAPProduct: String {
    case Unlock = ""
}

class IAPService: NSObject {
    
    //MARK: - Properties
    
    static let shared = IAPService()
    
    //MARK: - Methods
    
    func fetchProducts() {
        let products: Set = [IAPProduct.Unlock.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}
