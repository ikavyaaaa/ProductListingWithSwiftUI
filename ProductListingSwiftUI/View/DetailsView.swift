//
//  DetailsView.swift
//  ProductListingSwiftUI
//
//  Created by Kavya on 30/08/22.
//

import Foundation
import SwiftUI


struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var product: Product
    
    var body: some View {
        ZStack {
            ScrollView  {
                    Image(uiImage: product.image.load())
                        .resizable()
                        .aspectRatio(1,contentMode: .fit)
                        .edgesIgnoringSafeArea(.top)
                
                DescriptionView(product: product)
                
            }
            .edgesIgnoringSafeArea(.top)
            
         
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}))
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(product: Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 12, description: "men's clothing men's clothing men's clothing men's clothing", category: "men's clothing", image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg", rating: Rating(rate: 2.5, count: 2)))
    }
}


struct DescriptionView: View {
    
    var product: Product
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(product.category)
                .fontWeight(.medium)
                .padding(.vertical, 8)
            Text(product.title)
                .font(.title)
                .fontWeight(.bold)
            HStack (spacing: 4) {
                ForEach(0 ..< 5) { item in
                    Image("Rating")
                }
                Text("\(product.rating.rate.format(f: ".0")) (\(product.rating.count))")
                    .opacity(0.5)
                    .padding(.leading, 8)
                Spacer()
            }
            
            Text(product.description)
                .lineSpacing(8.0)
                .opacity(0.6)
            
            HStack {
                
                Text("$\(product.price.format(f: ".2"))")
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
                Spacer()
                
                Text("Add to Cart")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 8)
                    .background(Color.red)
                    .cornerRadius(10.0)
                
            }
            .padding()
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
 
        }
        .padding()
        .padding(.top)
        .background(Color("Color2"))
        .cornerRadius(60, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
    }
}

struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image("BackImage")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct ColorDotView: View {
    let color: Color
    var body: some View {
        color
            .frame(width: 24, height: 24)
            .clipShape(Circle())
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
