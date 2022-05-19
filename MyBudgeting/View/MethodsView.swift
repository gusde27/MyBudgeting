//
//  MethodsView.swift
//  MyBudgeting
//
//  Created by I Gede Bagus Wirawan on 26/04/22.
//

import SwiftUI

struct MethodsView: View {
    
    var methods : [Methods] = MethodsList.data
    
    var body: some View {
    
        List(methods, id:\.id) { methodData in
            
            NavigationLink(destination: DetailView(methods: methodData), label: {
                
                VStack(alignment: .leading, spacing: 7) {
                    
                    Text(methodData)
                    Image(methodData.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                    
                    Text(methodData.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                    Text(methodData.simple_dec)
                        .fontWeight(.regular)
                        .lineLimit(5)
                        .minimumScaleFactor(0.5)
                        .padding(.vertical, 10)
                    
                    
                  
                } //close vstack
            })
            
            
            
        }.navigationTitle("Budgeting Methods").navigationBarTitleDisplayMode(.inline)
        
        
    }
}

struct MethodsView_Previews: PreviewProvider {
    static var previews: some View {
        MethodsView()
            .preferredColorScheme(.dark)
    }
}
