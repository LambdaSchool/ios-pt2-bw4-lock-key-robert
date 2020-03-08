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
    case Unlock = "com.BobbyKeffury.Lock_Key.buy_in"
}

class IAPService: NSObject {
    
    //MARK: - Properties
    
    static let shared = IAPService()
    let paymentQueue = SKPaymentQueue.default()
    var product = [SKProduct]()
    
    //MARK: - Methods
    
    func fetchProducts() {
        let products: Set = [IAPProduct.Unlock.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        
        request.delegate = self
        request.start()
        
        paymentQueue.add(self)
    }
    
    func purchase(producty: IAPProduct) {
        guard let product = self.product.filter({ $0.productIdentifier == producty.rawValue }).first else { return }
        
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
    func restore() {
        paymentQueue.restoreCompletedTransactions()
    }
}

extension IAPService: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.product = response.products
        
        for product in response.products {
            print(product.localizedTitle)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                UserDefaults.standard.set(true, forKey: "Unlocked")
                
                if UserDefaults.standard.bool(forKey: "is5Complete") == true {
                    UserDefaults.standard.set(true, forKey: "isOn6")
                }
            } else if transaction.transactionState == .restored {
                UserDefaults.standard.set(true, forKey: "Unlocked")
                
                if UserDefaults.standard.bool(forKey: "is5Complete") == true {
                    UserDefaults.standard.set(true, forKey: "isOn6")
                }
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
