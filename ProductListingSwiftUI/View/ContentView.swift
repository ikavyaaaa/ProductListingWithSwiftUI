//
//  ContentView.swift
//  ProductListingSwiftUI
//
//  Created by Kavya on 30/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var search: String = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        TopView()
                        TitleView()
                            .padding()
                        SearchView(search: $search)
                    }
                }
                VStack {
                    Spacer()
                    BottomNavBarView()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle(Text(""))
        .edgesIgnoringSafeArea([.top, .bottom])
    }


}



struct TopView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image("MenuIcon")
                    .padding()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct TitleView: View {
    var body: some View {
        Text("New Arrivals \n")
            .font(.custom("Poppins-Regular", size: 32))
            .foregroundColor(Color.black)
        + Text("Custom clothing for the modern unique man!")
            .font(.custom("Poppins-Thin", size: 10))
            .foregroundColor(Color.black)
    }
}



struct SearchView: View {
    @Binding var search: String
    var body: some View {
        HStack {
            TextField("  Search items..", text: $search)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.black)
            ZStack {
                Image("Group")
                    .aspectRatio(contentMode: .fill)
                    .padding(.trailing, -2)
                Image("Search")
                    .padding(.trailing, 0)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5).stroke(Color(.gray), lineWidth: 0.5))
        .padding(.trailing, 20)
        .padding(.leading, 20)
        
        ProductListView(searchText: search)
    }
}

struct ProductListItem: View {
    let product: Product
    var body: some View {
        VStack {
            HStack(spacing: 2) {
                Text("\(product.formatedRating)").font(.title3)
                Text("(\(product.rating.count))").font(.caption2)
                    .foregroundColor(.secondary)
                    .offset(y: 3)
            }
        }.padding(8)
    }
}

struct ProductListView: View {
    
    var searchText : String
    @StateObject var productData = ProductViewModel()
    
    var body: some View {
        VStack {
            let data = searchText == "" ? productData.product : productData.product.filter{$0.title.lowercased().contains(searchText.lowercased())}
            ForEach(data, id: \.self) { prod in
                HStack {
                    NavigationLink(destination: DetailsView(product: prod)) {
                        Image(uiImage: prod.image.load())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 108, height: 130)
                            .cornerRadius(14)
                            .clipped()
                        VStack {
                            Text(prod.title)
                                .foregroundColor(.black)
                                .bold()
                                .padding()
                                
                            HStack(spacing: 10, content: {
                                ForEach(0 ..< 5) { item in
                                    Image("Rating")
                                }
                            })
                            Text("$\(prod.price.format(f: ".2"))")
                                .foregroundColor(.black)
                                .bold()
                                .font(Font.custom("Poppins-Regular", size: 18))
                                .padding()
                            
                        }.padding()
                    }
                }.padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5).stroke(Color(.gray), lineWidth: 0.5))
            }
        }.onAppear {
            productData.fetch()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BottomNavBarView: View {
    var body: some View {
        HStack {
            BottomNavBarItem(image: Image("Home"), action: {})
            BottomNavBarItem(image: Image("Fav"), action: {})
            BottomNavBarItem(image: Image("Cart"), action: {})
            BottomNavBarItem(image: Image("Unknown"), action: {})
        }
        .padding()
        .background(Color.white)
        .padding(.horizontal)
        .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
    }
}

struct BottomNavBarItem: View {
    let image: Image
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            image
                .frame(maxWidth: .infinity)
        }
    }
}

extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
