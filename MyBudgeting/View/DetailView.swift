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
            
            Text(methods.title)
                .fontWeight(.semibold)
                .font(.title2)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(methods.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Link(destination: methods.url, label: {
                Text("Reference")
                    .bold()
                    .font(.title3)
                    .frame(width: 300, height: 50)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
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
