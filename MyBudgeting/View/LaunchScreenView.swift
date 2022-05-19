//
//  LaunchScreenView.swift
//  MyBudgeting
//
//  Created by I Gede Bagus Wirawan on 27/04/22.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    
    var body: some View {
        
        if isActive == true {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image("MyBudgeting")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .cornerRadius(15)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear() {
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(){
                        self.isActive = true
                    }
                }
            }
            
            
        }
        //end if
        
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
