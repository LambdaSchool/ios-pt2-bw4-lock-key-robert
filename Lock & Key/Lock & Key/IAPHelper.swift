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
    case Unlock = "Cannot use the same ID here. It works on my other project"
}

class IAPService: NSObject {
    
    //MARK: - Properties
    
    static let shared = IAPService()
    let paymentQueue = SKPaymentQueue.default()
    var product: SKProduct?
    
    //MARK: - Methods
    
    func fetchProducts() {
        let products: Set = [IAPProduct.Unlock.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        
        request.delegate = self
        request.start()
        
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let product = self.product else { return }
        
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
    func restore() {
        paymentQueue.restoreCompletedTransactions()
    }
}

extension IAPService: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.product = response.products.first
        
        for product in response.products {
            print(product.localizedTitle)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                UserDefaults.standard.set(true, forKey: "Unlocked")
            } else if transaction.transactionState == .restored {
                UserDefaults.standard.set(true, forKey: "Unlocked")
            }
            print(transaction.transactionState.status())
        }
    }
    
}

extension SKPaymentTransactionState {
    
    func status() -> String {
        switch self {
        case .deferred:
            return "Deferred"
        case .failed:
            return "Failed"
        case .purchased:
            return "Purchased"
        case .restored:
            return "Restored"
        case .purchasing:
            return "Purchasing"
        @unknown default:
            fatalError()
        }
    }
    
}
