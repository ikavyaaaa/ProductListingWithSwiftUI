//
//  ProductViewModel.swift
//  ProductListingSwiftUI
//
//  Created by Kavya on 30/08/22.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var product : [Product] = []
    
    func fetch() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let productData = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self?.product = productData
                }
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}

