//
//  DetailView.swift
//  MyBudgeting
//
//  Created by I Gede Bagus Wirawan on 27/04/22.
//

import SwiftUI

struct DetailView: View {
    
    var methods : Methods
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            Image(methods.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
                .accessibility(label: Text("Method Image"))
                .accessibility(value: Text(methods.imageName))
                .accessibility(hint: Text("Method Image"))
                .accessibility(identifier: "ImageFile")
            
            Text(methods.title)
                .fontWeight(.semibold)
                .font(.title2)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .accessibility(label: Text("Method Title"))
                .accessibility(value: Text(methods.title))
                .accessibility(hint: Text("Method Title"))
                .accessibility(identifier: "TitleText")
            
            Text(methods.description)
                .font(.body)
                .padding()
                .accessibility(label: Text("Description"))
                .accessibility(value: Text(methods.description))
                .accessibility(hint: Text("Method Des"))
                .accessibility(identifier: "DesctiptionText")

            
            Spacer()
            
            Link(destination: methods.url, label: {
                Text("Reference")
                    .bold()
                    .font(.title3)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    .accessibility(label: Text("Reference"))
                    .accessibility(value: Text("URL is \(methods.url)"))
                    .accessibility(hint: Text("Go to Method Reference"))
                    .accessibility(identifier: "ReferenceButton")
//                    .contrast(-1)
//                    .overlay(Text("1"))
            })
        }
        .navigationTitle("Method Detail").navigationBarTitleDisplayMode(.inline)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(methods: MethodsList.data.first!)
    }
}
